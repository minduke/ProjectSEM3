using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GiveAID.Controllers
{
    public class ErrorController : BaseController
    {
     
        public ActionResult Error404() { return View(); }
        public ActionResult Error503() { return View(); }


    }
}