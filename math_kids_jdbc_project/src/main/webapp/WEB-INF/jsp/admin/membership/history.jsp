<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Lịch sử thành viên - Admin");
pageContext.setAttribute("currentPage", "membership-history");
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
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<main class="col-md-10 admin-content">
				<div
					class="admin-header d-flex justify-content-between align-items-center flex-wrap">
					<div>
						<h2 class="font-weight-bold text-primary mb-0">
							<i class="fas fa-history"></i> Lịch sử thành viên
						</h2>
						<p class="text-muted mb-0">Lịch sử các giao dịch thành viên</p>
					</div>
				</div>

				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Người dùng</th>
									<th>Hành động</th>
									<th>Gói</th>
									<th>Số tiền</th>
									<th>Trạng thái</th>
									<th>Ngày</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${history}">
									<tr>
										<td>#${item.id}</td>
										<td><strong>${item.userName}</strong></td>
										<td><span
											class="badge ${item.actionType == 'REGISTER' ? 'badge-success' : item.actionType == 'RENEW' ? 'badge-info' : 'badge-danger'}">
												${item.actionType} </span></td>
										<td>${item.packageType}</td>
										<td><fmt:formatNumber value="${item.amount}"
												pattern="#,##0" /> đ</td>
										<td><span
											class="badge ${item.paymentStatus == 'completed' ? 'badge-success' : 'badge-warning'}">
												${item.paymentStatus} </span></td>
										<td><fmt:formatDate value="${item.createdAt}"
												pattern="dd/MM/yyyy HH:mm" /></td>
									</tr>
								</c:forEach>
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