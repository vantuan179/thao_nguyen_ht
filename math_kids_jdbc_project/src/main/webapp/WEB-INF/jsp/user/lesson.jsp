<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${lesson.title} - Bé Học Toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);
            min-height: 100vh;
        }
        .lesson-box {
            background: #fff;
            border-radius: 30px;
            padding: 35px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .quiz-card {
            background: #fffbe6;
            border-radius: 25px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            border-left: 8px solid #ffd93d;
        }
        .option-btn {
            border-radius: 20px;
            font-size: 1.3rem;
            font-weight: 700;
            padding: 15px;
            margin: 8px 0;
            transition: all .2s;
            border: 3px solid #dee2e6;
            background: #fff;
            cursor: pointer;
        }
        .option-btn:hover { transform: scale(1.03); background: #f1f8ff; }
        .option-btn.correct { background: #d4edda; border-color: #28a745; color: #155724; }
        .option-btn.wrong { background: #f8d7da; border-color: #dc3545; color: #721c24; }
        .score-board {
            position: fixed;
            top: 20px; right: 20px;
            background: #fff;
            border-radius: 20px;
            padding: 15px 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            font-weight: 700;
            z-index: 1000;
        }
        .feedback {
            font-size: 1.2rem;
            font-weight: 700;
            min-height: 35px;
        }
        .confetti {
            position: fixed;
            width: 12px; height: 12px;
            background: #ff0;
            animation: confetti-fall 3s linear forwards;
            z-index: 9999;
        }
        @keyframes confetti-fall {
            0% { transform: translateY(-10vh) rotate(0deg); opacity: 1; }
            100% { transform: translateY(110vh) rotate(720deg); opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="score-board animate__animated animate__bounceIn">
        ⭐ Điểm: <span id="total-score" class="text-warning">0</span> | ✅ Đúng: <span id="correct-count" class="text-success">0</span>
    </div>

    <div class="container py-5">
        <a href="/" class="btn btn-light rounded-pill mb-3 font-weight-bold">⬅ Quay lại</a>
        <div class="lesson-box animate__animated animate__fadeInDown">
            <h1 class="text-center text-primary font-weight-bold mb-3">${lesson.title}</h1>
            <p class="lead text-center text-muted">${lesson.description}</p>
            <div class="bg-light p-4 rounded-3 mt-3">
                <h5 class="font-weight-bold text-info">📝 Nội dung bài học:</h5>
                <p>${lesson.content}</p>
            </div>
        </div>

        <h2 class="text-center mt-5 mb-4 text-danger font-weight-bold">🎯 Làm bài tập nào!</h2>
        <div id="quiz-list">
            <c:forEach var="quiz" items="${quizzes}" varStatus="loop">
                <div class="quiz-card animate__animated animate__zoomIn" data-quiz-id="${quiz.id}" style="animation-delay:${loop.index * 0.1}s">
                    <h4 class="font-weight-bold text-dark mb-3">Câu ${loop.index + 1}: ${quiz.question}</h4>
                    <div class="row">
                        <div class="col-md-6"><button class="option-btn w-100" data-option="A">A. ${quiz.optionA}</button></div>
                        <div class="col-md-6"><button class="option-btn w-100" data-option="B">B. ${quiz.optionB}</button></div>
                        <div class="col-md-6"><button class="option-btn w-100" data-option="C">C. ${quiz.optionC}</button></div>
                        <div class="col-md-6"><button class="option-btn w-100" data-option="D">D. ${quiz.optionD}</button></div>
                    </div>
                    <div class="feedback mt-3 text-center"></div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>
</html>
