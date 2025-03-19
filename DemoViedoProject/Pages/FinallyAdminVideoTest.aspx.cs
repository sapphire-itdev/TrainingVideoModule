using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Runtime.Remoting;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;


public partial class Pages_FinallyAdminVideoTest : System.Web.UI.Page
{ 
    protected void Page_Load(object sender, EventArgs e)
    { if (!IsPostBack)
        {
            //binddropdown();
        }
    }
 

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveData(string jsonString)
    {
        try
        {
            // Deserialize into RootObject instead of List<Content>
            var rootObject = JsonConvert.DeserializeObject<RootObject>(jsonString);
            var contentList = rootObject.ContentSections; // Extract content list



            // Extract FormDetails
            var formDetails = rootObject.FormDetails;

            // Access FormDetails values
            string title = formDetails.Title;
            string passingScore = formDetails.PassingScore;
            string totalScore = formDetails.TotalScore;
            string description = formDetails.Description;
            string startDate = formDetails.Startdate;
            string endDate = formDetails.Enddate;
            string department_id = formDetails.DeptId;
            int admin_id = 1;
        
            int createdby = 1;
            string createddate = DateTime.Now.ToString();
            int delindex = 1;
            string course_id = Guid.NewGuid().ToString();

            ClsDml clsata = new ClsDml();
            DataTable ds1 = clsata.insertCourse(admin_id,title,description,department_id,startDate,endDate,createdby,passingScore,totalScore, course_id);
            if (ds1 != null)
            {
                if (ds1.Rows.Count > 0)
                {
                }
            }

                    // Create a new DataSet
                    DataSet ds = new DataSet();


            // Convert FormDetails to DataTable
            DataTable formDetailsTable = new DataTable("FormDetails");
            formDetailsTable.Columns.Add("Title");
            formDetailsTable.Columns.Add("PassingScore");
            formDetailsTable.Columns.Add("TotalScore");
            formDetailsTable.Columns.Add("Description");
            formDetailsTable.Columns.Add("StartDate");
            formDetailsTable.Columns.Add("EndDate");

            formDetailsTable.Rows.Add(title, passingScore, totalScore, description, startDate, endDate);
           


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
            questionsTable.Columns.Add("VideoDescription");
            questionsTable.Columns.Add("TitleDescription");
            questionsTable.Columns.Add("QuestionText");
            questionsTable.Columns.Add("Score");

            answersTable.Columns.Add("AnswerID");
            answersTable.Columns.Add("QuestionID");
            answersTable.Columns.Add("AnswerText");
            answersTable.Columns.Add("IsCorrect", typeof(bool));
            
            foreach (var content in contentList)
            {
               DataTable dt1 = clsata.LessonsInsert(content.ContentID, course_id,content.TitleDescription, content.VideoDescription,content.UploadFileName,createdby);
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                    }
                }

                foreach (var question in content.Questions)
                {
                    DataTable ds2 = clsata.insertQuestion(content.ContentID, question.QuestionID, question.QuestionText,Convert.ToInt32(question.Score), createdby);
                    if (ds2 != null)
                    {
                        if (ds2.Rows.Count > 0)
                        {
                        }
                    }

                    questionsTable.Rows.Add(question.QuestionID, content.ContentID, content.UploadFileName, content.VideoDescription, content.TitleDescription, question.QuestionText, question.Score);

                    foreach (var answer in question.Answers)
                    {


                        DataTable ds3 = clsata.insertAnswer(question.QuestionID, answer.AnswerText, answer.AnswerID, Convert.ToInt32(answer.IsCorrect), createdby);
                        if (ds3 != null)
                        {
                            if (ds3.Rows.Count > 0)
                            {
                            }
                        }

                        answersTable.Rows.Add(answer.AnswerID, question.QuestionID, answer.AnswerText, answer.IsCorrect);
                    }
                }
            }

            ds.Tables.Add(questionsTable);
            ds.Tables.Add(answersTable);
            ds.Tables.Add(formDetailsTable);
            return JsonConvert.SerializeObject(new { success = true, data = ds });
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetCourseData()
    {
        try
        {
            ClsDml clsata = new ClsDml();
            DataSet ds = clsata.GetCourseData("e8392d7b-e3f5-44cd-8f96-dcef960bd061",1,1);
            return JsonConvert.SerializeObject(new { success = true, data = ds });
        }
        catch (Exception)
        {

            throw;
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

    public class FormDetails
    {
        public string Title { get; set; }
        public string PassingScore { get; set; }
        public string TotalScore { get; set; }
        public string Description { get; set; }
        public string Startdate { get; set; }
        public string Enddate { get; set; }
        public string DeptId { get; set; }
    }

    public class Answer
    {
        public string AnswerID { get; set; }
        public string AnswerText { get; set; }
        public bool IsCorrect { get; set; }
    }

    public class Question
    {
        public string QuestionID { get; set; }
        public string QuestionText { get; set; }
        public string Score { get; set; }
        public List<Answer> Answers { get; set; }
    }

    public class Content
    {
        public string ContentID { get; set; }
        public string UploadFileName { get; set; }
        public string VideoDescription { get; set; }
        public string TitleDescription { get; set; }
        public List<Question> Questions { get; set; }
    }

    public class RootObject
    {
        public FormDetails FormDetails { get; set; }
        public List<Content> ContentSections { get; set; }
    }


    [WebMethod]
    public static List<Department> binddropdown()
    {
        ClsDml dm = new ClsDml();
        DataTable dt = dm.GetBindDepartment();
        List<Department> departmentList = new List<Department>();

        foreach (DataRow dr in dt.Rows)
        {
            departmentList.Add(new Department
            {
                DeptID = dr["DeptID"].ToString(),
                DeptName = dr["DeptName"].ToString()
            });
        }

        return departmentList;
    }

    public class Department
    {
        public string DeptID { get; set; }
        public string DeptName { get; set; }
    }


}
