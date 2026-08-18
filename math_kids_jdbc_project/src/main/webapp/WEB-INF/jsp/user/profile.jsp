<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Thông tin tài khoản - Bé Học Toán");
%>

<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container py-4">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card shadow-lg border-0 rounded-lg">
				<div class="card-header bg-transparent border-0 pt-4">
					<h3 class="text-primary font-weight-bold">
						<i class="fas fa-user-circle"></i> Thông tin tài khoản
					</h3>
					<p class="text-muted">Quản lý thông tin cá nhân của bạn</p>
				</div>
				<div class="card-body p-4">
					<c:if test="${not empty success}">
						<div class="alert alert-success">${success}</div>
					</c:if>
					<c:if test="${not empty error}">
						<div class="alert alert-danger">${error}</div>
					</c:if>

					<form action="${pageContext.request.contextPath}/profile/update"
						method="POST">
						<!-- Họ tên -->
						<div class="form-group">
							<label class="font-weight-bold">Họ và tên <span
								class="text-danger">*</span></label> <input type="text" name="fullName"
								class="form-control"
								value="${sessionScope.currentUser.fullName}" required>
						</div>

						<!-- Email -->
						<div class="form-group">
							<label class="font-weight-bold">Email <span
								class="text-danger">*</span></label> <input type="email" name="email"
								class="form-control" value="${sessionScope.currentUser.email}"
								required>
						</div>

						<!-- Tên đăng nhập (không chỉnh sửa) -->
						<div class="form-group">
							<label class="font-weight-bold">Tên đăng nhập</label> <input
								type="text" class="form-control"
								value="${sessionScope.currentUser.username}" disabled
								style="background: #f8f9fa; cursor: not-allowed;"> <small
								class="text-muted">Tên đăng nhập không thể thay đổi</small>
						</div>

						<!-- Loại thành viên -->
						<div class="form-group">
							<label class="font-weight-bold">Loại thành viên</label>
							<div class="form-control"
								style="background: #f8f9fa; cursor: not-allowed;">
								<span
									class="badge ${sessionScope.currentUser.membershipType == 'premium' ? 'badge-success' : 'badge-info'}">
									${sessionScope.currentUser.membershipType == 'premium' ? 'Premium' : 'Dùng thử'}
								</span>
								<c:if
									test="${sessionScope.currentUser.membershipType == 'premium'}">
									<span class="text-muted ml-2"> Hết hạn: <fmt:formatDate
											value="${sessionScope.currentUser.membershipExpiryDate}"
											pattern="dd/MM/yyyy" />
									</span>
								</c:if>
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
					<hr>
					<div class="mt-3">
						<h5 class="text-primary">
							<i class="fas fa-key"></i> Đổi mật khẩu
						</h5>
						<form
							action="${pageContext.request.contextPath}/profile/change-password"
							method="POST" class="mt-3">
							<div class="form-group">
								<label>Mật khẩu hiện tại <span class="text-danger">*</span></label>
								<input type="password" name="oldPassword" class="form-control"
									required>
							</div>
							<div class="form-group">
								<label>Mật khẩu mới <span class="text-danger">*</span></label> <input
									type="password" name="newPassword" class="form-control"
									required minlength="6">
							</div>
							<div class="form-group">
								<label>Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
								<input type="password" name="confirmPassword"
									class="form-control" required minlength="6">
							</div>
							<button type="submit" class="btn btn-warning btn-fun">
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
		// Validate đổi mật khẩu
		$('form[action*="change-password"]').on('submit', function(e) {
			var newPass = $('input[name="newPassword"]').val();
			var confirmPass = $('input[name="confirmPassword"]').val();

			if (newPass !== confirmPass) {
				e.preventDefault();
				alert('Mật khẩu xác nhận không khớp!');
			}
		});
	});
</script>

</body>
</html>