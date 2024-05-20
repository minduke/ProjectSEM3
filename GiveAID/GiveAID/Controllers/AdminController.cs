using GiveAID.Models.entities;
using Microsoft.Ajax.Utilities;
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
            ViewBag.partner = en.partners.ToList();
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult SubmitNews(post post, HttpPostedFileBase[] fileBase)
        {
            if (!string.IsNullOrWhiteSpace(post.title) && !post.content.IsNullOrWhiteSpace() && post.target > 0 && fileBase != null && post.time_end != null)
            {

                var PathUpload = Server.MapPath("/Content/Images/post");
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
            else
            {
                throw new Exception("Vui lòng điền đầy đủ thông tin");
            }

        }
        public ActionResult chartJS()
        {
            return View();
        }

        public JsonResult partnerNew(partner partner, HttpPostedFileBase fileBase)
        {
            if (partner.name != null && fileBase != null && partner.description != null && partner.address != null && partner.phone != null && partner.email != null)
            {    // coi lại chỗ này 
                var PathUpload = Server.MapPath("/Content/Images/partner");
                if (!Directory.Exists(PathUpload))
                {
                    Directory.CreateDirectory(PathUpload);
                }
                string fileExtension = Path.GetExtension(fileBase.FileName).ToLower();
                if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".gif")
                {
                    var fileName = DateTime.Now.Ticks + "_" + fileBase.FileName;
                    var filePath = Path.Combine(PathUpload, fileName);
                    fileBase.SaveAs(filePath);
                    partner.partner_image = fileName;
                    en.partners.Add(partner);
                    en.SaveChanges();
                    return Json(new { result = true });
                }
                else
                {
                    throw new Exception("Sai định dạng ảnh");
                }
            }
            else
            {
                throw new Exception("Vui lòng điền đầy đủ thông tin");
            }

        }

        public ActionResult NewPartner()
        {
            return View();
        }

        public ActionResult EditPartner()
        {
            return View();
        }

        public ActionResult EditDetail()
        {
            return View();
        }

        public ActionResult ListAll()
        {
            return View();
        }
    }

}