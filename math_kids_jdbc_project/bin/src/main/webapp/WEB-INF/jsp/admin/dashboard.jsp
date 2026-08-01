<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản trị - Bé Học Toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Quicksand', sans-serif; background: #f4f7fb; }
        .sidebar { min-height: 100vh; background: #4e73df; color: #fff; }
        .sidebar a { color: rgba(255,255,255,0.8); display: block; padding: 12px 20px; text-decoration: none; }
        .sidebar a:hover, .sidebar a.active { background: rgba(255,255,255,0.15); color: #fff; }
        .card-stat { border-radius: 15px; border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 sidebar p-0">
            <div class="p-4 text-center font-weight-bold h5">🧮 Admin</div>
            <a href="/admin" class="active">📊 Tổng quan</a>
            <a href="/admin/lessons/add">➕ Thêm bài học</a>
            <a href="/admin/quizzes/add">➕ Thêm câu hỏi</a>
            <a href="/">🏠 Về trang chủ</a>
            <a href="/logout">🚪 Đăng xuất</a>
        </nav>

        <main class="col-md-10 p-4">
            <h2 class="font-weight-bold text-primary mb-4">📊 Bảng điều khiển quản trị</h2>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card card-stat p-3 bg-white">
                        <h5 class="text-muted">Tổng bài học</h5>
                        <h2 class="text-info font-weight-bold">${lessons.size()}</h2>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-stat p-3 bg-white">
                        <h5 class="text-muted">Tổng câu hỏi</h5>
                        <h2 class="text-warning font-weight-bold">${quizzes.size()}</h2>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-stat p-3 bg-white">
                        <h5 class="text-muted">Người dùng</h5>
                        <h2 class="text-success font-weight-bold">${users.size()}</h2>
                    </div>
                </div>
            </div>

            <h4 class="font-weight-bold text-dark mb-3">📚 Danh sách bài học</h4>
            <div class="table-responsive bg-white rounded-lg shadow-sm p-3 mb-4">
                <table class="table table-hover table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>ID</th><th>Tiêu đề</th><th>Mô tả</th><th>Lớp</th><th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="l" items="${lessons}">
                            <tr>
                                <td>${l.id}</td>
                                <td class="font-weight-bold">${l.title}</td>
                                <td>${l.description}</td>
                                <td>${l.grade}</td>
                                <td>
                                    <a href="/admin/lessons/edit/${l.id}" class="btn btn-sm btn-info">Sửa</a>
                                    <a href="/admin/lessons/delete/${l.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa bài học này?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <h4 class="font-weight-bold text-dark mb-3">❓ Danh sách câu hỏi</h4>
            <div class="table-responsive bg-white rounded-lg shadow-sm p-3">
                <table class="table table-hover table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>ID</th><th>Bài học ID</th><th>Câu hỏi</th><th>Đáp án đúng</th><th>Điểm</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="q" items="${quizzes}">
                            <tr>
                                <td>${q.id}</td>
                                <td>${q.lessonId}</td>
                                <td class="font-weight-bold">${q.question}</td>
                                <td><span class="badge badge-success">${q.correctOption}</span></td>
                                <td>${q.points}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>
</body>
</html>
