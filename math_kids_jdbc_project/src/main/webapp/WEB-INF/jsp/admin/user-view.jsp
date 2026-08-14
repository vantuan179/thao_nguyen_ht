<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Chi tiết người dùng - Admin");
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
				<div class="admin-sidebar-brand">
					<h4>🧮 Admin</h4>
					<small>Bé Học Toán</small>
				</div>
				<div class="nav-section">Quản lý</div>
				<a href="${pageContext.request.contextPath}/admin/users"
					class="nav-link active"> <i class="fas fa-users"></i> Người
					dùng
				</a>
			</nav>

			<main class="col-md-10 admin-content">
				<div style="max-width: 800px; margin: 0 auto;">
					<div class="d-flex justify-content-between align-items-center mb-4">
						<h2 class="font-weight-bold text-primary">
							<i class="fas fa-user-circle"></i> Chi tiết người dùng
						</h2>
						<a href="${pageContext.request.contextPath}/admin/users"
							class="btn btn-outline-secondary"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>

					<div class="card shadow-sm border-0 rounded-lg">
						<div class="card-body p-4">
							<div class="row">
								<div class="col-md-6">
									<div class="info-item">
										<span class="font-weight-bold text-secondary">ID:</span> <span>${user.id}</span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Họ tên:</span> <span
											class="font-weight-bold">${user.fullName}</span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Tên đăng
											nhập:</span> <span>${user.username}</span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Email:</span> <span>${user.email}</span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Vai trò:</span>
										<span
											class="badge ${user.role == 'ADMIN' ? 'badge-danger' : user.role == 'TEACHER' ? 'badge-warning' : 'badge-info'}">
											${user.role} </span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Ngày tạo:</span>
										<span><fmt:formatDate value="${user.createdAt}"
												pattern="dd/MM/yyyy HH:mm" /></span>
									</div>
								</div>
							</div>

							<hr>

							<div class="text-center mt-3">
								<a
									href="${pageContext.request.contextPath}/admin/users/edit/${user.id}"
									class="btn btn-warning btn-fun"> <i class="fas fa-edit"></i>
									Chỉnh sửa
								</a>
								<c:if test="${user.role != 'ADMIN'}">
									<a
										href="${pageContext.request.contextPath}/admin/users/delete/${user.id}"
										class="btn btn-danger btn-fun"
										onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')">
										<i class="fas fa-trash"></i> Xóa
									</a>
								</c:if>
							</div>
						</div>
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