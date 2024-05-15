using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace GiveAID.Helpers
{
    public class ErrorLog
    {
        public void WriteLog(Exception objErr, string Controller = "", string Function = "", string param = "")
        {
            try
            {
                StringBuilder err = new StringBuilder();
                err.AppendLine("Datetime: " + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));
                err.AppendLine("Controller: " + Controller);
                err.AppendLine("Function: " + Function);
                err.AppendLine("Params: " + param);
                err.AppendLine("Error message: " + objErr.Message.ToString());
                err.AppendLine("Stack trace: " + objErr.StackTrace);

                string fileAttachInfo = AppDomain.CurrentDomain.BaseDirectory + "\\App_Data\\ErrorLog\\" + DateTime.Now.ToString("yyyyMMdd") + "\\";
                if (!System.IO.Directory.Exists(fileAttachInfo))
                {
                    System.IO.Directory.CreateDirectory(fileAttachInfo);
                }

                string logFile = string.Empty;
                System.IO.StreamWriter logWriter = null;
                logFile = fileAttachInfo + "ErrorLog_" + DateTime.Now.ToString("yyyyMMdd_HH") + ".txt";

                if (System.IO.File.Exists(logFile))
                {
                    logWriter = System.IO.File.AppendText(logFile);
                }
                else
                {
                    logWriter = System.IO.File.CreateText(logFile);
                }
                logWriter.WriteLine(err.ToString());
                logWriter.Close();
            }
            catch
            {

            }

        }
    }
}