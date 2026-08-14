<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Lịch sử Email - Admin");
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
							<i class="fas fa-history"></i> Lịch sử gửi email
						</h2>
						<p class="text-muted mb-0">Danh sách tất cả email đã gửi</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<a href="${pageContext.request.contextPath}/admin/email"
							class="btn btn-outline-secondary"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>
				</div>

				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">#</th>
									<th>Người gửi</th>
									<th>Người nhận</th>
									<th>Tiêu đề</th>
									<th>Trạng thái</th>
									<th>Loại</th>
									<th style="width: 150px;">Thời gian</th>
									<th style="width: 80px;">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty emails}">
										<c:forEach var="email" items="${emails}" varStatus="loop">
											<tr>
												<td>${loop.index + 1}</td>
												<td>${email.fromEmail}</td>
												<td>${email.toEmail}</td>
												<td><strong>${email.subject}</strong></td>
												<td><span
													class="badge-status badge-${email.status.toLowerCase()}">
														${email.status} </span></td>
												<td><span class="badge badge-info">${email.type}</span></td>
												<td><fmt:formatDate value="${email.sentAt}"
														pattern="dd/MM/yyyy HH:mm" /></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/email/view/${email.id}"
													class="btn btn-sm btn-info"> <i class="fas fa-eye"></i>
												</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="8" class="text-center py-4"><i
												class="fas fa-inbox" style="font-size: 3rem; color: #ccc;"></i>
												<p class="text-muted mt-2">Chưa có email nào</p></td>
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