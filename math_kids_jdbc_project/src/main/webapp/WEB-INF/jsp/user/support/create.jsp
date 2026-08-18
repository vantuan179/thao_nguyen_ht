<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Tạo yêu cầu hỗ trợ - Bé Học Toán");
%>

<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container py-4">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card shadow-lg border-0 rounded-lg">
				<div class="card-header bg-transparent border-0 pt-4">
					<h3 class="text-primary font-weight-bold">
						<i class="fas fa-plus-circle"></i> Tạo yêu cầu hỗ trợ
					</h3>
					<p class="text-muted">Chúng tôi sẽ phản hồi trong thời gian sớm
						nhất</p>
				</div>
				<div class="card-body p-4">
					<form id="supportForm"
						action="${pageContext.request.contextPath}/support/create"
						method="POST">
						<!-- Tên người dùng - tự động điền và không cho chỉnh sửa -->
						<div class="form-group">
							<label class="font-weight-bold">Người gửi <span
								class="text-danger">*</span></label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="fas fa-user"></i></span>
								</div>
								<input type="text" class="form-control"
									value="${sessionScope.currentUser.fullName}" disabled readonly
									style="background: #f8f9fa; cursor: not-allowed;">
							</div>
							<small class="text-muted">Yêu cầu sẽ được gửi dưới tên
								của bạn</small>
						</div>

						<!-- Email - tự động điền và cho phép chỉnh sửa -->
						<div class="form-group">
							<label class="font-weight-bold">Email <span
								class="text-danger">*</span></label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i
										class="fas fa-envelope"></i></span>
								</div>
								<input type="email" name="email" id="email" class="form-control"
									value="${sessionScope.currentUser.email}"
									placeholder="Nhập email của bạn" required>
							</div>
							<small class="text-muted">Chúng tôi sẽ phản hồi qua email
								này</small>
							<div class="invalid-feedback" id="emailError"
								style="display: none;">
								<i class="fas fa-exclamation-circle"></i> Vui lòng nhập email
								hợp lệ
							</div>
						</div>

						<!-- Tiêu đề -->
						<div class="form-group">
							<label class="font-weight-bold">Tiêu đề <span
								class="text-danger">*</span></label> <input type="text" name="subject"
								id="subject" class="form-control"
								placeholder="Nhập tiêu đề yêu cầu" required>
							<div class="invalid-feedback" id="subjectError"
								style="display: none;">
								<i class="fas fa-exclamation-circle"></i> Vui lòng nhập tiêu đề
							</div>
						</div>

						<!-- Nội dung -->
						<div class="form-group">
							<label class="font-weight-bold">Nội dung <span
								class="text-danger">*</span></label>
							<textarea name="message" id="message" class="form-control"
								rows="6" placeholder="Mô tả chi tiết vấn đề của bạn" required>${param.message}</textarea>
							<div class="invalid-feedback" id="messageError"
								style="display: none;">
								<i class="fas fa-exclamation-circle"></i> Vui lòng nhập nội dung
							</div>
						</div>

						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-fun"
								id="submitBtn">
								<i class="fas fa-paper-plane"></i> Gửi yêu cầu
							</button>
							<a href="${pageContext.request.contextPath}/support"
								class="btn btn-outline-secondary btn-fun ml-2"> <i
								class="fas fa-times"></i> Hủy
							</a>
						</div>
					</form>
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
		// ===== VALIDATION =====
		$('#supportForm').on('submit', function(e) {
			var isValid = true;

			// Reset errors
			$('.invalid-feedback').hide();
			$('.form-control').removeClass('is-invalid');

			// Validate Email
			var email = $('#email').val().trim();
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!email) {
				$('#email').addClass('is-invalid');
				$('#emailError').text('Vui lòng nhập email!').show();
				isValid = false;
			} else if (!emailRegex.test(email)) {
				$('#email').addClass('is-invalid');
				$('#emailError').text('Vui lòng nhập email hợp lệ!').show();
				isValid = false;
			}

			// Validate Subject
			var subject = $('#subject').val().trim();
			if (!subject) {
				$('#subject').addClass('is-invalid');
				$('#subjectError').text('Vui lòng nhập tiêu đề!').show();
				isValid = false;
			}

			// Validate Message
			var message = $('#message').val().trim();
			if (!message) {
				$('#message').addClass('is-invalid');
				$('#messageError').text('Vui lòng nhập nội dung!').show();
				isValid = false;
			}

			if (!isValid) {
				e.preventDefault();
				// Scroll to first error
				$('.is-invalid:first').focus();
			}
		});

		// ===== REAL-TIME VALIDATION =====
		// Email
		$('#email').on('blur', function() {
			var email = $(this).val().trim();
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (email && !emailRegex.test(email)) {
				$(this).addClass('is-invalid');
				$('#emailError').text('Vui lòng nhập email hợp lệ!').show();
			} else if (!email) {
				$(this).addClass('is-invalid');
				$('#emailError').text('Vui lòng nhập email!').show();
			} else {
				$(this).removeClass('is-invalid');
				$('#emailError').hide();
			}
		});

		$('#email').on('input', function() {
			var email = $(this).val().trim();
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (email && emailRegex.test(email)) {
				$(this).removeClass('is-invalid');
				$('#emailError').hide();
			}
		});

		// Subject
		$('#subject').on('blur', function() {
			if (!$(this).val().trim()) {
				$(this).addClass('is-invalid');
				$('#subjectError').text('Vui lòng nhập tiêu đề!').show();
			} else {
				$(this).removeClass('is-invalid');
				$('#subjectError').hide();
			}
		});

		$('#subject').on('input', function() {
			if ($(this).val().trim()) {
				$(this).removeClass('is-invalid');
				$('#subjectError').hide();
			}
		});

		// Message
		$('#message').on('blur', function() {
			if (!$(this).val().trim()) {
				$(this).addClass('is-invalid');
				$('#messageError').text('Vui lòng nhập nội dung!').show();
			} else {
				$(this).removeClass('is-invalid');
				$('#messageError').hide();
			}
		});

		$('#message').on('input', function() {
			if ($(this).val().trim()) {
				$(this).removeClass('is-invalid');
				$('#messageError').hide();
			}
		});
	});
</script>

</body>
</html>