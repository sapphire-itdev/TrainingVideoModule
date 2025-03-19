using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Lesson : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string courseId = Request.QueryString["CourseId"];
            if (!string.IsNullOrEmpty(courseId))
            {
                LoadCourseDetails(courseId);
            }
        }

    }
    private void LoadCourseDetails(string courseId)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["connectionstring"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_SelectDataByMode", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "Lesson");
                cmd.Parameters.AddWithValue("@Id", courseId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    string title = reader["lesson_title"].ToString();
                    string description = reader["lesson_description"].ToString();
                    string Video = reader["video_content"].ToString();
                    sb.Append(string.Format(
                         "<div class=\"card\">" +
                         "<img src=\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbgFlVtm-qZLJ9J4RJ149JHki8MAlylS1CY0ltDaMoLlFgofm3RstlPPeoXE7C7XrAgNA&usqp=CAU\" alt=\"Introduction to AI\">" +
                         "<div class=\"card-content\">" +
                         "<a href=\"VideoQuiz.aspx?Video={2}\"><h2 class=\"card-title\">{0}</h2>" +
                         "<p class=\"card-description\">{1}</p></a>" +
                         "</div>" +
                         "</div>", title, description, Video));
                }
                reader.Close();
                LessonModulesDiv.Text = sb.ToString();
            }
        }
    }
}