<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Gửi Email - Admin");
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
					class="nav-link"> <i class="fas fa-users"></i> Người dùng
				</a>
				<div class="nav-section">Email</div>
				<a href="${pageContext.request.contextPath}/admin/email"
					class="nav-link"> <i class="fas fa-envelope"></i> Quản lý Email
				</a> <a href="${pageContext.request.contextPath}/admin/email/send"
					class="nav-link active"> <i class="fas fa-paper-plane"></i> Gửi
					Email
				</a> <a href="${pageContext.request.contextPath}/admin/email/templates"
					class="nav-link"> <i class="fas fa-file-alt"></i> Mẫu Email
				</a> <a href="${pageContext.request.contextPath}/admin/email/history"
					class="nav-link"> <i class="fas fa-history"></i> Lịch sử
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
				<div class="admin-form-container">
					<div
						class="form-header d-flex justify-content-between align-items-center">
						<div>
							<h3 class="text-primary mb-0">
								<i class="fas fa-paper-plane"></i> Gửi Email
							</h3>
							<small class="text-muted">Gửi email đến người dùng trong
								hệ thống</small>
						</div>
						<a href="${pageContext.request.contextPath}/admin/email"
							class="btn btn-outline-secondary btn-sm"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>

					<c:if test="${not empty error}">
						<div class="alert alert-danger">
							<i class="fas fa-exclamation-circle"></i> ${error}
						</div>
					</c:if>

					<form id="sendEmailForm"
						action="${pageContext.request.contextPath}/admin/email/send"
						method="POST">
						<!-- Chọn người nhận -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-user"></i>
								Người nhận <span class="text-danger">*</span></label> <select name="to"
								class="form-control" required>
								<option value="">-- Chọn người nhận --</option>
								<option value="all">📧 Tất cả người dùng (Newsletter)</option>
								<c:forEach var="user" items="${users}">
									<option value="${user.email}">${user.fullName}
										(${user.email})</option>
								</c:forEach>
							</select>
						</div>

						<!-- Tiêu đề -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-heading"></i>
								Tiêu đề <span class="text-danger">*</span></label> <input type="text"
								name="subject" class="form-control"
								placeholder="Nhập tiêu đề email" required>
						</div>

						<!-- Chọn template -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-file-alt"></i>
								Sử dụng mẫu (tùy chọn)</label> <select name="templateType"
								class="form-control" id="templateSelect">
								<option value="">-- Không sử dụng mẫu --</option>
								<c:forEach var="template" items="${templates}">
									<option value="${template.type}">${template.name}</option>
								</c:forEach>
							</select>
						</div>

						<!-- Nội dung -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-align-left"></i>
								Nội dung <span class="text-danger">*</span></label>
							<textarea name="content" class="form-control" rows="10"
								placeholder="Nhập nội dung email (HTML được hỗ trợ)"
								id="contentArea" required></textarea>
							<small class="text-muted"> <i class="fas fa-info-circle"></i>
								Hỗ trợ HTML. Các biến: {fullName}, {email}, {resetLink}
							</small>
						</div>

						<!-- Preview -->
						<div class="form-group">
							<button type="button" class="btn btn-outline-info btn-sm"
								onclick="previewEmail()">
								<i class="fas fa-eye"></i> Xem trước
							</button>
						</div>

						<!-- Nút submit -->
						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-fun">
								<i class="fas fa-paper-plane"></i> Gửi email
							</button>
							<button type="reset"
								class="btn btn-outline-secondary btn-fun ml-2">
								<i class="fas fa-undo"></i> Nhập lại
							</button>
						</div>
					</form>
				</div>
			</main>
		</div>
	</div>

	<!-- Modal Preview -->
	<div class="modal fade" id="previewModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fas fa-eye"></i> Xem trước email
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="previewContent">
					<p class="text-muted">Nhập nội dung để xem trước</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		$(document).ready(function() {
			// Load template khi chọn
			$('#templateSelect').change(function() {
				var selected = $(this).val();
				if (selected) {
					// Có thể gọi AJAX để lấy nội dung template
					// Hoặc hiển thị thông báo
					$('#contentArea').focus();
				}
			});

			// Validate form
			$('#sendEmailForm').submit(function(e) {
				var to = $('select[name="to"]').val();
				var subject = $('input[name="subject"]').val().trim();
				var content = $('#contentArea').val().trim();

				if (!to) {
					alert('Vui lòng chọn người nhận!');
					e.preventDefault();
					return false;
				}

				if (!subject) {
					alert('Vui lòng nhập tiêu đề!');
					e.preventDefault();
					return false;
				}

				if (!content) {
					alert('Vui lòng nhập nội dung!');
					e.preventDefault();
					return false;
				}

				return confirm('Bạn có chắc muốn gửi email này?');
			});
		});

		function previewEmail() {
			var content = $('#contentArea').val();
			if (!content) {
				alert('Vui lòng nhập nội dung trước!');
				return;
			}
			$('#previewContent').html(content);
			$('#previewModal').modal('show');
		}
	</script>

</body>
</html>