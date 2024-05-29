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
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    ViewBag.postCount = en.posts.Count();
                    ViewBag.runningCount = en.posts.Where(x => x.status == "Mở").Count();
                    ViewBag.completeCount = en.posts.Where(x => x.status == "Đóng").Count();
                    ViewBag.sumTarget = en.posts.Sum(x => x.target);
                    ViewBag.sumAmout = en.payments.Sum(x => x.transaction_amout);
                    return View();
                }
            }
           
            return RedirectToAction("Index", "Login");

        }

        public ActionResult CreateNews()
        {
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    ViewBag.category = en.categories.ToList();
                    ViewBag.partner = en.partners.ToList();
                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult SubmitNews(post post, HttpPostedFileBase[] fileBase, HttpPostedFileBase thumbnail)
        {
            if (!string.IsNullOrWhiteSpace(post.title) && !post.content.IsNullOrWhiteSpace() && post.target > 0 && fileBase != null && thumbnail != null && post.time_end != null)
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

                string thumbExtension = Path.GetExtension(thumbnail.FileName).ToLower();
                if (thumbExtension != ".jpg" && thumbExtension != ".png" && thumbExtension != ".gif")
                {
                    throw new Exception("Sai định dạng ảnh nền");
                }

                var thumbName = DateTime.Now.Ticks + "_" + thumbnail.FileName;
                var thumbPath = Path.Combine(PathUpload, thumbName);
                thumbnail.SaveAs(thumbPath);
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
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }

        public JsonResult partnerNew(partner partner, HttpPostedFileBase fileBasePartner)
        {
            if (string.IsNullOrWhiteSpace(partner.partner_name) &&
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
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }

        public ActionResult EditPartner(int id)
        {
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    var dt = en.partners.FirstOrDefault(x => x.id == id);
                    ViewBag.partner = dt;
                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }

        public JsonResult DoEditPartner(partner partner, HttpPostedFileBase fileBase)
        {
            try
            {
                var dt = en.partners.FirstOrDefault(x => x.id == partner.id);

                if (dt.partner_image == "" && fileBase == null)
                {
                    throw new Exception("Vui lòng điền đầy đủ thông tin");
                }

                if (fileBase != null)
                {
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
                        dt.partner_image = fileName;
                    }
                    else
                    {
                        throw new Exception("Sai định dạng ảnh");
                    }
                }

                dt.partner_name = partner.partner_name;
                dt.description = partner.description;
                dt.email = partner.email;
                dt.phone = partner.phone;
                dt.address = partner.address;
                en.SaveChanges();

                return Json(new { result = true });
            }
            catch
            {
                throw;
            }
        }

        public JsonResult DeleteImagePartner(int id)
        {
            try
            {
                var dt = en.partners.FirstOrDefault(x => x.id == id);
                dt.partner_image = "";
                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw new Exception("Lỗi không xác định");
            }
        }

        public ActionResult EditDetail(int id)
        {
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    var post = en.posts.FirstOrDefault(x => x.id == id);
                    ViewBag.EditPost = post;
                    ViewBag.cate = en.categories.ToList();
                    ViewBag.partner = en.partners.ToList();
                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }

        [ValidateInput(false)]
        public JsonResult DoEditPost(post post, HttpPostedFileBase[] fileBase, HttpPostedFileBase thumbnail)
        {
            try
            {
                var data = en.posts.FirstOrDefault(x => x.id == post.id);

                var dt = en.image_post.Where(x => x.post_id == post.id).Count();

                if (data.image == "" && thumbnail == null)
                {
                    throw new Exception("Vui lòng điền đầy đủ thông tin");
                }

                if (dt == 0 && fileBase[0] == null)
                {
                    throw new Exception("Vui lòng điền đầy đủ thông tin");
                }

                if (fileBase.Length > 0 && fileBase[0] != null)
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
                data.partner_id = post.partner_id;
                data.time_end = post.time_end;
                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw;
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
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    ViewBag.post = en.posts.OrderByDescending(x => x.id).ToList();
                    ViewBag.partner = en.partners.ToList();
                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }
    }

}