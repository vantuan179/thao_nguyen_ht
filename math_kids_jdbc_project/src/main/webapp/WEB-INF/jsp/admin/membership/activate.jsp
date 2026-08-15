<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Kích hoạt thành viên - Admin");
pageContext.setAttribute("currentPage", "membership");
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

<style>
/* Fix cho dropdown select */
select.form-control {
	height: auto !important;
	min-height: 50px;
	padding: 10px 12px;
	font-size: 1rem;
}

select.form-control option {
	padding: 10px 12px;
	white-space: normal;
	word-wrap: break-word;
	font-size: 1rem;
	min-height: 40px;
}
/* Fix cho container */
.admin-form-container {
	overflow: visible !important;
}

.form-group {
	overflow: visible !important;
}
</style>
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<main class="col-md-10 admin-content">
				<div class="admin-form-container"
					style="overflow: visible !important;">
					<div
						class="form-header d-flex justify-content-between align-items-center">
						<div>
							<h3 class="text-primary mb-0">
								<i class="fas fa-crown"></i> Kích hoạt thành viên
							</h3>
							<small class="text-muted"> <c:choose>
									<c:when test="${user != null}">
                                    Đang kích hoạt cho: <strong>${user.fullName}</strong>
									</c:when>
									<c:otherwise>
                                    Chọn người dùng và gói thành viên
                                </c:otherwise>
								</c:choose>
							</small>
						</div>
						<a href="${pageContext.request.contextPath}/admin/membership"
							class="btn btn-outline-secondary btn-sm"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>

					<c:if test="${not empty success}">
						<div class="alert alert-success">${success}</div>
					</c:if>
					<c:if test="${not empty error}">
						<div class="alert alert-danger">${error}</div>
					</c:if>

					<!-- Nếu đã chọn user, hiển thị form kích hoạt -->
					<c:if test="${user != null}">
						<form
							action="${pageContext.request.contextPath}/admin/membership/activate/${user.id}"
							method="POST">
							<!-- Thông tin user -->
							<div class="card shadow-sm border-0 rounded-lg mb-4">
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<span class="font-weight-bold text-secondary">Họ tên:</span>
											<span class="font-weight-bold">${user.fullName}</span>
										</div>
										<div class="col-md-4">
											<span class="font-weight-bold text-secondary">Tên đăng
												nhập:</span> <span>${user.username}</span>
										</div>
										<div class="col-md-4">
											<span class="font-weight-bold text-secondary">Email:</span> <span>${user.email}</span>
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-6">
											<span class="font-weight-bold text-secondary">Loại
												thành viên hiện tại:</span> <span
												class="badge ${user.membershipType == 'premium' ? 'badge-success' : 'badge-info'}">
												${user.membershipType == 'premium' ? 'Premium' : 'Dùng thử'}
											</span>
										</div>
										<div class="col-md-6">
											<span class="font-weight-bold text-secondary">Hết hạn:</span>
											<span> <c:choose>
													<c:when test="${user.membershipExpiryDate != null}">
														<fmt:formatDate value="${user.membershipExpiryDate}"
															pattern="dd/MM/yyyy" />
													</c:when>
													<c:otherwise>Chưa có</c:otherwise>
												</c:choose>
											</span>
										</div>
									</div>
								</div>
							</div>

							<!-- Chọn gói -->
							<div class="form-group" style="overflow: visible !important;">
								<label class="form-label"><i class="fas fa-gift"></i>
									Chọn gói thành viên <span class="text-danger">*</span></label> <select
									name="packageType" class="form-control" required
									style="height: auto !important; min-height: 50px; padding: 10px 12px;">
									<option value="">-- Chọn gói --</option>
									<c:forEach var="pkg" items="${packages}">
										<option value="${pkg.packageType}"
											style="padding: 10px 12px; white-space: normal; word-wrap: break-word; min-height: 40px;">
											${pkg.packageName} - ${pkg.months} tháng -
											<fmt:formatNumber value="${pkg.price}" pattern="#,##0" /> đ
										</option>
									</c:forEach>
								</select> <small class="text-muted">Chọn gói thành viên phù hợp</small>
							</div>

							<!-- Loại hành động -->
							<div class="form-group">
								<label class="form-label"><i class="fas fa-clock"></i>
									Loại hành động</label>
								<div class="custom-control custom-radio">
									<input type="radio" class="custom-control-input" id="register"
										name="action" value="register" checked> <label
										class="custom-control-label" for="register"> Đăng ký
										mới (từ dùng thử) <small class="text-muted d-block">Bắt
											đầu gói mới từ hôm nay</small>
									</label>
								</div>
								<div class="custom-control custom-radio">
									<input type="radio" class="custom-control-input" id="renew"
										name="action" value="renew"> <label
										class="custom-control-label" for="renew"> Gia hạn
										(cộng thêm thời gian) <small class="text-muted d-block">Cộng
											thêm thời gian vào gói hiện tại</small>
									</label>
								</div>
							</div>

							<!-- Nút submit -->
							<div class="text-center mt-4">
								<button type="submit" class="btn btn-success btn-fun">
									<i class="fas fa-check-circle"></i> Kích hoạt
								</button>
								<a
									href="${pageContext.request.contextPath}/admin/membership/activate"
									class="btn btn-outline-secondary btn-fun ml-2"> <i
									class="fas fa-user"></i> Chọn user khác
								</a> <a href="${pageContext.request.contextPath}/admin/membership"
									class="btn btn-outline-secondary btn-fun ml-2"> <i
									class="fas fa-times"></i> Hủy
								</a>
							</div>
						</form>
					</c:if>

					<!-- Nếu chưa chọn user, hiển thị form chọn user -->
					<c:if test="${user == null}">
						<form
							action="${pageContext.request.contextPath}/admin/membership/activate/select"
							method="GET">
							<div class="form-group">
								<label class="form-label"><i class="fas fa-user"></i>
									Chọn người dùng <span class="text-danger">*</span></label> <select
									name="userId" class="form-control" required>
									<option value="">-- Chọn người dùng --</option>
									<c:forEach var="u" items="${users}">
										<option value="${u.id}">${u.fullName} (${u.username})
											-
											<c:choose>
												<c:when test="${u.membershipType == 'premium'}">
													<span class="text-success">Premium</span>
												</c:when>
												<c:otherwise>
													<span class="text-info">Dùng thử</span>
												</c:otherwise>
											</c:choose>
										</option>
									</c:forEach>
								</select> <small class="text-muted">Chọn người dùng muốn kích
									hoạt thành viên</small>
							</div>

							<div class="text-center mt-4">
								<button type="submit" class="btn btn-primary btn-fun">
									<i class="fas fa-arrow-right"></i> Tiếp tục
								</button>
								<a href="${pageContext.request.contextPath}/admin/membership"
									class="btn btn-outline-secondary btn-fun ml-2"> <i
									class="fas fa-times"></i> Hủy
								</a>
							</div>
						</form>
					</c:if>
				</div>
			</main>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>