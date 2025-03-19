<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"  CodeFile="Lesson.aspx.cs" Inherits="Pages_Lesson" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
      body {
            font-family: Arial, sans-serif;
        }
      .MainSection{
          color:white;
      }
        .Coursecontainer {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: auto;
        }
        .card {
/*            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;*/

            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
            width: 100%;
            max-width: 230px;
            height: 292px;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .card-content {
            padding: 15px;
        }
        .card-title {
            font-size: 1.5em;
            margin-bottom: 10px;
        }
        .card-description {
            color: #ccc;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 MainSection">
                 <h1>Lessons</h1>
    <div class="Coursecontainer">
        <asp:Literal ID="LessonModulesDiv" runat="server"></asp:Literal>
<%--        <div class="card">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbgFlVtm-qZLJ9J4RJ149JHki8MAlylS1CY0ltDaMoLlFgofm3RstlPPeoXE7C7XrAgNA&usqp=CAU" alt="Introduction to AI">
            <div class="card-content">
                <h2 class="card-title">Introduction to AI</h2>
                <p class="card-description">Learn the basics of Artificial Intelligence and its applications.</p>
            </div>
        </div>--%>
<%--        <div class="card">
            <img src="https://source.unsplash.com/400x300/?machinelearning,data" alt="Machine Learning">
            <div class="card-content">
                <h2 class="card-title">Machine Learning</h2>
                <p class="card-description">Explore the fundamentals of machine learning algorithms.</p>
            </div>
        </div>
        <div class="card">
            <img src="https://source.unsplash.com/400x300/?neuralnetwork,brain" alt="Neural Networks">
            <div class="card-content">
                <h2 class="card-title">Neural Networks</h2>
                <p class="card-description">Understand how neural networks function and their use cases.</p>
            </div>
        </div>
        <div class="card">
            <img src="https://source.unsplash.com/400x300/?deeplearning,ai" alt="Deep Learning">
            <div class="card-content">
                <h2 class="card-title">Deep Learning</h2>
                <p class="card-description">Delve into deep learning models and architectures.</p>
            </div>
        </div>--%>
    </div>
                <%--                <h1>Lession</h1>
                <div class="course-container">
                        <asp:Literal ID="LessonModulesDiv" runat="server"></asp:Literal>
                </div>--%>
                <%--<h1>Lessons</h1>--%>
                <%--<asp:Literal ID="LessonModulesDiv" runat="server"></asp:Literal>--%>
<%--                <div class="Coursecontainer">
                    <div class="card">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbgFlVtm-qZLJ9J4RJ149JHki8MAlylS1CY0ltDaMoLlFgofm3RstlPPeoXE7C7XrAgNA&usqp=CAU" alt="Introduction to AI">
                        <div class="card-content">
                            <h2 class="card-title">Introduction to AI</h2>
                            <p class="card-description">Learn the basics of Artificial Intelligence and its applications.</p>
                        </div>
                    </div>--%>
<%--                    <div class="card">
                        <img src="https://source.unsplash.com/400x300/?machinelearning,data" alt="Machine Learning">
                        <div class="card-content">
                            <h2 class="card-title">Machine Learning</h2>
                            <p class="card-description">Explore the fundamentals of machine learning algorithms.</p>
                        </div>
                    </div>--%>
<%--                    <div class="card">
                        <img src="https://source.unsplash.com/400x300/?neuralnetwork,brain" alt="Neural Networks">
                        <div class="card-content">
                            <h2 class="card-title">Neural Networks</h2>
                            <p class="card-description">Understand how neural networks function and their use cases.</p>
                        </div>
                    </div>
                    <div class="card">
                        <img src="https://source.unsplash.com/400x300/?deeplearning,ai" alt="Deep Learning">
                        <div class="card-content">
                            <h2 class="card-title">Deep Learning</h2>
                            <p class="card-description">Delve into deep learning models and architectures.</p>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
  <%--  </div>--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsscripts" runat="Server">
    <script>
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

