<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FinallyAdminVideoTest.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="Pages_FinallyAdminVideoTest" %>

<asp:Content ID="ContentPlaceHolder3" ContentPlaceHolderID="head" runat="server">

    <style>
        .mt-12px {
            margin-top: 12px;
        }
    </style>


    <style>
        .drop-area {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            text-align: center;
            border: 2px dashed #007bff;
            border-radius: 10px;
            background-color: #f8f9fa;
            color: #007bff;
            font-family: Arial, sans-serif;
            cursor: pointer;
            transition: background-color 0.3s, border-color 0.3s;
        }

            .drop-area:hover {
                background-color: #e2e6ea;
                border-color: #0056b3;
            }

            .drop-area p {
                margin: 0;
                font-size: 16px;
            }

        .progress-container {
            width: 60%;
            height: 30px;
            background-color: #e0e0e0;
            border-radius: 15px;
            overflow: hidden;
            position: fixed !important;
            z-index: 1000;
        }

        .progress-bar {
            height: 100%;
            width: 0%;
            background-color: #28a745;
            text-align: center;
            color: white;
            line-height: 30px;
            font-weight: bold;
            transition: width 0.3s ease-in-out;
        }
    </style>


    <style>
        .x-btn {
            background: none;
            border: none;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            color: red;
        }
    </style>
        <style>
        .select2-results__option input {
            margin-right: 8px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="row">
        <div class="col-12 d-flex justify-content-center align-items-center ">
            <div class="progress-container">
                <div class="progress-bar" id="progressBar">0%</div>
            </div>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12">
            <%-- <div class="progress-container">
                <div class="progress-bar" id="progressBar">0%</div>
            </div>--%>
            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                <h4 class="mb-sm-0 font-size-18">Video Uploader</h4>
            </div>
        </div>
    </div>


    <div class="row">

        <div class="col-12">
            <div class="card">
                <div class="card-body">


                    <div class="row justify-content-center">
                        <div class="col-md-10">
                            <div class="d-flex justify-content-center align-items-center gap-2">
                                <input type="text" id="txttitle" placeholder="Title" class="form-control w-50" />:
                               <%-- <asp:TextBox ID="txttitle" runat="server" placeholder="Title" class="form-control w-50"></asp:TextBox>--%>
                                <input type="text" id="txtTotalpassingmarks" oninput="this.value = this.value.replace(/[^0-9]/g, '')" placeholder="Passing Score" class="form-control w-25" />/
                                <%--<asp:TextBox ID="txtTotalpassingmarks" placeholder="Passing Score" class="form-control w-25" runat="server"></asp:TextBox>--%>
                                <input type="hidden" id="hdnQuestionScore" />
                                <input type="text" id="txtTotalScore" oninput="this.value = this.value.replace(/[^0-9]/g, ''); updateProgress();" placeholder="Total Score" onfocusout="updateProgress();" onblur="updateProgress();" class="form-control w-25" />
                                <br />


                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12">

                            <textarea id="txtDescription" placeholder="Description" class="form-control w-100" rows="3"></textarea>
                        </div>
                    </div>
                    <br />
                    <div class="row justify-content-center">
                        <div class="col-md-4">
                            <%--<asp:DropDownList class="form-select" ID="ddldepartment" runat="server" 
                                 placeholder="Department">
                            </asp:DropDownList>--%>
                            <select id="multi-select" class="form-select" multiple>
                                <option value="0">Select Department</option>
                            </select>
                        </div>
                        <div class="col-md-8">
                            <div class="d-flex justify-content-center align-items-center gap-2">
                                <input type="text" id="txtstartdate" placeholder="Training Start Date" class="form-control w-25" />
                                <input type="text" id="txtenddate" placeholder="Training End Date" class="form-control w-25" />
                            </div>

                        </div>
                    </div>

                    <div id="divParentHidden" style="display: none;">
                        <br />
                        <div id="divContent" style="border: 2px solid #e0e0e0; padding: 10px;">
                            <div class="row" id="divPanelBtn">
                                <div class="d-flex justify-content-end align-items-center w-100">
                                    <button type="button" id="btnDeletePanel" class="btn btn-danger" onclick="DeletePanel(this)">Delete Panel</button>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-12">
                                    <label class="fw-bold">Training Content Uploader</label><br />
                                    <div class="drop-area d-flex justify-content-center align-items-center" id="dropArea" style="height: 200px" onclick="triggerFileInput(this)">
                                        Drag & Drop File Here or Click to Upload
   
                                    </div>
                                    <input type="file" style="display: none;" id="uploadVideo" onchange="uploadFile(this)" />
                                    <input type="hidden" id="hdnUploadFileName" />
                                    <br />
                                    <br />
                                    <input type="text" id="txtTitleDescription" placeholder="Lessons Title" class="form-control w-100" rows="3" />

                                    <br />
                                    <textarea id="txtvideoDescription" placeholder=" Lessons  Description" class="form-control w-100" rows="3"></textarea>

                                </div>

                                <div class="col-lg-8 col-md-8 col-sm-12">

                                    <div id="divQuestions">

                                        <div class="border p-3 shadow-sm rounded question-panel">
                                            <!-- Question Input -->
                                            <div class="d-flex justify-content-center align-items-center w-10">
                                                <input type="text" id="inpQuestionScore" oninput="this.value = this.value.replace(/[^0-9]/g, '')" inputmode="numeric" placeholder="Score" class="form-control questionscore text-center w-25" onfocusout="totalQuestionScore(this);" />
                                            </div>
                                            <br />
                                            <div class="mb-4">
                                                <input type="text" id="inpTextQuestion" placeholder="Question" textmode="MultiLine" class="form-control" />
                                            </div>
                                            <div id="divAnswers">
                                                <div class="row">
                                                    <div class="col-md-6 d-flex align-items-center" id="divAnswerBox1">
                                                        <button class="x-btn" id="btnDelAns1" onclick="return deleteAnswer(this)">
                                                            ✖
                                                        </button>
                                                        <input type="text" id="inpAnswer1" placeholder="Enter Answer" class="form-control me-2" />
                                                        <input type="checkbox" id="chkAnswer1" class="form-check-input" />

                                                    </div>

                                                    <div class="col-md-6 d-flex align-items-center" id="divAnswerBox2">
                                                        <button class="x-btn" id="btnDelAns2" onclick="return deleteAnswer(this)">
                                                            ✖
                                                        </button>
                                                        <input type="text" id="inpAnswer2" placeholder="Enter Answer" class="form-control me-2" />
                                                        <input type="checkbox" id="chkAnswer2" class="form-check-input" />

                                                    </div>

                                                    <%-- </div>
                                                <br />
                                                <div class="row">--%>
                                                    <div class="col-md-6 d-flex align-items-center" id="divAnswerBox3">
                                                        <button class="x-btn" id="btnDelAns3" onclick="return deleteAnswer(this)">
                                                            ✖
                                                        </button>
                                                        <input type="text" id="inpAnswer3" placeholder="Enter Answer" class="form-control me-2 mt-12px" />
                                                        <input type="checkbox" id="chkAnswer3" class="form-check-input" />

                                                    </div>

                                                    <div class="col-md-6 d-flex align-items-center" id="divAnswerBox4">
                                                        <button class="x-btn" id="btnDelAns4" onclick=" return deleteAnswer(this)">
                                                            ✖
                                                        </button>
                                                        <input type="text" id="inpAnswer4" placeholder=" Enter Answer" class="form-control me-2 mt-12px" />
                                                        <input type="checkbox" id="chkAnswer4" class="form-check-input" />

                                                    </div>

                                                    <%--</div>--%>
                                                    <%--<div class="col-md-4 d-flex align-items-center">--%>
                                                    <div id="divLoadAnswers" class="row" style="width: 104%; max-width: 104%;"></div>
                                                    <%--</div>--%>
                                                </div>
                                                <br />
                                                <%--  <div id="divAnswersHidden" style="display: none;">


                                                    <div class="col-md-6 d-flex align-items-center" id="divAnswerBox">
                                                        <button class="x-btn" id="btnDelAns" onclick="deleteAnswer(this)">
                                                            ✖
                                                        </button>
                                                        <input type="text" id="inpAnswer" placeholder="Enter Answer" class="form-control me-2 mt-12px" />
                                                        <input type="checkbox" id="chkAnswer" class="form-check-input" />

                                                    </div>
                                                </div>--%>

                                                <br />


                                            </div>

                                            <div id="divAnswersHidden" style="display: none;">


                                                <div class="col-md-6 d-flex align-items-center" id="divAnswerBox">
                                                    <button class="x-btn" id="btnDelAns" onclick="return deleteAnswer(this)">
                                                        ✖
                                                    </button>
                                                    <input type="text" id="inpAnswer" placeholder="Enter Answer" class="form-control me-2 mt-12px" />
                                                    <input type="checkbox" id="chkAnswer" class="form-check-input" />

                                                </div>
                                            </div>

                                            <div class="d-flex justify-content-center align-items-center w-10">

                                                <button type="button" id="btnAddAnswer" onclick="AddAnswer(this)" class="btn btn-success">Add Answer</button>
                                            </div>
                                        </div>
                                        <br />

                                    </div>

                                    <div id="divLoadMoreQuestions"></div>
                                    <br />
                                    <div class="d-flex justify-content-center align-items-center w-10">
                                        <button type="button" id="btnAddQuestion" class="btn btn-primary" onclick="AddQuestion(this)">Add Question</button>
                                        <br />
                                    </div>
                                </div>


                                <br />
                            </div>

                            <br />


                            <br />
                        </div>



                    </div>



                    <div class="row">
                        <div class="col-lg-8 col-md-8 col-sm-12">
                            <div id="divQuestionsHidden" style="display: none;">
                                <div id="divQuestions11">
                                    <div class="border p-3 shadow-sm rounded question-panel">
                                        <!-- Question Input -->

                                        <div class="d-flex justify-content-center align-items-center w-10">
                                            <div class="col-md-4"></div>
                                            <div class="col-md-4">
                                                <input type="text" id="inpQuestionScore11" oninput="this.value = this.value.replace(/[^0-9]/g, '')" placeholder="Score" onfocusout="totalQuestionScore(this);" class="form-control questionscore text-center w-50" />
                                            </div>
                                            <div class="col-md-4 d-flex justify-content-end">
                                                <button type="button" id="btnDeleteQuestion11" class="btn btn-danger ms-auto" onclick="DeleteQuestion(this)">Delete Question</button>
                                            </div>

                                        </div>
                                        <br />
                                        <div class="mb-4">
                                            <input type="text" id="inpTextQuestion11" placeholder="Question" class="form-control me-2" />
                                        </div>
                                        <br />
                                        <div id="divAnswers_11">
                                            <div class="row">
                                                <div class="col-md-6 d-flex align-items-center" id="divAnswerBox11">
                                                    <button class="x-btn" id="btnDelAns11" onclick="return deleteAnswer(this)">
                                                        ✖
                                                    </button>
                                                    <input type="text" id="inpAnswer11" placeholder="Enter Answer" class="form-control me-2 mt-12px" />
                                                    <input type="checkbox" id="chkAnswer11" class="form-check-input" />

                                                </div>
                                                <div class="col-md-6 d-flex align-items-center" id="divAnswerBox22">
                                                    <button class="x-btn" id="btnDelAns22" onclick="return deleteAnswer(this)">
                                                        ✖
                                                    </button>
                                                    <input type="text" id="inpAnswer22" placeholder="Enter Answer" class="form-control me-2 mt-12px" />
                                                    <input type="checkbox" id="chkAnswer22" class="form-check-input" />

                                                </div>
                                                <%--  </div>
                                            <div class="row">--%>
                                                <div class="col-md-6 d-flex align-items-center" id="divAnswerBox33">
                                                    <button class="x-btn" id="btnDelAns33" onclick="return deleteAnswer(this)">
                                                        ✖
                                                    </button>
                                                    <input type="text" id="inpAnswer33" placeholder="Enter Answer" class="form-control me-2 mt-12px" />
                                                    <input type="checkbox" id="chkAnswer33" class="form-check-input" />

                                                </div>
                                                <div class="col-md-6 d-flex align-items-center" id="divAnswerBox44">
                                                    <button class="x-btn" id="btnDelAns44" onclick="return deleteAnswer(this)">
                                                        ✖
                                                    </button>
                                                    <input type="text" id="inpAnswer44" placeholder="Enter Answer" class="form-control me-2 mt-12px" />
                                                    <input type="checkbox" id="chkAnswer44" class="form-check-input" />

                                                </div>

                                                <%--<div class="col-md-6 d-flex align-items-center">--%>
                                                <div id="divLoadAnswers1" class="row" style="width: 104%; max-width: 104%;"></div>
                                                <%--</div>--%>
                                                <br />

                                                <br />
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-center align-items-center w-10">

                                            <button type="button" id="btnAddAnswer1" onclick="AddAnswer(this)" class="btn btn-success">Add Answer</button>
                                        </div>

                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>






                    <div id="divDynamicPanels">
                        <br />
                    </div>
                    <br />
                    <div class="row">
                        <div class="d-flex justify-content-center align-items-center w-10">

                            <button type="button" id="btnAddPanel" class="btn btn-primary" onclick="AddPanel(this)">Add Panel</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 d-flex justify-content-end">
                            <button type="button" id="btnSaveData" class="btn btn-secondary" onclick="return SaveData()">Save</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="jsscripts" runat="Server">
 <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>


    <script>
               $(document).ready(function () {
            bindDropdown();
            $("#txtstartdate").datepicker({
                dateFormat: "dd-mm-yy",
                changeMonth: true,
                changeYear: true,

                onSelect: function (selectedDate) {
                    var date = $(this).datepicker("getDate");
                    if (date) {
                        var nextMonthDate = new Date(date);
                        nextMonthDate.setMonth(nextMonthDate.getMonth() + 1); // Adds 1 month

                        $("#txtenddate").datepicker("option", "minDate", date); // Start date as minDate
                        //$("#txtenddate").datepicker("option", "maxDate", nextMonthDate); // One month ahead as maxDate
                        $("#txtenddate").datepicker("setDate", nextMonthDate); // Auto select same date next month
                    }
                }
            });

            $("#txtenddate").datepicker({
                dateFormat: "dd-mm-yy",
                changeMonth: true,
                changeYear: true,
                
            });
        });

     

        // Call the function on page load
      
        $(document).ready(function () {
            $('#multi-select').select2({
                closeOnSelect: false,
                placeholder: "Select Departments"
            });
            function formatOption(option) {
                if (!option.id) return option.text;
                let checkbox = $('<input type="checkbox"/>');
                checkbox.prop('checked', $('#multi-select').val().includes(option.id));
                return $('<span></span>').append(checkbox).append(' ' + option.text);
            }

            function loadDepartments() {
                $.ajax({
                    url: "FinallyAdminVideoTest.aspx/binddropdown",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $('#multi-select').empty();
                        $('#multi-select').append('<option value="select_all">Select All</option>');
                        $.each(response.d, function (index, item) {
                            $('#multi-select').append($('<option>', {
                                value: item.DeptID,
                                text: item.DeptName
                            }));
                        });

                        $('#multi-select').select2({
                            closeOnSelect: false,
                            templateResult: formatOption
                        });

                        $('#multi-select').on('select2:select', function (e) {
                            let selectedValues = $('#multi-select').val();
                            if (selectedValues.includes('select_all')) {
                                $('#multi-select').val($('#multi-select option:not([value="select_all"])').map(function () {
                                    return $(this).val();
                                }).get()).trigger('change');
                            }
                        });

                        $('#multi-select').on('select2:unselect', function (e) {
                            let selectedValues = $('#multi-select').val();
                            if (!selectedValues || selectedValues.length === 0) {
                                $('#multi-select').val([]).trigger('change');
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        console.log("Error:", xhr.responseText);
                    }
                });
            }

            loadDepartments();
        });
       
        //function bindDropdown() {
        //    $.ajax({
        //        url: "FinallyAdminVideoTest.aspx/binddropdown",  // API/WebMethod URL
        //        type: "POST",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (response) {
        //            let dropdown = $('#ddldepartment');

        //            // Clear existing options
        //            dropdown.empty().append('<option value="0">Training For All Departments</option>');

        //            // Append department options dynamically
        //            $.each(response.d, function (index, dept) {
        //                dropdown.append(`<option value="${dept.DeptID}">${dept.DeptName}</option>`);
        //            });
        //            // Destroy existing instance (if already initialized) to prevent duplicate issues
        //            dropdown.multiselect('destroy').multiselect({
        //                includeSelectAllOption: true,  // "Select All" checkbox
        //                enableFiltering: true,  // Enables search box
        //                enableCaseInsensitiveFiltering: true,  // Case-insensitive search
        //                nonSelectedText: "Select Departments",  // Placeholder text
        //                buttonWidth: '100%',  // Full width button
        //                maxHeight: 250,  // Scrollable dropdown
        //                numberDisplayed: 2, // Show only 2 selected items, rest as "+X more"
        //                onChange: function (option, checked) {
        //                    console.log($(option).val() + ' was ' + (checked ? 'selected' : 'deselected'));
        //                }
        //            });
        //        },
        //        error: function () {
        //            alert("Failed to load departments.");
        //        }
        //    });
        //}

        function uploadFile(input) {
            var file = input.files[0]; // Get selected file
            if (!file) {
                return;
            }

            var formData = new FormData();
            formData.append("file", file);

            $.ajax({
                url: "/FileUploadHandler.ashx", // Call Generic Handler (ASHX)
                type: "POST",
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {

                    var hdnfilename = $(input).attr('id').replace('uploadVideo', 'hdnUploadFileName');

                    $('#' + hdnfilename).val(response); // Store filename
                    showVideoPreview(input);
                },
                error: function () {
                    $('#status').html("File upload failed.");
                }
            });
        }

        function showVideoPreview(input) {
            var file = input.files[0];
            if (!file) {
                return;
            }

            var videoURL = URL.createObjectURL(file);

            var videoThumbnail = $(input).attr('id').replace('uploadVideo', 'videoPreview');

            $('#' + videoThumbnail).attr("src", videoURL).show();
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /*Start Panel Logic*/
        function AddPanel() {

            var newId = '_' + new Date().getTime(); // Unique ID using timestamp
            var newContent = $('#divParentHidden').html(); // Get HTML content

            // Create a temporary jQuery object to modify IDs
            var $temp = $('<div>').html(newContent);


            // Modify IDs of elements inside
            $temp.find('[id]').each(function () {
                var oldId = $(this).attr('id');
                var newControlId = oldId + newId; // Append a unique part to the ID
                $(this).attr('id', newControlId);
            });

            $('#divDynamicPanels').append($temp.html());

            return newId;
        }

        function DeletePanel(button) {
            var divPanel = $(button).attr('id').replace('btnDeletePanel', 'divContent');

            $('#' + divPanel).remove();

            updateProgress();
        }
        /*End Panel Logic*/

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /*Start Question Answers Logic*/
        function AddQuestion(button) {
            var divQuestion = $(button).attr('id').replace('btnAddQuestion', 'divLoadMoreQuestions');

            console.log(divQuestion);

            var newContent = $('#divQuestionsHidden').html(); // Get hidden content
            var $temp = $('<div>').html(newContent); // Wrap in jQuery object to manipulate

            // Change the input field's ID to make it unique
            // Modify IDs of elements inside

            var newId = '_' + new Date().getTime(); // Unique ID using timestamp

            $temp.find('[id]').each(function () {
                var oldId = $(this).attr('id');
                var newControlId = oldId + newId; // Append a unique part to the ID
                $(this).attr('id', newControlId);
            });

            $('#' + divQuestion).append($temp.html()); // Append modified content
        }

        function DeleteQuestion(button) {
            var divQuestion = $(button).attr('id').replace('btnDeleteQuestion', 'divQuestions');

            $('#' + divQuestion).remove();

            updateProgress();
        }

        //function deleteAnswer(button) {
        //    var divAnswerBox = $(button).attr('id').replace('btnDelAns', 'divAnswerBox');

        //    $('#' + divAnswerBox).remove();
        //}
        function deleteAnswer(button) {
            if (confirm("Are you sure you want to delete this answer?")) {
                var divAnswerBox = $(button).attr('id').replace('btnDelAns', 'divAnswerBox');
                $('#' + divAnswerBox).remove();

                return true;
            }

            return false;
        }


        function AddAnswer(button) {
            var divAnswers = $(button).attr('id').replace('btnAddAnswer', 'divLoadAnswers');

            console.log(divAnswers);

            var newContent = $('#divAnswersHidden').html(); // Get hidden content
            var $temp = $('<div>').html(newContent); // Wrap in jQuery object to manipulate

            // Change the input field's ID to make it unique
            //$temp.find('#inpAnswer').attr('id', 'inpAnswer_' + new Date().getTime());
            //chkAnswer

            var newId = '_' + new Date().getTime(); // Unique ID using timestamp

            $temp.find('[id]').each(function () {
                var oldId = $(this).attr('id');
                var newControlId = oldId + newId; // Append a unique part to the ID
                $(this).attr('id', newControlId);
            });

            $('#' + divAnswers).before($temp.html()); // Append modified content
        }
        /*End  Question Answers Logic*/

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        // Start Score Calculation Logic

        function totalQuestionScore(inputScore) {



            let total = 0;
            document.querySelectorAll(".questionscore").forEach(input => {
                let value = parseFloat(input.value) || 0; // Convert blank to 0
                total += value;
            });
            document.getElementById("hdnQuestionScore").value = total;


            updateProgress();
        }

        // End Score Calculation Logic

    </script>


    <script>
        function generateJson() {
            let jsonData = [];

            // Capture global form fields
            let globalData = {
                Title: $('#txttitle').val() || "", // Global Title
                PassingScore: $('#txtTotalpassingmarks').val() || "0", // Global Passing Score
                TotalScore: $('#txtTotalScore').val() || "0",
                Description: $('#txtDescription').val() || "0",
                Startdate: $('#txtstartdate').val() || "0",
                Enddate: $('#txtenddate').val() || "0",
                // DeptId: $('#ddldepartment option:selected').val() || "0"
                DeptId: $('#ddldepartment').val() ? $('#ddldepartment').val().join(",") : "0"
            };

            // Loop through content divs
            $('[id^=divContent_]').each(function (i, elem) {
                let contentObj = {
                    ContentID: $(elem).attr('id'),
                    UploadFileName: $(elem).find('[id^=hdnUploadFileName]').val() || "", // Hidden input value
                    VideoDescription: $(elem).find('[id^=txtvideoDescription]').val() || "",  // Video description
                    TitleDescription: $(elem).find('[id^=txtTitleDescription]').val() || "",  // Title description
                    Questions: []
                };

                $(elem).find('[id^=divQuestions]').each(function (x, elemQuestion) {
                    let questionObj = {
                        QuestionID: $(elemQuestion).attr('id'),
                        QuestionText: $(elemQuestion).find('[id^=inpTextQuestion]').val(),
                        Score: $(elemQuestion).find('[id^=inpQuestionScore]').val() || "0",
                        Answers: []
                    };

                    $(elemQuestion).find('[id^=divAnswers_]').each(function (y, elemAnswer) {
                        $(elemAnswer).find('[id^=inpAnswer]').each(function (z, allAnselem) {

                            debugger;

                            let answerObj = {
                                AnswerID: $(allAnselem).attr('id'),
                                AnswerText: $(allAnselem).val(),
                                IsCorrect: $(allAnselem).next('[id^=chkAnswer]').is(':checked')

                            };
                            questionObj.Answers.push(answerObj);
                        });
                    });

                    contentObj.Questions.push(questionObj);
                });

                jsonData.push(contentObj);
            });

            // Combine globalData and jsonData into one object
            let finalJson = {
                FormDetails: globalData, // Global fields (title, passing score, total score)
                ContentSections: jsonData // All content divs and questions
            };

            return JSON.stringify(finalJson, null, 4);
        }

        function commonValidation(id, errorMsg) {
            var error = 0;

            $(id).each(function (index, elem) {
                if ($(elem).val().trim() == '') {
                    Swal.fire({
                        title: "",
                        text: errorMsg,
                        icon: "error"
                    });

                    error = 1;
                    return false;
                }
            });

            if (error > 0) {
                return false;
            }
            return true;

        }

        function validateForm() {
            // Usage Example
            //var result = commonValidation('#ddldepartment', 'Please select Department!');

            //if (!result) {
            //    return false;
            //}
            // Video File
            var result = commonValidation('[id^=hdnUploadFileName_]', 'Upload Video for each Panel !');

            if (!result) {
                return false;
            }

            // Lesson Title
            var result = commonValidation('[id^=txtTitleDescription_]', 'Lesson Title is missing !');

            if (!result) {
                return false;
            }

            // Lesson Description
            var result = commonValidation('[id^=txtvideoDescription_]', 'Lesson Description is missing !');

            if (!result) {
                return false;
            }

            // Question Score
            var result = commonValidation('[id^=inpQuestionScore_]', 'Question Score is missing !');

            if (!result) {
                return false;
            }



            // Question
            var result = commonValidation('[id^=inpTextQuestion_]', 'Question is missing !');

            if (!result) {
                return false;
            }

            var error = 0;

            // checking answers
            $('[id*=divAnswers_]').not('#divAnswers_11').each(function (index, elem) {

                $(elem).find('[id^=inpAnswer]').each(function (i, Anselem) {
                    console.log($(Anselem).attr('id'));
                    if ($(Anselem).val().trim() == '') {
                        Swal.fire({
                            title: "",
                            text: "Answer is missing !",
                            icon: "error"
                        });

                        error = 1;
                        return false;
                    }

                });

            });

            if (error > 0) {
                return false;
            }

            // checking checkbox
            $('[id*=divAnswers_]').not('#divAnswers_11').each(function (index, elem) {

                if ($(elem).find('input[type=checkbox]:checked').length == 0) {

                    Swal.fire({
                        title: "",
                        text: "Mark correct Answer !",
                        icon: "error"
                    });

                    error = 1;
                    return false;

                }
            });

            if (error > 0) {
                return false;
            }
            return true;
        }

        function SaveData() {

            var result = validateForm();

            if (!result) { return false; }

            let jsonData = generateJson();

            $.ajax({
                type: "POST",
                url: "FinallyAdminVideoTest.aspx/SaveData", // Update with your actual WebService path
                data: JSON.stringify({ jsonString: jsonData }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        title: "",
                        text: "Data Saved successfully !",
                        icon: "success"
                    }).then(() => {
                        location.reload(); // Reloads the current page
                    });

                },
                error: function (error) {
                    console.error("Error sending data:", error);
                }
            });
        }


    </script>

    <%--Drag and Drop Upload Logic--%>
    <script>

        $(document).ready(function () {

            $('#btnSaveData').hide();

            // Event delegation for dynamically created elements
            $(document).on('dragover', '.drop-area', function (event) {
                event.preventDefault();
                $(this).addClass("highlight");
            });

            $(document).on('dragleave', '.drop-area', function () {
                $(this).removeClass("highlight");
            });

            $(document).on('drop', '.drop-area', function (event) {
                event.preventDefault();
                $(this).removeClass("highlight");

                // Get the related file input dynamically
                let fileInput = $(this).siblings("input[type=file]");

                if (event.originalEvent.dataTransfer.files.length > 0) {
                    fileInput.prop("files", event.originalEvent.dataTransfer.files);
                    handleFile(fileInput[0]); // Call function to handle preview
                }
            });

            $(document).on('click', '.drop-area', function () {
                $(this).siblings("input[type=file]").click();
            });

            $(document).on('change', 'input[type=file]', function () {
                handleFile(this); // Handle preview when file is selected
            });

            function handleFile(input) {
                if (input.files.length > 0) {
                    let file = input.files[0];
                    let dropArea = $(input).siblings(".drop-area");

                    // Show preview for images/videos
                    if (file.type.startsWith("image/")) {
                        let reader = new FileReader();
                        reader.onload = function (e) {
                            dropArea.html(`<img src="${e.target.result}" width="100%" style="max-height:200px;"/>`);
                        };
                        reader.readAsDataURL(file);
                    } else if (file.type.startsWith("video/")) {
                        let reader = new FileReader();
                        reader.onload = function (e) {
                            dropArea.html(`<video width="100%" controls style="max-height:200px;"><source src="${e.target.result}" type="${file.type}"></video>`);
                        };
                        reader.readAsDataURL(file);
                    } else {
                        dropArea.text(`File: ${file.name}`);
                    }
                }
            }
        });

    </script>

    <%--Progress Bar Logic--%>
    <script>

        function updateProgress() {
            let total = parseFloat(document.getElementById("txtTotalScore").value) || 1;
            let current = parseFloat(document.getElementById("hdnQuestionScore").value) || 0;

            let percentage = Math.min((current / total) * 100, current); // Ensure it doesn't exceed 100%
            let progressBar = document.getElementById("progressBar");
            let saveButton = document.getElementById("btnSaveData"); // Assuming the save button has this ID

            if (current > total) {
                let total1 = total; // Calculate remaining score (negative if exceeded)
                let current1 = current;
                Swal.fire({
                    title: "Error",
                    text: `Current score cannot be greater than the total score! Your total score is ${total1}, but you entered score ${current1}.`,
                    icon: "error"
                });
                progressBar.style.backgroundColor = "red"; // Set color to red
                saveButton.style.display = "none"; // Hide the save button

            } else if (current < total) {
                progressBar.style.backgroundColor = "yellow"; // Set color to yellow
                saveButton.style.display = "none"; // Show the save button
            } else if (current === total) {
                progressBar.style.backgroundColor = "green"; // Set color to blue
                saveButton.style.display = "block"; // Ensure the save button is visible
            }

            progressBar.style.width = percentage + "%";
            progressBar.innerText = Math.round(percentage) + "%";
        }
    </script>

    <script>
        ////////////////////////////////
        // For Creating new Course
        $(document).ready(function () {
            var dynamicid = AddPanel();

            $('#btnDeleteQuestion' + dynamicid).remove();
            $('#btnDeletePanel' + dynamicid).remove();
        });

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Load Course Data For Edit
        $(document).ready(function () {

            return;



            $.ajax({
                type: "POST",
                url: "FinallyAdminVideoTest.aspx/GetCourseData",
                //data: {},
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var data = JSON.parse(response.d);

                    // Parent (courseId)
                    $.each(data.data.Table, function (i, elem) {

                        var PassingMark = data.data.Table[0].PassingMark;

                        // Panel (LessonId)
                        $.each(data.data.Table1, function (i, Panelelem) {

                            var lessonId = data.data.Table1[i].lesson_id;
                            var Lessontitle = data.data.Table1[i].lesson_title;

                            // Creating Dynamic Panels
                            var newId = '_' + new Date().getTime(); // Unique ID using timestamp
                            var newContent = $('#divParentHidden').html(); // Get HTML content

                            // Create a temporary jQuery object to modify IDs
                            var $temp = $('<div>').html(newContent);

                            // Modify IDs of elements inside
                            $temp.find('[id]').each(function () {
                                var oldId = $(this).attr('id');
                                var newControlId = oldId + newId; // Append a unique part to the ID
                                $(this).attr('id', newControlId);
                            });

                            var QId = $temp.find('[id^=divQuestions_]').attr('id');
                            $temp.find('[id^=divQuestions_]').html('');

                            $('#divDynamicPanels').append($temp.html());

                            let filteredQuestions = data.data.Table2.filter(lessonid => lessonid.lesson_id === lessonId);

                            // Questions Panel (Lession Id)
                            $.each(filteredQuestions, function (i, Questionelem) {

                                var QuestionId = filteredQuestions[i].question_id;
                                var Question = filteredQuestions[i].questions;

                                debugger;

                                $('#' + QId).html($('#divQuestionsHidden').html());
                                //$('#' + QId).find('[id^=divAnswers]').html('');

                                let filteredAnswers = data.data.Table3.filter(qid => qid.question_id === QuestionId);

                                // Answers Panel (Question Id)
                                $.each(filteredAnswers, function (i, Answerelem) {

                                    debugger;

                                    var AnswerId = filteredAnswers[i].answer_id;
                                    var Answer = filteredAnswers[i].answer_options;



                                });

                            });

                        });

                    });

                    debugger;

                    console.log(data);

                },
                error: function (error) {
                    console.error("Error receiving data:", error);
                }
            });

        });
    </script>



</asp:Content>
