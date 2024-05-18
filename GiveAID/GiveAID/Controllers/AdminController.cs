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
        public JsonResult SubmitNews(post post, HttpPostedFileBase[] fileBase)
        {
            var PathUpload = Server.MapPath("/Content/Images");
            if (!Directory.Exists(PathUpload))
            {
                Directory.CreateDirectory(PathUpload);
            }

            var imageFiles = new List<string>();
            foreach (var file in fileBase)
            {
                string fileExtension = Path.GetExtension(file.FileName).ToLower();
                if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".gif")
                {
                    var fileName = DateTime.Now.Ticks + "_" + file.FileName;
                    var filePath = Path.Combine(PathUpload, fileName);
                    file.SaveAs(filePath);
                    imageFiles.Add(fileName);
                }
                else
                {
                    throw new Exception("Sai định dạng ảnh");
                }
            }

            post.image = imageFiles[0];
            en.posts.Add(post);
            en.SaveChanges();

            var postId = post.id;
            foreach (var imageFile in imageFiles)
            {
                var imagePost = new image_post
                {
                    image = imageFile,
                    post_id = postId
                };
                en.image_post.Add(imagePost);
            }

            en.SaveChanges();
            return Json(new { result = true });

        }
        public ActionResult chartJS()
        {
            return View();
        }

    }

}