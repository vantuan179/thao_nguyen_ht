<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Chi tiết lớp học - Admin");
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
/* Style riêng cho trang view */
.detail-card {
	background: white;
	border-radius: 20px;
	padding: 30px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	max-width: 800px;
	margin: 0 auto;
}

.detail-icon {
	font-size: 4rem;
	text-align: center;
	padding: 20px;
	background: #f8f9fa;
	border-radius: 20px;
	margin-bottom: 20px;
}

.detail-row {
	padding: 12px 0;
	border-bottom: 1px solid #f0f2f5;
	display: flex;
	flex-wrap: wrap;
}

.detail-row:last-child {
	border-bottom: none;
}

.detail-label {
	font-weight: 600;
	color: #6c757d;
	width: 150px;
	flex-shrink: 0;
}

.detail-value {
	color: #2d3436;
	flex: 1;
}

.detail-actions {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
	justify-content: center;
}
</style>
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<!-- Include Sidebar -->
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<!-- Main Content -->
			<main class="col-md-10 admin-content">
				<div style="max-width: 800px; margin: 0 auto;">
					<!-- Header -->
					<div
						class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
						<div>
							<h2 class="font-weight-bold text-primary mb-0">
								<i class="fas fa-info-circle"></i> Chi tiết lớp học
							</h2>
							<p class="text-muted mb-0">Thông tin chi tiết về lớp học</p>
						</div>
						<div class="mt-2 mt-sm-0">
							<a href="${pageContext.request.contextPath}/admin/grades"
								class="btn btn-outline-secondary btn-sm"> <i
								class="fas fa-arrow-left"></i> Quay lại
							</a> <a
								href="${pageContext.request.contextPath}/admin/grades/edit/${grade.id}"
								class="btn btn-warning btn-sm"> <i class="fas fa-edit"></i>
								Sửa
							</a>
						</div>
					</div>

					<!-- Thông báo -->
					<c:if test="${not empty error}">
						<div class="alert alert-danger">
							<i class="fas fa-exclamation-circle"></i> ${error}
						</div>
					</c:if>

					<!-- Detail Card -->
					<div class="detail-card">
						<!-- Icon -->
						<div class="detail-icon">${grade.icon}</div>

						<!-- Thông tin -->
						<div class="detail-row">
							<span class="detail-label"><i class="fas fa-tag"></i> Tên
								lớp</span> <span class="detail-value font-weight-bold">${grade.gradeName}</span>
						</div>

						<div class="detail-row">
							<span class="detail-label"><i class="fas fa-align-left"></i>
								Mô tả</span> <span class="detail-value">${grade.description != null ? grade.description : 'Chưa có mô tả'}</span>
						</div>

						<div class="detail-row">
							<span class="detail-label"><i class="fas fa-sort"></i> Thứ
								tự</span> <span class="detail-value">${grade.displayOrder}</span>
						</div>

						<div class="detail-row">
							<span class="detail-label"><i class="fas fa-toggle-on"></i>
								Trạng thái</span> <span class="detail-value"> <span
								class="badge-status ${grade.active ? 'badge-active' : 'badge-inactive'}">
									<i
									class="fas ${grade.active ? 'fa-check-circle' : 'fa-times-circle'}"></i>
									${grade.active ? 'Đang hoạt động' : 'Đã vô hiệu hóa'}
							</span>
							</span>
						</div>

						<div class="detail-row">
							<span class="detail-label"><i class="fas fa-clock"></i>
								Ngày tạo</span> <span class="detail-value"> <fmt:formatDate
									value="${grade.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
							</span>
						</div>

						<div class="detail-row">
							<span class="detail-label"><i class="fas fa-book"></i> Số
								bài học</span> <span class="detail-value"> <span
								class="badge badge-info">${lessonCount}</span> bài học
							</span>
						</div>

						<!-- Actions -->
						<div class="text-center mt-4 pt-3 border-top">
							<div class="detail-actions">
								<a
									href="${pageContext.request.contextPath}/admin/grades/edit/${grade.id}"
									class="btn btn-warning btn-fun"> <i class="fas fa-edit"></i>
									Chỉnh sửa
								</a>
								<c:choose>
									<c:when test="${grade.active}">
										<a
											href="${pageContext.request.contextPath}/admin/grades/soft-delete/${grade.id}"
											class="btn btn-secondary btn-fun"
											onclick="return confirm('Bạn có chắc muốn vô hiệu hóa lớp ${grade.gradeName}?')">
											<i class="fas fa-ban"></i> Vô hiệu hóa
										</a>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath}/admin/grades/restore/${grade.id}"
											class="btn btn-success btn-fun"
											onclick="return confirm('Bạn có chắc muốn khôi phục lớp ${grade.gradeName}?')">
											<i class="fas fa-undo"></i> Khôi phục
										</a>
									</c:otherwise>
								</c:choose>
								<a
									href="${pageContext.request.contextPath}/admin/grades/delete/${grade.id}"
									class="btn btn-danger btn-fun"
									onclick="return confirm('Bạn có chắc muốn xóa lớp ${grade.gradeName}? Hành động này không thể hoàn tác!')">
									<i class="fas fa-trash"></i> Xóa hẳn
								</a>
							</div>
						</div>
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