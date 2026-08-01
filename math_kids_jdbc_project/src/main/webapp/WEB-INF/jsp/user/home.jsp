<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🌈 Bé Học Toán Vui Vẻ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, #fff1eb 0%, #ace0f9 100%);
            min-height: 100vh;
        }
        .hero {
            background: linear-gradient(90deg, #ff9a9e, #fad0c4, #fad0c4);
            border-radius: 30px;
            padding: 40px;
            margin-top: 30px;
            box-shadow: 0 10px 30px rgba(255, 105, 180, 0.3);
            color: #fff;
            text-align: center;
        }
        .hero h1 { font-size: 3rem; text-shadow: 2px 2px #ff6f91; }
        .lesson-card {
            border: none;
            border-radius: 25px;
            background: #fff;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            transition: transform .3s;
            overflow: hidden;
        }
        .lesson-card:hover { transform: translateY(-8px) scale(1.02); }
        .lesson-card .card-body { padding: 30px; }
        .lesson-icon { font-size: 3.5rem; margin-bottom: 15px; }
        .btn-fun {
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 700;
            font-size: 1.1rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .navbar { background: rgba(255,255,255,0.9) !important; border-radius: 0 0 20px 20px; }
        .floating-shape {
            position: fixed;
            width: 60px; height: 60px;
            background: rgba(255,255,255,0.4);
            border-radius: 50%;
            animation: float 8s infinite ease-in-out;
            z-index: -1;
        }
        @keyframes float {
            0%,100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-30px) rotate(180deg); }
        }
    </style>
</head>
<body>
    <div class="floating-shape" style="top:10%;left:5%"></div>
    <div class="floating-shape" style="top:60%;right:8%;animation-delay:2s"></div>
    <div class="floating-shape" style="bottom:10%;left:15%;animation-delay:4s"></div>

    <nav class="navbar navbar-expand-lg navbar-light container">
        <a class="navbar-brand font-weight-bold text-primary" href="/">🧮 Bé Học Toán</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="/">Trang chủ</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <li class="nav-item"><span class="nav-link text-success font-weight-bold">👋 ${sessionScope.currentUser.fullName}</span></li>
                        <li class="nav-item"><a class="nav-link" href="/logout">Đăng xuất</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="/login">Đăng nhập</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="hero animate__animated animate__bounceIn">
            <h1>🌟 Chào mừng bé đến thế giới Toán học! 🌟</h1>
            <p class="lead mt-3">Học toán thật vui qua những bài học sinh động và câu đố thú vị.</p>
            <a href="#lessons" class="btn btn-warning btn-fun mt-3 animate__animated animate__pulse animate__infinite">Bắt đầu học nào! 🚀</a>
        </div>

        <h2 id="lessons" class="text-center mt-5 mb-4 text-primary font-weight-bold">📚 Chọn bài học yêu thích</h2>
        <div class="row">
            <c:forEach var="lesson" items="${lessons}" varStatus="loop">
                <div class="col-md-4 mb-4">
                    <div class="lesson-card animate__animated animate__fadeInUp" style="animation-delay:${loop.index * 0.15}s">
                        <div class="card-body text-center">
                            <div class="lesson-icon">
                                <c:choose>
                                    <c:when test="${loop.index % 3 == 0}">➕</c:when>
                                    <c:when test="${loop.index % 3 == 1}">➖</c:when>
                                    <c:otherwise>🔺</c:otherwise>
                                </c:choose>
                            </div>
                            <h4 class="card-title text-info font-weight-bold">${lesson.title}</h4>
                            <p class="card-text text-muted">${lesson.description}</p>
                            <a href="/lesson/${lesson.id}" class="btn btn-primary btn-fun">Vào học 🎒</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
