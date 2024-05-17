﻿using GiveAID.Models.entities;
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
            public string username { get; set; }
            public string password { get; set; }
        }

        public JsonResult Login(LoginModel model)
        {
            string username = model.username;
            string password = model.password;

            var user = en.users.FirstOrDefault(x => x.username == username || x.phone == username || x.email == username);

            if (user == null)
                throw new Exception("Tài khoản không tồn tại");

            string a = DecryptDES(user.password, SecretKey);

            if (password != a)
                throw new Exception("Sai mật khẩu");

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
                        throw new Exception("Vui lòng kiểm tra lại mật khẩu");
                    string pass = EncryptDES(user.password, SecretKey);
                    user.password = pass;
                    en.users.Add(user);
                    en.SaveChanges();
                    return Json(new { result = true });
                }
                else
                {
                    throw new Exception("Tài khoản hoặc email đã tồn tại");
                }
            }
            catch
            {
                throw new Exception("Lỗi không xác định");
            }
        }

        public ActionResult LogOut()
        {
            Session.Remove("USER");
            return RedirectToAction("Index", "Login");
        }

        public ActionResult ChangePass()
        {
            return View();
        }

    }
}