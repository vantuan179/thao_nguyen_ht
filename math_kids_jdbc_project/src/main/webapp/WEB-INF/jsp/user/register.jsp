<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Đăng ký - Bé Học Toán");
pageContext.setAttribute("pageJs", "register.js");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng ký - Bé Học Toán</title>

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
.register-avatar {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	background: linear-gradient(135deg, #667eea, #764ba2);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 2rem;
	color: #fff;
	margin: 0 auto 10px auto;
}

.form-group-half {
	margin-bottom: 0.8rem;
}

.form-group-half label {
	font-size: 0.85rem;
	font-weight: 600;
	color: #495057;
	margin-bottom: 3px;
}

.form-group-half .form-control {
	border-radius: 10px;
	padding: 10px 15px;
	font-size: 0.95rem;
}

.form-group-half .form-control-lg {
	padding: 12px 18px;
	font-size: 1rem;
}

.register-section-title {
	font-size: 0.8rem;
	font-weight: 700;
	color: #6c757d;
	text-transform: uppercase;
	letter-spacing: 1px;
	margin-bottom: 12px;
	padding-bottom: 6px;
	border-bottom: 2px solid #f0f2f5;
}

@media ( max-width : 768px) {
	.form-group-half {
		margin-bottom: 0.6rem;
	}
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

	<div class="container">
		<div class="row justify-content-center mt-3">
			<div class="col-lg-8">
				<div
					class="card shadow-lg border-0 rounded-lg register-card animate__animated animate__fadeInUp">
					<div class="card-header bg-transparent border-0 text-center pt-3">
						<div class="register-avatar">
							<i class="fas fa-user-plus"></i>
						</div>
						<h4 class="font-weight-bold text-primary mb-0">🌟 Tạo tài
							khoản mới</h4>
						<p class="text-muted small">Tham gia cộng đồng học toán vui vẻ
							nào!</p>
					</div>

					<div class="card-body p-4">
						<!-- Thông báo -->
						<c:if test="${not empty error}">
							<div class="alert alert-danger alert-dismissible fade show">
								<i class="fas fa-exclamation-circle"></i> ${error}
								<button type="button" class="close" data-dismiss="alert">×</button>
							</div>
						</c:if>
						<c:if test="${not empty success}">
							<div class="alert alert-success alert-dismissible fade show">
								<i class="fas fa-check-circle"></i> ${success}
								<button type="button" class="close" data-dismiss="alert">×</button>
							</div>
						</c:if>

						<form id="registerForm"
							action="${pageContext.request.contextPath}/register"
							method="POST">
							<!-- Thông tin cơ bản - 2 cột -->
							<div class="register-section-title">
								<i class="fas fa-user"></i> Thông tin cơ bản
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Họ và tên <span class="text-danger">*</span></label> <input
											type="text" class="form-control form-control-lg"
											id="fullName" name="fullName" placeholder="Họ và tên"
											value="${param.fullName}" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Email <span class="text-danger">*</span></label> <input
											type="email" class="form-control form-control-lg" id="email"
											name="email" placeholder="Email liên hệ"
											value="${param.email}" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Tên đăng nhập <span class="text-danger">*</span></label>
										<input type="text" class="form-control form-control-lg"
											id="username" name="username" placeholder="Tên đăng nhập"
											value="${param.username}" required> <small
											class="text-muted" style="font-size: 0.7rem;">3-20 ký
											tự, chữ và số</small>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Số điện thoại</label> <input type="tel"
											class="form-control form-control-lg" id="phone" name="phone"
											placeholder="Số điện thoại" value="${param.phone}">
									</div>
								</div>
							</div>

							<!-- Ngày sinh & Địa chỉ -->
							<div class="register-section-title mt-3">
								<i class="fas fa-calendar-alt"></i> Thông tin thêm
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Ngày sinh</label> <input type="date"
											class="form-control form-control-lg" id="dateOfBirth"
											name="dateOfBirth" value="${param.dateOfBirth}"> <small
											class="text-muted" style="font-size: 0.7rem;">Không
											bắt buộc</small>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Đường/Phố</label> <input type="text"
											class="form-control form-control-lg" id="street"
											name="street" placeholder="Số nhà, tên đường..."
											value="${param.street}">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group-half">
										<label>Thôn/Xóm/Ấp</label> <input type="text"
											class="form-control form-control-lg" id="hamlet"
											name="hamlet" placeholder="Thôn/Xóm" value="${param.hamlet}">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group-half">
										<label>Xã/Phường</label> <input type="text"
											class="form-control form-control-lg" id="commune"
											name="commune" placeholder="Xã/Phường"
											value="${param.commune}">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group-half">
										<label>Huyện/Quận</label> <input type="text"
											class="form-control form-control-lg" id="district"
											name="district" placeholder="Huyện/Quận"
											value="${param.district}">
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group-half">
										<label>Tỉnh/Thành phố</label> <input type="text"
											class="form-control form-control-lg" id="province"
											name="province" placeholder="Tỉnh/Thành phố"
											value="${param.province}">
									</div>
								</div>
							</div>

							<!-- Mật khẩu - 2 cột -->
							<div class="register-section-title mt-3">
								<i class="fas fa-lock"></i> Bảo mật
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Mật khẩu <span class="text-danger">*</span></label>
										<div class="input-group">
											<input type="password" class="form-control form-control-lg"
												id="password" name="password" placeholder="Mật khẩu"
												required>
											<div class="input-group-append">
												<button class="btn btn-outline-secondary" type="button"
													id="togglePassword">
													<i class="fas fa-eye"></i>
												</button>
											</div>
										</div>
										<small class="text-muted" style="font-size: 0.7rem;">Tối
											thiểu 6 ký tự</small>
										<div class="password-strength mt-1">
											<div class="progress" style="height: 4px;">
												<div class="progress-bar" id="passwordStrength"
													role="progressbar" style="width: 0%"></div>
											</div>
											<small class="text-muted" id="strengthText"
												style="font-size: 0.7rem;">Độ mạnh: Chưa nhập</small>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group-half">
										<label>Xác nhận mật khẩu <span class="text-danger">*</span></label>
										<input type="password" class="form-control form-control-lg"
											id="confirmPassword" name="confirmPassword"
											placeholder="Xác nhận mật khẩu" required> <small
											class="text-muted" id="passwordMatch"
											style="font-size: 0.75rem;"></small>
									</div>
								</div>
							</div>

							<!-- Đồng ý điều khoản -->
							<div class="form-group form-check mt-2">
								<input type="checkbox" class="form-check-input" id="agreeTerms"
									name="agreeTerms" required> <label
									class="form-check-label small" for="agreeTerms"> Tôi
									đồng ý với <a href="${pageContext.request.contextPath}/terms"
									target="_blank">Điều khoản sử dụng</a> và <a
									href="${pageContext.request.contextPath}/privacy"
									target="_blank">Chính sách bảo mật</a>
								</label>
							</div>

							<!-- Nút đăng ký -->
							<button type="submit"
								class="btn btn-fun btn-fun-primary btn-block btn-lg mt-2">
								<i class="fas fa-user-plus"></i> Đăng ký ngay
							</button>
						</form>

						<!-- Link đăng nhập -->
						<div class="text-center mt-3">
							<p class="text-muted small">
								Đã có tài khoản? <a
									href="${pageContext.request.contextPath}/login"
									class="font-weight-bold text-primary"> Đăng nhập ngay </a>
							</p>
						</div>
					</div>
				</div>

				<!-- Ưu điểm -->
				<div class="row mt-3 mb-4">
					<div class="col-md-4">
						<div class="text-center feature-item py-2">
							<i class="fas fa-shield-alt text-primary"
								style="font-size: 1.8rem;"></i>
							<h6 class="mt-1 font-weight-bold">An toàn</h6>
							<small class="text-muted">Bảo mật thông tin</small>
						</div>
					</div>
					<div class="col-md-4">
						<div class="text-center feature-item py-2">
							<i class="fas fa-graduation-cap text-success"
								style="font-size: 1.8rem;"></i>
							<h6 class="mt-1 font-weight-bold">Miễn phí</h6>
							<small class="text-muted">Hoàn toàn miễn phí</small>
						</div>
					</div>
					<div class="col-md-4">
						<div class="text-center feature-item py-2">
							<i class="fas fa-trophy text-warning" style="font-size: 1.8rem;"></i>
							<h6 class="mt-1 font-weight-bold">Thú vị</h6>
							<small class="text-muted">Học mà chơi</small>
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
		$(document)
				.ready(
						function() {
							// Toggle password
							$('#togglePassword')
									.click(
											function() {
												var type = $('#password').attr(
														'type') === 'password' ? 'text'
														: 'password';
												$('#password').attr('type',
														type);
												$(this).find('i').toggleClass(
														'fa-eye fa-eye-slash');
											});

							// Password strength
							$('#password').on(
									'keyup',
									function() {
										var password = $(this).val();
										var strength = 0;
										var text = '', color = '';

										if (password.length === 0) {
											$('#passwordStrength').css('width',
													'0%');
											$('#strengthText').text(
													'Độ mạnh: Chưa nhập');
											return;
										}

										if (password.length >= 6)
											strength++;
										if (password.length >= 10)
											strength++;
										if (password.match(/[a-z]/))
											strength++;
										if (password.match(/[A-Z]/))
											strength++;
										if (password.match(/\d/))
											strength++;
										if (password.match(/[^a-zA-Z\d]/))
											strength++;

										if (strength <= 2) {
											text = 'Yếu';
											color = '#e74c3c';
											$('#passwordStrength').css('width',
													'20%');
										} else if (strength <= 3) {
											text = 'Trung bình';
											color = '#f39c12';
											$('#passwordStrength').css('width',
													'40%');
										} else if (strength <= 4) {
											text = 'Khá';
											color = '#3498db';
											$('#passwordStrength').css('width',
													'60%');
										} else if (strength <= 5) {
											text = 'Mạnh';
											color = '#2ecc71';
											$('#passwordStrength').css('width',
													'80%');
										} else {
											text = 'Rất mạnh';
											color = '#27ae60';
											$('#passwordStrength').css('width',
													'100%');
										}

										$('#passwordStrength').css(
												'background', color);
										$('#strengthText').text(
												'Độ mạnh: ' + text).css(
												'color', color);
									});

							// Check password match
							$('#confirmPassword')
									.on(
											'keyup',
											function() {
												var password = $('#password')
														.val();
												var confirm = $(this).val();

												if (confirm.length === 0) {
													$('#passwordMatch')
															.text('');
													return;
												}

												if (password === confirm) {
													$('#passwordMatch')
															.html(
																	'<i class="fas fa-check-circle text-success"></i> Khớp');
												} else {
													$('#passwordMatch')
															.html(
																	'<i class="fas fa-times-circle text-danger"></i> Không khớp');
												}
											});
						});
	</script>

</body>
</html>