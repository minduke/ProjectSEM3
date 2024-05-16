using GiveAID.Models.entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GiveAID.Controllers
{
    public class HomeController : BaseController
    {
        GiveAIDEntities en = new GiveAIDEntities();

        public ActionResult Index()
        {
            var posts = en.posts.ToList();
            ViewBag.posts = posts;
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
            return View();
        }

    }
}