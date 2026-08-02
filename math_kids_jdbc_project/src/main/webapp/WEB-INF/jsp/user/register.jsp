<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Đăng ký - Bé Học Toán");
pageContext.setAttribute("pageJs", "register.js");
pageContext.setAttribute("pageCss", "register.css");
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

<!-- Animate.css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap"
	rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/register.css">
</head>
<body>
	<!-- Floating Shapes -->
	<div class="floating-shape" style="top: 10%; left: 5%"></div>
	<div class="floating-shape"
		style="top: 60%; right: 8%; animation-delay: 2s"></div>
	<div class="floating-shape"
		style="bottom: 10%; left: 15%; animation-delay: 4s"></div>

	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg navbar-light navbar-custom container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">🧮
			Bé Học Toán</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/">Trang chủ</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/lessons">Bài học</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/games">Trò chơi</a></li>
				<c:choose>
					<c:when test="${not empty sessionScope.currentUser}">
						<li class="nav-item"><span
							class="nav-link text-success font-weight-bold"> 👋
								${sessionScope.currentUser.fullName} </span></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
						<li class="nav-item"><a
							class="nav-link btn btn-fun btn-fun-primary text-white px-3"
							href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>

	<!-- Main Content -->
	<div class="main-content" id="mainContent">
		<div class="container">
			<div class="row justify-content-center mt-4">
				<div class="col-md-8 col-lg-6">
					<!-- Card đăng ký -->
					<div
						class="card shadow-lg border-0 rounded-lg register-card animate__animated animate__fadeInUp">
						<div class="card-header bg-transparent border-0 text-center pt-4">
							<div class="register-icon mb-3">
								<i class="fas fa-user-plus"></i>
							</div>
							<h3 class="font-weight-bold text-primary">🌟 Tạo tài khoản
								mới</h3>
							<p class="text-muted">Tham gia cộng đồng học toán vui vẻ nào!</p>
						</div>

						<div class="card-body p-4 p-md-5">
							<!-- Hiển thị thông báo lỗi nếu có -->
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

							<form id="registerForm"
								action="${pageContext.request.contextPath}/register"
								method="POST">
								<!-- Họ và tên -->
								<div class="form-group">
									<label for="fullName" class="font-weight-bold text-secondary">
										<i class="fas fa-user"></i> Họ và tên
									</label> <input type="text" class="form-control form-control-lg"
										id="fullName" name="fullName"
										placeholder="Nhập họ và tên của bé" value="${param.fullName}"
										required> <small class="form-text text-muted">Tên
										sẽ hiển thị trên bảng xếp hạng</small>
								</div>

								<!-- Tên đăng nhập -->
								<div class="form-group">
									<label for="username" class="font-weight-bold text-secondary">
										<i class="fas fa-id-card"></i> Tên đăng nhập
									</label> <input type="text" class="form-control form-control-lg"
										id="username" name="username" placeholder="Chọn tên đăng nhập"
										value="${param.username}" required> <small
										class="form-text text-muted">Từ 3-20 ký tự, chỉ bao
										gồm chữ và số</small>
								</div>

								<!-- Email -->
								<div class="form-group">
									<label for="email" class="font-weight-bold text-secondary">
										<i class="fas fa-envelope"></i> Email
									</label> <input type="email" class="form-control form-control-lg"
										id="email" name="email" placeholder="Nhập email của phụ huynh"
										value="${param.email}" required> <small
										class="form-text text-muted">Chúng tôi sẽ gửi thông
										tin qua email này</small>
								</div>

								<!-- Mật khẩu -->
								<div class="form-group">
									<label for="password" class="font-weight-bold text-secondary">
										<i class="fas fa-lock"></i> Mật khẩu
									</label>
									<div class="input-group">
										<input type="password" class="form-control form-control-lg"
											id="password" name="password" placeholder="Tạo mật khẩu"
											required>
										<div class="input-group-append">
											<button class="btn btn-outline-secondary" type="button"
												id="togglePassword">
												<i class="fas fa-eye"></i>
											</button>
										</div>
									</div>
									<small class="form-text text-muted">Tối thiểu 6 ký tự,
										bao gồm chữ và số</small>
									<div class="password-strength mt-2">
										<div class="progress" style="height: 5px;">
											<div class="progress-bar" id="passwordStrength"
												role="progressbar" style="width: 0%"></div>
										</div>
										<small class="text-muted" id="strengthText">Độ mạnh:
											Yếu</small>
									</div>
								</div>

								<!-- Xác nhận mật khẩu -->
								<div class="form-group">
									<label for="confirmPassword"
										class="font-weight-bold text-secondary"> <i
										class="fas fa-check-circle"></i> Xác nhận mật khẩu
									</label> <input type="password" class="form-control form-control-lg"
										id="confirmPassword" name="confirmPassword"
										placeholder="Nhập lại mật khẩu" required> <small
										class="form-text" id="passwordMatch"></small>
								</div>

								<!-- Đồng ý điều khoản -->
								<div class="form-group form-check">
									<input type="checkbox" class="form-check-input" id="agreeTerms"
										name="agreeTerms" required> <label
										class="form-check-label" for="agreeTerms"> Tôi đồng ý
										với <a href="${pageContext.request.contextPath}/terms"
										target="_blank">Điều khoản sử dụng</a> và <a
										href="${pageContext.request.contextPath}/privacy"
										target="_blank">Chính sách bảo mật</a>
									</label>
								</div>

								<!-- Nút đăng ký -->
								<button type="submit"
									class="btn btn-fun btn-fun-primary btn-block btn-lg mt-3">
									<i class="fas fa-user-plus"></i> Đăng ký ngay
								</button>
							</form>

							<!-- Link đăng nhập -->
							<div class="text-center mt-4">
								<p class="text-muted">
									Đã có tài khoản? <a
										href="${pageContext.request.contextPath}/login"
										class="font-weight-bold text-primary"> Đăng nhập ngay </a>
								</p>
							</div>
						</div>
					</div>

					<!-- Ưu điểm -->
					<div class="row mt-4 mb-5">
						<div class="col-md-4">
							<div class="text-center feature-item">
								<i class="fas fa-shield-alt text-primary"
									style="font-size: 2rem;"></i>
								<h6 class="mt-2 font-weight-bold">An toàn</h6>
								<small class="text-muted">Bảo mật thông tin tuyệt đối</small>
							</div>
						</div>
						<div class="col-md-4">
							<div class="text-center feature-item">
								<i class="fas fa-graduation-cap text-success"
									style="font-size: 2rem;"></i>
								<h6 class="mt-2 font-weight-bold">Miễn phí</h6>
								<small class="text-muted">Hoàn toàn miễn phí cho bé</small>
							</div>
						</div>
						<div class="col-md-4">
							<div class="text-center feature-item">
								<i class="fas fa-trophy text-warning" style="font-size: 2rem;"></i>
								<h6 class="mt-2 font-weight-bold">Thú vị</h6>
								<small class="text-muted">Học mà chơi, chơi mà học</small>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="footer" id="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<h5>
						<i class="fas fa-graduation-cap"></i> Bé Học Toán
					</h5>
					<p style="font-size: 0.95rem; color: #0d47a1;">Nền tảng học
						toán trực tuyến dành cho trẻ em từ 4-10 tuổi. Giúp các bé yêu
						thích môn toán thông qua các bài học sinh động và trò chơi thú vị.
					</p>
					<div class="badge-math mt-2">
						<i class="fas fa-star"></i> Hơn 10.000 học sinh
					</div>
				</div>

				<div class="col-md-3">
					<h5>
						<i class="fas fa-link"></i> Liên kết nhanh
					</h5>
					<ul class="list-unstyled">
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/">Trang chủ</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/lessons">Bài học</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/games">Trò chơi</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/exercises">Bài tập</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/ranking">Bảng xếp
								hạng</a></li>
					</ul>
				</div>

				<div class="col-md-3">
					<h5>
						<i class="fas fa-life-ring"></i> Hỗ trợ
					</h5>
					<ul class="list-unstyled">
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/faq">Câu hỏi thường
								gặp</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/privacy">Chính sách
								bảo mật</a></li>
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/terms">Điều khoản sử
								dụng</a></li>
					</ul>
				</div>

				<div class="col-md-3">
					<h5>
						<i class="fas fa-phone"></i> Kết nối với chúng tôi
					</h5>
					<div class="social-icons mb-3">
						<a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
						<a href="#" aria-label="YouTube"><i class="fab fa-youtube"></i></a>
						<a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
						<a href="#" aria-label="Zalo"><i class="fas fa-comment"></i></a>
					</div>
					<ul class="list-unstyled">
						<li><i class="fas fa-envelope"></i> <a
							href="mailto:support@behoctoan.com">support@behoctoan.com</a></li>
						<li><i class="fas fa-phone"></i> <a href="tel:19001234">1900
								1234</a></li>
						<li><i class="fas fa-clock"></i> <span
							style="color: #0d47a1;">T2-T7: 8:00 - 20:00</span></li>
					</ul>
				</div>
			</div>

			<div class="footer-bottom text-center">
				<div class="row">
					<div class="col-md-6 text-md-left">
						<p>
							© 2024 <strong>Bé Học Toán</strong>. Tất cả các quyền được bảo
							lưu.
						</p>
					</div>
					<div class="col-md-6 text-md-right">
						<p>
							<i class="fas fa-heart text-danger"></i> Phát triển với tình yêu
							dành cho trẻ em <i class="fas fa-heart text-danger"></i>
						</p>
					</div>
				</div>
			</div>
		</div>
	</footer>

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script src="${pageContext.request.contextPath}/assets/js/register.js"></script>

	<!-- QUAN TRỌNG: Script cuộn lên đầu trang -->
	<script>
		// Đảm bảo trang luôn bắt đầu từ top
		(function() {
			// Vô hiệu hóa scroll restoration của trình duyệt
			if ('scrollRestoration' in history) {
				history.scrollRestoration = 'manual';
			}

			// Cuộn lên đầu trang ngay lập tức
			window.scrollTo(0, 0);

			// Cuộn lên đầu với animation sau khi load xong
			window.addEventListener('load', function() {
				window.scrollTo(0, 0);
				// Hoặc dùng jQuery
				// $('html, body').animate({ scrollTop: 0 }, 0);
			});

			// Đảm bảo cuộn lên đầu sau 100ms
			setTimeout(function() {
				window.scrollTo(0, 0);
			}, 100);
		})();
	</script>
</body>
</html>