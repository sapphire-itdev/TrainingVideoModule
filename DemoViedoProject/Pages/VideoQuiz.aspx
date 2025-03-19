<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="VideoQuiz.aspx.cs" Inherits="Pages_VideoQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
    <link href="../assets/css/VideoQuiz.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-wrapper">
        <div class="container-fluid pb-0">
            <div class="video-block section-padding">
                <div class="row">
                    <div class="col-md-8">
                        <div class="single-video-left">
                            <%-- Video Section--%>
                            <div class="single-video">
                                <h4>Video Title</h4>
                                <div class="video-container">
                                    <%--<video id="video" src="Assets/Videos/SampleVideo2.mp4"></video>--%>
                                    <video id="video"></video>
                                    <div class="Vidcontrols">
                                        <button class="btnPlayControl" type="button" id="playPauseBtn" onclick="togglePlay()">▶</button>
                                        <button class="btnPlayControl" type="button" onclick="rewind()">⏪</button>
                                        <div class="progress-bar" id="progress-bar" onmousemove="moveDisableIcon(event)" onmouseenter="showDisableIcon()" onmouseleave="hideDisableIcon()">
                                            <div class="progress" id="progress"></div>
                                            <span class="disable-icon disableIcon" id="disable-icon">🚫</span>
                                        </div>
                                        <span id="time">00:00 / 00:00</span>
                                        <div class="volume">
                                            <button class="btnPlayControl" type="button" id="muteBtn" onclick="toggleMute()">🔊</button>
                                            <input type="range" id="volume-slider" min="0" max="1" step="0.1" value="1" onchange="changeVolume()">
                                        </div>
                                        <button class="btnPlayControl" type="button" onclick="toggleFullscreen()">⛶</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--Quiz Section--%>
                        <%--<div id="myBtn"></div>
                                <div id="myModal" class="modal">
                                    <div class="quiz-container">
                                        <span class="close" data-toggle="tooltip" data-placement="top" title="Close">x</span>
                                        <h3 class="Quizheading">🎥 Video Quiz</h3>
                                        <div class="question">
                                            Q1: What is the capital of France?
                                        </div>
                                        <div class="options">
                                            <button type="button">🔹 Berlin</button>
                                            <button type="button">🔹 Madrid</button>
                                            <button type="button">✅ Paris</button>
                                            <button type="button">🔹 Rome</button>
                                        </div>
                                        <button type="button" class="next-btn">Next ➡</button>
                                    </div>
                                    <button type="button" class="next-btn" onclick="nextQuestion()">Next ➡</button>
                                </div>--%>
                        <div id="myBtn"></div>
                        <div id="myModal" class="modal">
                            <div id="QuizQuestions" class="quiz-container">
                                <span class="close" onclick="closeQuiz()">x</span>
                                <h3 class="Quizheading">🎥 Video Quiz</h3>
                                <div class="question" id="questionText">
                                    Loading question...
                                </div>
                                <div class="options" id="optionsContainer">
                                    <!-- Options will be loaded dynamically -->
                                </div>
                                 <p id="validationMessage" style="color: red; display: none;"></p>
                                <button type="button" class="next-btn" onclick="nextQuestion()">Next ➡</button>
                            </div>
                        </div>


                       <%-- <div id="myModal" class="modal">--%>
                        <div id="showScoreSection" class="modal">
                            <div id="ScoreSection" class="quiz-container">
                                <span class="close" onclick="closeQuiz()" data-toggle="tooltip" data-placement="top" title="Tooltip on top">x</span>
                                <h3 class="Quizheading">Quiz Completed</h3>
                                <div class="score-box">
                                    <p>Your Score:</p>
                                    <h2 id="finalScore">0%</h2>
                                    <h2 id="scoreResult" class="score-Result"></h2>  <!-- Pass/Fail Result -->
                                    <img id="resultIcon" class="result-icon" src="" alt=""> 
                                    <p id="scoreMessage"></p>
                                </div>
                                <button type="button" class="score-next-btn" onclick="closeQuiz()">Finish</button>
                                <canvas id="confettiCanvas"></canvas>
                            </div>
                        </div>
                        <div class="loading-screen" id="loadingScreen">
                            <div class="loading-icon"></div>
                            <p>Quiz Loading...</p>
                        </div>
                        <div class="single-video-title box mb-3">
                            <h4><a href="#">Contrary to (2019) is not.</a></h4>
                        </div>
                        <div class="single-video-info-content box mb-3">
                            <h6>Cast:</h6>
                            <p>Nathan Drake , Victor Sullivan , Sam Drake , Elena Fisher</p>
                            <h6>Category :</h6>
                            <p>Gaming , PS4 Exclusive , Gameplay , 1080p</p>
                            <h6>About :</h6>
                            <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved overVarious versions have evolved over the years, sometimes </p>
                            <h6>Tags :</h6>
                            <p class="tags mb-0">
                                <span><a href="#">Uncharted 4</a></span>
                                <span><a href="#">Playstation 4</a></span>
                                <span><a href="#">Gameplay</a></span>
                                <span><a href="#">1080P</a></span>
                                <span><a href="#">ps4Share</a></span>
                                <span><a href="#">+ 6</a></span>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-video-right">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="adblock">
                                        <div class="main-title">
                                            <button class="start-quiz-btn" type="button" onclick="showLoadingScreen()">Start Quiz</button>
                                            <div class="btn-group float-right right-action">
                                            </div>
                                            <h6>Recommended for You</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="video-card video-card-list">
                                        <div class="video-card-image">
                                            <a class="play-icon" href="VideoQuiz.aspx?video=Assets/Videos/SampleVideo3.mp4"><i class="fas fa-play-circle"></i></a>
                                            <a href="VideoQuiz.aspx?video=Assets/Videos/SampleVideo3.mp4">
                                                <img class="img-fluid" src="Assets/Videos/SampleVideo3.mp4" alt="">
                                            </a>
                                            <div class="time">3:50</div>
                                        </div>
                                        <div class="video-card-body">
                                            <div class="btn-group float-right right-action">
                                            </div>
                                            <div class="video-title">
                                                <a href="VideoQuiz.aspx?video=Assets/Videos/SampleVideo3.mp4">
                                                    Here are many variati of passages of Lrem
                                                </a>
                                            </div>
                                            <div class="video-page text-success">
                                                Completed <span title="" data-placement="top" data-toggle="tooltip" href="#" data-original-title="Verified"><i class="fa fa-eye text-success" aria-hidden="true"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="video-card video-card-list">
                                        <div class="video-card-image">
                                            <a class="play-icon" href="quiz.aspx"><i class="fas fa-play-circle"></i></a>
                                            <a href="quiz.aspx">
                                                <img class="img-fluid" src="Assets/Videos/SampleVideo2.mp4" alt=""></a>
                                            <div class="time">3:50</div>
                                        </div>
                                        <div class="video-card-body">
                                            <div class="btn-group float-right right-action">
                                            </div>
                                            <div class="video-title">
                                                <a href="test.aspx">Here are many variati of passages of Lrem</a>
                                            </div>
                                            <div class="video-page txtOrange">
                                                Continue Watching <span title="" data-placement="top" data-toggle="tooltip" href="#" data-original-title="Verified"><i class="fa fa-eye txtOrange" aria-hidden="true"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="video-card video-card-list" data-toggle="tooltip" data-placement="top" title="Watch the previous video to continue.">
                                        <div class="video-card-image">
                                            <a class="play-icon disabledVideo" href="quiz.aspx"><i class="fas fa-play-circle"></i></a>
                                            <a href="#">
                                                <img class="img-fluid" src="Assets/Videos/SampleVideo3.mp4" alt=""></a>
                                            <div class="time">3:50</div>
                                        </div>
                                        <div class="video-card-body">
                                            <div class="btn-group float-right right-action">
                                                <a href="#" class="right-action-link text-gray" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                            </div>
                                            <div class="video-title">
                                                <a class="disabledVideo" href="#">Duis aute irure dolor in reprehenderit in.</a>
                                            </div>
                                            <div class="video-page text-secondary">
                                                Not Started yet   <span title="" data-placement="top" data-toggle="tooltip" href="#" data-original-title="Verified"><i class="fa fa-eye-slash text-secondary" aria-hidden="true"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsscripts" runat="Server">
    <script src="../assets/js/VideoQuiz.js"></script>
    <%--    <script>
        var currentQuestionIndex = 0;<video src="../Videos/The%20Ant%20and%20The%20Dove%20_%20Best%20Short%20Stories%20for%20Kids%20in%20English%20_%20Bedtime%20Story_20250318_112131.mp4" controls="controls" />
        var correctAnswers = 0;
        var totalQuestions = 0;

        // Load first question on page load
        $(document).ready(function () {
            loadQuestion();
        });

        function loadQuestion() {
            $.ajax({
                type: "POST",
                url: "VideoQuiz.aspx/GetQuestion",
                data: JSON.stringify({ index: currentQuestionIndex }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var data = response.d;
                    if (data === null) {
                        // If no more questions, show score
                        showScore();
                    } else {
                        $("#questionText").html("Q" + (currentQuestionIndex + 1) + ": " + data.Question);
                        $("#optionsContainer").html(
                            '<button type="button" class="option-btn" onclick="submitAnswer(\'' + data.Option1 + '\', ' + data.IsCorrect1 + ')">🔹 ' + data.Option1 + '</button>' +
                            '<button type="button" class="option-btn" onclick="submitAnswer(\'' + data.Option2 + '\', ' + data.IsCorrect2 + ')">🔹 ' + data.Option2 + '</button>' +
                            '<button type="button" class="option-btn" onclick="submitAnswer(\'' + data.Option3 + '\', ' + data.IsCorrect3 + ')">🔹 ' + data.Option3 + '</button>' +
                            '<button type="button" class="option-btn" onclick="submitAnswer(\'' + data.Option4 + '\', ' + data.IsCorrect4 + ')">🔹 ' + data.Option4 + '</button>'
                        );
                    }
                },
                error: function (error) {
                    console.log("Error fetching question: ", error);
                }
            });
        }

        function submitAnswer(answer, isCorrect) {
            $.ajax({
                type: "POST",
                url: "Quiz.aspx/SubmitAnswer",
                data: JSON.stringify({ index: currentQuestionIndex, answer: answer, isCorrect: isCorrect }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d) correctAnswers++;
                    totalQuestions++;
                    nextQuestion();
                },
                error: function (error) {
                    console.log("Error submitting answer: ", error);
                }
            });
        }

        function nextQuestion() {
            currentQuestionIndex++;
            loadQuestion();
        }

        function showScore() {
            let percentage = (correctAnswers / totalQuestions) * 100;
            if (percentage >= 70) {
                $("#finalScore").text(percentage.toFixed(2));
                $("#scoreContainer").show();
                $("#myModal").hide();
            }
        }

        function closeQuiz() {
            $("#myModal").hide();
        }
    </script>--%>
</asp:Content>
