<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thông tin tài khoản - Bé Học Toán</title>

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
.profile-avatar {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	background: linear-gradient(135deg, #667eea, #764ba2);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 2.5rem;
	color: #fff;
	margin: 0 auto 15px auto;
}

.profile-section-title {
	font-size: 0.85rem;
	font-weight: 700;
	color: #6c757d;
	text-transform: uppercase;
	letter-spacing: 1px;
	margin-bottom: 15px;
	padding-bottom: 8px;
	border-bottom: 2px solid #f0f2f5;
}

.form-group-half {
	margin-bottom: 1rem;
}

.form-group-half label {
	font-size: 0.9rem;
	font-weight: 600;
	color: #495057;
	margin-bottom: 4px;
}

.form-group-half .form-control {
	border-radius: 10px;
	padding: 10px 15px;
	font-size: 0.95rem;
}

.form-control[disabled] {
	background: #f8f9fa;
	cursor: not-allowed;
}

@media ( max-width : 768px) {
	.form-group-half {
		margin-bottom: 0.8rem;
	}
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

	<div class="container py-4">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card shadow-lg border-0 rounded-lg">
					<div class="card-header bg-transparent border-0 pt-4 text-center">
						<div class="profile-avatar">
							<i class="fas fa-user"></i>
						</div>
						<h3 class="font-weight-bold text-primary mb-0">Thông tin tài
							khoản</h3>
						<p class="text-muted small">Quản lý thông tin cá nhân của bạn</p>
					</div>

					<div class="card-body p-4">
						<!-- Thông báo -->
						<c:if test="${not empty success}">
							<div class="alert alert-success alert-dismissible fade show">
								<i class="fas fa-check-circle"></i> ${success}
								<button type="button" class="close" data-dismiss="alert">×</button>
							</div>
						</c:if>
						<c:if test="${not empty error}">
							<div class="alert alert-danger alert-dismissible fade show">
								<i class="fas fa-exclamation-circle"></i> ${error}
								<button type="button" class="close" data-dismiss="alert">×</button>
							</div>
						</c:if>

						<!-- Form thông tin - 2 cột -->
						<form action="${pageContext.request.contextPath}/profile/update"
							method="POST">
							<div class="row">
								<!-- Cột trái -->
								<div class="col-md-6">
									<!-- Họ và tên -->
									<div class="form-group-half">
										<label><i class="fas fa-user text-primary"></i> Họ và
											tên <span class="text-danger">*</span></label> <input type="text"
											name="fullName" class="form-control"
											value="${sessionScope.currentUser.fullName}" required>
									</div>

									<!-- Email -->
									<div class="form-group-half">
										<label><i class="fas fa-envelope text-primary"></i>
											Email <span class="text-danger">*</span></label> <input type="email"
											name="email" class="form-control"
											value="${sessionScope.currentUser.email}" required>
									</div>

									<!-- Tên đăng nhập -->
									<div class="form-group-half">
										<label><i class="fas fa-id-card text-primary"></i> Tên
											đăng nhập</label> <input type="text" class="form-control"
											value="${sessionScope.currentUser.username}" disabled>
									</div>

									<!-- Ngày sinh -->
									<div class="form-group-half">
										<label><i class="fas fa-calendar-alt text-primary"></i>
											Ngày sinh</label> <input type="date" name="dateOfBirth"
											class="form-control"
											value="${sessionScope.currentUser.dateOfBirth != null ? sessionScope.currentUser.dateOfBirth : ''}">
									</div>
								</div>

								<!-- Cột phải -->
								<div class="col-md-6">
									<!-- Số điện thoại -->
									<div class="form-group-half">
										<label><i class="fas fa-phone text-primary"></i> Số
											điện thoại</label> <input type="tel" name="phone"
											class="form-control"
											value="${sessionScope.currentUser.phone != null ? sessionScope.currentUser.phone : ''}"
											placeholder="Nhập số điện thoại">
									</div>

									<!-- Lớp học -->
									<div class="form-group-half">
										<label><i class="fas fa-school text-primary"></i> Lớp
											học</label> <select name="gradeId" class="form-control">
											<option value="">-- Chọn lớp --</option>
											<c:forEach var="grade" items="${grades}">
												<option value="${grade.id}"
													${sessionScope.currentUser.gradeId == grade.id ? 'selected' : ''}>
													${grade.gradeName}</option>
											</c:forEach>
										</select>
									</div>

									<!-- Loại thành viên -->
									<div class="form-group-half">
										<label><i class="fas fa-crown text-primary"></i> Loại
											thành viên</label>
										<div class="form-control"
											style="background: #f8f9fa; cursor: not-allowed;">
											<span
												class="badge ${sessionScope.currentUser.membershipType == 'premium' ? 'badge-success' : 'badge-info'}">
												${sessionScope.currentUser.membershipType == 'premium' ? 'Premium' : 'Dùng thử'}
											</span>
											<c:if
												test="${sessionScope.currentUser.membershipType == 'premium'}">
												<span class="text-muted ml-2 small"> Hết hạn: <fmt:formatDate
														value="${sessionScope.currentUser.membershipExpiryDate}"
														pattern="dd/MM/yyyy" />
												</span>
											</c:if>
										</div>
									</div>
								</div>
							</div>

							<!-- Địa chỉ - Full width -->
							<div class="border-top pt-3 mt-3">
								<div class="profile-section-title">
									<i class="fas fa-home"></i> Địa chỉ
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group-half">
											<label>Đường/Phố</label> <input type="text" name="street"
												class="form-control"
												value="${sessionScope.currentUser.street != null ? sessionScope.currentUser.street : ''}"
												placeholder="Số nhà, tên đường...">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group-half">
											<label>Thôn/Xóm/Ấp</label> <input type="text" name="hamlet"
												class="form-control"
												value="${sessionScope.currentUser.hamlet != null ? sessionScope.currentUser.hamlet : ''}"
												placeholder="Thôn/Xóm/Ấp">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group-half">
											<label>Xã/Phường</label> <input type="text" name="commune"
												class="form-control"
												value="${sessionScope.currentUser.commune != null ? sessionScope.currentUser.commune : ''}"
												placeholder="Xã/Phường">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group-half">
											<label>Huyện/Quận</label> <input type="text" name="district"
												class="form-control"
												value="${sessionScope.currentUser.district != null ? sessionScope.currentUser.district : ''}"
												placeholder="Huyện/Quận">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group-half">
											<label>Tỉnh/Thành phố</label> <input type="text"
												name="province" class="form-control"
												value="${sessionScope.currentUser.province != null ? sessionScope.currentUser.province : ''}"
												placeholder="Tỉnh/Thành phố">
										</div>
									</div>
								</div>
							</div>

							<!-- Nút submit -->
							<div class="text-center mt-4">
								<button type="submit" class="btn btn-primary btn-fun">
									<i class="fas fa-save"></i> Cập nhật
								</button>
								<a href="${pageContext.request.contextPath}/"
									class="btn btn-outline-secondary btn-fun ml-2"> <i
									class="fas fa-times"></i> Hủy
								</a>
							</div>
						</form>

						<!-- Đổi mật khẩu -->
						<div class="border-top mt-4 pt-4">
							<h6 class="text-primary font-weight-bold">
								<i class="fas fa-key"></i> Đổi mật khẩu
							</h6>
							<form action="${pageContext.request.contextPath}/profile/update"
								method="POST" class="mt-2">
								<input type="hidden" name="fullName"
									value="${sessionScope.currentUser.fullName}"> <input
									type="hidden" name="email"
									value="${sessionScope.currentUser.email}">

								<div class="row">
									<div class="col-md-4">
										<div class="form-group-half">
											<label>Mật khẩu hiện tại <span class="text-danger">*</span></label>
											<input type="password" name="oldPassword"
												class="form-control" required>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group-half">
											<label>Mật khẩu mới <span class="text-danger">*</span></label>
											<input type="password" name="newPassword"
												class="form-control" required minlength="6">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group-half">
											<label>Xác nhận <span class="text-danger">*</span></label> <input
												type="password" name="confirmPassword" class="form-control"
												required minlength="6">
										</div>
									</div>
								</div>
								<button type="submit" class="btn btn-warning btn-fun mt-2">
									<i class="fas fa-key"></i> Đổi mật khẩu
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		$(document).ready(function() {
			$('form').on('submit', function(e) {
				var oldPass = $('input[name="oldPassword"]').val();
				var newPass = $('input[name="newPassword"]').val();
				var confirmPass = $('input[name="confirmPassword"]').val();

				if (oldPass && newPass && confirmPass) {
					if (newPass !== confirmPass) {
						e.preventDefault();
						alert('Mật khẩu xác nhận không khớp!');
					}
					if (newPass.length < 6) {
						e.preventDefault();
						alert('Mật khẩu mới phải có ít nhất 6 ký tự!');
					}
				}
			});
		});
	</script>

</body>
</html>