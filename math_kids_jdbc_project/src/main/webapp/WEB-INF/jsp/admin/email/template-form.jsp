<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
// Kiểm tra template có tồn tại không trước khi dùng
String title = "Tạo mẫu email mới";
Object templateObj = request.getAttribute("template");
if (templateObj != null) {
	com.kidsmath.model.EmailTemplate template = (com.kidsmath.model.EmailTemplate) templateObj;
	if (template.getId() != null) {
		title = "Cập nhật mẫu email";
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
					class="nav-link"> <i class="fas fa-paper-plane"></i> Gửi Email
				</a> <a href="${pageContext.request.contextPath}/admin/email/templates"
					class="nav-link active"> <i class="fas fa-file-alt"></i> Mẫu
					Email
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
								<i
									class="fas fa-${template == null || template.id == null ? 'plus-circle' : 'edit'}"></i>
								${template == null || template.id == null ? 'Tạo mẫu email mới' : 'Cập nhật mẫu email'}
							</h3>
							<c:if test="${template != null && template.id != null}">
								<small class="text-muted">ID: ${template.id}</small>
							</c:if>
						</div>
						<a href="${pageContext.request.contextPath}/admin/email/templates"
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
						action="${pageContext.request.contextPath}/admin/email/templates/${template == null || template.id == null ? 'create' : 'edit/' += template.id}"
						method="POST">

						<!-- Tên mẫu -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-tag"></i> Tên
								mẫu <span class="text-danger">*</span></label> <input type="text"
								name="name" class="form-control"
								value="${template != null ? template.name : ''}"
								placeholder="Ví dụ: Chào mừng" required>
						</div>

						<!-- Loại -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-tag"></i> Loại
								<span class="text-danger">*</span></label> <select name="type"
								class="form-control" required>
								<option value="">-- Chọn loại --</option>
								<option value="WELCOME"
									${template != null && template.type == 'WELCOME' ? 'selected' : ''}>Chào
									mừng</option>
								<option value="NOTIFICATION"
									${template != null && template.type == 'NOTIFICATION' ? 'selected' : ''}>Thông
									báo</option>
								<option value="NEWSLETTER"
									${template != null && template.type == 'NEWSLETTER' ? 'selected' : ''}>Bản
									tin</option>
								<option value="RESET_PASSWORD"
									${template != null && template.type == 'RESET_PASSWORD' ? 'selected' : ''}>Đặt
									lại mật khẩu</option>
								<option value="CUSTOM"
									${template != null && template.type == 'CUSTOM' ? 'selected' : ''}>Tùy
									chỉnh</option>
							</select>
						</div>

						<!-- Tiêu đề -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-heading"></i>
								Tiêu đề <span class="text-danger">*</span></label> <input type="text"
								name="subject" class="form-control"
								value="${template != null ? template.subject : ''}"
								placeholder="Tiêu đề email" required>
						</div>

						<!-- Nội dung -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-align-left"></i>
								Nội dung <span class="text-danger">*</span></label>
							<textarea name="body" class="form-control" rows="10"
								placeholder="Nội dung email (HTML)" required>${template != null ? template.body : ''}</textarea>
							<small class="text-muted"> <i class="fas fa-info-circle"></i>
								Các biến: {fullName}, {email}, {resetLink}, {content}, {title}
							</small>
						</div>

						<!-- Mô tả -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-align-left"></i>
								Mô tả</label>
							<textarea name="description" class="form-control" rows="3"
								placeholder="Mô tả về mẫu email này">${template != null ? template.description : ''}</textarea>
						</div>

						<!-- Trạng thái -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-toggle-on"></i>
								Trạng thái</label>
							<div class="custom-control custom-switch">
								<input type="checkbox" class="custom-control-input" id="active"
									name="active"
									${template == null || template.active == null || template.active ? 'checked' : ''}
									value="true"> <label class="custom-control-label"
									for="active"> <span id="statusLabel">${template == null || template.active == null || template.active ? 'Hoạt động' : 'Vô hiệu'}</span>
								</label>
							</div>
						</div>

						<!-- Nút submit -->
						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-fun">
								<i
									class="fas fa-${template == null || template.id == null ? 'plus' : 'save'}"></i>
								${template == null || template.id == null ? 'Tạo mẫu' : 'Cập nhật'}
							</button>
							<a
								href="${pageContext.request.contextPath}/admin/email/templates"
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

	<script>
		$(document).ready(function() {
			// Toggle trạng thái
			$('#active').change(function() {
				if ($(this).is(':checked')) {
					$('#statusLabel').text('Hoạt động');
				} else {
					$('#statusLabel').text('Vô hiệu');
				}
			});
		});
	</script>

</body>
</html>