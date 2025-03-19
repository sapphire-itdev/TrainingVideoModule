<%@ WebHandler Language="C#" Class="FileUploadHandler" %>

using System;
using System.IO;
using System.Web;

public class FileUploadHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            HttpPostedFile file = context.Request.Files["file"];
            if (file != null && file.ContentLength > 0)
            {
                string uploadFolder = HttpContext.Current.Server.MapPath("~/Videos/"); // Ensure this folder exists
                if (!Directory.Exists(uploadFolder))
                {
                    Directory.CreateDirectory(uploadFolder);
                }

                // Get original file extension
                string originalFileName = Path.GetFileNameWithoutExtension(file.FileName);
                string fileExtension = Path.GetExtension(file.FileName);

                // Append datetime string to filename (e.g., MyFile_20250309_153045.jpg)
                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string newFileName = $"{originalFileName}_{timestamp}{fileExtension}";

                // Define the final file path
                string filePath = Path.Combine(uploadFolder, newFileName);

                // Save the file
                file.SaveAs(filePath);

                // Respond with the new file name
                context.Response.ContentType = "text/plain";
                context.Response.Write(newFileName);
            }
            else
            {
                context.Response.StatusCode = 400; // Bad Request
                context.Response.Write("No file uploaded.");
            }
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500; // Internal Server Error
            context.Response.Write("Error: " + ex.Message);
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}