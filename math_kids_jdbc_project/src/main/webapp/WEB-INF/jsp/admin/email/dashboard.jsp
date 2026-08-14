<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Quản lý Email - Admin");
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

<style>
.stat-card {
	background: white;
	border-radius: 15px;
	padding: 20px 25px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	transition: transform 0.3s;
	border-left: 4px solid #667eea;
	height: 100%;
}

.stat-card:hover {
	transform: translateY(-5px);
}

.stat-card .icon {
	font-size: 2.5rem;
	float: left;
	margin-right: 15px;
}

.stat-card .number {
	font-size: 2rem;
	font-weight: 700;
	color: #2d3436;
}

.stat-card .label {
	color: #6c757d;
	font-size: 0.9rem;
}

.stat-card .sub {
	font-size: 0.8rem;
	color: #6c757d;
}

.stat-card .icon.blue {
	color: #1976d2;
}

.stat-card .icon.green {
	color: #388e3c;
}

.stat-card .icon.orange {
	color: #f57c00;
}

.stat-card .icon.purple {
	color: #7b1fa2;
}

.email-item {
	padding: 15px;
	border-bottom: 1px solid #f0f2f5;
	transition: background 0.3s;
}

.email-item:hover {
	background: #f8f9fa;
}

.email-item:last-child {
	border-bottom: none;
}

.email-item .email-subject {
	font-weight: 600;
	color: #2d3436;
}

.email-item .email-to {
	color: #6c757d;
	font-size: 0.9rem;
}

.email-item .email-date {
	color: #6c757d;
	font-size: 0.8rem;
}

.badge-status {
	padding: 3px 12px;
	border-radius: 20px;
	font-size: 0.75rem;
	font-weight: 600;
}

.badge-sent {
	background: #d4edda;
	color: #155724;
}

.badge-failed {
	background: #f8d7da;
	color: #721c24;
}

.badge-draft {
	background: #fff3cd;
	color: #856404;
}

.quick-action-btn {
	border-radius: 50px;
	padding: 12px 20px;
	font-weight: 600;
	transition: all 0.3s;
}

