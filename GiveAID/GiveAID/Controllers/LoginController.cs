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

        public class LoginModel
        {
            public string username {  get; set; }
            public string password { get; set; }
        }

        public JsonResult Login(LoginModel model)
        {
            string username = model.username;
            string password = model.password;

            var user = en.users.FirstOrDefault(x => x.username == username || x.phone == username || x.email == username);

            if (user == null)
                return Json(new { result = false, error = "Tài khoản không tồn tại" });

            string a = DecryptDES(user.password, SecretKey);

            if (password != a)
                return Json(new { result = false, error = "Sai mật khẩu" });

            Session["USER"] = user;
            return Json(new { result = true });
        }

        public JsonResult Register(user user)
        {
            try
            {
                string pass2 = Request.Form["password2"];
                var CheckExists = en.users.FirstOrDefault(x => x.username == user.username || x.email == user.email);

                if (CheckExists == null)
                {
                    if (pass2 != user.password)
                        return Json(new { result = false, error = "Vui lòng kiểm tra lại mật khẩu" });
                    string pass = EncryptDES(user.password, SecretKey);
                    user.password = pass;
                    en.users.Add(user);
                    en.SaveChanges();
                    return Json(new { result = true });
                }
                else
                {
                    return Json(new { result = false, error = "Tài khoản hoặc Email đã tồn tại" });
                }
            }
            catch
            {
                return Json(new { result = false, error = "Lỗi không xác định" });
            }
        }

        public ActionResult LogOut()
        {
            Session.Remove("USER");
            return RedirectToAction("Index", "Login");
        }

    }
}