<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "Mẫu Email - Admin");
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

			<!-- Main Content -->
			<main class="col-md-10 admin-content">
				<div
					class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
					<div>
						<h2 class="font-weight-bold text-primary mb-0">
							<i class="fas fa-file-alt"></i> Mẫu Email
						</h2>
						<p class="text-muted mb-0">Quản lý các mẫu email sử dụng trong
							hệ thống</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<a
							href="${pageContext.request.contextPath}/admin/email/templates/create"
							class="btn btn-primary"> <i class="fas fa-plus"></i> Tạo mẫu
							mới
						</a>
					</div>
				</div>

				<c:if test="${not empty success}">
					<div class="alert alert-success alert-dismissible fade show">
						<i class="fas fa-check-circle"></i> ${success}
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show">
						<i class="fas fa-exclamation-circle"></i> ${error}
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">#</th>
									<th>Tên mẫu</th>
									<th>Loại</th>
									<th>Mô tả</th>
									<th>Trạng thái</th>
									<th style="width: 150px;">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty templates}">
										<c:forEach var="template" items="${templates}"
											varStatus="loop">
											<tr>
												<td>${loop.index + 1}</td>
												<td><strong>${template.name}</strong></td>
												<td><span class="badge badge-info">${template.type}</span></td>
												<td>${template.description}</td>
												<td><span
													class="badge ${template.active ? 'badge-success' : 'badge-secondary'}">
														${template.active ? 'Hoạt động' : 'Vô hiệu'} </span></td>
												<td>
													<div class="btn-group btn-group-sm" role="group">
														<a
															href="${pageContext.request.contextPath}/admin/email/templates/edit/${template.id}"
															class="btn btn-warning btn-action" title="Sửa"> <i
															class="fas fa-edit"></i>
														</a> <a
															href="${pageContext.request.contextPath}/admin/email/templates/delete/${template.id}"
															class="btn btn-danger btn-action" title="Xóa"
															onclick="return confirm('Bạn có chắc muốn xóa mẫu này?')">
															<i class="fas fa-trash"></i>
														</a>
													</div>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="6" class="text-center py-4"><i
												class="fas fa-file-alt"
												style="font-size: 3rem; color: #ccc;"></i>
												<p class="text-muted mt-2">Chưa có mẫu email nào</p> <a
												href="${pageContext.request.contextPath}/admin/email/templates/create"
												class="btn btn-primary btn-sm"> <i class="fas fa-plus"></i>
													Tạo mẫu đầu tiên
											</a></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</main>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>