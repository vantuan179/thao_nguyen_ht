<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Bé Học Toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
        }
        .login-card {
            background: #fff;
            border-radius: 30px;
            padding: 40px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            width: 100%; max-width: 420px;
        }
        .btn-login { border-radius: 50px; font-weight: 700; padding: 12px; }
    </style>
</head>
<body>
    <div class="login-card text-center">
        <h2 class="text-primary font-weight-bold mb-4">🔐 Đăng nhập</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form method="post" action="/login">
            <div class="form-group text-left">
                <label class="font-weight-bold">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control rounded-pill" placeholder="Nhập tên đăng nhập" required>
            </div>
            <div class="form-group text-left">
                <label class="font-weight-bold">Mật khẩu</label>
                <input type="password" name="password" class="form-control rounded-pill" placeholder="Nhập mật khẩu" required>
            </div>
            <button type="submit" class="btn btn-primary btn-login btn-block mt-4">Vào học 🚀</button>
        </form>
        <p class="mt-3 text-muted">Tài khoản thử: <b>admin / admin123</b> hoặc <b>be_nam / 123456</b></p>
        <a href="/" class="btn btn-link">⬅ Quay lại trang chủ</a>
    </div>
</body>
</html>
