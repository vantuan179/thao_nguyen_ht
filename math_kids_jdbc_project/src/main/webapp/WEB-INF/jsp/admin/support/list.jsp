<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Hỗ trợ khách hàng - Admin");
pageContext.setAttribute("currentPage", "support");
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
							<i class="fas fa-headset"></i> Hỗ trợ khách hàng
						</h2>
						<p class="text-muted mb-0">Quản lý các ticket hỗ trợ</p>
					</div>
					<div class="date-time mt-2 mt-sm-0">
						<i class="far fa-calendar-alt"></i>
						<%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date())%>
					</div>
				</div>

				<!-- Thống kê -->
				<div class="row mb-4">
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card">
							<div class="icon blue">
								<i class="fas fa-ticket-alt"></i>
							</div>
							<div class="info">
								<div class="label">Tổng ticket</div>
								<div class="number">${tickets.size()}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3"
						style="border-left-color: #28a745;">
						<div class="admin-stat-card" style="border-left-color: #28a745;">
							<div class="icon green">
								<i class="fas fa-clock"></i>
							</div>
							<div class="info">
								<div class="label">Mở</div>
								<div class="number">${openCount}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3"
						style="border-left-color: #ffc107;">
						<div class="admin-stat-card" style="border-left-color: #ffc107;">
							<div class="icon orange">
								<i class="fas fa-spinner"></i>
							</div>
							<div class="info">
								<div class="label">Đang xử lý</div>
								<div class="number">${inProgressCount}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #dc3545;">
							<div class="icon red">
								<i class="fas fa-envelope"></i>
							</div>
							<div class="info">
								<div class="label">Tin nhắn chưa đọc</div>
								<div class="number">${unreadCount}</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Danh sách ticket -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-list"></i> Danh sách ticket
						</h5>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>Mã ticket</th>
									<th>Người dùng</th>
									<th>Chủ đề</th>
									<th>Trạng thái</th>
									<th>Tin nhắn</th>
									<th>Ngày tạo</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty tickets}">
										<c:forEach var="ticket" items="${tickets}">
											<tr>
												<td><strong>#${ticket.ticketId}</strong></td>
												<td>${ticket.userName}</td>
												<td>${ticket.subject}</td>
												<td><span class="ticket-status ${ticket.status}">${ticket.status}</span>
												</td>
												<td>${ticket.messageCount}</td>
												<td><fmt:formatDate value="${ticket.createdAt}"
														pattern="dd/MM/yyyy HH:mm" /></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/support/ticket/${ticket.ticketId}"
													class="btn btn-sm btn-primary"> <i class="fas fa-eye"></i>
														Xem
												</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="7" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có ticket hỗ trợ</td>
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