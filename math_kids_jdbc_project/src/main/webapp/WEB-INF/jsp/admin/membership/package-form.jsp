<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
// Kiểm tra packageObj có tồn tại không trước khi dùng
String title = "Thêm gói thành viên mới";
Object packageObj = request.getAttribute("packageObj");
if (packageObj != null) {
	com.kidsmath.model.MembershipPackage pkg = (com.kidsmath.model.MembershipPackage) packageObj;
	if (pkg.getId() != null) {
		title = "Cập nhật gói thành viên";
	}
}
pageContext.setAttribute("pageTitle", title + " - Admin");
pageContext.setAttribute("currentPage", "membership-packages");
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
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<main class="col-md-10 admin-content">
				<div class="admin-form-container">
					<div
						class="form-header d-flex justify-content-between align-items-center">
						<div>
							<h3 class="text-primary mb-0">
								<i
									class="fas fa-${packageObj == null || packageObj.id == null ? 'plus-circle' : 'edit'}"></i>
								${packageObj == null || packageObj.id == null ? 'Thêm gói thành viên mới' : 'Cập nhật gói thành viên'}
							</h3>
							<c:if test="${packageObj != null && packageObj.id != null}">
								<small class="text-muted">ID: ${packageObj.id}</small>
							</c:if>
						</div>
						<a
							href="${pageContext.request.contextPath}/admin/membership/packages"
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
						action="${pageContext.request.contextPath}/admin/membership/packages/${packageObj == null || packageObj.id == null ? 'create' : 'edit/' += packageObj.id}"
						method="POST">

						<!-- Tên gói -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-tag"></i> Tên
								gói <span class="text-danger">*</span></label> <input type="text"
								name="packageName" class="form-control"
								value="${packageObj != null ? packageObj.packageName : ''}"
								placeholder="Ví dụ: 1 Tháng, 3 Tháng..." required>
						</div>

						<!-- Loại gói -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-tag"></i> Loại
								gói <span class="text-danger">*</span></label> <select
								name="packageType" class="form-control" required>
								<option value="">-- Chọn loại --</option>
								<option value="MONTHLY"
									${packageObj != null && packageObj.packageType == 'MONTHLY' ? 'selected' : ''}>Tháng
									(MONTHLY)</option>
								<option value="QUARTERLY"
									${packageObj != null && packageObj.packageType == 'QUARTERLY' ? 'selected' : ''}>Quý
									(QUARTERLY)</option>
								<option value="SEMESTER"
									${packageObj != null && packageObj.packageType == 'SEMESTER' ? 'selected' : ''}>6
									Tháng (SEMESTER)</option>
								<option value="YEARLY"
									${packageObj != null && packageObj.packageType == 'YEARLY' ? 'selected' : ''}>Năm
									(YEARLY)</option>
								<option value="BI_YEARLY"
									${packageObj != null && packageObj.packageType == 'BI_YEARLY' ? 'selected' : ''}>2
									Năm (BI_YEARLY)</option>
							</select>
						</div>

						<!-- Số tháng -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-calendar-alt"></i>
								Số tháng <span class="text-danger">*</span></label> <input type="number"
								name="months" class="form-control"
								value="${packageObj != null ? packageObj.months : ''}"
								placeholder="Nhập số tháng" min="1" required>
						</div>

						<!-- Giá -->
						<div class="form-group">
							<label class="form-label"><i
								class="fas fa-money-bill-wave"></i> Giá (VNĐ) <span
								class="text-danger">*</span></label> <input type="number" name="price"
								class="form-control"
								value="${packageObj != null ? packageObj.price : ''}"
								placeholder="Nhập giá (VNĐ)" min="0" required>
						</div>

						<!-- Mô tả -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-align-left"></i>
								Mô tả</label>
							<textarea name="description" class="form-control" rows="3"
								placeholder="Mô tả về gói thành viên này">${packageObj != null ? packageObj.description : ''}</textarea>
						</div>

						<!-- Trạng thái -->
						<div class="form-group">
							<label class="form-label"><i class="fas fa-toggle-on"></i>
								Trạng thái</label>
							<div class="custom-control custom-switch">
								<input type="checkbox" class="custom-control-input" id="active"
									name="active"
									${packageObj == null || packageObj.active == null || packageObj.active ? 'checked' : ''}
									value="true"> <label class="custom-control-label"
									for="active"> <span id="statusLabel">${packageObj == null || packageObj.active == null || packageObj.active ? 'Hoạt động' : 'Vô hiệu'}</span>
								</label>
							</div>
						</div>

						<!-- Nút submit -->
						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-fun">
								<i
									class="fas fa-${packageObj == null || packageObj.id == null ? 'plus' : 'save'}"></i>
								${packageObj == null || packageObj.id == null ? 'Thêm gói' : 'Cập nhật'}
							</button>
							<a
								href="${pageContext.request.contextPath}/admin/membership/packages"
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