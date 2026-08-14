<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
// Kiểm tra quiz có tồn tại không trước khi dùng
String title = "Thêm câu hỏi mới";
Object quizObj = request.getAttribute("quiz");
if (quizObj != null) {
	com.kidsmath.model.Quiz quiz = (com.kidsmath.model.Quiz) quizObj;
	if (quiz.getId() != null) {
		title = "Cập nhật câu hỏi";
	}
}
pageContext.setAttribute("pageTitle", title + " - Admin");
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
			<!-- Include Sidebar -->
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<main class="col-md-10 admin-content">
				<div class="admin-form-container">
					<div
						class="form-header d-flex justify-content-between align-items-center">
						<div>
							<h3 class="text-primary mb-0">
								<i
									class="fas fa-${quiz == null || quiz.id == null ? 'plus-circle' : 'edit'}"></i>
								${quiz == null || quiz.id == null ? 'Thêm câu hỏi mới' : 'Cập nhật câu hỏi'}
							</h3>
							<c:if test="${quiz != null && quiz.id != null}">
								<small class="text-muted">ID: ${quiz.id}</small>
							</c:if>
						</div>
						<a href="${pageContext.request.contextPath}/admin/quizzes"
							class="btn btn-outline-secondary btn-sm"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>

					<c:if test="${not empty error}">
						<div class="alert alert-danger">
							<i class="fas fa-exclamation-circle"></i> ${error}
						</div>
					</c:if>

					<form
						action="${pageContext.request.contextPath}/admin/quizzes/${quiz == null || quiz.id == null ? 'add' : 'edit/' += quiz.id}"
						method="POST">
						<div class="form-group">
							<label>Bài học <span class="text-danger">*</span></label> <select
								name="lessonId" class="form-control" required>
								<option value="">-- Chọn bài học --</option>
								<c:forEach var="lesson" items="${lessons}">
									<option value="${lesson.id}"
										${quiz != null && quiz.lessonId == lesson.id ? 'selected' : ''}>
										${lesson.title} (Lớp ${lesson.grade})</option>
								</c:forEach>
							</select>
						</div>

						<div class="form-group">
							<label>Câu hỏi <span class="text-danger">*</span></label> <input
								type="text" name="question" class="form-control"
								value="${quiz != null ? quiz.question : ''}" required>
						</div>

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Đáp án A <span class="text-danger">*</span></label> <input
										type="text" name="optionA" class="form-control"
										value="${quiz != null ? quiz.optionA : ''}" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Đáp án B <span class="text-danger">*</span></label> <input
										type="text" name="optionB" class="form-control"
										value="${quiz != null ? quiz.optionB : ''}" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Đáp án C <span class="text-danger">*</span></label> <input
										type="text" name="optionC" class="form-control"
										value="${quiz != null ? quiz.optionC : ''}" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Đáp án D <span class="text-danger">*</span></label> <input
										type="text" name="optionD" class="form-control"
										value="${quiz != null ? quiz.optionD : ''}" required>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Đáp án đúng <span class="text-danger">*</span></label> <select
										name="correctOption" class="form-control" required>
										<option value="">-- Chọn --</option>
										<option value="A"
											${quiz != null && quiz.correctOption == 'A' ? 'selected' : ''}>A</option>
										<option value="B"
											${quiz != null && quiz.correctOption == 'B' ? 'selected' : ''}>B</option>
										<option value="C"
											${quiz != null && quiz.correctOption == 'C' ? 'selected' : ''}>C</option>
										<option value="D"
											${quiz != null && quiz.correctOption == 'D' ? 'selected' : ''}>D</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Điểm</label> <input type="number" name="points"
										class="form-control"
										value="${quiz != null && quiz.points != null ? quiz.points : 10}"
										min="1">
								</div>
							</div>
						</div>

						<div class="form-group">
							<label>Giải thích</label>
							<textarea name="explanation" class="form-control" rows="3">${quiz != null ? quiz.explanation : ''}</textarea>
						</div>

						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-fun">
								<i
									class="fas fa-${quiz == null || quiz.id == null ? 'plus' : 'save'}"></i>
								${quiz == null || quiz.id == null ? 'Thêm câu hỏi' : 'Cập nhật'}
							</button>
							<a href="${pageContext.request.contextPath}/admin/quizzes"
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