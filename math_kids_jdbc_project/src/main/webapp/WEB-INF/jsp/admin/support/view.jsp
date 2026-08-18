<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Chi tiết ticket - Admin");
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

<style>
.ticket-status {
	font-size: 0.8rem;
	font-weight: 600;
	padding: 4px 12px;
	border-radius: 20px;
}

.ticket-status.open {
	background: #d4edda;
	color: #155724;
}

.ticket-status.in_progress {
	background: #fff3cd;
	color: #856404;
}

.ticket-status.resolved {
	background: #cce5ff;
	color: #004085;
}

.ticket-status.closed {
	background: #e2e3e5;
	color: #383d41;
}

.chat-messages {
	max-height: 400px;
	overflow-y: auto;
	padding: 20px;
	background: #f8f9fa;
	border-radius: 15px;
}

.chat-message {
	margin-bottom: 15px;
	max-width: 80%;
}

.chat-message.user {
	margin-left: auto;
}

.chat-message.admin {
	margin-right: auto;
}

.chat-message .message-content {
	padding: 12px 18px;
	border-radius: 15px;
	word-wrap: break-word;
}

.chat-message.user .message-content {
	background: linear-gradient(135deg, #667eea, #764ba2);
	color: #fff;
}

.chat-message.admin .message-content {
	background: #fff;
	border: 1px solid #e8f0fe;
	color: #2d3436;
}

.chat-message .message-time {
	font-size: 0.7rem;
	color: #6c757d;
	margin-top: 5px;
}

.chat-message.user .message-time {
	text-align: right;
}
</style>
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<main class="col-md-10 admin-content">
				<div style="max-width: 900px; margin: 0 auto;">
					<div
						class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
						<div>
							<h2 class="font-weight-bold text-primary mb-0">
								<i class="fas fa-ticket-alt"></i> Chi tiết ticket
							</h2>
							<p class="text-muted mb-0">#${ticket.ticketId} -
								${ticket.userName}</p>
						</div>
						<div class="mt-2 mt-sm-0">
							<a href="${pageContext.request.contextPath}/admin/support"
								class="btn btn-outline-secondary btn-sm"> <i
								class="fas fa-arrow-left"></i> Quay lại
							</a>
						</div>
					</div>

					<!-- Thông tin ticket -->
					<div class="card shadow-sm border-0 rounded-lg mb-4">
						<div class="card-body">
							<div class="row">
								<div class="col-md-6">
									<span class="font-weight-bold text-secondary">Chủ đề:</span> <span
										class="font-weight-bold">${ticket.subject}</span>
								</div>
								<div class="col-md-3">
									<span class="font-weight-bold text-secondary">Trạng
										thái:</span> <span class="ticket-status ${ticket.status}">${ticket.status}</span>
								</div>
								<div class="col-md-3">
									<span class="font-weight-bold text-secondary">Người
										dùng:</span> <span>${ticket.userName}</span>
								</div>
							</div>
							<div class="row mt-2">
								<div class="col-md-6">
									<span class="font-weight-bold text-secondary">Ngày tạo:</span>
									<span><fmt:formatDate value="${ticket.createdAt}"
											pattern="dd/MM/yyyy HH:mm" /></span>
								</div>
								<div class="col-md-6">
									<span class="font-weight-bold text-secondary">Cập nhật:</span>
									<span><fmt:formatDate value="${ticket.updatedAt}"
											pattern="dd/MM/yyyy HH:mm" /></span>
								</div>
							</div>
						</div>
					</div>

					<!-- Tin nhắn -->
					<div class="card shadow-sm border-0 rounded-lg mb-4">
						<div class="card-header bg-white border-0">
							<h5 class="mb-0">
								<i class="fas fa-comment-dots"></i> Tin nhắn
							</h5>
						</div>
						<div class="chat-messages" id="chatMessages">
							<c:choose>
								<c:when test="${not empty messages}">
									<c:forEach var="msg" items="${messages}">
										<div class="chat-message ${msg.senderType}">
											<div class="message-content">
												<div class="font-weight-bold small">${msg.senderType == 'user' ? msg.senderName : 'Admin'}
												</div>
												${msg.message}
											</div>
											<div class="message-time">
												<fmt:formatDate value="${msg.createdAt}"
													pattern="dd/MM/yyyy HH:mm" />
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="text-center text-muted py-4">
										<i class="fas fa-inbox" style="font-size: 2rem;"></i>
										<p class="mt-2">Chưa có tin nhắn</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<!-- Trả lời -->
					<div class="card shadow-sm border-0 rounded-lg">
						<div class="card-header bg-white border-0">
							<h5 class="mb-0">
								<i class="fas fa-reply"></i> Trả lời
							</h5>
						</div>
						<div class="card-body">
							<div class="form-group">
								<textarea id="replyMessage" class="form-control" rows="3"
									placeholder="Nhập câu trả lời..."></textarea>
							</div>
							<div class="d-flex justify-content-between">
								<div>
									<select id="statusSelect" class="form-control"
										style="width: auto; display: inline-block;">
										<option value="open"
											${ticket.status == 'open' ? 'selected' : ''}>Mở</option>
										<option value="in_progress"
											${ticket.status == 'in_progress' ? 'selected' : ''}>Đang
											xử lý</option>
										<option value="resolved"
											${ticket.status == 'resolved' ? 'selected' : ''}>Đã
											giải quyết</option>
										<option value="closed"
											${ticket.status == 'closed' ? 'selected' : ''}>Đóng</option>
									</select>
								</div>
								<div>
									<button class="btn btn-success" onclick="sendReply()">
										<i class="fas fa-paper-plane"></i> Gửi trả lời
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>

			</main>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		function sendReply() {
			var message = $('#replyMessage').val().trim();
			var status = $('#statusSelect').val();
			var ticketId = '${ticket.ticketId}';

			if (!message) {
				alert('Vui lòng nhập nội dung trả lời!');
				return;
			}

			$.ajax({
				url : '/admin/support/ticket/' + ticketId + '/reply',
				type : 'POST',
				data : {
					message : message
				},
				success : function(response) {
					if (response.success) {
						// Cập nhật trạng thái
						$.ajax({
							url : '/admin/support/ticket/' + ticketId
									+ '/status',
							type : 'POST',
							data : {
								status : status
							},
							success : function(statusResponse) {
								if (statusResponse.success) {
									location.reload();
								} else {
									alert(statusResponse.message);
								}
							}
						});
					} else {
						alert(response.message);
					}
				},
				error : function() {
					alert('Có lỗi xảy ra!');
				}
			});
		}

		// Enter để gửi
		$('#replyMessage').on('keypress', function(e) {
			if (e.which === 13 && !e.shiftKey) {
				e.preventDefault();
				sendReply();
			}
		});
	</script>

</body>
</html>