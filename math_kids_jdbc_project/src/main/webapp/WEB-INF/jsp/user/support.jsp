<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Hỗ trợ - Bé Học Toán");
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@mdi/font@7.0.96/css/materialdesignicons.min.css">

<style>
.chat-container {
	max-width: 900px;
	margin: 0 auto;
}

.ticket-list .ticket-item {
	cursor: pointer;
	padding: 15px 20px;
	border-bottom: 1px solid #f0f2f5;
	transition: background 0.3s;
}

.ticket-list .ticket-item:hover {
	background: #f8f9fa;
}

.ticket-list .ticket-item.active {
	background: #e8f0fe;
	border-left: 4px solid #667eea;
}

.ticket-status {
	font-size: 0.75rem;
	font-weight: 600;
	padding: 3px 10px;
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

.chat-box {
	height: 400px;
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

.chat-input-area {
	padding: 15px;
	background: #fff;
	border-radius: 15px;
	border: 1px solid #e8f0fe;
}

.chat-input-area textarea {
	border: none;
	resize: none;
	outline: none;
	width: 100%;
	padding: 10px;
	font-size: 0.95rem;
}

.badge-unread {
	background: #dc3545;
	color: #fff;
	font-size: 0.6rem;
	padding: 2px 8px;
	border-radius: 50%;
	margin-left: 5px;
}

.new-ticket-form {
	background: #fff;
	border-radius: 15px;
	padding: 20px;
	border: 1px solid #e8f0fe;
}

.chat-icon {
	position: fixed;
	bottom: 30px;
	right: 30px;
	width: 60px;
	height: 60px;
	background: linear-gradient(135deg, #667eea, #764ba2);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
	font-size: 1.8rem;
	box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
	cursor: pointer;
	transition: all 0.3s;
	z-index: 999;
	border: none;
}

.chat-icon:hover {
	transform: scale(1.1);
	box-shadow: 0 8px 30px rgba(102, 126, 234, 0.6);
}

.chat-icon .badge {
	position: absolute;
	top: -5px;
	right: -5px;
	background: #dc3545;
	border-radius: 50%;
	padding: 4px 8px;
	font-size: 0.7rem;
}

.chat-window {
	position: fixed;
	bottom: 100px;
	right: 30px;
	width: 400px;
	max-height: 500px;
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
	display: none;
	z-index: 1000;
	flex-direction: column;
	overflow: hidden;
}

.chat-window.active {
	display: flex;
}

.chat-window .chat-header {
	padding: 15px 20px;
	background: linear-gradient(135deg, #667eea, #764ba2);
	color: #fff;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.chat-window .chat-header .close-btn {
	background: none;
	border: none;
	color: #fff;
	font-size: 1.5rem;
	cursor: pointer;
}

.chat-window .chat-messages {
	flex: 1;
	padding: 15px;
	overflow-y: auto;
	max-height: 350px;
	background: #f8f9fa;
}

.chat-window .chat-input {
	padding: 10px 15px;
	border-top: 1px solid #e8f0fe;
	display: flex;
	gap: 10px;
}

.chat-window .chat-input input {
	flex: 1;
	border: none;
	outline: none;
	padding: 8px 12px;
	border-radius: 20px;
	background: #f1f3f5;
}

.chat-window .chat-input button {
	background: linear-gradient(135deg, #667eea, #764ba2);
	color: #fff;
	border: none;
	border-radius: 50%;
	width: 40px;
	height: 40px;
	cursor: pointer;
}

.chat-message-small {
	margin-bottom: 8px;
	font-size: 0.9rem;
}

.chat-message-small.user {
	text-align: right;
}

.chat-message-small .msg-content {
	display: inline-block;
	padding: 8px 14px;
	border-radius: 12px;
	max-width: 85%;
}

.chat-message-small.user .msg-content {
	background: linear-gradient(135deg, #667eea, #764ba2);
	color: #fff;
}

.chat-message-small.admin .msg-content {
	background: #e8f0fe;
	color: #2d3436;
}

.chat-message-small .msg-time {
	font-size: 0.6rem;
	color: #6c757d;
	margin-top: 2px;
}

@media ( max-width : 576px) {
	.chat-window {
		width: 95%;
		right: 2.5%;
		bottom: 80px;
	}
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

	<div class="container py-4">
		<div class="chat-container">
			<h2 class="text-center text-primary font-weight-bold mb-4">
				<i class="fas fa-headset"></i> Hỗ trợ khách hàng
			</h2>

			<div class="row">
				<!-- Danh sách ticket -->
				<div class="col-md-4">
					<div class="card shadow-sm border-0 rounded-lg">
						<div class="card-header bg-white border-0">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="mb-0">
									<i class="fas fa-ticket-alt"></i> Ticket của bạn
								</h5>
								<button class="btn btn-sm btn-primary" onclick="showNewTicket()">
									<i class="fas fa-plus"></i> Mới
								</button>
							</div>
						</div>
						<div class="ticket-list"
							style="max-height: 400px; overflow-y: auto;">
							<c:choose>
								<c:when test="${not empty tickets}">
									<c:forEach var="ticket" items="${tickets}">
										<div class="ticket-item" data-ticket-id="${ticket.ticketId}"
											onclick="loadTicket('${ticket.ticketId}')">
											<div
												class="d-flex justify-content-between align-items-center">
												<div>
													<div class="font-weight-bold">${ticket.subject}</div>
													<small class="text-muted">#${ticket.ticketId}</small>
												</div>
												<span class="ticket-status ${ticket.status}">${ticket.status}</span>
											</div>
											<div class="d-flex justify-content-between mt-1">
												<small class="text-muted"> <fmt:formatDate
														value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm" />
												</small>
												<c:if test="${ticket.messageCount > 0}">
													<span class="badge badge-secondary">${ticket.messageCount}</span>
												</c:if>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="text-center py-4 text-muted">
										<i class="fas fa-inbox" style="font-size: 2rem;"></i>
										<p class="mt-2">Chưa có ticket nào</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<!-- Chat window -->
				<div class="col-md-8">
					<div class="card shadow-sm border-0 rounded-lg" id="chatContainer">
						<div class="card-header bg-white border-0">
							<h5 class="mb-0" id="chatTitle">
								<i class="fas fa-comment-dots text-primary"></i> Chọn ticket để
								bắt đầu
							</h5>
						</div>
						<div class="chat-box" id="chatMessages">
							<div class="text-center text-muted py-5">
								<i class="fas fa-comment" style="font-size: 3rem;"></i>
								<p class="mt-3">Chọn một ticket để xem tin nhắn</p>
								<button class="btn btn-primary btn-sm" onclick="showNewTicket()">
									<i class="fas fa-plus"></i> Tạo ticket mới
								</button>
							</div>
						</div>
						<div class="chat-input-area" id="chatInputArea"
							style="display: none;">
							<div class="d-flex">
								<textarea id="messageInput" class="form-control" rows="2"
									placeholder="Nhập tin nhắn..."></textarea>
								<button class="btn btn-primary ml-2" onclick="sendMessage()">
									<i class="fas fa-paper-plane"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal tạo ticket mới -->
	<div class="modal fade" id="newTicketModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fas fa-plus-circle"></i> Tạo ticket mới
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="newTicketForm">
						<div class="form-group">
							<label>Chủ đề <span class="text-danger">*</span></label> <input
								type="text" id="ticketSubject" class="form-control"
								placeholder="Nhập chủ đề..." required>
						</div>
						<div class="form-group">
							<label>Nội dung <span class="text-danger">*</span></label>
							<textarea id="ticketMessage" class="form-control" rows="4"
								placeholder="Mô tả vấn đề của bạn..." required></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Hủy</button>
					<button type="button" class="btn btn-primary"
						onclick="createTicket()">
						<i class="fas fa-paper-plane"></i> Gửi
					</button>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		var currentTicketId = null;

		function showNewTicket() {
			$('#newTicketModal').modal('show');
			$('#ticketSubject').val('');
			$('#ticketMessage').val('');
		}

		function createTicket() {
			var subject = $('#ticketSubject').val().trim();
			var message = $('#ticketMessage').val().trim();

			if (!subject || !message) {
				alert('Vui lòng nhập đầy đủ thông tin!');
				return;
			}

			$.ajax({
				url : '/support/ticket/create',
				type : 'POST',
				data : {
					subject : subject,
					message : message
				},
				success : function(response) {
					if (response.success) {
						alert('Tạo ticket thành công! Mã ticket: '
								+ response.ticketId);
						location.reload();
					} else {
						alert(response.message);
					}
				},
				error : function() {
					alert('Có lỗi xảy ra!');
				}
			});
		}

		function loadTicket(ticketId) {
			currentTicketId = ticketId;

			// Highlight ticket
			$('.ticket-item').removeClass('active');
			$('.ticket-item[data-ticket-id="' + ticketId + '"]').addClass(
					'active');

			$
					.ajax({
						url : '/support/ticket/' + ticketId + '/messages',
						type : 'GET',
						success : function(response) {
							if (response.success) {
								var ticket = response.ticket;
								var messages = response.messages;

								$('#chatTitle')
										.html(
												'<i class="fas fa-comment-dots text-primary"></i> '
														+ ticket.subject
														+ ' <span class="badge badge-secondary">#'
														+ ticket.ticketId
														+ '</span>');

								var html = '';
								if (messages && messages.length > 0) {
									messages
											.forEach(function(msg) {
												var isUser = msg.senderType === 'user';
												html += '<div class="chat-message ' + msg.senderType + '">';
												html += '  <div class="message-content">'
														+ msg.message
														+ '</div>';
												html += '  <div class="message-time">'
														+ new Date(
																msg.createdAt)
																.toLocaleString()
														+ '</div>';
												html += '</div>';
											});
								} else {
									html = '<div class="text-center text-muted py-4">Chưa có tin nhắn</div>';
								}

								$('#chatMessages').html(html);
								$('#chatMessages').scrollTop(
										$('#chatMessages')[0].scrollHeight);

								$('#chatInputArea').show();
							}
						},
						error : function() {
							alert('Có lỗi xảy ra!');
						}
					});
		}

		function sendMessage() {
			var message = $('#messageInput').val().trim();
			if (!message || !currentTicketId)
				return;

			$('#messageInput').prop('disabled', true);

			$.ajax({
				url : '/support/ticket/' + currentTicketId + '/send',
				type : 'POST',
				data : {
					message : message
				},
				success : function(response) {
					if (response.success) {
						$('#messageInput').val('');
						loadTicket(currentTicketId);
					} else {
						alert(response.message);
					}
					$('#messageInput').prop('disabled', false);
				},
				error : function() {
					alert('Có lỗi xảy ra!');
					$('#messageInput').prop('disabled', false);
				}
			});
		}

		// Enter để gửi tin nhắn
		$('#messageInput').on('keypress', function(e) {
			if (e.which === 13 && !e.shiftKey) {
				e.preventDefault();
				sendMessage();
			}
		});
	</script>

</body>
</html>