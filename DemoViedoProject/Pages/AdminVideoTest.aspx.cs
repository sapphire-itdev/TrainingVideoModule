using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Pages_AdminVideoTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //[WebMethod]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static string SaveData(string jsonString)
    //{
    //    try
    //    {
    //        // Deserialize JSON to DataSet
    //        DataSet ds = JsonConvert.DeserializeObject<DataSet>(jsonString.Trim());

    //        // Optionally: Process DataSet (save to DB, manipulate, etc.)

    //        return JsonConvert.SerializeObject(new { success = true, message = "Data processed successfully", data = ds });
    //    }
    //    catch (Exception ex)
    //    {
    //        return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
    //    }
    //}

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveData(string jsonString)
    {
        try
        {
            // Deserialize the JSON string into a list of Content objects
            var contentList = JsonConvert.DeserializeObject<List<Content>>(jsonString);

            // Create a new DataSet
            DataSet ds = new DataSet();

            // Convert the Content list to a DataTable and add it to DataSet
            DataTable contentTable = ConvertToDataTable(contentList);
            contentTable.TableName = "Content";
            ds.Tables.Add(contentTable);

            // Convert Questions and Answers to DataTables
            DataTable questionsTable = new DataTable("Questions");
            DataTable answersTable = new DataTable("Answers");

            questionsTable.Columns.Add("QuestionID");
            questionsTable.Columns.Add("ContentID");
            questionsTable.Columns.Add("UploadFileName");
            questionsTable.Columns.Add("QuestionText");
            questionsTable.Columns.Add("Score");

            answersTable.Columns.Add("AnswerID");
            answersTable.Columns.Add("QuestionID");
            answersTable.Columns.Add("AnswerText");
            answersTable.Columns.Add("IsCorrect", typeof(bool));

            foreach (var content in contentList)
            {
                foreach (var question in content.Questions)
                {
                    questionsTable.Rows.Add(question.QuestionID, content.ContentID, content.UploadFileName, question.QuestionText, question.Score);

                    foreach (var answer in question.Answers)
                    {
                        answersTable.Rows.Add(answer.AnswerID, question.QuestionID, answer.AnswerText, answer.IsCorrect);
                    }
                }
            }

            ds.Tables.Add(questionsTable);
            ds.Tables.Add(answersTable);

            DataView view = new DataView(questionsTable);
            DataTable distinctDt = view.ToTable(true, "ContentID");

            // Looping on distinct Content ID
            foreach(DataRow dr in distinctDt.Rows)
            {
                
                // Finding Question based on Content ID
                foreach (DataRow drQuestions in questionsTable.Select("ContentID = '" + Convert.ToString(dr["ContentID"])  + "'"))
                {
                    string Question = Convert.ToString(drQuestions["QuestionText"]);
                    // Finding Answers based on Questions
                    foreach (DataRow drAnswers in answersTable.Select("QuestionID = '" + Convert.ToString(drQuestions["QuestionID"]) + "'"))
                    {
                        string Answer = Convert.ToString(drAnswers["AnswerText"]);

                    }
                }
            }

            return JsonConvert.SerializeObject(new { success = true, data = ds });
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
        }
    }

    public static DataTable ConvertToDataTable<T>(List<T> items)
    {
        DataTable dataTable = new DataTable(typeof(T).Name);
        var props = typeof(T).GetProperties();

        foreach (var prop in props)
        {
            dataTable.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
        }

        foreach (var item in items)
        {
            var values = new object[props.Length];
            for (int i = 0; i < props.Length; i++)
            {
                values[i] = props[i].GetValue(item, null);
            }
            dataTable.Rows.Add(values);
        }

        return dataTable;
    }

    public class Content
    {
        public string ContentID { get; set; }

        public string UploadFileName { get; set; }
        public List<Question> Questions { get; set; }
    }

    public class Question
    {
        public string QuestionID { get; set; }
        public string QuestionText { get; set; }
        public string Score { get; set; }
        public List<Answer> Answers { get; set; }
    }

    public class Answer
    {
        public string AnswerID { get; set; }
        public string AnswerText { get; set; }
        public bool IsCorrect { get; set; }
    }


}