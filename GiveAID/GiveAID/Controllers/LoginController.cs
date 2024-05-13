using GiveAID.Models.entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GiveAID.Controllers
{
    public class LoginController : BaseController
    {
        GiveAIDEntities en = new GiveAIDEntities();

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult CreateAcc() { return View(); }


        [HttpPost]
        public ActionResult Login(string username, string password)
        {
            var s = en.users.FirstOrDefault(x => x.username == username || x.phone == username || x.email == username);
            if (s != null)
            {
                string a = DecryptDES(s.password, SecretKey);
                if (password == a)
                {
                    return RedirectToAction("Index", "Admin");
                }
            }
            return RedirectToAction("Index", "Login");
        }

        public ActionResult Register(user user)
        {
            var s = en.users.FirstOrDefault(x => x.username == user.username || x.phone == user.username || x.email == user.username);
            if (s == null)
            {
                string pass = EncryptDES(user.username, SecretKey);
                user.password = pass;
                en.users.Add(user);
                en.SaveChanges();
            }
            return RedirectToAction("Index", "Admin");
        }

    }
}