using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GiveAID.Helpers
{
    public class ExceptionHandlingAttributeMVC : FilterAttribute, IExceptionFilter
    {
        private ErrorLog log = new ErrorLog();
        public void OnException(ExceptionContext context)
        {
            //ghi log loi ra txt, luu o app_data
            log.WriteLog(context.Exception, context.RouteData.Values["controller"].ToString(), context.RouteData.Values["action"].ToString(), context.RequestContext.HttpContext.Request.Params.ToString());

            //custom tra json error khi co exception
            context.HttpContext.Response.StatusCode = 500;
            context.ExceptionHandled = true;
            context.Result = new JsonResult
            {
                Data = new { error = context.Exception.Message },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };

        }
    }
}