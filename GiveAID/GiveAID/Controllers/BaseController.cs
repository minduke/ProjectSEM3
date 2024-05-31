﻿using GiveAID.Models.entities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using GiveAID.Helpers;
using System.EnterpriseServices;
using System.Web.UI;

namespace GiveAID.Controllers
{
    public class BaseController : Controller
    {
        public static string SecretKey = "WuDuke2@";

        GiveAIDEntities en = new GiveAIDEntities();

        private ErrorLog log = new ErrorLog();

        public bool CheckLogin()
        {
            try
            {
                if (Session["USER"] != null)
                {
                    return true;
                }
                else
                    return false;
            }
            catch
            {
                return false;
            }
        }

        public string EncryptDES(string originalString, string key)
        {
            if (String.IsNullOrEmpty(originalString))
            {
                throw new ArgumentNullException
                       ("The string which needs to be encrypted can not be null.");
            }
            byte[] bytes = ASCIIEncoding.ASCII.GetBytes(key);

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            MemoryStream memoryStream = new MemoryStream();
            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                cryptoProvider.CreateEncryptor(bytes, bytes), CryptoStreamMode.Write);
            StreamWriter writer = new StreamWriter(cryptoStream);
            writer.Write(originalString);
            writer.Flush();
            cryptoStream.FlushFinalBlock();
            writer.Flush();
            return Convert.ToBase64String(memoryStream.GetBuffer(), 0, (int)memoryStream.Length);
        }

        public string DecryptDES(string cryptedString, string key)
        {
            if (String.IsNullOrEmpty(cryptedString))
            {
                throw new ArgumentNullException
                   ("The string which needs to be decrypted can not be null.");
            }
            byte[] bytes = ASCIIEncoding.ASCII.GetBytes(key);
            cryptedString = cryptedString.Replace(" ", "+");
            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            MemoryStream memoryStream = new MemoryStream
                    (Convert.FromBase64String(cryptedString));
            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                cryptoProvider.CreateDecryptor(bytes, bytes), CryptoStreamMode.Read);
            StreamReader reader = new StreamReader(cryptoStream);
            return reader.ReadToEnd();
        }

        public void UpdateStatusByDate()
        {
            try
            {
                var today = DateTime.Now.Date;
                var posts = en.posts.Where(x => x.status == "Mở" && DbFunctions.TruncateTime(x.time_end) <= today).ToList();
                foreach (var post in posts)
                {
                    post.status = "Đóng";
                }
                en.SaveChanges();
            }
            catch (Exception ex)
            {
                log.WriteLog(ex, "UpdateStatusByDate");
            }
        }

        public void UpdateStatusByTarget()
        {
            try
            {
                var posts = en.posts.Where(x => x.payments.Where(s => s.pay_status == "Thành công").Sum(s => s.transaction_amout ?? 0) >= x.target).ToList();
                foreach (var item in posts)
                {
                    item.status = "Đóng";
                }
                en.SaveChanges();
            }
            catch (Exception ex)
            {
                log.WriteLog(ex, "UpdateStatusByTarget");
            }
        }

        public void SendMailThanks(string toAddress)
        {
            string fromAddress = "vuvunguyen12345@gmail.com";
            string password = "viovutezgtdjjvar";

            string templatePath = Server.MapPath("~/Content/template_email/tks_email.html");
            string emailBody = System.IO.File.ReadAllText(templatePath);

            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress(fromAddress);
                mail.To.Add(new MailAddress(toAddress));
                mail.Subject = "Thư Cám Ơn";
                mail.Body = emailBody;
                mail.IsBodyHtml = true;

                using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                {
                    smtp.EnableSsl = true;
                    smtp.Credentials = new NetworkCredential(fromAddress, password);

                    try
                    {
                        smtp.Send(mail);
                    }
                    catch (SmtpException ex)
                    {

                    }
                }
            }
        }

        public void SendMailInvite(string[] toAddress, string currentUrl, string titlePost)
        {
            string fromAddress = "vuvunguyen12345@gmail.com";
            string password = "viovutezgtdjjvar";

            string templatePath = Server.MapPath("~/Content/template_email/invite_email.html");
            string emailBody = System.IO.File.ReadAllText(templatePath);

            var user = Session["USER"] as user;
            emailBody = emailBody.Replace("{{username}}", user.fullname);
            emailBody = emailBody.Replace("{{urlPost}}", currentUrl);
            emailBody = emailBody.Replace("{{title}}", titlePost);

            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress(fromAddress);
                foreach (var item in toAddress)
                {
                    mail.To.Add(new MailAddress(item));
                }
                mail.Subject = "Thư Mời";
                mail.Body = emailBody;
                mail.IsBodyHtml = true;

                using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                {
                    smtp.EnableSsl = true;
                    smtp.Credentials = new NetworkCredential(fromAddress, password);

                    try
                    {
                        smtp.Send(mail);
                    }
                    catch (SmtpException ex)
                    {

                    }
                }
            }
        }
    }
}