using GiveAID.Models.entities;
using GiveAID.Models.model_view;
using System;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GiveAID.Helpers;
using Microsoft.Ajax.Utilities;
using System.Globalization;
using System.IO;
using System.Data.Entity;

namespace GiveAID.Controllers
{
    public class HomeController : BaseController
    {

        GiveAIDEntities en = new GiveAIDEntities();

        private static string vnp_TmnCode = "URFUYJCU"; //Ma định danh merchant kết nối (Terminal Id)
        private static string vnp_HashSecret = "E9I897QUPGE8T9T41D62F5JQ3GVDILBP"; //Secret Key

        public ActionResult DonationP()
        {


            ViewBag.donation = en.posts
                .Select(s => new ViewPost
                {
                    id = s.id,
                    title = s.title,
                    image = s.image,
                    target = s.target ?? 0,
                    cate_name = s.category.name,
                    partner_image = s.partner.partner_image,
                    partner_name = s.partner.partner_name,
                    total = s.payments.Any(x => x.pay_status == "Thành công") ? s.payments.Where(x => x.pay_status == "Thành công").Sum(x => x.transaction_amout ?? 0) : 0
                })
                .OrderByDescending(x => x.id)
                .ToList();

            ViewBag.banner = en.banners.ToList();
            return View();
        }

        public ActionResult FilterPost(string filter)
        {
            var query = en.posts
                .Select(s => new ViewPost
                {
                    id = s.id,
                    title = s.title,
                    image = s.image,
                    target = s.target ?? 0,
                    cate_name = s.category.name,
                    partner_image = s.partner.partner_image,
                    partner_name = s.partner.partner_name,
                    total = s.payments.Any(x => x.pay_status == "Thành công") ? s.payments.Where(x => x.pay_status == "Thành công").Sum(x => x.transaction_amout ?? 0) : 0,
                    status = s.status
                });

            switch (filter)
            {
                case "1":
                    query = query.Where(x => x.status == "Đóng");
                    break;
                case "2":
                    query = query.OrderByDescending(x => x.target);
                    break;
                case "3":
                    query = query.OrderBy(x => x.target);
                    break;
                default:
                    break;
            }

            var filterPosts = query.ToList();

            return PartialView("_FilterView", filterPosts);
        }

        public ActionResult Index(int page = 1, int pageSize = 3)
        {

            int totalPosts = en.posts.Where(s => s.status == "Mở").Count();

            int totalPages = (int)Math.Ceiling((double)totalPosts / pageSize);

            int maxDisplayPages = 3; // Số lượng ô phân trang hiển thị

            int startPage = ((page - 1) / maxDisplayPages) * maxDisplayPages + 1;
            int endPage = Math.Min(startPage + maxDisplayPages - 1, totalPages);

            var posts = en.posts
                .Where(s => s.status == "Mở")
                .Select(s => new ViewPost
                {
                    id = s.id,
                    title = s.title,
                    image = s.image,
                    target = s.target ?? 0,
                    cate_name = s.category.name,
                    partner_image = s.partner.partner_image,
                    partner_name = s.partner.partner_name,
                    total = s.payments.Any(x => x.pay_status == "Thành công") ? s.payments.Where(x => x.pay_status == "Thành công").Sum(x => x.transaction_amout ?? 0) : 0
                })
                .OrderByDescending(x => x.id)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.posts = posts;
            ViewBag.TotalPosts = totalPosts;
            ViewBag.CurrentPage = page;
            ViewBag.PageSize = pageSize;
            ViewBag.TotalPages = totalPages;
            ViewBag.StartPage = startPage;
            ViewBag.EndPage = endPage;
            ViewBag.categories = en.categories.ToList();
            ViewBag.banner = en.banners.ToList();

            return View();

        }

        public ActionResult CardDetails(int id)
        {
            var detail = en.posts.FirstOrDefault(x => x.id == id);
            ViewBag.cardDetails = detail;
            var donater = en.payments.Where(x => x.post_id == id).ToList();
            ViewBag.donater = donater;
            var sum = en.payments.Where(x => x.post_id == id && x.pay_status == "Thành công").Sum(x => x.transaction_amout) ?? 0;
            ViewBag.sum = sum;
            return View();
        }

        public JsonResult InviteMail(string linkPost, string receiverEmails, string titlePost)
        {
            try
            {
                if (CheckLogin())
                {
                    DateTime savedTime = new DateTime();
                    if (Session["TimeSendMail"] != null)
                    {
                        savedTime = (DateTime)Session["TimeSendMail"];
                    }

                    DateTime currentTime = DateTime.Now;

                    DateTime future = savedTime.AddMinutes(5);
                    TimeSpan timeSubtract = future - currentTime;

                    string[] receiverEmail = receiverEmails.Split(',');
                    foreach(var item in receiverEmail)
                    {
                        if (!IsValidEmail(item))
                        {
                            throw new Exception("Email is not valid");
                        }
                    }

                    if (Session["TimeSendMail"] == null || timeSubtract.TotalMinutes <= 0)
                    {
                        SendMailInvite(receiverEmail, linkPost, titlePost);
                        Session["TimeSendMail"] = DateTime.Now;
                        return Json(new { result = true });
                    }
                    else
                    {
                        throw new Exception("Please wait " + (int)timeSubtract.TotalMinutes + " minutes to continue sending");
                    }
                }
                else
                {
                    return Json(new { result = false });
                }
            }
            catch
            {
                throw;
            }
        }

