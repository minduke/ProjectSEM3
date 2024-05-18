using GiveAID.Models.entities;
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

namespace GiveAID.Controllers
{
    public class HomeController : BaseController
    {
        //private static readonly ILog log =
        //  LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        GiveAIDEntities en = new GiveAIDEntities();

        public ActionResult Index(int page = 1, int pageSize = 3)
        {

            var posts = en.posts.ToList();
            int totalPosts = posts.Count;
            int totalPages = (int)Math.Ceiling((double)totalPosts / pageSize);

            posts = posts.Skip((page - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.posts = posts;
            ViewBag.TotalPosts = totalPosts;
            ViewBag.CurrentPage = page;
            ViewBag.PageSize = pageSize;
            ViewBag.TotalPages = totalPages;
            return View();


        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult CardDetails(int id)
        {
            var detail = en.posts.FirstOrDefault(x => x.id == id);
            ViewBag.cardDetails = detail;
            var donater = en.payments.Where(x => x.post_id == id).ToList();
            ViewBag.donater = donater;
            return View();
        }

        public ActionResult sendMail()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SendEmail(string toAddress, string subject, string body)
        {
            // Thiết lập thông tin tài khoản email
            string fromAddress = "vuvunguyen12345@gmail.com";
            string password = "viovutezgtdjjvar";

            // Tạo đối tượng MailMessage
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(fromAddress);
            mail.To.Add(new MailAddress(toAddress));
            mail.Subject = subject;
            mail.Body = body;

            // Thiết lập thông tin SMTP Server
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
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
            finally
            {
                // Giải phóng tài nguyên
                mail.Dispose();
                smtp.Dispose();
            }
        }

        public void Donate(int transaction_amout, int id)
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

            vnpay.AddRequestData("vnp_CreateDate", payment.transaction_date.ToString("yyyyMMddHHmmss"));
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




    }
}