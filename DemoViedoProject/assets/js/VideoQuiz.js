
//  ==========================
//     variable decleration
//  ========================== 
const video = document.getElementById("video");
const playPauseBtn = document.getElementById("playPauseBtn");
const progressBar = document.getElementById("progress");
const progressContainer = document.getElementById("progress-bar");
const timeDisplay = document.getElementById("time");
const volumeSlider = document.getElementById("volume-slider");
const muteBtn = document.getElementById("muteBtn");
const disableIcon = document.getElementById("disable-icon");
const loadingScreen = document.getElementById("loadingScreen");
const loadingScreenMain = document.getElementById("content-wrapper");

var checkBoxInput = true;
var modal = document.getElementById("myModal");
var span = document.getElementsByClassName("close")[0];
var correctAnswers = 0;

//Ajax call
var currentQuestionIndex = 0;
var correctAnswers = 0;
var totalQuestions = 0;
$(document).ready(function () {
    loadQuestion();
    //showLoadingScreen();
    $("#showScoreSection").hide();
    //$("input[name='answer']").on("change", function () {
    //    if ($("input[name='answer']:checked").length > 0) {
    //        $("#validationMessage").hide();
    //    }
    //});

    // Function to get URL parameter by name
    function getQueryParam(param) {
        debugger;
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    // Fetch 'video' parameter from URL
    const videoFile = getQueryParam("Video");
    
    // Set the video source if a valid value exists
    if (videoFile) {
        debugger;
        document.getElementById("video").innerHTML = `
            <source src="../Videos/${videoFile}" type="video/mp4">
            Your browser does not support the video tag.
        `;
    }
});

//$(document).ready(function () {
//    $("input[name='answer']").on("change", function () {
//        if ($("input[name='answer']:checked").length > 0) {
//            $("#validationMessage").hide();
//        }
//    });
//});
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
                showScore();
            } else {
                $("#questionText").html("Q" + (currentQuestionIndex + 1) + ": " + data.Question);
                $("#optionsContainer").html(
                    '<label class="glow-checkbox"> A. <input type="checkbox" name="answer" value="' + data.Option1 + '" data-correct="' + data.IsCorrect1 + '"><span class="glow"></span> ' + data.Option1 + '</label><br>' +
                    '<label class="glow-checkbox"> B. <input type="checkbox" name="answer" value="' + data.Option2 + '" data-correct="' + data.IsCorrect2 + '"><span class="glow"></span> ' + data.Option2 + '</label><br>' +
                    '<label class="glow-checkbox"> C. <input type="checkbox" name="answer" value="' + data.Option3 + '" data-correct="' + data.IsCorrect3 + '"><span class="glow"></span> ' + data.Option3 + '</label><br>' +
                    '<label class="glow-checkbox"> D. <input type="checkbox" name="answer" value="' + data.Option4 + '" data-correct="' + data.IsCorrect4 + '"><span class="glow"></span> ' + data.Option4 + '</label><br>'
                );
                // Hide validation message initially
                $("#validationMessage").hide();
            }
        },
        error: function (error) {
            console.log("Error fetching question: ", error);
        }
    });
}

