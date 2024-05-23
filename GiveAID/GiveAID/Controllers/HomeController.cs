using GiveAID.Models.entities;
using GiveAID.Models.model_view;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GiveAID.Helpers;
using WebGrease;
using Microsoft.Ajax.Utilities;
using System.Runtime.InteropServices;

namespace GiveAID.Controllers
{
    public class HomeController : BaseController
    {
        //private static readonly ILog log =
        //  LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        GiveAIDEntities en = new GiveAIDEntities();

       public ActionResult DonationP()
        {
            return View();
        }

        public ActionResult Index(int page = 1, int pageSize = 3)
        {

            int totalPosts = en.posts.Count();

            int totalPages = (int)Math.Ceiling((double)totalPosts / pageSize);

            int maxDisplayPages = 3; // Số lượng ô phân trang hiển thị

            int startPage = ((page - 1) / maxDisplayPages) * maxDisplayPages + 1;
            int endPage = Math.Min(startPage + maxDisplayPages - 1, totalPages);
            // Lọc và phân trang trực tiếp trên truy vấn
            var posts = en.sp_GetPost()
                            .Select(x => new ViewPost
                            {
                                id = x.id,
                                title = x.title,
                                image = x.image,
                                target = (decimal)x.target,
                                cate_id = x.cate_id,
                                cate_name = x.name,
                                partner_name = x.partner_name,
                                total = (decimal)x.total
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


            return View();

        }

       

        //public class ViewPost
        //{
        //    public int id { get; set; }
        //    public string title { get; set; }
        //    public string image { get; set; }
        //    public decimal target { get; set; }
        //    public int cate_id { get; set; }
        //    public string name { get; set; }
        //    public decimal total { get; set; }
        //}

        public ActionResult CardDetails(int id)
        {
            var detail = en.posts.FirstOrDefault(x => x.id == id);
            ViewBag.cardDetails = detail;
            var donater = en.payments.Where(x => x.post_id == id).ToList();
            ViewBag.donater = donater;
            var sum = en.payments.Where(x => x.id == id).Sum(x => x.transaction_amout);
            ViewBag.sum = sum;
            return View();
        }

        public ActionResult sendMail()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SendEmail(string toAddress, string subject, string body)
        {
            if (CheckLogin())
            {
                // Thiết lập thông tin tài khoản email
                string fromAddress = "vuvunguyen12345@gmail.com";
                string password = "viovutezgtdjjvar";

                // Xây dựng URL động
                string url = Url.Action("CardDetails", "Home", new { id = 14 }, Request.Url.Scheme);
                string emailBody = $"Tham gia link cá độ đi nè: <a href='{url}'>{url}</a>";

                // Tạo đối tượng MailMessage
                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(fromAddress);
                    mail.To.Add(new MailAddress(toAddress));
                    mail.Subject = subject;
                    mail.Body = emailBody;
                    mail.IsBodyHtml = true; // Đảm bảo nội dung email được gửi dưới dạng HTML

                    // Thiết lập thông tin SMTP Server
                    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                    {
                        smtp.EnableSsl = true;
                        smtp.Credentials = new NetworkCredential(fromAddress, password);

                        try
                        {
                            // Gửi email
                            smtp.Send(mail);
                            return Content("Email sent successfully!");
                        }
                        catch (SmtpException ex)
                        {
                            return Content("Failed to send email. Error: " + ex.Message);
                        }
                    }
                }
            }

            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        public void Donate(int transaction_amout, int id)
        {
            if (CheckLogin())
            {
                //Get Config Info
                string vnp_Returnurl = "https://localhost:44311/home/result"; //URL nhan ket qua tra ve 
                string vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html"; //URL thanh toan cua VNPAY 
                string vnp_TmnCode = "TXK5WD36"; //Ma định danh merchant kết nối (Terminal Id)
                string vnp_HashSecret = "J6O0W70J5QTK03K66VLSVO2PR6M7ASLM"; //Secret Key

                //Get payment input
                //OrderInfo order = new OrderInfo();
                //order.OrderId = DateTime.Now.Ticks; // Giả lập mã giao dịch hệ thống merchant gửi sang VNPAY
                //order.Amount = 100000; // Giả lập số tiền thanh toán hệ thống merchant gửi sang VNPAY 100,000 VND
                //order.Status = "0"; //0: Trạng thái thanh toán "chờ thanh toán" hoặc "Pending" khởi tạo giao dịch chưa có IPN
                //order.CreatedDate = DateTime.Now;

                //Save order to db
                payment payment = new payment();
                payment.transaction_amout = transaction_amout;
                payment.user_id = 1;
                payment.transaction_date = DateTime.Now;
                payment.post_id = id;
                en.payments.Add(payment);
                en.SaveChanges();

                int PayId = payment.id;
                //Build URL for VNPAY
                VnPayLibrary vnpay = new VnPayLibrary();

                vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
                vnpay.AddRequestData("vnp_Command", "pay");
                vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
                vnpay.AddRequestData("vnp_Amount", (payment.transaction_amout * 100).ToString()); //Số tiền thanh toán. Số tiền không mang các ký tự phân tách thập phân, phần nghìn, ký tự tiền tệ. Để gửi số tiền thanh toán là 100,000 VND (một trăm nghìn VNĐ) thì merchant cần nhân thêm 100 lần (khử phần thập phân), sau đó gửi sang VNPAY là: 10000000
                                                                                                  //if (bankcode_Vnpayqr.Checked == true)
                                                                                                  //{
                                                                                                  //    vnpay.AddRequestData("vnp_BankCode", "VNPAYQR");
                                                                                                  //}
                                                                                                  //else if (bankcode_Vnbank.Checked == true)
                                                                                                  //{
                vnpay.AddRequestData("vnp_BankCode", "VNBANK");
                //}
                //else if (bankcode_Intcard.Checked == true)
                //{
                //    vnpay.AddRequestData("vnp_BankCode", "INTCARD");
                //}

                vnpay.AddRequestData("vnp_CreateDate", payment.transaction_date.Value.ToString("yyyyMMddHHmmss"));
                vnpay.AddRequestData("vnp_CurrCode", "VND");
                vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());

                //if (locale_Vn.Checked == true)
                //{
                vnpay.AddRequestData("vnp_Locale", "vn");
                //}
                //else if (locale_En.Checked == true)
                //{
                //    vnpay.AddRequestData("vnp_Locale", "en");
                //}
                vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:" + PayId);
                vnpay.AddRequestData("vnp_OrderType", "other"); //default value: other

                vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
                vnpay.AddRequestData("vnp_TxnRef", PayId.ToString()); // Mã tham chiếu của giao dịch tại hệ thống của merchant. Mã này là duy nhất dùng để phân biệt các đơn hàng gửi sang VNPAY. Không được trùng lặp trong ngày

                //Add Params of 2.1.0 Version
                //Billing

                string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
                //log.InfoFormat("VNPAY URL: {0}", paymentUrl);
                Response.Redirect(paymentUrl);
                //RedirectToRoute(paymentUrl);
            }
            else
            {
                Response.Redirect("~/Login");
            }
        }

        public ActionResult Result()
        {
            string transaction_no = Request.QueryString["vnp_TransactionNo"];
            string response_code = Request.QueryString["vnp_ResponseCode"];
            int id = Int32.Parse(Request.QueryString["vnp_TxnRef"]);

            ViewBag.transaction_no = transaction_no;
            ViewBag.response_code = response_code;
            ViewBag.id = id;

            var data = en.payments.FirstOrDefault(x => x.id == id);
            data.transaction_no = transaction_no;
            en.SaveChanges();
            return View();
        }

        public ActionResult InforUser()
        {
            if (CheckLogin())
            {
                var user = Session["USER"] as user;
                var info = en.users.FirstOrDefault(x => x.id == user.id);
                ViewBag.infor = info;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        public JsonResult EditUser(user user)
        {
            if (CheckLogin())
            {
                var a = Session["USER"] as user;
                var edit = en.users.FirstOrDefault(x => x.id == a.id);
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
                return Json(new { result = true });
            }
            throw new Exception("something wrong");
        }


        public ActionResult About()
        {


            return View();
        }

        public ActionResult Contact()
        {


            return View();
        }

        [HttpPost]
        public JsonResult chartJS()
        {
            var listU = en.payments.Where(x => !string.IsNullOrEmpty(x.transaction_no)) // Lọc các bản ghi với giá trị transaction_no không rỗng
    .Select(x => new
    {
        x.transaction_no
    })
    .ToList();

            return Json(listU);
        }

        public ActionResult TestView() { return View(); }
    }
}