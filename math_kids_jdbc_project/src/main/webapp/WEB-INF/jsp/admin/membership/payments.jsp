<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Quản lý thanh toán - Admin");
pageContext.setAttribute("currentPage", "membership-payments");
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
							<i class="fas fa-credit-card"></i> Quản lý thanh toán
						</h2>
						<p class="text-muted mb-0">Xác nhận và quản lý các giao dịch
							thanh toán</p>
					</div>
					<div class="date-time mt-2 mt-sm-0">
						<i class="far fa-calendar-alt"></i>
						<%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date())%>
					</div>
				</div>

				<c:if test="${not empty success}">
					<div class="alert alert-success">${success}</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>

				<!-- Thanh toán chờ xác nhận -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-clock text-warning"></i> Thanh toán chờ xác nhận
						</h5>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Người dùng</th>
									<th>Gói</th>
									<th>Số tiền</th>
									<th>Nội dung</th>
									<th>Ngày tạo</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty pendingPayments}">
										<c:forEach var="payment" items="${pendingPayments}">
											<tr>
												<td>#${payment.id}</td>
												<td><strong>${payment.userName}</strong></td>
												<td>${payment.packageType}</td>
												<td><fmt:formatNumber value="${payment.amount}"
														pattern="#,##0" /> đ</td>
												<td>${payment.paymentNote}</td>
												<td><fmt:formatDate value="${payment.createdAt}"
														pattern="dd/MM/yyyy HH:mm" /></td>
												<td>
													<form
														action="${pageContext.request.contextPath}/admin/membership/payments/confirm/${payment.id}"
														method="POST" style="display: inline;">
														<button type="submit" class="btn btn-sm btn-success"
															onclick="return confirm('Xác nhận thanh toán này?')">
															<i class="fas fa-check"></i> Xác nhận
														</button>
													</form>
													<form
														action="${pageContext.request.contextPath}/admin/membership/payments/cancel/${payment.id}"
														method="POST" style="display: inline;">
														<button type="submit" class="btn btn-sm btn-danger"
															onclick="return confirm('Hủy thanh toán này?')">
															<i class="fas fa-times"></i> Hủy
														</button>
													</form>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="7" class="text-center py-3 text-muted"><i
												class="fas fa-check-circle text-success"></i> Không có thanh
												toán chờ xác nhận</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>

				<!-- Lịch sử thanh toán -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-history"></i> Lịch sử thanh toán
						</h5>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Người dùng</th>
									<th>Gói</th>
									<th>Số tiền</th>
									<th>Trạng thái</th>
									<th>Ngày xử lý</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty allPayments}">
										<c:forEach var="payment" items="${allPayments}">
											<tr>
												<td>#${payment.id}</td>
												<td><strong>${payment.userName}</strong></td>
												<td>${payment.packageType}</td>
												<td><fmt:formatNumber value="${payment.amount}"
														pattern="#,##0" /> đ</td>
												<td><span
													class="badge ${payment.paymentStatus == 'completed' ? 'badge-success' : payment.paymentStatus == 'pending' ? 'badge-warning' : 'badge-danger'}">
														${payment.paymentStatus} </span></td>
												<td><fmt:formatDate value="${payment.processedAt}"
														pattern="dd/MM/yyyy HH:mm" /></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="6" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có lịch sử thanh toán</td>
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