.quick-action-btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
}
</style>
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
					class="nav-link"> <i class="fas fa-users"></i> Người dùng
				</a>
				<div class="nav-section">Email</div>
				<a href="${pageContext.request.contextPath}/admin/email"
					class="nav-link active"> <i class="fas fa-envelope"></i> Quản
					lý Email <span class="badge">${totalEmails}</span>
				</a> <a href="${pageContext.request.contextPath}/admin/email/send"
					class="nav-link"> <i class="fas fa-paper-plane"></i> Gửi Email
				</a> <a href="${pageContext.request.contextPath}/admin/email/templates"
					class="nav-link"> <i class="fas fa-file-alt"></i> Mẫu Email
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
							<i class="fas fa-envelope"></i> Quản lý Email
						</h2>
						<p class="text-muted mb-0">Quản lý gửi và nhận email trong hệ
							thống</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<a href="${pageContext.request.contextPath}/admin/email/send"
							class="btn btn-primary"> <i class="fas fa-plus"></i> Gửi
							Email mới
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

				<!-- Statistics -->
				<div class="row mb-4">
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card">
							<div class="icon blue">
								<i class="fas fa-envelope"></i>
							</div>
							<div class="info">
								<div class="label">Tổng số email</div>
								<div class="number">${totalEmails}</div>
								<div class="sub">Đã gửi từ trước đến nay</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card" style="border-left-color: #28a745;">
							<div class="icon green">
								<i class="fas fa-check-circle"></i>
							</div>
							<div class="info">
								<div class="label">Hôm nay</div>
								<div class="number">${todayEmails}</div>
								<div class="sub">Email đã gửi hôm nay</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card" style="border-left-color: #ffc107;">
							<div class="icon orange">
								<i class="fas fa-clock"></i>
							</div>
							<div class="info">
								<div class="label">Chưa gửi</div>
								<div class="number">0</div>
								<div class="sub">Email trong hàng đợi</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card" style="border-left-color: #6c757d;">
							<div class="icon purple">
								<i class="fas fa-users"></i>
							</div>
							<div class="info">
								<div class="label">Người nhận</div>
								<div class="number">${totalUsers}</div>
								<div class="sub">Người dùng trong hệ thống</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Quick Actions -->
				<div class="row mb-4">
					<div class="col-12">
						<div class="admin-table-container">
							<div class="header">
								<h5>
									<i class="fas fa-bolt"></i> Thao tác nhanh
								</h5>
							</div>
							<div class="row">
								<div class="col-md-3 col-sm-6 mb-2">
									<a href="${pageContext.request.contextPath}/admin/email/send"
										class="btn btn-primary quick-action-btn btn-block"> <i
										class="fas fa-paper-plane"></i> Gửi email mới
									</a>
								</div>
								<div class="col-md-3 col-sm-6 mb-2">
									<a
										href="${pageContext.request.contextPath}/admin/email/templates"
										class="btn btn-info quick-action-btn btn-block"> <i
										class="fas fa-file-alt"></i> Quản lý mẫu
									</a>
								</div>
								<div class="col-md-3 col-sm-6 mb-2">
									<a
										href="${pageContext.request.contextPath}/admin/email/history"
										class="btn btn-secondary quick-action-btn btn-block"> <i
										class="fas fa-history"></i> Lịch sử gửi
									</a>
								</div>
								<div class="col-md-3 col-sm-6 mb-2">
									<button class="btn btn-success quick-action-btn btn-block"
										onclick="sendNewsletter()">
										<i class="fas fa-bullhorn"></i> Gửi Newsletter
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Recent Emails -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-clock"></i> Email gần đây
						</h5>
						<div class="actions">
							<a href="${pageContext.request.contextPath}/admin/email/history"
								class="btn btn-sm btn-primary"> <i
								class="fas fa-arrow-right"></i> Xem tất cả
							</a>
						</div>
					</div>
					<div class="table-responsive">
						<c:choose>
							<c:when test="${not empty recentEmails}">
								<c:forEach var="email" items="${recentEmails}">
									<div
										class="email-item d-flex align-items-center justify-content-between flex-wrap">
										<div class="flex-grow-1">
											<div class="email-subject">
												<a
													href="${pageContext.request.contextPath}/admin/email/view/${email.id}"
													class="text-dark"> ${email.subject} </a>
											</div>
											<div class="email-to">
												<i class="fas fa-user"></i> ${email.toEmail}
											</div>
										</div>
										<div class="text-right">
											<span
												class="badge-status badge-${email.status.toLowerCase()}">
												${email.status} </span>
											<div class="email-date mt-1">
												<i class="far fa-calendar-alt"></i>
												<fmt:formatDate value="${email.sentAt}"
													pattern="dd/MM/yyyy HH:mm" />
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="text-center py-4">
									<i class="fas fa-inbox" style="font-size: 3rem; color: #ccc;"></i>
									<p class="text-muted mt-2">Chưa có email nào được gửi</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<!-- Email Templates Quick View -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-file-alt"></i> Mẫu Email
						</h5>
						<div class="actions">
							<a
								href="${pageContext.request.contextPath}/admin/email/templates"
								class="btn btn-sm btn-primary"> <i
								class="fas fa-arrow-right"></i> Quản lý mẫu
							</a>
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>Tên mẫu</th>
									<th>Loại</th>
									<th>Trạng thái</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty templates}">
										<c:forEach var="template" items="${templates}" end="4">
											<tr>
												<td><strong>${template.name}</strong></td>
												<td><span class="badge badge-info">${template.type}</span></td>
												<td><span
													class="badge ${template.active ? 'badge-success' : 'badge-secondary'}">
														${template.active ? 'Hoạt động' : 'Vô hiệu'} </span></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/email/templates/edit/${template.id}"
													class="btn btn-sm btn-warning"> <i class="fas fa-edit"></i>
												</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4" class="text-center text-muted"><i
												class="fas fa-file-alt"></i> Chưa có mẫu email</td>
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

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		$(document).ready(function() {
			// Tự động đóng alert sau 5 giây
			setTimeout(function() {
				$('.alert').alert('close');
			}, 5000);
		});

		function sendNewsletter() {
			if (confirm('Bạn có chắc muốn gửi newsletter đến tất cả người dùng?')) {
				// Chuyển hướng đến trang gửi newsletter
				window.location.href = '${pageContext.request.contextPath}/admin/email/send?type=newsletter';
			}
		}
	</script>

</body>
</html>