<%@ WebHandler Language="C#" Class="VideoUploadHandler" %>

using System;
using System.IO;
using System.Web;
using System.Linq;

public class VideoUploadHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (context.Request.Files.Count == 0)
            {
                throw new Exception("No file uploaded.");
            }

            HttpPostedFile file = context.Request.Files[0];

            int maxFileSize = 50 * 1024 * 1024; // 50MB
            if (file.ContentLength > maxFileSize)
            {
                throw new Exception("File size exceeds 50MB limit.");
            }

            string[] allowedExtensions = { ".mp4", ".mov", ".avi", ".wmv" };
            string fileExt = Path.GetExtension(file.FileName).ToLower();

            if (!allowedExtensions.Contains(fileExt))
            {
                throw new Exception("Invalid file format. Allowed: MP4, MOV, AVI, WMV.");
            }

            string videoDir = context.Server.MapPath("~/Videos/");
            if (!Directory.Exists(videoDir))
            {
                Directory.CreateDirectory(videoDir);
            }

            string fileName = Path.GetFileNameWithoutExtension(file.FileName);
            string uniqueFileName = $"{fileName}_{Guid.NewGuid()}{fileExt}";
            string filePath = Path.Combine(videoDir, uniqueFileName);

            file.SaveAs(filePath);

            string videoUrl = "/Videos/" + uniqueFileName;
            string mimeType = GetMimeType(fileExt);

            context.Response.ContentType = "text/html";
            context.Response.Write($"<video width='400' controls><source src='{videoUrl}' type='{mimeType}'></video>");
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.Write("Server Error: " + ex.Message);
        }
    }

    private static string GetMimeType(string fileExt)
    {
        switch (fileExt)
        {
            case ".mp4": return "video/mp4";
            case ".mov": return "video/quicktime";
            case ".avi": return "video/x-msvideo";
            case ".wmv": return "video/x-ms-wmv";
            default: return "application/octet-stream";
        }
    }

    public bool IsReusable => false;
}
