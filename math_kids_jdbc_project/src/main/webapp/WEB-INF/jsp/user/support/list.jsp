<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Hỗ trợ - Bé Học Toán");
%>

<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container py-4">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<div>
			<h2 class="text-primary font-weight-bold">
				<i class="fas fa-headset"></i> Hỗ trợ khách hàng
			</h2>
			<p class="text-muted">Quản lý các yêu cầu hỗ trợ của bạn</p>
		</div>
		<a href="${pageContext.request.contextPath}/support/create"
			class="btn btn-primary btn-fun"> <i class="fas fa-plus"></i> Tạo
			yêu cầu mới
		</a>
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

	<div class="card shadow-sm border-0 rounded-lg">
		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover mb-0">
					<thead class="thead-light">
						<tr>
							<th style="width: 60px;">ID</th>
							<th>Tiêu đề</th>
							<th style="width: 120px;">Trạng thái</th>
							<th style="width: 100px;">Mức độ</th>
							<th style="width: 150px;">Ngày tạo</th>
							<th style="width: 100px;">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty tickets}">
								<c:forEach var="ticket" items="${tickets}">
									<tr>
										<td><strong>#${ticket.id}</strong></td>
										<td><strong>${ticket.subject}</strong> <c:if
												test="${ticket.unreadCount > 0}">
												<span class="badge badge-danger badge-pill ml-2">${ticket.unreadCount}
													mới</span>
											</c:if></td>
										<td><span
											class="badge ${ticket.status == 'open' ? 'badge-success' : ticket.status == 'in_progress' ? 'badge-warning' : 'badge-secondary'}">
												<c:choose>
													<c:when test="${ticket.status == 'open'}">Đang mở</c:when>
													<c:when test="${ticket.status == 'in_progress'}">Đang xử lý</c:when>
													<c:when test="${ticket.status == 'closed'}">Đã đóng</c:when>
													<c:otherwise>${ticket.status}</c:otherwise>
												</c:choose>
										</span></td>
										<td><span
											class="badge ${ticket.priority == 'urgent' ? 'badge-danger' : ticket.priority == 'high' ? 'badge-warning' : 'badge-info'}">
												<c:choose>
													<c:when test="${ticket.priority == 'urgent'}">Khẩn cấp</c:when>
													<c:when test="${ticket.priority == 'high'}">Cao</c:when>
													<c:when test="${ticket.priority == 'normal'}">Bình thường</c:when>
													<c:when test="${ticket.priority == 'low'}">Thấp</c:when>
													<c:otherwise>${ticket.priority}</c:otherwise>
												</c:choose>
										</span></td>
										<td><fmt:formatDate value="${ticket.createdAt}"
												pattern="dd/MM/yyyy HH:mm" /></td>
										<td><a
											href="${pageContext.request.contextPath}/support/${ticket.id}"
											class="btn btn-sm btn-primary"> <i class="fas fa-eye"></i>
												Xem
										</a></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="text-center py-5"><i
										class="fas fa-inbox" style="font-size: 3rem; color: #ccc;"></i>
										<p class="text-muted mt-3">Chưa có yêu cầu hỗ trợ nào</p> <a
										href="${pageContext.request.contextPath}/support/create"
										class="btn btn-primary btn-sm"> <i class="fas fa-plus"></i>
											Tạo yêu cầu đầu tiên
									</a></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>