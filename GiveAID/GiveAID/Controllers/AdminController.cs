using GiveAID.Models.entities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GiveAID.Controllers
{
    public class AdminController : BaseController
    {
        GiveAIDEntities en = new GiveAIDEntities();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CreateNews()
        { 
            ViewBag.category = en.categories.ToList();
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult SubmitNews(post post, HttpPostedFileBase fileBase)
        {
            var PathUpload = Server.MapPath("/Content/Images");
            if(!Directory.Exists(PathUpload))
            {
                Directory.CreateDirectory(PathUpload);
            }

            string fileExtension = Path.GetExtension(fileBase.FileName).ToLower();
            if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".gif")
            {
                var fileName = DateTime.Now.Ticks + fileBase.FileName;
                PathUpload += "\\" + fileName;
                fileBase.SaveAs(PathUpload);
                post.image = fileName;
                en.posts.Add(post);
                en.SaveChanges();
                return Json(new {result = true});
            }
            return Json(new { result = false, error = "Sai định dạng ảnh" });
        }

    }

}