<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Quản lý thành viên - Admin");
pageContext.setAttribute("currentPage", "membership");
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

<style>
.stat-card {
	background: white;
	border-radius: 15px;
	padding: 20px 25px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	transition: transform 0.3s;
	border-left: 4px solid #667eea;
	height: 100%;
}

.stat-card:hover {
	transform: translateY(-5px);
}

.stat-card .icon {
	font-size: 2.5rem;
	float: left;
	margin-right: 15px;
}

.stat-card .number {
	font-size: 2rem;
	font-weight: 700;
	color: #2d3436;
}

.stat-card .label {
	color: #6c757d;
	font-size: 0.9rem;
}

.stat-card .icon.blue {
	color: #1976d2;
}

.stat-card .icon.green {
	color: #388e3c;
}

.stat-card .icon.orange {
	color: #f57c00;
}

.stat-card .icon.purple {
	color: #7b1fa2;
}

.stat-card .icon.red {
	color: #dc3545;
}

.stat-card .icon.gold {
	color: #ffd700;
}

.badge-status {
	padding: 5px 12px;
	border-radius: 20px;
	font-weight: 600;
	font-size: 0.75rem;
}

.badge-active {
	background: #d4edda;
	color: #155724;
}

.badge-inactive {
	background: #f8d7da;
	color: #721c24;
}

