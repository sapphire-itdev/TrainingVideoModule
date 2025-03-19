<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="AdminVideoTest.aspx.cs" Inherits="Pages_AdminVideoTest" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script>
        function saveData() {
            $('[id^=divContent]').each(function () {
                console.log(1);
            });
        }
    </script>

    <div id="divParentHidden" style="display: none;">
        <br />
        <div id="divContent">
            <input type="file" id="uploadVideo" onchange="uploadFile(this)" />
            <input type="hidden" id="hdnUploadFileName" />
            <video id="videoPreview" width="150" controls style="display: none;"></video>

            <div id="divQuestions">
                <input type="text" id="inpQuestion" placeholder="Question" />

                <br />
                <input type="text" id="inpQuestionScore" placeholder="Score" onfocusout="totalQuestionScore(this);" />
                <button type="button" id="btnDeleteQuestion" onclick="DeleteQuestion(this)">Delete Question</button>
                <br />

                <div id="divAnswers">
                    <input type="checkbox" id="chkAnswer1" />
                    <input type="text" id="inpAnswer1" placeholder="Answer 1" />

                    <input type="checkbox" id="chkAnswer2" />
                    <input type="text" id="inpAnswer2" placeholder="Answer 2" />

                    <input type="checkbox" id="chkAnswer3" />
                    <input type="text" id="inpAnswer3" placeholder="Answer 3" />

                    <input type="checkbox" id="chkAnswer4" />
                    <input type="text" id="inpAnswer4" placeholder="Answer 4" />
                    <div id="divLoadAnswers"></div>
                    <br />
                </div>
                <button type="button" id="btnAddAnswer" onclick="AddAnswer(this)">Add Answer</button>
                <br />
            </div>

            <div id="divLoadMoreQuestions"></div>
            <br />
            <button type="button" id="btnAddQuestion" onclick="AddQuestion(this)">Add Question</button>
            <br />
            <button type="button" id="btnAddPanel" onclick="AddPanel(this)">Add Panel</button>
            <button type="button" id="btnDeletePanel" onclick="DeletePanel(this)">Delete Panel</button>

            <br />
        </div>
    </div>

    <div id="divAnswersHidden" style="display: none;">
        <input type="checkbox" id="chkAnswer" />
         <input type="text" id="inpAnswer" placeholder="Enter Answer" />
            </div>

    <div id="divQuestionsHidden" style="display: none;">
        <div id="divQuestions11">
            <input type="text" id="inpQuestion11" placeholder="Question" />
            <br />
            <input type="text" id="inpQuestionScore11" placeholder="Score" onfocusout="totalQuestionScore(this);" />
            <button type="button" id="btnDeleteQuestion11" onclick="DeleteQuestion(this)">Delete Question</button>
            <br />
            <div id="divAnswers11">
                <input type="checkbox" id="chkAnswer11" />
                <input type="text" id="inpAnswer11" placeholder="Answer 1" />

                <input type="checkbox" id="chkAnswer22" />
                <input type="text" id="inpAnswer22" placeholder="Answer 2" />

                <input type="checkbox" id="chkAnswer33" />
                <input type="text" id="inpAnswer33" placeholder="Answer 3" />

                <input type="checkbox" id="chkAnswer44" />
                <input type="text" id="inpAnswer44" placeholder="Answer 4" />

                <div id="divLoadAnswers1"></div>
                <br />
            </div>
            <button type="button" id="btnAddAnswer1" onclick="AddAnswer(this)">Add Answer</button>
            <br />
        </div>
    </div>

    <input type="text" id="txtTotalScore" disabled placeholder="Total Score" />

    <br />
    <br />
    <div id="divDynamicPanels">
    </div>

    <button type="button" id="btnSaveData" onclick="SaveData()">Save</button>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="jsscripts" runat="Server">
    <script>

        $(document).ready(function () {
            var dynamicid = AddPanel();

            $('#btnDeleteQuestion' + dynamicid).remove();
            $('#btnDeletePanel' + dynamicid).remove();
        });

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

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

            $('#' + divAnswers).append($temp.html()); // Append modified content
        }
        /*End  Question Answers Logic*/

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        // Start Score Calculation Logic

        function totalQuestionScore(inputScore) {

            var score = $('#' + $(inputScore).attr('id')).val();
            score = score == "" ? '0' : score;

            var totalScore = $('#txtTotalScore').val() == "" ? '0' : $('#txtTotalScore').val();

            var total = parseInt(score) + parseInt(totalScore);


            if (total > 100) {
                alert('Score going above 100');
                return false;
            }

            $('#txtTotalScore').val(total);
        }

        // End Score Calculation Logic

    </script>


    <script>
        //function saveData() {

        //    $('[id^=divContent_]').each(function (i, elem) {
        //        console.log('Content ' + i);

        //        var ContentID = $(elem).attr('id');

        //        // Questions
        //        $('#' + ContentID).find($('[id^=divQuestions]')).each(function (x, elemQuestion) {
        //            console.log('Question No. ' + x);
        //            //console.log($(elemQuestion).attr('id'));

        //            var QuestionId = $(elemQuestion).attr('id');
        //            // Answers
        //            $('#' + QuestionId).find($('[id^=divAnswers]')).each(function (x, elemAnswer) {
        //                console.log('Answer Div No. ' + x);
        //                //console.log($(elemAnswer).attr('id'));

        //                var AnswerDivId = $(elemAnswer).attr('id');

        //                // Fetching All Answers
        //                $('#' + AnswerDivId).find($('[id^=inpAnswer]')).each(function (y, allAnselem) {
        //                    console.log('Answer No. ' + y);
        //                    console.log($(allAnselem).attr('id'));

        //                });

        //            });
        //        });

        //    });
        //}


        function generateJson() {
            let jsonData = [];

            $('[id^=divContent_]').each(function (i, elem) {
                let contentObj = {
                    ContentID: $(elem).attr('id'),
                    UploadFileName: $(elem).find('[id^=hdnUploadFileName]').val() || "", // Get hidden input value
                    Questions: []
                };

                $(elem).find('[id^=divQuestions]').each(function (x, elemQuestion) {
                    let questionObj = {
                        QuestionID: $(elemQuestion).attr('id'),
                        QuestionText: $(elemQuestion).find('[id^=inpQuestion]').val(),
                        Score: $(elemQuestion).find('[id^=inpQuestionScore]').val() || "0",
                        Answers: []
                    };

                    $(elemQuestion).find('[id^=divAnswers]').each(function (y, elemAnswer) {
                        $(elemAnswer).find('[id^=inpAnswer]').each(function (z, allAnselem) {
                            let answerObj = {
                                AnswerID: $(allAnselem).attr('id'),
                                AnswerText: $(allAnselem).val(),
                                IsCorrect: $(allAnselem).prev('[id^=chkAnswer]').is(':checked')
                            };
                            questionObj.Answers.push(answerObj);
                        });
                    });

                    contentObj.Questions.push(questionObj);
                });

                jsonData.push(contentObj);
            });

            return JSON.stringify(jsonData, null, 4);
        }

        //console.log(generateJson());

        function SaveData() {
            let jsonData = generateJson();

            $.ajax({
                type: "POST",
                url: "AdminVideoTest.aspx/SaveData", // Update with your actual WebService path
                data: JSON.stringify({ jsonString: jsonData }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log("Data sent successfully!", response);
                },
                error: function (error) {
                    console.error("Error sending data:", error);
                }
            });
        }


    </script>


</asp:Content>


