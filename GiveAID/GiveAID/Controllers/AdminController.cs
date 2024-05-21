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
        public JsonResult SubmitNews(post post, HttpPostedFileBase[] fileBase, HttpPostedFileBase thumb)
        {
            if (!string.IsNullOrWhiteSpace(post.title) && !post.content.IsNullOrWhiteSpace() && post.target > 0 && fileBase != null && thumb != null && post.time_end != null)
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

                string thumbExtension = Path.GetExtension(thumb.FileName).ToLower();
                if (thumbExtension != ".jpg" || thumbExtension != ".png" || thumbExtension != ".gif")
                {
                    throw new Exception("Sai định dạng ảnh nền");
                }

                var thumbName = DateTime.Now.Ticks + "_" + thumb.FileName;
                var thumbPath = Path.Combine(PathUpload, thumbName);
                thumb.SaveAs(thumbPath);
                post.image = thumbName;

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

        public JsonResult partnerNew(partner partner, HttpPostedFileBase fileBasePartner)
        {
            if (string.IsNullOrWhiteSpace(partner.name) &&
                fileBasePartner == null &&
                string.IsNullOrWhiteSpace(partner.description) &&
                string.IsNullOrWhiteSpace(partner.address) &&
                string.IsNullOrWhiteSpace(partner.phone) &&
                string.IsNullOrWhiteSpace(partner.email))
            {
                throw new Exception("Vui lòng điền đầy đủ thông tin");
            }

            var PathUpload = Server.MapPath("/Content/Images/partner");
            if (!Directory.Exists(PathUpload))
            {
                Directory.CreateDirectory(PathUpload);
            }
            string fileExtension = Path.GetExtension(fileBasePartner.FileName).ToLower();
            if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".gif")
            {
                var fileName = DateTime.Now.Ticks + "_" + fileBasePartner.FileName;
                var filePath = Path.Combine(PathUpload, fileName);
                fileBasePartner.SaveAs(filePath);
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

        public ActionResult NewPartner()
        {
            return View();
        }

        public ActionResult EditPartner()
        {
            return View();
        }

        public ActionResult EditDetail(int id)
        {
            var post = en.posts.FirstOrDefault(x => x.id == id);
            ViewBag.EditPost = post;
            ViewBag.cate = en.categories.ToList();
            return View();
        }

        [ValidateInput(false)]
        public JsonResult DoEditPost(post post, HttpPostedFileBase[] fileBase, HttpPostedFileBase thumbnail)
        {
            try
            {
                var data = en.posts.FirstOrDefault(x => x.id == post.id);

                if (fileBase != null)
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

                    foreach (var imageFile in imageFiles)
                    {
                        var imagePost = new image_post
                        {
                            image = imageFile,
                            post_id = data.id
                        };
                        en.image_post.Add(imagePost);
                    }
                }

                if (thumbnail != null)
                {
                    var PathUpload = Server.MapPath("/Content/Images/post");
                    if (!Directory.Exists(PathUpload))
                    {
                        Directory.CreateDirectory(PathUpload);
                    }

                    string thumbExtension = Path.GetExtension(thumbnail.FileName).ToLower();
                    if (thumbExtension == ".jpg" || thumbExtension == ".png" || thumbExtension == ".gif")
                    {
                        var thumbName = DateTime.Now.Ticks + "_" + thumbnail.FileName;
                        var thumbPath = Path.Combine(PathUpload, thumbName);
                        thumbnail.SaveAs(thumbPath);
                        data.image = thumbName;
                    }
                }

                data.title = post.title;
                data.target = post.target;
                data.content = post.content;
                data.cate_id = post.cate_id;
                data.time_end = post.time_end;
                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw new Exception("Lỗi không xác định");
            }
        }

        public JsonResult DeleteThumb(int id)
        {
            var dt = en.posts.FirstOrDefault(x => x.id == id);

            var filePath = Server.MapPath("~/Content/Images/post/" + dt.image);
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }

            dt.image = "";
            en.SaveChanges();
            return Json(new { result = true });
        }

        public JsonResult DeleteImage(int id)
        {
            var dt = en.image_post.Find(id);
            var filePath = Server.MapPath("~/Content/Images/post/" + dt.image);
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }
            en.image_post.Remove(dt);
            en.SaveChanges();
            return Json(new { result = true });
        }

        public ActionResult ListAll()
        {
            ViewBag.post = en.posts.ToList();
            ViewBag.partner = en.partners.ToList();
            return View();
        }
    }

}