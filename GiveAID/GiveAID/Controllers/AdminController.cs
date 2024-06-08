using GiveAID.Helpers;
using GiveAID.Models.entities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography.Xml;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

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
                    ViewBag.postCount = en.posts
                        .Count(x => x.time_start.Value.Year == DateTime.Now.Year && x.time_start.Value.Month == DateTime.Now.Month);

                    ViewBag.runningCount = en.posts
                        .Count(x => x.status == "Open" && x.time_start.Value.Year == DateTime.Now.Year && x.time_start.Value.Month == DateTime.Now.Month);

                    ViewBag.completeCount = en.posts
                        .Count(x => x.status == "Closed" && x.time_start.Value.Year == DateTime.Now.Year && x.time_start.Value.Month == DateTime.Now.Month);

                    ViewBag.sumTarget = en.posts
                        .Where(x => x.time_start.Value.Year == DateTime.Now.Year && x.time_start.Value.Month == DateTime.Now.Month)
                        .Sum(x => x.target);

                    ViewBag.sumAmout = en.payments
                        .Where(x => x.pay_status == "Success" && x.transaction_date.Value.Year == DateTime.Now.Year && x.transaction_date.Value.Month == DateTime.Now.Month)
                        .Sum(x => x.transaction_amout) ?? 0;
                    return View();
                }
            }

            return RedirectToAction("Index", "Login");

        }

        public ActionResult CreateNews(string search, string sortColumn, string sortOrder, int page = 1, int pagesize = 10)
        {
            if (CheckLogin())
            {
                var toTalPage = en.posts.Count();
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    var postQuery = en.posts.AsQueryable();

                    switch (sortColumn)
                    {
                        case "title":
                            postQuery = sortOrder == "asc" ? postQuery.OrderBy(x => x.title) : postQuery.OrderByDescending(x => x.title);
                            break;
                        case "target":
                            postQuery = sortOrder == "asc" ? postQuery.OrderBy(x => x.target) : postQuery.OrderByDescending(x => x.target);
                            break;
                        case "donated":
                            postQuery = sortOrder == "asc" ?
                                postQuery.OrderBy(x => x.payments.Where(p => p.pay_status == "Success").Sum(p => p.transaction_amout) ?? 0) :
                                postQuery.OrderByDescending(x => x.payments.Where(p => p.pay_status == "Success").Sum(p => p.transaction_amout) ?? 0);
                            break;
                        default:
                            postQuery = postQuery.OrderByDescending(x => x.id);
                            break;
                    }

                    var post = postQuery.Skip((page - 1) * pagesize).Take(pagesize).ToList();

                    if (!string.IsNullOrEmpty(search))
                    {
                        ViewBag.post = post.Where(x => x.title.ToUnsign().Contains(search)).ToList();
                    }
                    else
                    {
                        ViewBag.post = post;

                    }

                    ViewBag.CurrentPage = page;
                    ViewBag.TotalPagesRunning = (int)Math.Ceiling((double)toTalPage / pagesize);
                    ViewBag.search = search;
                    ViewBag.sortColumn = sortColumn;
                    ViewBag.sortOrder = sortOrder;

                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }


        public ActionResult NewPartner(string search, int page = 1, int pagesize = 5)
        {
            if (!CheckLogin())
                return RedirectToAction("Index", "Login");

            var toTalPage = en.partners.Count();
            var user = Session["USER"] as user;
            if (user.permission != "admin")
                return RedirectToAction("Index", "Login");

            ViewBag.partner = en.partners.OrderByDescending(x => x.id).Skip((page - 1) * pagesize)
                .Take(pagesize).ToList();

            if (!string.IsNullOrEmpty(search))
            {
                ViewBag.partner = en.partners.OrderByDescending(x => x.id).Skip((page - 1) * pagesize)
                .Take(pagesize).ToList().Where(x=>x.partner_name.ToUnsign().Contains(search)).ToList();
            }

            ViewBag.CurrentPage = page;
            ViewBag.TotalPagesRunning = (int)Math.Ceiling((double)toTalPage / pagesize);
            ViewBag.search = search;
            return View();
        }


        public ActionResult EditDetail(int? id = null)
        {
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                if (user.permission == "admin")
                {
                    var post = en.posts.FirstOrDefault(x => x.id == id);
                    ViewBag.EditPost = post == null ? new post() : post;
                    ViewBag.IsEditPost = post != null;
                    ViewBag.cate = en.categories.ToList();
                    ViewBag.partner = en.partners.Where(x => x.partner_status == "Open").ToList();
                    return View();
                }
            }
            return RedirectToAction("Index", "Login");
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult SubmitNews(post post, HttpPostedFileBase[] fileBase, HttpPostedFileBase thumbnail)
        {
            if (!string.IsNullOrWhiteSpace(post.title) &&
                !string.IsNullOrWhiteSpace(post.content) &&
                post.target > 0 && fileBase[0] != null &&
                thumbnail != null &&
                post.time_end != null)
            {

                if (post.title.Length() > 100)
                    throw new Exception("Max of title is 100 characters");

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
                        throw new Exception("Wrong image format");
                    }
                }

                string thumbExtension = Path.GetExtension(thumbnail.FileName).ToLower();
                if (thumbExtension != ".jpg" && thumbExtension != ".png" && thumbExtension != ".gif")
                {
                    throw new Exception("Wrong image format");
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
                throw new Exception("Please fill in all fields");
            }

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
                    throw new Exception("THUMBNAILS cannot be left blank");
                }

                if (dt == 0 && fileBase[0] == null)
                {
                    throw new Exception("IMAGES cannot be left blank");
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
                            throw new Exception("Wrong image format");
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

        public JsonResult ChangeStatusPost(int id)
        {
            try
            {
                var post = en.posts.FirstOrDefault(x => x.id == id);

                if (post.status == "Open")
                {
                    post.status = "Closed";
                }
                else
                {
                    var today = DateTime.Now.Date;
                    var amout = en.payments.Where(x => x.post_id == id && x.pay_status == "Thành công").Sum(x => x.transaction_amout);

                    if (post.time_end <= today)
                        throw new Exception("Please update time end");

                    if (post.target <= amout)
                        throw new Exception("Please update target");

                    post.status = "Open";
                }
                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw;
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




        public ActionResult EditPartner(int? id = null)
        {
            if (!CheckLogin())
                return RedirectToAction("Index", "Login");

            var user = Session["USER"] as user;
            if (user.permission != "admin")
                return RedirectToAction("Index", "Login");


            var dt = en.partners.FirstOrDefault(x => x.id == id);

            ViewBag.partner = dt == null ? new partner() : dt;
            ViewBag.IsEditing = dt != null;

            return View();
        }

        public JsonResult partnerNew(partner partner, HttpPostedFileBase fileBase)
        {
            if (string.IsNullOrWhiteSpace(partner.partner_name) ||
                fileBase == null ||
                string.IsNullOrWhiteSpace(partner.description) ||
                string.IsNullOrWhiteSpace(partner.address) ||
                string.IsNullOrWhiteSpace(partner.phone) ||
                string.IsNullOrWhiteSpace(partner.email))
            {
                throw new Exception("Please fill in all fields");
            }

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
                throw new Exception("Wrong image format");
            }
        }

        public JsonResult DoEditPartner(partner partner, HttpPostedFileBase fileBase)
        {
            try
            {
                if (partner.partner_name == null || partner.phone == null || partner.address == null || partner.description == null || partner.email == null)
                    throw new Exception("Please fill in all fields");

                var dt = en.partners.FirstOrDefault(x => x.id == partner.id);

                if (dt.partner_image == "" && fileBase == null)
                {
                    throw new Exception("Please fill in all fields");
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
                        throw new Exception("Wrong image format");
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



        public JsonResult ChangeStatusPartner(int id)
        {
            try
            {
                var partner = en.partners.FirstOrDefault(x => x.id == id);
                if (partner.partner_status == "Open")
                    partner.partner_status = "Closed";
                else
                    partner.partner_status = "Open";

                en.SaveChanges();
                return Json(new { result = true });
            }
            catch { throw; }
        }

        public JsonResult DeleteImagePartner(int id)
        {
            try
            {
                var dt = en.partners.FirstOrDefault(x => x.id == id);

                var filePath = Server.MapPath("~/Content/Images/partner/" + dt.partner_image);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }

                dt.partner_image = "";
                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw new Exception("Something went wrong. Please try again");
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

        public JsonResult DeleteImage(int id, int idPost)
        {
            var data = en.image_post.Count(x => x.post_id == idPost);
            if (data == 1)
                throw new Exception("You need to leave at least 1 photo");

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

        public ActionResult ViewConfiguration()
        {
            if (CheckLogin())
            {
                ViewBag.SysAddress = en.configurations.FirstOrDefault(x => x.keyword == "SYS_ADDRESS");
                ViewBag.SysEmail = en.configurations.FirstOrDefault(x => x.keyword == "SYS_EMAIL");
                ViewBag.SysPhone = en.configurations.FirstOrDefault(x => x.keyword == "SYS_PHONE");
                ViewBag.SysIntroduce = en.configurations.FirstOrDefault(x => x.keyword == "SYS_INTRODUCE");
                ViewBag.SysMailAddress = en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_ADDRESS");
                ViewBag.SysMailPass = DecryptDES(en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_PASS").value, SecretKey);
                ViewBag.SysMailPort = en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_PORT");
                ViewBag.smtp = en.configurations.FirstOrDefault(x => x.keyword == "SYS_SMTP_SERVER");
                ViewBag.MailUsername = en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_USERNAME");
                ViewBag.DisplayName = en.configurations.FirstOrDefault(x => x.keyword == "SYS_DISPLAY_NAME");
                ViewBag.ssl = en.configurations.FirstOrDefault(x => x.keyword == "SYS_SSL");
                ViewBag.banner = en.banners.ToList();
                return View();
            }
            return RedirectToAction("Index", "Login");
        }

        public JsonResult DeleteBanner(int id)
        {
            try
            {
                var banner = en.banners.FirstOrDefault(x => x.id == id);
                var filePath = Server.MapPath("~/Content/Images/banner/" + banner.banner_image);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }

                en.banners.Remove(banner);
                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw new Exception("Something went wrong. Please try again");
            }
        }

        public class ModelConfig
        {
            public string phone { get; set; }
            public string address { get; set; }
            public string email { get; set; }
            public string introduce { get; set; }
        }

        public JsonResult EditConfig(ModelConfig model, HttpPostedFileBase[] fileBase)
        {
            try
            {
                if (model.introduce == null || model.phone == null || model.email == null || model.address == null)
                    throw new Exception("Please fill in all fields");

                var image = en.banners.Count();
                if (image == 0 && fileBase[0] == null)
                    throw new Exception("IMAGES cannot be left blank");

                var SysPhone = en.configurations.FirstOrDefault(x => x.keyword == "SYS_PHONE");
                if (SysPhone == null)
                {
                    SysPhone = new configuration()
                    {
                        keyword = "SYS_PHONE"
                    };
                    en.configurations.Add(SysPhone);
                }
                SysPhone.value = model.phone;

                var SysAddress = en.configurations.FirstOrDefault(x => x.keyword == "SYS_ADDRESS");
                if (SysAddress == null)
                {
                    SysAddress = new configuration()
                    {
                        keyword = "SYS_ADDRESS"
                    };
                    en.configurations.Add(SysAddress);
                }
                SysAddress.value = model.address;

                var SysEmail = en.configurations.FirstOrDefault(x => x.keyword == "SYS_EMAIL");
                if (SysEmail == null)
                {
                    SysEmail = new configuration()
                    {
                        keyword = "SYS_EMAIL"
                    };
                    en.configurations.Add(SysEmail);
                }
                SysEmail.value = model.email;

                var SysIntroduce = en.configurations.FirstOrDefault(x => x.keyword == "SYS_INTRODUCE");
                if (SysIntroduce == null)
                {
                    SysIntroduce = new configuration()
                    {
                        keyword = "SYS_INTRODUCE"
                    };
                    en.configurations.Add(SysIntroduce);
                }
                SysIntroduce.value = model.introduce;

                if (fileBase != null && fileBase[0] != null)
                {
                    var PathUpload = Server.MapPath("/Content/Images/banner");
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
                            throw new Exception("Wrong image format");
                        }
                    }

                    foreach (var imageFile in imageFiles)
                    {
                        var imagePost = new banner()
                        {
                            banner_image = imageFile

                        };
                        en.banners.Add(imagePost);
                    }
                }

                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw;
            }
        }

        public class ModelMailCofig
        {
            public string MailAddress { get; set; }
            public string MailPass { get; set; }
            public string MailPort { get; set; }
            public string MailUsername { get; set; }
            public string DisplayName { get; set; }
            public string SmtpServer { get; set; }
            public string Ssl { get; set; }
        }

        public JsonResult EditMailConfig(ModelMailCofig model)
        {
            try
            {
                if (model.MailAddress == null || model.MailPass == null || model.MailPort == null)
                    throw new Exception("Please fill in all fields");

                var SysMailAddress = en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_ADDRESS");
                if (SysMailAddress == null)
                {
                    SysMailAddress = new configuration()
                    {
                        keyword = "SYS_MAIL_ADDRESS"
                    };
                    en.configurations.Add(SysMailAddress);
                }
                SysMailAddress.value = model.MailAddress;

                var SysMailPass = en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_PASS");
                if (SysMailPass == null)
                {
                    SysMailPass = new configuration()
                    {
                        keyword = "SYS_MAIL_PASS"
                    };
                    en.configurations.Add(SysMailPass);
                }
                SysMailPass.value = EncryptDES(model.MailPass, SecretKey);

                var SysMailPort = en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_PORT");
                if (SysMailPort == null)
                {
                    SysMailPort = new configuration()
                    {
                        keyword = "SYS_MAIL_PORT"
                    };
                    en.configurations.Add(SysMailPort);
                }
                SysMailPort.value = model.MailPort;

                var SysMailUserName = en.configurations.FirstOrDefault(x => x.keyword == "SYS_MAIL_USERNAME");
                if (SysMailUserName == null)
                {
                    SysMailUserName = new configuration()
                    {
                        keyword = "SYS_MAIL_USERNAME"
                    };
                    en.configurations.Add(SysMailUserName);
                }
                SysMailUserName.value = model.MailUsername;

                var SysDisplayName = en.configurations.FirstOrDefault(x => x.keyword == "SYS_DISPLAY_NAME");
                if (SysDisplayName == null)
                {
                    SysDisplayName = new configuration()
                    {
                        keyword = "SYS_DISPLAY_NAME"
                    };
                    en.configurations.Add(SysDisplayName);
                }
                SysDisplayName.value = model.DisplayName;

                var SmtpServer = en.configurations.FirstOrDefault(x => x.keyword == "SYS_SMTP_SERVER");
                if (SmtpServer == null)
                {
                    SmtpServer = new configuration()
                    {
                        keyword = "SYS_SMTP_SERVER"
                    };
                    en.configurations.Add(SmtpServer);
                }
                SysDisplayName.value = model.SmtpServer;

                var Ssl = en.configurations.FirstOrDefault(x => x.keyword == "SYS_SSL");
                if (Ssl == null)
                {
                    Ssl = new configuration()
                    {
                        keyword = "SYS_SSL"
                    };
                    en.configurations.Add(Ssl);
                }
                Ssl.value = model.Ssl;

                en.SaveChanges();
                return Json(new { result = true });
            }
            catch
            {
                throw;
            }
        }

        public JsonResult AddCategory(string name)
        {
            try
            {
                if (name == null)
                    throw new Exception("Please fill in the name of category");

                var check = en.categories.FirstOrDefault(x => x.name == name);
                if (check != null)
                    throw new Exception("The category name is exists");

                var newCate = new category { name = name };
                en.categories.Add(newCate);
                en.SaveChanges();
                return Json(new { result = true, newCate = new { cate_id = newCate.cate_id, name = newCate.name } });
            }
            catch
            {
                throw;
            }
        }
    }

}