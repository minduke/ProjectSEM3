using GiveAID.Models.entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace GiveAID.Controllers
{
    public class HomeController : BaseController
    {
        GiveAIDEntities en = new GiveAIDEntities();

        public ActionResult Index()
        {
            var posts = en.posts.ToList();
            ViewBag.posts = posts;
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult CardDetails(int id)
        {
            var detail = en.posts.FirstOrDefault(x => x.id == id);
            ViewBag.cardDetails = detail;
            return View();
        }

        public ActionResult sendMail()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SendEmail(string toAddress, string subject, string body)
        {
            // Thiết lập thông tin tài khoản email
            string fromAddress = "vuvunguyen12345@gmail.com";
            string password = "viovutezgtdjjvar";

            // Tạo đối tượng MailMessage
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(fromAddress);
            mail.To.Add(new MailAddress(toAddress));
            mail.Subject = subject;
            mail.Body = body;

            // Thiết lập thông tin SMTP Server
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Credentials = new NetworkCredential(fromAddress, password);

            try
            {
                // Gửi email
                smtp.Send(mail);
                return Content("Email sent successfully!");
            }
            catch (SmtpException ex)
            {
                return Content("Failed to send email. Error: " + ex.Message);
            }
            finally
            {
                // Giải phóng tài nguyên
                mail.Dispose();
                smtp.Dispose();
            }
        }





    }
}