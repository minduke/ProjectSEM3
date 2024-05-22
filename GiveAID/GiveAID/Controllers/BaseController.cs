using GiveAID.Models.entities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace GiveAID.Controllers
{
    public class BaseController : Controller
    {
        public static string SecretKey = "WuDuke2@";

        GiveAIDEntities en = new GiveAIDEntities();

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
            var posts = en.posts.ToList();
            foreach (var post in posts)
            {
                if(post.time_end == DateTime.Now)
                {
                    post.status = "Đóng";
                    en.SaveChanges();
                }
            }
        }

        public void UpdateStatusByTarget()
        {
            var posts = en.sp_GetTarget();
            foreach (var item in posts)
            {
                if(item.amout == item.target)
                {
                    var post = en.posts.FirstOrDefault(x=>x.id == item.id);
                    post.status = "Đóng";
                }
            }
        }
    }
}