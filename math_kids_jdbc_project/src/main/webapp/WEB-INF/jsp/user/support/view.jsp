<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Chi tiết yêu cầu hỗ trợ - Bé Học Toán");
%>

<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container py-4">
	<!-- Header -->
	<div
		class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
		<div>
			<a href="${pageContext.request.contextPath}/support"
				class="btn btn-outline-secondary btn-sm"> <i
				class="fas fa-arrow-left"></i> Quay lại
			</a>
			<h3 class="text-primary font-weight-bold mt-2">#${ticket.id} -
				${ticket.subject}</h3>
		</div>
		<div class="mt-2 mt-sm-0">
			<span
				class="badge ${ticket.status == 'open' ? 'badge-success' : ticket.status == 'in_progress' ? 'badge-warning' : 'badge-secondary'}"
				style="font-size: 0.9rem; padding: 8px 16px;"> <c:choose>
					<c:when test="${ticket.status == 'open'}">🟢 Đang mở</c:when>
					<c:when test="${ticket.status == 'in_progress'}">🟡 Đang xử lý</c:when>
					<c:when test="${ticket.status == 'closed'}">🔴 Đã đóng</c:when>
					<c:otherwise>${ticket.status}</c:otherwise>
				</c:choose>
			</span> <span
				class="badge ${ticket.priority == 'urgent' ? 'badge-danger' : ticket.priority == 'high' ? 'badge-warning' : 'badge-info'}"
				style="font-size: 0.9rem; padding: 8px 16px;"> <c:choose>
					<c:when test="${ticket.priority == 'urgent'}">🔥 Khẩn cấp</c:when>
					<c:when test="${ticket.priority == 'high'}">⚡ Cao</c:when>
					<c:when test="${ticket.priority == 'normal'}">📌 Bình thường</c:when>
					<c:when test="${ticket.priority == 'low'}">📎 Thấp</c:when>
					<c:otherwise>${ticket.priority}</c:otherwise>
				</c:choose>
			</span>
		</div>
	</div>

	<!-- Thông báo -->
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

	<!-- Thông tin ticket -->
	<div class="card shadow-sm border-0 rounded-lg mb-3">
		<div class="card-body">
			<div class="row">
				<div class="col-md-4">
					<span class="font-weight-bold text-secondary">Người gửi:</span> <span>${ticket.userName}</span>
				</div>
				<div class="col-md-4">
					<span class="font-weight-bold text-secondary">Email:</span> <span>${ticket.userEmail}</span>
				</div>
				<div class="col-md-4">
					<span class="font-weight-bold text-secondary">Ngày tạo:</span> <span><fmt:formatDate
							value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm" /></span>
				</div>
			</div>
			<div class="row mt-2">
				<div class="col-md-12">
					<span class="font-weight-bold text-secondary">Tiêu đề:</span> <span
						class="font-weight-bold">${ticket.subject}</span>
				</div>
			</div>
		</div>
	</div>

	<!-- Danh sách tin nhắn -->
	<div class="card shadow-sm border-0 rounded-lg">
		<div class="card-header bg-light border-0">
			<h5 class="mb-0">
				<i class="fas fa-comments"></i> Tin nhắn
			</h5>
		</div>
		<div class="card-body p-4"
			style="max-height: 500px; overflow-y: auto;" id="messageContainer">
			<c:choose>
				<c:when test="${not empty messages}">
					<c:forEach var="msg" items="${messages}">
						<div
							class="d-flex ${msg.senderId == ticket.userId ? 'justify-content-start' : 'justify-content-end'} mb-3">
							<div
								class="message-bubble ${msg.senderId == ticket.userId ? 'user' : 'admin'}"
								style="max-width: 75%; padding: 12px 18px; border-radius: 15px; ${msg.senderId == ticket.userId ? 'background: #f8f9fa; border-bottom-left-radius: 5px;' : 'background: #667eea; color: #fff; border-bottom-right-radius: 5px;'}">
								<div class="d-flex justify-content-between align-items-center">
									<strong> <c:choose>
											<c:when test="${msg.senderId == ticket.userId}">
												<i class="fas fa-user"></i> Bạn
                                            </c:when>
											<c:otherwise>
												<i class="fas fa-headset"></i> ${msg.senderName}
                                            </c:otherwise>
										</c:choose>
									</strong> <span class="message-time"
										style="font-size: 0.7rem; opacity: 0.7; margin-left: 10px;">
										<i class="far fa-clock"></i> <fmt:formatDate
											value="${msg.createdAt}" pattern="dd/MM/yyyy HH:mm" />
									</span>
								</div>
								<div class="mt-1" style="white-space: pre-wrap;">${msg.message}</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="text-center py-4 text-muted">
						<i class="fas fa-inbox" style="font-size: 2rem;"></i>
						<p class="mt-2">Chưa có tin nhắn nào</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- Form trả lời -->
	<c:if test="${ticket.status != 'closed'}">
		<div class="card shadow-sm border-0 rounded-lg mt-3">
			<div class="card-body">
				<h6 class="font-weight-bold">
					<i class="fas fa-reply"></i> Trả lời
				</h6>
				<form
					action="${pageContext.request.contextPath}/support/${ticket.id}/send"
					method="POST">
					<div class="form-group">
						<textarea name="message" class="form-control" rows="3"
							placeholder="Nhập tin nhắn của bạn..." required></textarea>
					</div>
					<button type="submit" class="btn btn-primary btn-fun">
						<i class="fas fa-paper-plane"></i> Gửi tin nhắn
					</button>
				</form>
			</div>
		</div>
	</c:if>

	<c:if test="${ticket.status == 'closed'}">
		<div class="alert alert-secondary mt-3">
			<i class="fas fa-info-circle"></i> Yêu cầu này đã được đóng. Bạn
			không thể gửi thêm tin nhắn.
		</div>
	</c:if>
</div>

<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
	$(document).ready(function() {
		// Auto scroll to bottom of messages
		var container = document.getElementById('messageContainer');
		if (container) {
			container.scrollTop = container.scrollHeight;
		}
	});
</script>

</body>
</html>