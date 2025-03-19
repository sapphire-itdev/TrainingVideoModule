using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Reflection.Emit;
using System.Security.Cryptography.X509Certificates;
using System.Xml.Linq;
using System.Runtime.InteropServices.ComTypes;


/// <summary>
/// Summary description for ClsDml
/// </summary>
public class ClsDml
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["connectionstring"]);
    public DataTable insertCourse(int admin_id,string title,string description, string department_id,string course_start, string coursr_end,int createdby, string PassingMark, string totalMark, string course_id)
    {

        // int uid= Convert.ToInt32(Session["uid"]).ToString()
        SqlCommand cmd = new SqlCommand("Sp_Training_Insert", conn);

        conn.Open();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@IntType", "Course");
        cmd.Parameters.AddWithValue("@admin_id", admin_id);
        cmd.Parameters.AddWithValue("@title", title);
        cmd.Parameters.AddWithValue("@description", description);
        cmd.Parameters.AddWithValue("@department_id", department_id);
        cmd.Parameters.AddWithValue("@course_start", course_start);
        cmd.Parameters.AddWithValue("@coursr_end", coursr_end);
        cmd.Parameters.AddWithValue("@createdby", createdby);
        //cmd.Parameters.AddWithValue("@Createddate", Createddate);
       // cmd.Parameters.AddWithValue("@delindex", delindex);
        cmd.Parameters.AddWithValue("@PassingMark", PassingMark);
        cmd.Parameters.AddWithValue("@totalMark", totalMark);
        cmd.Parameters.AddWithValue("@course_id", course_id);
        // cmd.ExecuteNonQuery();
        conn.Close();
        DataTable ds = new DataTable();
        SqlDataAdapter sqladapter = new SqlDataAdapter();
        sqladapter.SelectCommand = cmd;
        sqladapter.Fill(ds);

        return ds;

    }

    public DataTable insertQuestion(string lesson_id, string question_id, string questions, int weightage, int createdby)
    {

        // int uid= Convert.ToInt32(Session["uid"]).ToString()
        SqlCommand cmd = new SqlCommand("Sp_Training_Insert", conn);

        conn.Open();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@IntType", "QustionInsert");
        cmd.Parameters.AddWithValue("@lesson_id", lesson_id);
        cmd.Parameters.AddWithValue("@question_id", question_id);
        cmd.Parameters.AddWithValue("@questions", questions);
   
        cmd.Parameters.AddWithValue("@weightage", weightage);
        cmd.Parameters.AddWithValue("@createdby", createdby);

        // cmd.ExecuteNonQuery();
        conn.Close();
        DataTable ds = new DataTable();
        SqlDataAdapter sqladapter = new SqlDataAdapter();
        sqladapter.SelectCommand = cmd;
        sqladapter.Fill(ds);

        return ds;

    }
    public DataTable insertAnswer(string question_id, string answer_options, string answer_id, int correct_answer, int createdby)
    {

        // int uid= Convert.ToInt32(Session["uid"]).ToString()
        SqlCommand cmd = new SqlCommand("Sp_Training_Insert", conn);

        conn.Open();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@IntType", "AnswerInsert");
        cmd.Parameters.AddWithValue("@question_id", question_id);
        cmd.Parameters.AddWithValue("@answer_options", answer_options);
        cmd.Parameters.AddWithValue("@answer_id", answer_id);
        cmd.Parameters.AddWithValue("@correct_answer", correct_answer);
        cmd.Parameters.AddWithValue("@createdby", createdby);

        // cmd.ExecuteNonQuery();
        conn.Close();
        DataTable ds = new DataTable();
        SqlDataAdapter sqladapter = new SqlDataAdapter();
        sqladapter.SelectCommand = cmd;
        sqladapter.Fill(ds);

        return ds;

    }

    public DataTable LessonsInsert(string lesson_id, string course_id, string lesson_title, string lesson_description, string video_content ,int createdby)
    {

        SqlCommand cmd = new SqlCommand("Sp_Training_Insert", conn);

        conn.Open();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@IntType", "LessonsInsert");
        cmd.Parameters.AddWithValue("@lesson_id", lesson_id);
        cmd.Parameters.AddWithValue("@course_id", course_id);
        cmd.Parameters.AddWithValue("@lesson_title", lesson_title);
        cmd.Parameters.AddWithValue("@lesson_description", lesson_description);
        cmd.Parameters.AddWithValue("@video_content", video_content);
        cmd.Parameters.AddWithValue("@createdby", createdby);

        // cmd.ExecuteNonQuery();
        conn.Close();
        DataTable ds = new DataTable();
        SqlDataAdapter sqladapter = new SqlDataAdapter();
        sqladapter.SelectCommand = cmd;
        sqladapter.Fill(ds);

        return ds;

    }

    public DataSet GetCourseData(string course_id, int UserType , int department_id)
    {

        // int uid= Convert.ToInt32(Session["uid"]).ToString()
        SqlCommand cmd = new SqlCommand("Sp_select_Data", conn);

        conn.Open();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@IntType", "data");
        cmd.Parameters.AddWithValue("@course_id", course_id);
        cmd.Parameters.AddWithValue("@UserType", UserType);
        cmd.Parameters.AddWithValue("@department_id", department_id);
        // cmd.ExecuteNonQuery();
        conn.Close();
        DataSet ds = new DataSet();
        SqlDataAdapter sqladapter = new SqlDataAdapter();
        sqladapter.SelectCommand = cmd;
        sqladapter.Fill(ds);

        return ds;

    }


    public DataTable GetBindData( int UserType, int department_id)
    {

        // int uid= Convert.ToInt32(Session["uid"]).ToString()
        SqlCommand cmd = new SqlCommand("Sp_select_Data", conn);

        conn.Open();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@IntType", "griddata");
       
        cmd.Parameters.AddWithValue("@UserType", UserType);
        cmd.Parameters.AddWithValue("@department_id", department_id);
        // cmd.ExecuteNonQuery();
        conn.Close();
        DataTable dt = new DataTable();
        SqlDataAdapter sqladapter = new SqlDataAdapter();
        sqladapter.SelectCommand = cmd;
        sqladapter.Fill(dt);

        return dt;

    }

    public DataTable  GetBindDepartment()
    {
        SqlCommand cmd = new SqlCommand("Sp_select_Data", conn);

        conn.Open();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@IntType", "BindDepartment");

         conn.Close();
        DataTable dt = new DataTable();
        SqlDataAdapter sqladapter = new SqlDataAdapter();
        sqladapter.SelectCommand = cmd;
        sqladapter.Fill(dt);

        return dt;


    }

}