//function submitAnswer(answer, isCorrect) {
//    $.ajax({
//        type: "POST",
//        url: "VideoQuiz.aspx/SubmitAnswer",
//        data: JSON.stringify({ index: currentQuestionIndex, answer: answer, isCorrect: isCorrect }),
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        success: function (response) {
//            if (response.d) correctAnswers++;
//            totalQuestions++;
//            nextQuestion();
//        },
//        error: function (error) {
//            console.log("Error submitting answer: ", error);
//        }
//    });
//}
function submitAnswer() {
    var selectedOptions = $("input[name='answer']:checked");

    if (selectedOptions.length === 0) {
        $("#validationMessage").text("An answer is required to continue.").show();
        checkBoxInput = false;
        return; // Stop execution if no option is selected
    }
    else {
        $("#validationMessage").hide();
        checkBoxInput = true;
    }

    if (currentQuestionIndex < 5) {
        var isCorrect = 0;
        selectedOptions.each(function () {
            if ($(this).attr("data-correct") === "1") {
                isCorrect = 1;
            }
        });

        if (isCorrect == 1) {
            correctAnswers++;
        }
        totalQuestions++;
        loadQuestion();
    }
    else {
        // showScore();
        $("#showScoreSection").show();
        $("#validationMessage").hide();
        $("#myModal").hide();
        showFinalScore(80);
    }
    // nextQuestion();
    //return isCorrect == 1;

    //$.ajax({
    //    type: "POST",
    //    url: "VideoQuiz.aspx/SubmitAnswer",
    //    data: JSON.stringify({ index: currentQuestionIndex, isCorrect: isCorrect }),
    //    contentType: "application/json; charset=utf-8",
    //    dataType: "json",
    //    success: function (response) {
    //        if (response.d) correctAnswers++;
    //        totalQuestions++;
    //        nextQuestion();
    //    },
    //    error: function (error) {
    //        console.log("Error submitting answer: ", error);
    //    }
    //});
}

function nextQuestion() {
    submitAnswer();
    if (checkBoxInput) {
        currentQuestionIndex++;
        loadQuestion();
    }
}
function showScore() {
    let percentage = (correctAnswers / totalQuestions) * 100;
    if (percentage >= 70) {
        $("#finalScore").text(percentage.toFixed(2));
        $("#scoreContainer").show();
        // $("#myModal").hide();
    }
}
function closeQuiz() {
    $("#myModal").hide();
}

//  ==========================
//     Model Section
//  ========================== 
span.onclick = function () {
    modal.style.display = "none";
}


//  ==========================
//     Video Player Control
//  ========================== 

function togglePlay(event) {
    if (video.paused) {
        video.play();
        playPauseBtn.textContent = "⏸";
    } else {
        video.pause();
        playPauseBtn.textContent = "▶";
    }
}
function rewind() {
    video.currentTime = Math.max(video.currentTime - 5, 0);
}

function updateProgress() {
    const percent = (video.currentTime / video.duration) * 100;
    progressBar.style.width = `${percent}%`;
    timeDisplay.textContent = `${String(Math.floor(video.currentTime / 60)).padStart(2, '0')}:${String(Math.floor(video.currentTime % 60)).padStart(2, '0')} / ${String(Math.floor(video.duration / 60)).padStart(2, '0')}:${String(Math.floor(video.duration % 60)).padStart(2, '0')}`;
}
//function toggleFullscreen() {
//    if (!document.fullscreenElement) {
//        video.parentElement.requestFullscreen();
//    } else {
//        document.exitFullscreen();
//    }
//}

function toggleFullscreen() {
    if (!document.fullscreenElement) {
        video.parentElement.requestFullscreen().then(() => {
            rotateVideoForMobile();
        });
    } else {
        document.exitFullscreen();
        resetRotation();
    }
}

// Function to rotate the video for mobile devices
function rotateVideoForMobile() {
    if (window.innerWidth < window.innerHeight) { // Detect portrait mode (mobile)
        video.style.transform = "rotate(90deg)";
        video.style.width = "100vh"; // Adjust width to full height
        video.style.height = "100vw"; // Adjust height to full width
    }
}

// Function to reset rotation when exiting fullscreen
function resetRotation() {
    video.style.transform = "rotate(0deg)";
    video.style.width = "";
    video.style.height = "";
}

// Detect fullscreen exit and reset rotation
document.addEventListener("fullscreenchange", () => {
    if (!document.fullscreenElement) {
        resetRotation();
    }
});

function toggleMute() {
    video.muted = !video.muted;
    muteBtn.textContent = video.muted ? "🔇" : "🔊";
}
function changeVolume() {
    video.volume = volumeSlider.value;
    updateMuteButton();
}

// ✅ Function to toggle mute
function toggleMute() {
    if (video.volume > 0) {
        video.volume = 0;
        volumeSlider.value = 0; // Update slider
    } else {
        video.volume = 1;
        volumeSlider.value = 1; // Reset volume
    }
    updateMuteButton();
}

// ✅ Function to update mute button icon
function updateMuteButton() {
    muteBtn.textContent = (video.volume === 0) ? "🔇" : "🔊";
}
function showDisableIcon() {
    disableIcon.style.display = "block";
}
function hideDisableIcon() {
    disableIcon.style.display = "none";
}
function moveDisableIcon(event) {
    disableIcon.style.left = `${event.offsetX}px`;
}

video.addEventListener("timeupdate", updateProgress);
video.addEventListener("ended", () => {
    if (document.fullscreenElement) {
        document.exitFullscreen().then(() => {
           // showLoadingScreen();
        }).catch(() => {
           // showLoadingScreen();
        });
    } else {
       // showLoadingScreen();
    }
});

function showLoadingScreen() {
    document.body.style.pointerEvents = 'none';
    loadingScreen.style.display = "flex";
    setTimeout(() => {
        loadingScreen.style.display = "none";
        modal.style.display = "block";
        document.body.style.pointerEvents = 'auto';
    }, 1000);
    playPauseBtn.textContent = "▶";
}


// Video length display 00:00 / 00:05
function formatTime(seconds) {
    let minutes = Math.floor(seconds / 60);
    let secs = Math.floor(seconds % 60);
    return `${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
}

function updateVideoDuration() {
    if (!isNaN(video.duration)) {
        timeDisplay.innerText = `00:00 / ${formatTime(video.duration)}`;
    }
}

window.onload = function () {
    if (video.readyState >= 1) {
        updateVideoDuration();
    } else {
        video.onloadedmetadata = updateVideoDuration;
    }
    GetVideoURL();
};

 function GetVideoURL() {
    // Get URL Parameters
    const urlParams = new URLSearchParams(window.location.search);
    const videoUrl = urlParams.get('video');

    if (videoUrl) {
        // Set Video Source and AutoPlay
        let videoElement = document.getElementById("video");
        videoElement.src = videoUrl;
        videoElement.load(); // Reload the video
        videoElement.play(); // Auto-play
        playPauseBtn.textContent = "⏸";
    }
};

video.onloadedmetadata = function () {
    timeDisplay.innerText = `00:00 / ${formatTime(video.duration)}`;
};



function showFinalScore(score) {
    const scoreText = document.getElementById("finalScore");
    const scoreResult = document.getElementById("scoreResult");
    const scoreMessage = document.getElementById("scoreMessage");
    const resultIcon = document.getElementById("resultIcon");
    const confettiCanvas = document.getElementById("confettiCanvas");

    scoreText.innerText = score + "%";

    if (score >= 50) {
        // Pass
        scoreResult.innerText = "✔️ Passed!";
        scoreResult.className = "score-Result pass";
        resultIcon.src = "https://cdn-icons-png.flaticon.com/512/190/190411.png"; // Green Check Icon
        scoreMessage.innerText = "🌟 Well done! You passed the quiz!";
        confettiCanvas.style.display = "block";
        startConfetti();
    } else {
        // Fail
        scoreResult.innerText = "❌ Failed!";
        scoreResult.className = "score-Result fail";
        resultIcon.src = "https://cdn-icons-png.flaticon.com/512/190/190406.png"; // Red Cross Icon
        scoreMessage.innerText = "😢 Don't worry! Try again!";
    }
}

function closeQuiz() {
    document.getElementById("showScoreSection").style.display = "none";
    document.getElementById("confettiCanvas").style.display = "none";
}

/* Confetti Animation */
function startConfetti() {
    let canvas = document.getElementById("confettiCanvas");
    let ctx = canvas.getContext("2d");
    let confetti = [];

    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    for (let i = 0; i < 100; i++) {
        confetti.push({
            x: Math.random() * canvas.width,
            y: Math.random() * canvas.height - canvas.height,
            r: Math.random() * 6 + 2,
            d: Math.random() * 100 + 50,
            color: "hsl(" + Math.random() * 360 + ", 100%, 50%)"
        });
    }

    function drawConfetti() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        confetti.forEach((c, i) => {
            ctx.beginPath();
            ctx.arc(c.x, c.y, c.r, 0, Math.PI * 2);
            ctx.fillStyle = c.color;
            ctx.fill();
            c.y += c.d / 100;
            if (c.y > canvas.height) confetti[i].y = 0;
        });
        requestAnimationFrame(drawConfetti);
    }

    drawConfetti();
}
