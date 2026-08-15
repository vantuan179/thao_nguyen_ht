<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Gói thành viên - Admin");
pageContext.setAttribute("currentPage", "membership-packages");
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
							<i class="fas fa-gift"></i> Gói thành viên
						</h2>
						<p class="text-muted mb-0">Quản lý các gói thành viên</p>
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

				<div class="admin-table-container">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>Tên gói</th>
									<th>Loại</th>
									<th>Số tháng</th>
									<th>Giá</th>
									<th>Trạng thái</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty packages}">
										<c:forEach var="pkg" items="${packages}">
											<tr>
												<td>${pkg.id}</td>
												<td><strong>${pkg.packageName}</strong></td>
												<td><span class="badge badge-info">${pkg.packageType}</span></td>
												<td>${pkg.months}</td>
												<td><c:choose>
														<c:when test="${pkg.price != null}">
															<fmt:formatNumber value="${pkg.price}" pattern="#,##0" /> đ
                                                    </c:when>
														<c:otherwise>0 đ</c:otherwise>
													</c:choose></td>
												<td><span
													class="badge ${pkg.active ? 'badge-success' : 'badge-secondary'}">
														${pkg.active ? 'Hoạt động' : 'Vô hiệu'} </span></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/membership/packages/edit/${pkg.id}"
													class="btn btn-sm btn-warning"> <i class="fas fa-edit"></i>
												</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="7" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có gói thành viên nào</td>
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