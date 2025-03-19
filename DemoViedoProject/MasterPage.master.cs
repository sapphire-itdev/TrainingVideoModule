using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net.Mail;

public partial class MasterPage : System.Web.UI.MasterPage
{
   // ClsPettyCash objven = new ClsPettyCash();

    string uid, uname, utype;
    protected void Page_Load(object sender, EventArgs e)
    {
        //uid = "001";
        //uname = "Srishti";
        //utype = "1";

        //if (Session["uid"] != null)
        //{
        //    utype = Session["utype"].ToString();
        //    uid = Session["uid"].ToString();
        //    uname = Session["uname"].ToString();

        //    if (uname != null)
        //    {
        //        plcuname.Controls.Add(new LiteralControl("<span class='d-none d-xl-inline-block ms-1' key='t-henry'>" + uname + "</span>"));
        //    }

        //    bindmenu();
        //}
        //else
        //{
        //    Session.Abandon();
        //    Session.Clear();
        //    Response.Redirect("https://portals.sapphirefoods.in/");
        //}

    }

    //private void bindmenu()
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        ds = objven.bindmenu(utype);

    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
    //            {
    //                string submenustr = "";
    //                string menuname = ds.Tables[0].Rows[i]["m_name"].ToString();
    //                string menuid = ds.Tables[0].Rows[i]["mid"].ToString();
    //                string menulink = ds.Tables[0].Rows[i]["m_pagelink"].ToString();
    //                string menuicon = ds.Tables[0].Rows[i]["m_icon"].ToString();
    //                string menuli = ds.Tables[0].Rows[i]["m_li"].ToString();
    //                string menuclass = ds.Tables[0].Rows[i]["m_class"].ToString();

    //                DataSet ds1 = new DataSet();
    //                ds1 = objven.bindsubmenu(menuid, utype);

    //                if (ds1.Tables[0].Rows.Count > 0)
    //                {
    //                    for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
    //                    {
    //                        string submenuname = ds1.Tables[0].Rows[j]["m_name"].ToString();
    //                        string submenuid = ds1.Tables[0].Rows[j]["mid"].ToString();
    //                        string submenulink = ds1.Tables[0].Rows[j]["m_pagelink"].ToString();


    //                        submenustr += "<li><a href='/" + submenulink + "'>" + submenuname + "</a></li>";
    //                    }

    //                    plcmenu.Controls.Add(new LiteralControl("<li class='" + menuli + "'><a href='javascript: void(0);' class='" + menuclass + "'><i class='" + menuicon + "'></i><span>" + menuname + "</span></a><ul class='sub-menu' aria-expanded='true'>" + submenustr + "</ul></li>"));
    //                }
    //                else
    //                {
    //                    plcmenu.Controls.Add(new LiteralControl("<li class='" + menuli + "'><a href='/" + menulink + "' class='" + menuclass + "'><i class='" + menuicon + "'></i><span>" + menuname + "</span></a></li>"));
    //                }

    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        writetolog(ex.ToString());
    //    }
    //}

    //private void writetolog(string v)
    //{
    //    string errorlog, user, user_type, pagename, user_mail;

    //    errorlog = v.ToString();

    //    DataSet ds = objven.checkempid(uid);
    //    pagename = "MasterPage.master";

    //    user = ds.Tables[0].Rows[0]["user_name"].ToString();
    //    user_type = ds.Tables[0].Rows[0]["user_type"].ToString();
    //    user_mail = ds.Tables[0].Rows[0]["user_email"].ToString();

    //    objven.inserterrorlog(errorlog, user, user_type, user_mail, pagename, uid);

    //    System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
    //    SmtpClient SmtpServer = new SmtpClient("smtp.office365.com");
    //    mail.To.Add("Srishti.mehrotra@sapphirefoods.in");
    //    mail.From = new MailAddress("donotreply@sapphirefoods.in", "Vendor Master", System.Text.Encoding.UTF8);
    //    mail.Subject = "Error Log Recorded - Vendor Master";
    //    mail.SubjectEncoding = System.Text.Encoding.UTF8;
    //    mail.Body = errorlog;
    //    mail.BodyEncoding = System.Text.Encoding.UTF8;
    //    mail.IsBodyHtml = true;
    //    mail.Priority = MailPriority.Normal;
    //    SmtpServer.Credentials = new System.Net.NetworkCredential("donotreply@sapphirefoods.in", "Cuw73216");
    //    SmtpServer.Port = 587;
    //    SmtpServer.EnableSsl = true;
    //    SmtpServer.Send(mail);


    //    Session.Abandon();
    //    Session.Clear();
    //    Response.Redirect("https://portals.sapphirefoods.in/");
    //}

    protected void btnlogout_clicked(object sender, EventArgs e)
    {
        Session.Abandon();
        Session.Clear();
        Response.Redirect("/no-access.aspx");
    }
}
