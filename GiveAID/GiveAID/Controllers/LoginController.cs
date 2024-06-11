using GiveAID.Models.entities;
using System;
using System.Linq;
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

        public class LoginModel
        {
            public string username { get; set; }
            public string password { get; set; }
        }

        public JsonResult Login(LoginModel model)
        {
            try
            {
                string username = model.username;
                string password = model.password;

                var user = en.users.FirstOrDefault(x => x.username == username || x.phone == username || x.email == username) ?? throw new Exception("Username does not exists");

                string a = DecryptDES(user.password, SecretKey);

                if (password != a)
                    throw new Exception("Wrong password");

                if (user.status == "banned")
                    throw new Exception("You have been banned");

                Session["USER"] = user;
                return Json(new { result = true });
            }
            catch
            {
                throw;
            }
        }

        public JsonResult Register(user user)
        {
            try
            {
                string pass2 = Request.Form["password2"];
                var CheckExists = en.users.FirstOrDefault(x => x.username == user.username || x.email == user.email);

                if (CheckExists == null)
                {
                    if (user.password.Length < 8)
                        throw new Exception("Password at least 8 characters");

                    if (pass2 != user.password)
                        throw new Exception("Please check your password again");
                    string pass = EncryptDES(user.password, SecretKey);
                    user.password = pass;
                    en.users.Add(user);
                    en.SaveChanges();
                    return Json(new { result = true });
                }
                else
                {
                    throw new Exception("Username or Email already exists");
                }
            }
            catch
            {
                throw;
            }
        }

        public ActionResult LogOut()
        {
            Session.Remove("USER");
            return RedirectToAction("Index", "Login");
        }

        public class ChangePassModel
        {
            public string oldPass { get; set; }
            public string newPass { get; set; }
            public string repeatPass { get; set; }
        }

        public JsonResult ChangePassword(ChangePassModel model)
        {
            try
            {
                var user = Session["USER"] as user;
                var data = en.users.FirstOrDefault(x => x.id == user.id);

                if (DecryptDES(user.password, SecretKey) != model.oldPass)
                    throw new Exception("The current password is wrong");

                if (model.newPass != model.repeatPass)
                    throw new Exception("Please check your new password again");

                if (model.newPass.Length < 8)
                    throw new Exception("Password at least 8 characters");

                data.password = EncryptDES(model.newPass, SecretKey);
                en.SaveChanges();
                Session.Remove("USER");
                return Json(new { result = true });
            }
            catch
            {
                throw;
            }
        }

        public ActionResult ChangePass()
        {
            if (CheckLogin())
            {
                return View();
            }
            return RedirectToAction("Index", "Login");
        }
    }
}