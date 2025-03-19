<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Course.aspx.cs" Inherits="Pages_Default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            /*background: linear-gradient(135deg, #ffeb3b, #ff9800, #f5f5f2);*/
            background: linear-gradient(135deg, #ffd700, #ffffff);
            color: black;
            overflow-x: hidden;
            animation: backgroundShift 10s infinite alternate;
        }

        .Coursecontainer {
            width: 80%;
            margin: auto;
            padding: 20px;
            text-align: center;
        }

        h1 {
            font-size: 3rem;
            color: #ff9800;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
            animation: fadeIn 2s ease-in-out;
            transition: color 0.3s, transform 0.3s;
        }

            h1:hover {
                color: white;
                transform: scale(1.05);
            }

        .course-info {
            background: rgba(255, 255, 255, 0.9);
            padding: 10px;
            border-radius: 10px;
            margin-top: 10px;
            margin-bottom: 30px;
            padding-bottom: 1px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            animation: slideIn 1.5s ease-in-out;
            transition: color 0.3s, transform 0.3s;
        }

            .course-info:hover {
                color: #ff9800;
                transform: scale(1.05);
            }

        .Coursemodules {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .Coursemodule {
            background: white;
            color: black;
            padding: 15px;
            border-radius: 8px;
            width: 250px;
            transition: transform 0.3s, box-shadow 0.3s;
            animation: float 3s infinite ease-in-out;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
        }

            .Coursemodule:hover {
                transform: scale(1.1);
                box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
            }

        .cta {
            margin-top: 30px;
            animation: bounce 2s infinite;
        }

            .cta button {
                background: #ff4081;
                color: white;
                padding: 15px 30px;
                border: none;
                border-radius: 5px;
                font-size: 1.2rem;
                cursor: pointer;
                transition: background 0.3s, transform 0.3s;
            }

                .cta button:hover {
                    background: #e91e63;
                    transform: scale(1.1);
                }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }

            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes float {
            0% {
                transform: translateY(0px);
            }

            50% {
                transform: translateY(-10px);
            }

            100% {
                transform: translateY(0px);
            }
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-5px);
            }
        }

        /*        @keyframes backgroundShift {
            0% {
                background: linear-gradient(135deg, #ffeb3b, #ff9800, #f5f5f2);
            }

            100% {
                background: linear-gradient(135deg, #f5f5f2, #ff9800, #ffeb3b);
            }*/
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <%--                <div class="Coursecontainer">
                    <h1>Training Course</h1>
                    <div class="course-info">
                        <p>Learn industry-level skills from top instructors and elevate your career with our well-structured training program.</p>
                    </div>
                    <div class="Coursemodules">
                        <div class="Coursemodule">Introduction to the Course</div>
                        <div class="Coursemodule">Advanced Technical Skills</div>
                        <div class="Coursemodule">Project-Based Learning</div>
                        <div class="Coursemodule">Soft Skills & Communication</div>
                    </div>
                </div>--%>
                <div class="Coursecontainer">
                    <h1>Training Course</h1>
                    <div class="course-info">
                        <p>Learn industry-level skills from top instructors and elevate your career with our well-structured training program.</p>
                    </div>
                    <div class="Coursemodules">
                        <asp:Literal ID="CourseModulesDiv" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsscripts" runat="Server">
    <script>
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
