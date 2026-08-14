<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Quản lý bài học - Admin");
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
							<i class="fas fa-book"></i> Quản lý bài học
						</h2>
						<p class="text-muted mb-0">Quản lý danh sách các bài học</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<a href="${pageContext.request.contextPath}/admin/lessons/add"
							class="btn btn-primary btn-sm"> <i class="fas fa-plus"></i>
							Thêm bài học
						</a>
					</div>
				</div>

				<c:if test="${not empty success}">
					<div class="alert alert-success">${success}</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>

				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Tiêu đề</th>
									<th>Lớp</th>
									<th>Số câu hỏi</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty lessons}">
										<c:forEach var="lesson" items="${lessons}">
											<tr>
												<td>${lesson.id}</td>
												<td><strong>${lesson.title}</strong></td>
												<td><span class="badge badge-info">Lớp
														${lesson.grade}</span></td>
												<td>${quizService.countByLessonId(lesson.id)}</td>
												<td><a
													href="${pageContext.request.contextPath}/admin/lessons/edit/${lesson.id}"
													class="btn btn-sm btn-warning"> <i class="fas fa-edit"></i>
												</a> <a
													href="${pageContext.request.contextPath}/admin/lessons/delete/${lesson.id}"
													class="btn btn-sm btn-danger"
													onclick="return confirm('Xóa bài học này?')"> <i
														class="fas fa-trash"></i>
												</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" class="text-center">Chưa có bài học nào</td>
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