<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
// Kiểm tra grade có tồn tại không trước khi dùng
String title = "Thêm lớp học mới";
Object gradeObj = request.getAttribute("grade");
if (gradeObj != null) {
	com.kidsmath.model.Grade grade = (com.kidsmath.model.Grade) gradeObj;
	if (grade.getId() != null) {
		title = "Cập nhật lớp học";
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
			<!-- Include Sidebar -->
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<!-- Main Content -->
			<main class="col-md-10 admin-content">
				<div class="admin-form-container">
					<!-- Header -->
					<div
						class="form-header d-flex justify-content-between align-items-center">
						<div>
							<h3 class="text-primary mb-0">
								<i
									class="fas fa-${grade == null || grade.id == null ? 'plus-circle' : 'edit'}"></i>
								${grade == null || grade.id == null ? 'Thêm lớp học mới' : 'Cập nhật lớp học'}
							</h3>
							<c:if test="${grade != null && grade.id != null}">
								<small class="text-muted">ID: ${grade.id}</small>
							</c:if>
						</div>
						<a href="${pageContext.request.contextPath}/admin/grades"
							class="btn btn-outline-secondary btn-sm"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>

					<!-- Thông báo -->
					<c:if test="${not empty error}">
						<div class="alert alert-danger">
							<i class="fas fa-exclamation-circle"></i> ${error}
						</div>
					</c:if>

					<!-- Form -->
					<form
						action="${pageContext.request.contextPath}/admin/grades/${grade == null || grade.id == null ? 'create' : 'edit/' += grade.id}"
						method="POST">

						<!-- Tên lớp -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-tag"></i> Tên
								lớp <span class="text-danger">*</span></label> <input type="text"
								name="gradeName" class="form-control"
								value="${grade != null ? grade.gradeName : ''}"
								placeholder="Ví dụ: Lớp 1, Lớp 2..." required> <small
								class="text-muted">Tên lớp phải là duy nhất</small>
						</div>

						<!-- Icon -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-smile"></i>
								Biểu tượng</label>
							<div class="icon-selector" id="iconSelector">
								<div
									class="icon-option ${grade != null && grade.icon == '1️⃣' ? 'selected' : ''}"
									data-icon="1️⃣">1️⃣</div>
								<div
									class="icon-option ${grade != null && grade.icon == '2️⃣' ? 'selected' : ''}"
									data-icon="2️⃣">2️⃣</div>
								<div
									class="icon-option ${grade != null && grade.icon == '3️⃣' ? 'selected' : ''}"
									data-icon="3️⃣">3️⃣</div>
								<div
									class="icon-option ${grade != null && grade.icon == '4️⃣' ? 'selected' : ''}"
									data-icon="4️⃣">4️⃣</div>
								<div
									class="icon-option ${grade != null && grade.icon == '5️⃣' ? 'selected' : ''}"
									data-icon="5️⃣">5️⃣</div>
								<div
									class="icon-option ${grade != null && grade.icon == '📚' ? 'selected' : ''}"
									data-icon="📚">📚</div>
								<div
									class="icon-option ${grade != null && grade.icon == '🎓' ? 'selected' : ''}"
									data-icon="🎓">🎓</div>
								<div
									class="icon-option ${grade != null && grade.icon == '⭐' ? 'selected' : ''}"
									data-icon="⭐">⭐</div>
								<div
									class="icon-option ${grade != null && grade.icon == '🌈' ? 'selected' : ''}"
									data-icon="🌈">🌈</div>
								<div
									class="icon-option ${grade != null && grade.icon == '🌟' ? 'selected' : ''}"
									data-icon="🌟">🌟</div>
								<div
									class="icon-option ${grade != null && grade.icon == '📖' ? 'selected' : ''}"
									data-icon="📖">📖</div>
								<div
									class="icon-option ${grade != null && grade.icon == '✏️' ? 'selected' : ''}"
									data-icon="✏️">✏️</div>
							</div>
							<input type="hidden" name="icon" id="selectedIcon"
								value="${grade != null ? grade.icon : '📚'}">
							<div class="mt-2">
								<span class="preview-icon" id="iconPreview">${grade != null ? grade.icon : '📚'}</span>
								<span class="text-muted ml-2">Biểu tượng sẽ hiển thị trên
									trang chủ</span>
							</div>
						</div>

						<!-- Mô tả -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-align-left"></i>
								Mô tả</label>
							<textarea name="description" class="form-control" rows="3"
								placeholder="Mô tả ngắn về lớp học này">${grade != null ? grade.description : ''}</textarea>
						</div>

						<!-- Thứ tự hiển thị -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-sort"></i> Thứ
								tự hiển thị</label> <input type="number" name="displayOrder"
								class="form-control"
								value="${grade != null && grade.displayOrder != null ? grade.displayOrder : maxOrder + 1}"
								min="1" step="1"> <small class="text-muted">Số
								nhỏ hơn sẽ hiển thị trước</small>
						</div>

						<!-- Trạng thái -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-toggle-on"></i>
								Trạng thái</label>
							<div class="custom-control custom-switch">
								<input type="checkbox" class="custom-control-input" id="active"
									name="active"
									${grade == null || grade.active == null || grade.active ? 'checked' : ''}
									value="true"> <label class="custom-control-label"
									for="active"> <span id="statusLabel">${grade == null || grade.active == null || grade.active ? 'Hoạt động' : 'Vô hiệu hóa'}</span>
								</label>
							</div>
						</div>

						<!-- Nút submit -->
						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-fun">
								<i
									class="fas fa-${grade == null || grade.id == null ? 'plus' : 'save'}"></i>
								${grade == null || grade.id == null ? 'Thêm lớp học' : 'Cập nhật'}
							</button>
							<a href="${pageContext.request.contextPath}/admin/grades"
								class="btn btn-outline-secondary btn-fun ml-2"> <i
								class="fas fa-times"></i> Hủy
							</a>
						</div>
					</form>

					<c:if test="${grade != null && grade.id != null}">
						<hr>
						<div class="text-center text-muted small">
							<i class="fas fa-info-circle"></i> Lớp học có ${lessonCount} bài
							học
						</div>
					</c:if>
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
			// Chọn icon
			$('.icon-option').click(function() {
				$('.icon-option').removeClass('selected');
				$(this).addClass('selected');
				var icon = $(this).data('icon');
				$('#selectedIcon').val(icon);
				$('#iconPreview').text(icon);
			});

			// Toggle trạng thái
			$('#active').change(function() {
				if ($(this).is(':checked')) {
					$('#statusLabel').text('Hoạt động');
				} else {
					$('#statusLabel').text('Vô hiệu hóa');
				}
			});
		});
	</script>
</body>
</html>