.badge-pending {
	background: #fff3cd;
	color: #856404;
}
</style>
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<!-- Sidebar -->
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<!-- Main Content -->
			<main class="col-md-10 admin-content">
				<div
					class="admin-header d-flex justify-content-between align-items-center flex-wrap">
					<div>
						<h2 class="font-weight-bold text-primary mb-0">
							<i class="fas fa-crown"></i> Quản lý thành viên
						</h2>
						<p class="text-muted mb-0">Quản lý thành viên và gói đăng ký</p>
					</div>
					<div class="date-time mt-2 mt-sm-0">
						<i class="far fa-calendar-alt"></i>
						<%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date())%>
					</div>
				</div>

				<!-- Thống kê -->
				<div class="row mb-4">
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card">
							<div class="icon blue">
								<i class="fas fa-users"></i>
							</div>
							<div class="info">
								<div class="label">Tổng người dùng</div>
								<div class="number">${stats.totalUsers != null ? stats.totalUsers : 0}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card" style="border-left-color: #28a745;">
							<div class="icon green">
								<i class="fas fa-user-check"></i>
							</div>
							<div class="info">
								<div class="label">Premium</div>
								<div class="number">${stats.premiumUsers != null ? stats.premiumUsers : 0}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card" style="border-left-color: #ffc107;">
							<div class="icon orange">
								<i class="fas fa-user-clock"></i>
							</div>
							<div class="info">
								<div class="label">Dùng thử</div>
								<div class="number">${stats.trialUsers != null ? stats.trialUsers : 0}</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="stat-card" style="border-left-color: #dc3545;">
							<div class="icon red">
								<i class="fas fa-user-slash"></i>
							</div>
							<div class="info">
								<div class="label">Hết hạn</div>
								<div class="number">${stats.expiredUsers != null ? stats.expiredUsers : 0}</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Doanh thu -->
				<div class="row mb-4">
					<div class="col-md-6 mb-3">
						<div class="stat-card" style="border-left-color: #ffd700;">
							<div class="icon gold">
								<i class="fas fa-money-bill-wave"></i>
							</div>
							<div class="info">
								<div class="label">Tổng doanh thu</div>
								<div class="number">
									<c:choose>
										<c:when test="${stats.totalRevenue != null}">
											<fmt:formatNumber value="${stats.totalRevenue}"
												pattern="#,##0" /> đ
                                    </c:when>
										<c:otherwise>0 đ</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 mb-3">
						<div class="stat-card" style="border-left-color: #20c997;">
							<div class="icon green">
								<i class="fas fa-calendar-day"></i>
							</div>
							<div class="info">
								<div class="label">Doanh thu tháng này</div>
								<div class="number">
									<c:choose>
										<c:when test="${stats.monthlyRevenue != null}">
											<fmt:formatNumber value="${stats.monthlyRevenue}"
												pattern="#,##0" /> đ
                                    </c:when>
										<c:otherwise>0 đ</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Thanh toán chờ xác nhận -->
				<c:if test="${not empty pendingPayments}">
					<div class="admin-table-container">
						<div class="header">
							<h5>
								<i class="fas fa-clock text-warning"></i> Thanh toán chờ xác
								nhận
							</h5>
							<div class="actions">
								<a
									href="${pageContext.request.contextPath}/admin/membership/payments"
									class="btn btn-sm btn-primary"> <i
									class="fas fa-arrow-right"></i> Xem tất cả
								</a>
							</div>
						</div>
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>Người dùng</th>
										<th>Gói</th>
										<th>Số tiền</th>
										<th>Ngày tạo</th>
										<th>Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="payment" items="${pendingPayments}" end="4">
										<tr>
											<td>#${payment.id}</td>
											<td>${payment.userName}</td>
											<td>${payment.packageType}</td>
											<td><c:choose>
													<c:when test="${payment.amount != null}">
														<fmt:formatNumber value="${payment.amount}"
															pattern="#,##0" /> đ
                                                </c:when>
													<c:otherwise>0 đ</c:otherwise>
												</c:choose></td>
											<td><fmt:formatDate value="${payment.createdAt}"
													pattern="dd/MM/yyyy HH:mm" /></td>
											<td>
												<form
													action="${pageContext.request.contextPath}/admin/membership/payments/confirm/${payment.id}"
													method="POST" style="display: inline;">
													<button type="submit" class="btn btn-sm btn-success"
														onclick="return confirm('Xác nhận thanh toán này?')">
														<i class="fas fa-check"></i>
													</button>
												</form>
												<form
													action="${pageContext.request.contextPath}/admin/membership/payments/cancel/${payment.id}"
													method="POST" style="display: inline;">
													<button type="submit" class="btn btn-sm btn-danger"
														onclick="return confirm('Hủy thanh toán này?')">
														<i class="fas fa-times"></i>
													</button>
												</form>
											</td>
										</tr>
									</c:forEach>
									<c:if test="${pendingPayments.size() > 5}">
										<tr>
											<td colspan="6" class="text-center text-muted"><i
												class="fas fa-ellipsis-h"></i> Còn ${pendingPayments.size() - 5}
												thanh toán khác.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>

				<!-- Danh sách thành viên Premium -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-crown text-warning"></i> Thành viên Premium
						</h5>
						<div class="actions">
							<a
								href="${pageContext.request.contextPath}/admin/membership/activate"
								class="btn btn-sm btn-success"> <i class="fas fa-plus"></i>
								Kích hoạt
							</a>
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Họ tên</th>
									<th>Tên đăng nhập</th>
									<th>Ngày bắt đầu</th>
									<th>Ngày hết hạn</th>
									<th>Trạng thái</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty premiumUsers}">
										<c:forEach var="user" items="${premiumUsers}">
											<tr>
												<td>${user.id}</td>
												<td><strong>${user.fullName}</strong></td>
												<td>${user.username}</td>
												<td><c:choose>
														<c:when test="${user.membershipStartDate != null}">
															<fmt:formatDate value="${user.membershipStartDate}"
																pattern="dd/MM/yyyy" />
														</c:when>
														<c:otherwise>Chưa có</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${user.membershipExpiryDate != null}">
															<fmt:formatDate value="${user.membershipExpiryDate}"
																pattern="dd/MM/yyyy" />
														</c:when>
														<c:otherwise>Chưa có</c:otherwise>
													</c:choose></td>
												<td><span
													class="badge-status ${user.membershipStatus == 'active' ? 'badge-active' : 'badge-inactive'}">
														${user.membershipStatus} </span></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/membership/history/user/${user.id}"
													class="btn btn-sm btn-info"> <i class="fas fa-history"></i>
												</a> <a
													href="${pageContext.request.contextPath}/admin/membership/activate/${user.id}"
													class="btn btn-sm btn-warning"> <i class="fas fa-edit"></i>
												</a>
													<form
														action="${pageContext.request.contextPath}/admin/membership/cancel/${user.id}"
														method="POST" style="display: inline;">
														<button type="submit" class="btn btn-sm btn-danger"
															onclick="return confirm('Hủy thành viên của ${user.fullName}?')">
															<i class="fas fa-ban"></i>
														</button>
													</form></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="7" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có thành viên Premium</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>

				<!-- Danh sách thành viên dùng thử -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-user-clock text-info"></i> Thành viên dùng thử
						</h5>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Họ tên</th>
									<th>Tên đăng nhập</th>
									<th>Ngày đăng ký</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty trialUsers}">
										<c:forEach var="user" items="${trialUsers}">
											<tr>
												<td>${user.id}</td>
												<td><strong>${user.fullName}</strong></td>
												<td>${user.username}</td>
												<td><fmt:formatDate value="${user.createdAt}"
														pattern="dd/MM/yyyy" /></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/membership/activate/${user.id}"
													class="btn btn-sm btn-success"> <i class="fas fa-crown"></i>
														Nâng cấp
												</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có thành viên dùng thử</td>
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