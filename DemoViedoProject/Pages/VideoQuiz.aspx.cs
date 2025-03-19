using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_VideoQuiz : System.Web.UI.Page
{
    private static DataTable quizData;
    private static int totalQuestions = 0;
    private static int correctAnswers = 0;
    //private static string Connection = System.Configuration.ConfigurationManager.AppSettings["connectionstring"];
    //private static int currentQuestionIndex = 0;
    //private static DataTable quizData;
    // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["connectionstring"]);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //LoadQuizData();
            string Video = Request.QueryString["Video"];
            string courseId = Request.QueryString["Title"];
            if (!string.IsNullOrEmpty(courseId))
            {
                //LoadCourseDetails(courseId);
            }
        }

    }

    private void LoadQuizData()
    {
        // string connectionString = "your_connection_string_here";
        using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["connectionstring"]))
        {
            string query = "SELECT QuestionID, QuestionText, Option1, Option2, Option3, Option4, CorrectAnswer FROM QuizQuestions";
            SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
            quizData = new DataTable();
            adapter.Fill(quizData);
        }
    }

    [WebMethod]
    public static object GetQuestion(int index)
    {
        if (quizData == null || index >= quizData.Rows.Count)
        {
            return null;
        }

        DataRow question = quizData.Rows[index];

        return new
        {
            Question = question["QuestionText"].ToString(),
            Option1 = question["Option1"].ToString(),
            Option2 = question["Option2"].ToString(),
            Option3 = question["Option3"].ToString(),
            Option4 = question["Option4"].ToString(),
            IsCorrect1 = (question["CorrectAnswer"].ToString() == question["Option1"].ToString()) ? 1 : 0,
            IsCorrect2 = (question["CorrectAnswer"].ToString() == question["Option2"].ToString()) ? 1 : 0,
            IsCorrect3 = (question["CorrectAnswer"].ToString() == question["Option3"].ToString()) ? 1 : 0,
            IsCorrect4 = (question["CorrectAnswer"].ToString() == question["Option4"].ToString()) ? 1 : 0
        };
    }

    [WebMethod]
    public static bool SubmitAnswer(int index, int isCorrect)
    {
        if (isCorrect == 1)
        {
            correctAnswers++;
        }
        totalQuestions++;
        return isCorrect == 1;
    }

    //private void LoadQuestions()
    //{

    //    using (SqlConnection connection = new SqlConnection(Connection))
    //    {
    //        connection.Open();
    //        string query = "SELECT QuestionID, QuestionText, Option1, Option2, Option3, Option4, CorrectAnswer FROM QuizQuestions";

    //        using (SqlCommand command = new SqlCommand(query, connection))
    //        {
    //            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
    //            {
    //                quizData = new DataTable();
    //                adapter.Fill(quizData);
    //            }
    //        }
    //    }
    //}
    //private void LoadCurrentQuestion()
    //{
    //    if (quizData != null && currentQuestionIndex < quizData.Rows.Count)
    //    {
    //        DataTable singleQuestionTable = quizData.Clone(); // Clone the structure
    //        singleQuestionTable.ImportRow(quizData.Rows[currentQuestionIndex]); // Import row

    //        rptQuiz.DataSource = singleQuestionTable; // Bind the cloned table
    //        rptQuiz.DataBind();

    //        lblResult.Visible = false;
    //        //DataRow question = quizData.Rows[currentQuestionIndex];
    //        //rptQuiz.DataSource = new DataTable { Rows = { question } };
    //        //rptQuiz.DataBind();
    //        //lblResult.Visible = false;
    //    }
    //}

    //protected void rptQuiz_ItemCommand(object source, RepeaterCommandEventArgs e)
    //{
    //    if (e.CommandName == "CheckAnswer")
    //    {
    //        string selectedAnswer = e.CommandArgument.ToString();
    //        string correctAnswer = quizData.Rows[currentQuestionIndex]["CorrectAnswer"].ToString();

    //        lblResult.Visible = true;
    //        lblResult.Text = (selectedAnswer == correctAnswer) ? "✅ Correct!" : "❌ Wrong!";
    //    }
    //}

    //protected void Page_LoadComplete(object sender, EventArgs e)
    //{
    //    if (Request["__EVENTTARGET"] == "NextQuestion")
    //    {
    //        currentQuestionIndex++;
    //        if (currentQuestionIndex < quizData.Rows.Count)
    //        {
    //            LoadCurrentQuestion();
    //        }
    //        else
    //        {
    //            lblResult.Text = "Quiz completed!";
    //            lblResult.Visible = true;
    //        }
    //    }
    //}



    //[WebMethod]
    //public static object GetQuestions()
    //{
    //    DataTable dt = new DataTable();
    //    using (SqlConnection conn = new SqlConnection(Connection))
    //    {
    //        string query = "SELECT QuestionID, QuestionText, Option1, Option2, Option3, Option4 FROM QuizQuestions";
    //        using (SqlCommand cmd = new SqlCommand(query, conn))
    //        {
    //            // conn.Open();
    //            SqlDataAdapter da = new SqlDataAdapter(cmd);
    //            da.Fill(dt);
    //            //  conn.Close();
    //        }
    //    }
    //    return dt;
    //}
}