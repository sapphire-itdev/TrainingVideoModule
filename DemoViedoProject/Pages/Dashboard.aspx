<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPage.master"  CodeFile="Dashboard.aspx.cs" Inherits="Pages_Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <style>
        .logo-container {
            transition: transform 0.3s ease-in-out;
        }

            .logo-container:hover {
                transform: scale(1.2);
            }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 10px;
            padding: 10px 10px;
            max-width: 1200px;
            margin: auto;
        }

        .Dashcard {
            background: rgba(255, 255, 255, 255);
            backdrop-filter: blur(10px);
            padding: 10px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: 0.3s;
        }

            .Dashcard:hover {
                transform: scale(1.05);
                background-color: #ffcc00;
            }

            .Dashcard h2 {
                font-size: 18px;
                margin-bottom: 10px;
            }

            .Dashcard p {
                font-size: 14px;
                opacity: 0.9;
            }

            .Dashcard .value {
                font-size: 23px;
                font-weight: bold;
                color: #ff7eb3;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <!-- Dashboard Section -->
                <div class="dashboard" >
                    <div class="Dashcard" style="background-color:">
                        <h2>Completed Trainings</h2>
                        <p class="value">5</p>
                        <p>Trainings you have finished</p>
                    </div>
                    <div class="Dashcard">
                        <h2>Pending Trainings</h2>
                        <p class="value">3</p>
                        <p>Trainings you still need to complete</p>
                    </div>
                    <div class="Dashcard">
                        <h2>Total Trainings</h2>
                        <p class="value">30</p>
                        <p>Available Trainings in the system</p>
                    </div>
                    <div class="Dashcard">
                        <h2>Leaderboard Rank</h2>
                        <p class="value">#2</p>
                        <p>Your current position</p>
                    </div>
                    <div class="Dashcard">
                        <h2>Upcoming Trainings</h2>
                        <p class="value">4</p>
                        <p>Trainings launching soon</p>
                    </div>
                    <div class="Dashcard">
                        <h2>Total Users</h2>
                        <p class="value">250</p>
                        <p>Users currently on the platform</p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsscripts" runat="Server">
</asp:Content>

