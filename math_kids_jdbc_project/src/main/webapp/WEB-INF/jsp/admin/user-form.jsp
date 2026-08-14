<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String title = "Cập nhật người dùng";
pageContext.setAttribute("pageTitle", title + " - Admin");
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
			<!-- Include Sidebar -->
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<main class="col-md-10 admin-content">
				<div class="admin-form-container">
					<div
						class="form-header d-flex justify-content-between align-items-center">
						<div>
							<h3 class="text-primary mb-0">
								<i class="fas fa-user-edit"></i> Cập nhật người dùng
							</h3>
							<c:if test="${user != null}">
								<small class="text-muted">ID: ${user.id} -
									${user.username}</small>
							</c:if>
						</div>
						<a href="${pageContext.request.contextPath}/admin/users"
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
						action="${pageContext.request.contextPath}/admin/users/edit/${user.id}"
						method="POST">
						<div class="form-group">
							<label>Họ tên <span class="text-danger">*</span></label> <input
								type="text" name="fullName" class="form-control"
								value="${user.fullName}" required>
						</div>

						<div class="form-group">
							<label>Email <span class="text-danger">*</span></label> <input
								type="email" name="email" class="form-control"
								value="${user.email}" required>
						</div>

						<div class="form-group">
							<label>Vai trò <span class="text-danger">*</span></label> <select
								name="role" class="form-control" required>
								<option value="USER" ${user.role == 'USER' ? 'selected' : ''}>Học
									sinh</option>
								<option value="TEACHER"
									${user.role == 'TEACHER' ? 'selected' : ''}>Giáo viên</option>
								<option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Quản
									trị viên</option>
							</select>
						</div>

						<div class="form-group">
							<label>Mật khẩu mới (để trống nếu không đổi)</label> <input
								type="password" name="password" class="form-control"
								placeholder="Nhập mật khẩu mới">
						</div>

						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-fun">
								<i class="fas fa-save"></i> Cập nhật
							</button>
							<a href="${pageContext.request.contextPath}/admin/users"
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
</body>
</html>