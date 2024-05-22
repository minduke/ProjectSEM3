using GiveAID.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Timers;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace GiveAID
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            Timer timerForDate = new Timer();
            timerForDate.Elapsed += new ElapsedEventHandler(ChangeStatusByDate);
            timerForDate.Interval = 43200000; // 1000ms is a second, so 43200000ms is 12 hours
            timerForDate.Start();

            Timer timerForTarget = new Timer();
            timerForTarget.Elapsed += new ElapsedEventHandler(ChangeStatusByTarget);
            timerForTarget.Interval = 1000;
            timerForTarget.Start();
        }

        private void ChangeStatusByDate(object sender, ElapsedEventArgs e)
        {
            BaseController baseController = new BaseController();
            baseController.UpdateStatusByDate();
        }

        private void ChangeStatusByTarget(object sender, ElapsedEventArgs e)
        {
            BaseController baseController = new BaseController();
            baseController.UpdateStatusByTarget();
        }
    }
}
