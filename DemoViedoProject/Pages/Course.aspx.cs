using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCourses();
        }

    }
    private void LoadCourses()
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["connectionstring"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_SelectDataByMode", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "Course");
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    string title = reader["title"].ToString();
                    string courseId = reader["course_id"].ToString();
                    sb.Append(string.Format("<div class='Coursemodule'><a href='lesson.aspx?CourseId={1}'>{0}</a></div>", title, courseId));
                }
                reader.Close();
                CourseModulesDiv.Text = sb.ToString(); // Changed InnerHtml to Text
            }
        }
    }
}