<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Quản lý người dùng - Admin");
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
					class="nav-link"> <i class="fas fa-school"></i> Lớp học
				</a> <a href="${pageContext.request.contextPath}/admin/lessons"
					class="nav-link"> <i class="fas fa-book"></i> Bài học
				</a> <a href="${pageContext.request.contextPath}/admin/quizzes"
					class="nav-link"> <i class="fas fa-question-circle"></i> Câu
					hỏi
				</a> <a href="${pageContext.request.contextPath}/admin/users"
					class="nav-link active"> <i class="fas fa-users"></i> Người
					dùng <span class="badge">${totalUsers}</span>
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
				<div
					class="admin-header d-flex justify-content-between align-items-center flex-wrap">
					<div>
						<h2 class="font-weight-bold text-primary mb-0">
							<i class="fas fa-users"></i> Quản lý người dùng
						</h2>
						<p class="text-muted mb-0">Quản lý danh sách người dùng trong
							hệ thống</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<span class="text-muted"> <i class="far fa-calendar-alt"></i>
							<%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date())%>
						</span>
					</div>
				</div>

				<!-- Thống kê -->
				<div class="row mb-4">
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card">
							<div class="icon blue">
								<i class="fas fa-users"></i>
							</div>
							<div class="info">
								<div class="label">Tổng người dùng</div>
								<div class="number">${totalUsers}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #dc3545;">
							<div class="icon red">
								<i class="fas fa-user-shield"></i>
							</div>
							<div class="info">
								<div class="label">Admin</div>
								<div class="number">${adminCount}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #ffc107;">
							<div class="icon orange">
								<i class="fas fa-chalkboard-teacher"></i>
							</div>
							<div class="info">
								<div class="label">Giáo viên</div>
								<div class="number">${teacherCount}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #28a745;">
							<div class="icon green">
								<i class="fas fa-user-graduate"></i>
							</div>
							<div class="info">
								<div class="label">Học sinh</div>
								<div class="number">${userCount}</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Thông báo -->
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

				<!-- Tìm kiếm -->
				<div class="row mb-3">
					<div class="col-md-6">
						<form
							action="${pageContext.request.contextPath}/admin/users/search"
							method="GET" class="d-flex">
							<input type="text" name="keyword" class="form-control"
								placeholder="🔍 Tìm kiếm người dùng..." value="${keyword}"
								style="border-radius: 50px; padding: 10px 20px; border: 2px solid #e0e0e0;">
							<button type="submit" class="btn btn-primary ml-2"
								style="border-radius: 50px; padding: 10px 25px;">
								<i class="fas fa-search"></i> Tìm
							</button>
							<c:if test="${not empty keyword}">
								<a href="${pageContext.request.contextPath}/admin/users"
									class="btn btn-outline-secondary ml-2"
									style="border-radius: 50px; padding: 10px 25px;"> <i
									class="fas fa-times"></i> Xóa
								</a>
							</c:if>
						</form>
					</div>
					<div class="col-md-6 text-right">
						<span class="text-muted">Hiển thị ${totalUsers} người dùng</span>
					</div>
				</div>

				<!-- Bảng danh sách -->
				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">ID</th>
									<th>Họ tên</th>
									<th>Tên đăng nhập</th>
									<th>Email</th>
									<th>Vai trò</th>
									<th style="width: 150px;">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty users}">
										<c:forEach var="user" items="${users}">
											<tr>
												<td>${user.id}</td>
												<td><strong>${user.fullName}</strong></td>
												<td>${user.username}</td>
												<td>${user.email}</td>
												<td><span
													class="badge ${user.role == 'ADMIN' ? 'badge-danger' : user.role == 'TEACHER' ? 'badge-warning' : 'badge-info'}">
														${user.role} </span></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/users/view/${user.id}"
													class="btn btn-sm btn-info" title="Xem chi tiết"> <i
														class="fas fa-eye"></i>
												</a> <a
													href="${pageContext.request.contextPath}/admin/users/edit/${user.id}"
													class="btn btn-sm btn-warning" title="Sửa"> <i
														class="fas fa-edit"></i>
												</a> <c:if test="${user.role != 'ADMIN'}">
														<a
															href="${pageContext.request.contextPath}/admin/users/delete/${user.id}"
															class="btn btn-sm btn-danger" title="Xóa"
															onclick="return confirm('Bạn có chắc muốn xóa người dùng ${user.username}?')">
															<i class="fas fa-trash"></i>
														</a>
													</c:if></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="6" class="text-center py-4"><i
												class="fas fa-inbox" style="font-size: 3rem; color: #ccc;"></i>
												<p class="text-muted mt-2">Không tìm thấy người dùng</p></td>
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