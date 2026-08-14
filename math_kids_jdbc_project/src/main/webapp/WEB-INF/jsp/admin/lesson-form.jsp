<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String title = "Thêm bài học mới";
Object lessonObj = request.getAttribute("lesson");
if (lessonObj != null) {
	com.kidsmath.model.Lesson lesson = (com.kidsmath.model.Lesson) lessonObj;
	if (lesson.getId() != null) {
		title = "Cập nhật bài học";
	}
}
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle}</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<nav class="col-md-2 admin-sidebar">
				<!-- Sidebar content -->
				<div class="admin-sidebar-brand">
					<h4>🧮 Admin</h4>
					<small>Bé Học Toán</small>
				</div>
				<div class="nav-section">Quản lý</div>
				<a href="${pageContext.request.contextPath}/admin/lessons"
					class="nav-link active"> <i class="fas fa-book"></i> Bài học
				</a>
			</nav>

			<main class="col-md-10 admin-content">
				<div class="admin-form-container">
					<div
						class="form-header d-flex justify-content-between align-items-center">
						<h3 class="text-primary">
							<i class="fas fa-${lesson.id == null ? 'plus-circle' : 'edit'}"></i>
							${lesson.id == null ? 'Thêm bài học mới' : 'Cập nhật bài học'}
						</h3>
						<a href="${pageContext.request.contextPath}/admin/lessons"
							class="btn btn-outline-secondary btn-sm"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>

					<form
						action="${pageContext.request.contextPath}/admin/lessons/${lesson.id == null ? 'add' : 'edit/' += lesson.id}"
						method="POST">
						<div class="form-group">
							<label>Tiêu đề <span class="text-danger">*</span></label> <input
								type="text" name="title" class="form-control"
								value="${lesson.title}" required>
						</div>

						<div class="form-group">
							<label>Mô tả</label>
							<textarea name="description" class="form-control" rows="3">${lesson.description}</textarea>
						</div>

						<div class="form-group">
							<label>Lớp <span class="text-danger">*</span></label> <select
								name="grade" class="form-control" required>
								<option value="">-- Chọn lớp --</option>
								<c:forEach var="grade" items="${grades}">
									<option value="${grade.id}"
										${lesson.grade == grade.id ? 'selected' : ''}>
										${grade.gradeName}</option>
								</c:forEach>
							</select>
						</div>

						<div class="form-group">
							<label>Nội dung</label>
							<textarea name="content" class="form-control" rows="5">${lesson.content}</textarea>
						</div>

						<div class="form-group">
							<label>Video URL</label> <input type="text" name="videoUrl"
								class="form-control" value="${lesson.videoUrl}"
								placeholder="https://www.youtube.com/embed/...">
						</div>

						<div class="text-center">
							<button type="submit" class="btn btn-primary btn-fun">
								<i class="fas fa-save"></i> ${lesson.id == null ? 'Thêm' : 'Cập nhật'}
							</button>
							<a href="${pageContext.request.contextPath}/admin/lessons"
								class="btn btn-outline-secondary btn-fun ml-2"> <i
								class="fas fa-times"></i> Hủy
							</a>
						</div>
					</form>
				</div>
			</main>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>