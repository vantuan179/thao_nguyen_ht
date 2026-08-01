<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý câu hỏi - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Quicksand', sans-serif; background: #f4f7fb; }
        .form-card { max-width: 800px; margin: 40px auto; background: #fff; border-radius: 25px; padding: 35px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-card">
            <h3 class="text-primary font-weight-bold mb-4">➕ Thêm câu hỏi mới</h3>
            <form id="quizForm">
                <div class="form-group">
                    <label class="font-weight-bold">Chọn bài học</label>
                    <select name="lessonId" class="form-control" required>
                        <c:forEach var="l" items="${lessons}">
                            <option value="${l.id}">${l.title}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="font-weight-bold">Câu hỏi</label>
                    <input type="text" name="question" class="form-control" required>
                </div>
                <div class="row">
                    <div class="col-md-6 form-group"><label>Đáp án A</label><input type="text" name="optionA" class="form-control" required></div>
                    <div class="col-md-6 form-group"><label>Đáp án B</label><input type="text" name="optionB" class="form-control" required></div>
                    <div class="col-md-6 form-group"><label>Đáp án C</label><input type="text" name="optionC" class="form-control" required></div>
                    <div class="col-md-6 form-group"><label>Đáp án D</label><input type="text" name="optionD" class="form-control" required></div>
                </div>
                <div class="row">
                    <div class="col-md-6 form-group">
                        <label class="font-weight-bold">Đáp án đúng</label>
                        <select name="correctOption" class="form-control" required>
                            <option value="A">A</option><option value="B">B</option><option value="C">C</option><option value="D">D</option>
                        </select>
                    </div>
                    <div class="col-md-6 form-group">
                        <label class="font-weight-bold">Điểm</label>
                        <input type="number" name="points" class="form-control" value="10" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="font-weight-bold">Giải thích</label>
                    <textarea name="explanation" class="form-control" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-success font-weight-bold rounded-pill px-4">💾 Lưu câu hỏi</button>
                <a href="/admin" class="btn btn-secondary rounded-pill px-4">Quay lại</a>
            </form>
            <div id="result" class="mt-3"></div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function(){
            $('#quizForm').on('submit', function(e){
                e.preventDefault();
                let data = {};
                $(this).serializeArray().forEach(item => data[item.name] = item.value);
                $.ajax({
                    url: '/api/admin/quizzes',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: function(){
                        $('#result').html('<div class="alert alert-success">🎉 Thêm câu hỏi thành công!</div>');
                        $('#quizForm')[0].reset();
                    },
                    error: function(){
                        $('#result').html('<div class="alert alert-danger">❌ Có lỗi xảy ra!</div>');
                    }
                });
            });
        });
    </script>
</body>
</html>