        public class DonateModel
        {
            public int idPost { get; set; }
            public decimal target { get; set; }
            public decimal amout { get; set; }
            public int transaction_amout { get; set; }
            public decimal balance { get; set; }
        }

        public JsonResult Donate(DonateModel model)
        {
            if (CheckLogin())
            {
                var post = en.posts.FirstOrDefault(x => x.id == model.idPost);
                if (post.status == "Đóng")
                    throw new Exception("Cannot donate for this case");

                //Get Config Info
                string vnp_Returnurl = "https://localhost:44311/home/result"; //URL nhan ket qua tra ve 
                string vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html"; //URL thanh toan cua VNPAY 


                var user = Session["USER"] as user;

                if (model.transaction_amout > model.balance || model.transaction_amout < 5000)
                {
                    throw new Exception("Invalid amout");
                }

                //Save order to db
                payment payment = new payment();
                payment.transaction_amout = model.transaction_amout;
                payment.user_id = user.id;
                payment.transaction_date = DateTime.Now;
                payment.post_id = model.idPost;
                en.payments.Add(payment);
                en.SaveChanges();

                int PayId = payment.id;
                //Build URL for VNPAY
                VnPayLibrary vnpay = new VnPayLibrary();

                vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
                vnpay.AddRequestData("vnp_Command", "pay");
                vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
                vnpay.AddRequestData("vnp_Amount", (payment.transaction_amout * 100).ToString()); //Số tiền thanh toán. Số tiền không mang các ký tự phân tách thập phân, phần nghìn, ký tự tiền tệ. Để gửi số tiền thanh toán là 100,000 VND (một trăm nghìn VNĐ) thì merchant cần nhân thêm 100 lần (khử phần thập phân), sau đó gửi sang VNPAY là: 10000000

                vnpay.AddRequestData("vnp_BankCode", "VNBANK");

                vnpay.AddRequestData("vnp_CreateDate", payment.transaction_date.Value.ToString("yyyyMMddHHmmss"));
                vnpay.AddRequestData("vnp_CurrCode", "VND");
                vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());


                vnpay.AddRequestData("vnp_Locale", "vn");

                vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:" + PayId);
                vnpay.AddRequestData("vnp_OrderType", "other"); //default value: other

                vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
                vnpay.AddRequestData("vnp_TxnRef", PayId.ToString()); // Mã tham chiếu của giao dịch tại hệ thống của merchant. Mã này là duy nhất dùng để phân biệt các đơn hàng gửi sang VNPAY. Không được trùng lặp trong ngày

                //Add Params of 2.1.0 Version
                //Billing

                string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);

