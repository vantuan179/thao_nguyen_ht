<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Quản lý câu hỏi - Admin");
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

			<!-- Main Content -->
			<main class="col-md-10 admin-content">
				<div
					class="admin-header d-flex justify-content-between align-items-center flex-wrap">
					<div>
						<h2 class="font-weight-bold text-primary mb-0">
							<i class="fas fa-question-circle"></i> Quản lý câu hỏi
						</h2>
						<p class="text-muted mb-0">Quản lý danh sách các câu hỏi</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<a href="${pageContext.request.contextPath}/admin/quizzes/add"
							class="btn btn-primary btn-sm"> <i class="fas fa-plus"></i>
							Thêm câu hỏi
						</a>
					</div>
				</div>

				<c:if test="${not empty success}">
					<div class="alert alert-success alert-dismissible fade show">
						<i class="fas fa-check-circle"></i> ${success}
						<button type="button" class="close" data-dismiss="alert">&times;</button>
					</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show">
						<i class="fas fa-exclamation-circle"></i> ${error}
						<button type="button" class="close" data-dismiss="alert">&times;</button>
					</div>
				</c:if>

				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">ID</th>
									<th>Câu hỏi</th>
									<th>Bài học</th>
									<th>Đáp án đúng</th>
									<th>Điểm</th>
									<th style="width: 150px;">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty quizzes}">
										<c:forEach var="quiz" items="${quizzes}">
											<tr>
												<td>${quiz.id}</td>
												<td><strong>${quiz.question}</strong></td>
												<td><span class="badge badge-info"> Bài
														${quiz.lessonId} </span></td>
												<td><span class="badge badge-success">${quiz.correctOption}</span>
												</td>
												<td>${quiz.points}</td>
												<td><a
													href="${pageContext.request.contextPath}/admin/quizzes/edit/${quiz.id}"
													class="btn btn-sm btn-warning" title="Sửa"> <i
														class="fas fa-edit"></i>
												</a> <a
													href="${pageContext.request.contextPath}/admin/quizzes/delete/${quiz.id}"
													class="btn btn-sm btn-danger" title="Xóa"
													onclick="return confirm('Bạn có chắc muốn xóa câu hỏi này?')">
														<i class="fas fa-trash"></i>
												</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="6" class="text-center py-4"><i
												class="fas fa-inbox" style="font-size: 3rem; color: #ccc;"></i>
												<p class="text-muted mt-2">Chưa có câu hỏi nào</p> <a
												href="${pageContext.request.contextPath}/admin/quizzes/add"
												class="btn btn-primary btn-sm"> <i class="fas fa-plus"></i>
													Thêm câu hỏi đầu tiên
											</a></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</main>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>