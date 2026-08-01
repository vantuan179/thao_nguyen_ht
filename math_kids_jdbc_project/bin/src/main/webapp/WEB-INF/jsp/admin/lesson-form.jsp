<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bài học - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Quicksand', sans-serif; background: #f4f7fb; }
        .form-card { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 25px; padding: 35px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-card">
            <h3 class="text-primary font-weight-bold mb-4">${empty lesson.id ? '➕ Thêm' : '✏️ Sửa'} bài học</h3>
            <form method="post" action="/admin/lessons/save">
                <input type="hidden" name="id" value="${lesson.id}">
                <div class="form-group">
                    <label class="font-weight-bold">Tiêu đề</label>
                    <input type="text" name="title" class="form-control" value="${lesson.title}" required>
                </div>
                <div class="form-group">
                    <label class="font-weight-bold">Mô tả</label>
                    <input type="text" name="description" class="form-control" value="${lesson.description}">
                </div>
                <div class="form-group">
                    <label class="font-weight-bold">Lớp / Cấp độ</label>
                    <input type="number" name="grade" class="form-control" value="${lesson.grade != null ? lesson.grade : 1}" required>
                </div>
                <div class="form-group">
                    <label class="font-weight-bold">Nội dung bài học</label>
                    <textarea name="content" class="form-control" rows="5">${lesson.content}</textarea>
                </div>
                <div class="form-group">
                    <label class="font-weight-bold">Link video (nếu có)</label>
                    <input type="text" name="videoUrl" class="form-control" value="${lesson.videoUrl}">
                </div>
                <button type="submit" class="btn btn-primary font-weight-bold rounded-pill px-4">💾 Lưu bài học</button>
                <a href="/admin" class="btn btn-secondary rounded-pill px-4">Quay lại</a>
            </form>
        </div>
    </div>
</body>
</html>