                return Json(new { result = true, url = paymentUrl });
            }
            else
            {
                return Json(new { result = false, url = "~/Login" });
            }
        }

        public ActionResult Result()
        {
            string transaction_no = Request.QueryString["vnp_TransactionNo"];
            string response_code = Request.QueryString["vnp_ResponseCode"];
            int id = Int32.Parse(Request.QueryString["vnp_TxnRef"]);
            string banktran_no = Request.QueryString["vnp_BankTranNo"];
            string payDate = Request.QueryString["vnp_PayDate"];
            string TmnCode = Request.QueryString["vnp_TmnCode"];

            if (response_code == "00" && TmnCode == vnp_TmnCode)
            {
                DateTime dateTime = DateTime.ParseExact(payDate, "yyyyMMddHHmmss", CultureInfo.InvariantCulture);

                var data = en.payments.FirstOrDefault(x => x.id == id);
                data.transaction_no = transaction_no;
                data.pay_status = "Thành công";
                data.transaction_date = dateTime;
                data.banktran_no = banktran_no;
                en.SaveChanges();

                ViewBag.data = data;
            }
            return View();
        }

        public ActionResult InforUser()
        {
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                var info = en.users.FirstOrDefault(x => x.id == user.id);
                var donate = en.payments.Where(x => x.user_id == user.id).Take(5).OrderByDescending(x => x.transaction_date).ToList();
                ViewBag.donate = donate;
                ViewBag.infor = info;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        public JsonResult EditUser(user user, HttpPostedFileBase thumbnail)
        {
            if (CheckLogin())
            {
                var PathUpload = Server.MapPath("/Content/Images/user");
                if (!Directory.Exists(PathUpload))
                {
                    Directory.CreateDirectory(PathUpload);
                }

                var a = Session["USER"] as user;
                var edit = en.users.FirstOrDefault(x => x.id == a.id);

                if (thumbnail != null)
                {
                    string thumbExtension = Path.GetExtension(thumbnail.FileName).ToLower();
                    if (thumbExtension != ".jpg" && thumbExtension != ".png" && thumbExtension != ".gif")
                    {
                        throw new Exception("Wrong image format");
                    }

                    var thumbName = DateTime.Now.Ticks + "_" + thumbnail.FileName;
                    var thumbPath = Path.Combine(PathUpload, thumbName);
                    thumbnail.SaveAs(thumbPath);
                    edit.image = thumbName;
                }

                edit.fullname = user.fullname;
                edit.phone = user.phone;
                edit.email = user.email;

                if (user.address.IsNullOrWhiteSpace())
                {
                    edit.address = "";
                }
                else
                {
                    edit.address = user.address;
                }

                en.SaveChanges();

                var updateUser = en.users.FirstOrDefault(x => x.id == edit.id);
                return Json(new
                {
                    result = true,
                    data = new
                    {
                        fullname = updateUser.fullname,
                        phone = updateUser.phone,
                        email = updateUser.email,
                        address = updateUser.address,
                        image = updateUser.image
                    }
                });
            }
            throw new Exception("Something went wrong. Please try again");
        }


        public ActionResult About()
        {
            ViewBag.SysEmail = en.configurations.FirstOrDefault(x => x.keyword == "SYS_EMAIL");
            ViewBag.SysPhone = en.configurations.FirstOrDefault(x => x.keyword == "SYS_PHONE");
            ViewBag.SysAddress = en.configurations.FirstOrDefault(x => x.keyword == "SYS_ADDRESS");
            ViewBag.partner = en.partners.ToList();

            return View();
        }



        [HttpPost]
        public JsonResult chartJS()
        {
            var listU = en.payments
                .Where(x => x.pay_status == "Thành công")
                .Select(s => new
                {
                    s.transaction_amout
                });

            return Json(listU);
        }

        [HttpPost]
        public JsonResult ChartData()
        {

            var chartJS = en.categories.Select(s => new ModelChart
            {
                name = s.name,
                count = s.posts.Count,
            });
            return Json(chartJS);

        }

        public class ModelChart
        {
            public string name { get; set; }
            public int count { get; set; }
        }

        public JsonResult FilterChart(int year, int month)
        {
            var payments = en.payments
                .Where(x => x.transaction_date.Value.Year == year && x.transaction_date.Value.Month == month && x.pay_status == "Thành công")
                .Select(s => new
                {
                    s.transaction_amout
                });

            var cate = en.categories.Select(s => new ModelChart
            {
                name = s.name,
                count = s.posts.Count(x => x.time_start.Value.Year == year && x.time_start.Value.Month == month)
            });

            var postCount = en.posts.Count(x => x.time_start.Value.Year == year && x.time_start.Value.Month == month);
            var runningCount = en.posts.Count(x => x.time_start.Value.Year == year && x.time_start.Value.Month == month && x.status == "Mở");
            var completeCount = en.posts.Count(x => x.time_start.Value.Year == year && x.time_start.Value.Month == month && x.status == "Đóng");
            var sumTarget = en.posts.Where(x => x.time_start.Value.Year == year && x.time_start.Value.Month == month).Sum(x => x.target) ?? 0;
            var sumAmout = en.payments.Where(x => x.pay_status == "Thành công" && x.transaction_date.Value.Year == year && x.transaction_date.Value.Month == month).Sum(x => x.transaction_amout) ?? 0;

            return Json(new
            {
                payments,
                postCount,
                runningCount,
                completeCount,
                sumTarget,
                sumAmout,
                cate
            });
        }

   

        public ActionResult Detail(int id)
        {
            ViewBag.posts = en.posts
                .Where(s => s.status == "Mở" && s.cate_id == id)
                .Select(s => new ViewPost
                {
                    id = s.id,
                    title = s.title,
                    image = s.image,
                    target = s.target ?? 0,
                    cate_name = s.category.name,
                    partner_image = s.partner.partner_image,
                    partner_name = s.partner.partner_name,
                    total = s.payments.Any(x => x.pay_status == "Thành công") ? s.payments.Where(x => x.pay_status == "Thành công").Sum(x => x.transaction_amout ?? 0) : 0
                })
                .OrderByDescending(s => s.id)
                .ToList();

            ViewBag.banner = en.banners.ToList();
            ViewBag.categories = en.categories.ToList();
            return View();
        }

        public ActionResult Partner(int page = 1, int pagesize = 6)
        {
            var totalPage = en.partners.Count();
            ViewBag.partner = en.partners.OrderByDescending(x => x.id).Skip((page - 1) * pagesize)
                .Take(pagesize).ToList();
            ViewBag.CurrentPage = page;
            ViewBag.TotalPagesRunning = (int)Math.Ceiling((double)totalPage / pagesize);

            return View();
        }

        public ActionResult helpCenter()
        {
        return View(); 
        }


    }
}