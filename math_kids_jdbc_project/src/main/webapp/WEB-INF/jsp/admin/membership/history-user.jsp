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
						<p class="text-muted mb-0">
							Lịch sử giao dịch của <strong>${user != null ? user.fullName : 'Người dùng'}</strong>
						</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<a
							href="${pageContext.request.contextPath}/admin/membership/history"
							class="btn btn-outline-secondary btn-sm"> <i
							class="fas fa-arrow-left"></i> Quay lại
						</a>
					</div>
				</div>

				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>

				<!-- Thông tin user -->
				<c:if test="${user != null}">
					<div class="card shadow-sm border-0 rounded-lg mb-4">
						<div class="card-body">
							<div class="row">
								<div class="col-md-3">
									<span class="font-weight-bold text-secondary">Họ tên:</span> <span
										class="font-weight-bold">${user.fullName}</span>
								</div>
								<div class="col-md-3">
									<span class="font-weight-bold text-secondary">Tên đăng
										nhập:</span> <span>${user.username}</span>
								</div>
								<div class="col-md-3">
									<span class="font-weight-bold text-secondary">Email:</span> <span>${user.email}</span>
								</div>
								<div class="col-md-3">
									<span class="font-weight-bold text-secondary">Loại thành
										viên:</span> <span
										class="badge ${user.membershipType == 'premium' ? 'badge-success' : 'badge-info'}">
										${user.membershipType} </span>
								</div>
							</div>
							<div class="row mt-2">
								<div class="col-md-6">
									<span class="font-weight-bold text-secondary">Ngày bắt
										đầu:</span> <span> <c:choose>
											<c:when test="${user.membershipStartDate != null}">
												<fmt:formatDate value="${user.membershipStartDate}"
													pattern="dd/MM/yyyy" />
											</c:when>
											<c:otherwise>Chưa có</c:otherwise>
										</c:choose>
									</span>
								</div>
								<div class="col-md-6">
									<span class="font-weight-bold text-secondary">Ngày hết
										hạn:</span> <span> <c:choose>
											<c:when test="${user.membershipExpiryDate != null}">
												<fmt:formatDate value="${user.membershipExpiryDate}"
													pattern="dd/MM/yyyy" />
											</c:when>
											<c:otherwise>Chưa có</c:otherwise>
										</c:choose>
									</span>
								</div>
							</div>
						</div>
					</div>
				</c:if>

				<!-- Danh sách lịch sử -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-list"></i> Danh sách giao dịch
						</h5>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Hành động</th>
									<th>Gói</th>
									<th>Số tháng</th>
									<th>Số tiền</th>
									<th>Trạng thái</th>
									<th>Ngày tạo</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty history}">
										<c:forEach var="item" items="${history}">
											<tr>
												<td>#${item.id}</td>
												<td><span
													class="badge ${item.actionType == 'REGISTER' ? 'badge-success' : item.actionType == 'RENEW' ? 'badge-info' : 'badge-danger'}">
														${item.actionType} </span></td>
												<td>${item.packageType}</td>
												<td>${item.packageMonths}</td>
												<td><c:choose>
														<c:when test="${item.amount != null}">
															<fmt:formatNumber value="${item.amount}" pattern="#,##0" /> đ
                                                    </c:when>
														<c:otherwise>0 đ</c:otherwise>
													</c:choose></td>
												<td><span
													class="badge ${item.paymentStatus == 'completed' ? 'badge-success' : item.paymentStatus == 'pending' ? 'badge-warning' : 'badge-danger'}">
														${item.paymentStatus} </span></td>
												<td><fmt:formatDate value="${item.createdAt}"
														pattern="dd/MM/yyyy HH:mm" /></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="7" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có lịch sử giao dịch</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>

				<!-- Nút quay lại -->
				<div class="text-center mt-3">
					<a
						href="${pageContext.request.contextPath}/admin/membership/history"
						class="btn btn-outline-secondary"> <i
						class="fas fa-arrow-left"></i> Quay lại lịch sử
					</a> <a
						href="${pageContext.request.contextPath}/admin/membership/activate/${user.id}"
						class="btn btn-success"> <i class="fas fa-crown"></i> Gia hạn
						thành viên
					</a>
				</div>

			</main>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>