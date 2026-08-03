<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Quản lý lớp học - Admin");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle}</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap"
	rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<!-- Sidebar -->
			<nav class="col-md-2 admin-sidebar">
				<div class="admin-sidebar-brand">
					<h4>🧮 Admin</h4>
					<small>Bé Học Toán</small>
				</div>
				<div class="nav-section">Điều hướng</div>
				<a href="${pageContext.request.contextPath}/admin" class="nav-link">
					<i class="fas fa-chart-pie"></i> Tổng quan
				</a>
				<div class="nav-section">Quản lý</div>
				<a href="${pageContext.request.contextPath}/admin/grades"
					class="nav-link active"> <i class="fas fa-school"></i> Lớp học
					<span class="badge">${totalGrades}</span>
				</a> <a href="${pageContext.request.contextPath}/admin/lessons"
					class="nav-link"> <i class="fas fa-book"></i> Bài học
				</a> <a href="${pageContext.request.contextPath}/admin/quizzes"
					class="nav-link"> <i class="fas fa-question-circle"></i> Câu
					hỏi
				</a> <a href="${pageContext.request.contextPath}/admin/users"
					class="nav-link"> <i class="fas fa-users"></i> Người dùng
				</a>
				<div class="nav-section">Hệ thống</div>
				<a href="${pageContext.request.contextPath}/" class="nav-link">
					<i class="fas fa-home"></i> Về trang chủ
				</a> <a href="${pageContext.request.contextPath}/logout"
					class="nav-link"> <i class="fas fa-sign-out-alt"></i> Đăng xuất
				</a>
			</nav>

			<!-- Main Content -->
			<main class="col-md-10 admin-content">
				<!-- Header -->
				<div
					class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
					<div>
						<h2 class="font-weight-bold text-primary mb-0">
							<i class="fas fa-school"></i> Quản lý lớp học
						</h2>
						<p class="text-muted mb-0">Quản lý danh sách các lớp học</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<a href="${pageContext.request.contextPath}/admin"
							class="btn btn-outline-secondary btn-sm"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a> <a href="${pageContext.request.contextPath}/admin/grades/create"
							class="btn btn-primary btn-sm"> <i class="fas fa-plus"></i>
							Thêm lớp mới
						</a>
					</div>
				</div>

				<!-- Thông báo -->
				<c:if test="${not empty success}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<i class="fas fa-check-circle"></i> ${success}
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<i class="fas fa-exclamation-circle"></i> ${error}
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>
				<c:if test="${not empty warning}">
					<div class="alert alert-warning alert-dismissible fade show"
						role="alert">
						<i class="fas fa-exclamation-triangle"></i> ${warning}
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<!-- Thống kê -->
				<div class="row mb-4">
					<div class="col-md-4 col-sm-6 mb-3">
						<div class="admin-stat-card">
							<div class="icon blue">
								<i class="fas fa-school"></i>
							</div>
							<div class="info">
								<div class="label">Tổng số lớp</div>
								<div class="number">${totalGrades}</div>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #28a745;">
							<div class="icon green">
								<i class="fas fa-check-circle"></i>
							</div>
							<div class="info">
								<div class="label">Đang hoạt động</div>
								<div class="number">${activeGrades}</div>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #dc3545;">
							<div class="icon red">
								<i class="fas fa-times-circle"></i>
							</div>
							<div class="info">
								<div class="label">Đã vô hiệu</div>
								<div class="number">${totalGrades - activeGrades}</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Tìm kiếm -->
				<div class="row mb-3">
					<div class="col-md-6">
						<form
							action="${pageContext.request.contextPath}/admin/grades/search"
							method="GET" class="d-flex">
							<input type="text" name="keyword" class="form-control"
								placeholder="🔍 Tìm kiếm lớp học..." value="${keyword}"
								style="border-radius: 50px; padding: 10px 20px; border: 2px solid #e0e0e0;">
							<button type="submit" class="btn btn-primary ml-2"
								style="border-radius: 50px; padding: 10px 25px;">
								<i class="fas fa-search"></i> Tìm
							</button>
							<c:if test="${not empty keyword}">
								<a href="${pageContext.request.contextPath}/admin/grades"
									class="btn btn-outline-secondary ml-2"
									style="border-radius: 50px; padding: 10px 25px;"> <i
									class="fas fa-times"></i> Xóa
								</a>
							</c:if>
						</form>
					</div>
					<div class="col-md-6 text-right">
						<span class="text-muted">Hiển thị ${grades.size()} lớp</span>
					</div>
				</div>

				<!-- Bảng danh sách -->
				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">#</th>
									<th style="width: 70px;">Icon</th>
									<th>Tên lớp</th>
									<th>Mô tả</th>
									<th style="width: 100px;">Thứ tự</th>
									<th style="width: 120px;">Trạng thái</th>
									<th style="width: 50px;">Bài học</th>
									<th style="width: 180px;">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty grades}">
										<tr>
											<td colspan="8">
												<div class="admin-empty-state">
													<i class="fas fa-inbox"></i>
													<h6 class="text-muted">Chưa có lớp học nào</h6>
													<a
														href="${pageContext.request.contextPath}/admin/grades/create"
														class="btn btn-primary mt-2"> <i class="fas fa-plus"></i>
														Thêm lớp học đầu tiên
													</a>
												</div>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="grade" items="${grades}" varStatus="loop">
											<tr>
												<td>${loop.index + 1}</td>
												<td style="font-size: 2rem;">${grade.icon}</td>
												<td><strong>${grade.gradeName}</strong></td>
												<td>${grade.description}</td>
												<td>${grade.displayOrder}</td>
												<td><span
													class="badge-status ${grade.active ? 'badge-active' : 'badge-inactive'}">
														<i
														class="fas ${grade.active ? 'fa-check-circle' : 'fa-times-circle'}"></i>
														${grade.active ? 'Hoạt động' : 'Vô hiệu'}
												</span></td>
												<td><span class="badge badge-info">${gradeService.countLessonsByGradeId(grade.id)}</span>
												</td>
												<td>
													<div class="btn-group btn-group-sm" role="group">
														<a
															href="${pageContext.request.contextPath}/admin/grades/view/${grade.id}"
															class="btn btn-info btn-action" title="Xem chi tiết">
															<i class="fas fa-eye"></i>
														</a> <a
															href="${pageContext.request.contextPath}/admin/grades/edit/${grade.id}"
															class="btn btn-warning btn-action" title="Sửa"> <i
															class="fas fa-edit"></i>
														</a>
														<c:choose>
															<c:when test="${grade.active}">
																<a
																	href="${pageContext.request.contextPath}/admin/grades/soft-delete/${grade.id}"
																	class="btn btn-secondary btn-action"
																	title="Vô hiệu hóa"
																	onclick="return confirm('Bạn có chắc muốn vô hiệu hóa lớp ${grade.gradeName}?')">
																	<i class="fas fa-ban"></i>
																</a>
															</c:when>
															<c:otherwise>
																<a
																	href="${pageContext.request.contextPath}/admin/grades/restore/${grade.id}"
																	class="btn btn-success btn-action" title="Khôi phục"
																	onclick="return confirm('Bạn có chắc muốn khôi phục lớp ${grade.gradeName}?')">
																	<i class="fas fa-undo"></i>
																</a>
															</c:otherwise>
														</c:choose>
														<a
															href="${pageContext.request.contextPath}/admin/grades/delete/${grade.id}"
															class="btn btn-danger btn-action" title="Xóa hẳn"
															onclick="return confirm('Bạn có chắc muốn xóa lớp ${grade.gradeName}? Hành động này không thể hoàn tác!')">
															<i class="fas fa-trash"></i>
														</a>
													</div>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</main>
		</div>
	</div>

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>