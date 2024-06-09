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
              name: "User",
              url: "User-View",
              defaults: new { controller = "Admin", action = "UserL" }
             );

            routes.MapRoute(
             name: "ListPosts",
              url: "List-Posts",
             defaults: new { controller = "Admin", action = "CreateNews" }
           );

            routes.MapRoute(
              name: "ListParter",
               url: "List-Partners",
              defaults: new { controller = "Admin", action = "NewPartner" }
            );

            routes.MapRoute(
           name: "viewHomePartner",
           url: "Partner",
           defaults: new { controller = "Home", action = "Partner" }
           );

            routes.MapRoute(
             name: "ViewHome",
             url: "Home",
             defaults: new { controller = "Home", action = "Index"}
             );

            routes.MapRoute(
            name: "UserS",
             url: "User-{pagesize}/L-{page}",
             defaults: new { controller = "Admin", action = "UserL", page = UrlParameter.Optional, pagesize = UrlParameter.Optional }
            );

            routes.MapRoute(
             name: "PagePartner",
              url: "newPartner-{pagesize}/Page-{page}",
              defaults: new { controller = "Admin", action = "NewPartner", page = UrlParameter.Optional, pagesize = UrlParameter.Optional }
             );

            routes.MapRoute(
             name: "PagePosts",
             url: "createrNews-{pagesize}/page-{page}",
             defaults: new { controller = "Admin", action = "CreateNews", page = UrlParameter.Optional, pagesize = UrlParameter.Optional }
             );

            routes.MapRoute(
               name: "PagedPartner",
               url: "Home-{pagesize}/page-{page}",
               defaults: new { controller = "Home", action = "Partner", page = UrlParameter.Optional, pagesize = UrlParameter.Optional }
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
