using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace GiveAID
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // Route cho phân trang với URL thân thiện

            routes.MapRoute(
             name: "ViewHome",
             url: "Home",
             defaults: new { controller = "Home", action = "Index"}
         );


            routes.MapRoute(
                name: "PagedPosts",
                url: "View-{pageSize}/Page-{page}",
                defaults: new { controller = "Home", action = "Index", page = UrlParameter.Optional, pageSize = UrlParameter.Optional }
            );


            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
