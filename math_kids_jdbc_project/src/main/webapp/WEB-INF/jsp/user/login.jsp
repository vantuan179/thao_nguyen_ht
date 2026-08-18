<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Đăng nhập - Bé Học Toán");
pageContext.setAttribute("pageJs", "login.js");
%>

<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container">
	<div class="row justify-content-center mt-5">
		<div class="col-md-6 col-lg-5">
			<div
				class="card shadow-lg border-0 rounded-lg register-card animate__animated animate__fadeInUp">
				<div class="card-header bg-transparent border-0 text-center pt-4">
					<div class="register-icon mb-3"
						style="background: linear-gradient(135deg, #4facfe, #00f2fe);">
						<i class="fas fa-sign-in-alt"></i>
					</div>
					<h3 class="font-weight-bold text-primary">🔐 Đăng nhập</h3>
					<p class="text-muted">Chào mừng bạn quay trở lại!</p>
				</div>

				<div class="card-body p-4 p-md-5">
					<!-- ===== CHỈ HIỂN THỊ KHI CÓ LỖI ===== -->
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

					<form id="loginForm"
						action="${pageContext.request.contextPath}/login" method="POST">
						<div class="form-group">
							<label for="username" class="font-weight-bold text-secondary">
								<i class="fas fa-user"></i> Tên đăng nhập
							</label> <input type="text" class="form-control form-control-lg"
								id="username" name="username" placeholder="Nhập tên đăng nhập"
								value="${param.username}" required>
						</div>

						<div class="form-group">
							<label for="password" class="font-weight-bold text-secondary">
								<i class="fas fa-lock"></i> Mật khẩu
							</label>
							<div class="input-group">
								<input type="password" class="form-control form-control-lg"
									id="password" name="password" placeholder="Nhập mật khẩu"
									required>
								<div class="input-group-append">
									<button class="btn btn-outline-secondary" type="button"
										id="togglePassword">
										<i class="fas fa-eye"></i>
									</button>
								</div>
							</div>
						</div>

						<div
							class="form-group d-flex justify-content-between align-items-center">
							<div class="form-check">
								<input type="checkbox" class="form-check-input" id="rememberMe"
									name="rememberMe"> <label class="form-check-label"
									for="rememberMe">Ghi nhớ tôi</label>
							</div>
							<a href="${pageContext.request.contextPath}/forgot-password"
								class="text-primary"> Quên mật khẩu? </a>
						</div>

						<button type="submit"
							class="btn btn-fun btn-fun-primary btn-block btn-lg mt-3">
							<i class="fas fa-sign-in-alt"></i> Đăng nhập
						</button>
					</form>

					<div class="text-center mt-4">
						<p class="text-muted">
							Chưa có tài khoản? <a
								href="${pageContext.request.contextPath}/register"
								class="font-weight-bold text-primary"> Đăng ký ngay </a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Đóng main-content -->
</div>

<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<c:if test="${not empty pageJs}">
	<script src="${pageContext.request.contextPath}/assets/js/${pageJs}"></script>
</c:if>

<script>
	$(document)
			.ready(
					function() {
						$('#togglePassword')
								.click(
										function() {
											var type = $('#password').attr(
													'type') === 'password' ? 'text'
													: 'password';
											$('#password').attr('type', type);
											$(this).find('i').toggleClass(
													'fa-eye fa-eye-slash');
										});
					});
</script>

</body>
</html>