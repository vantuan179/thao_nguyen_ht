<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty sessionScope.currentUser}">
	<!-- Chat Widget -->
	<div id="chatWidget"
		style="position: fixed; bottom: 30px; right: 30px; z-index: 9999;">
		<!-- Chat Button -->
		<button id="chatToggle"
			class="btn btn-primary rounded-circle shadow-lg"
			style="width: 60px; height: 60px; font-size: 28px; background: linear-gradient(135deg, #667eea, #764ba2); border: none; box-shadow: 0 5px 25px rgba(102, 126, 234, 0.5); transition: all 0.3s;">
			<i class="fas fa-comment-dots" id="chatIcon"></i>
		</button>

		<!-- Chat Window -->
		<div id="chatWindow"
			style="display: none; position: absolute; bottom: 70px; right: 0; width: 380px; max-width: 90vw; height: 500px; background: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2); overflow: hidden; border: 1px solid rgba(0, 0, 0, 0.05);">

			<!-- Chat Header -->
			<div
				style="background: linear-gradient(135deg, #667eea, #764ba2); padding: 15px 20px; color: #fff; display: flex; justify-content: space-between; align-items: center;">
				<div>
					<i class="fas fa-headset"></i> <span class="font-weight-bold ml-2">Hỗ
						trợ</span>
				</div>
				<button id="chatClose" class="btn btn-sm text-white"
					style="opacity: 0.8; border: none; background: none;">
					<i class="fas fa-times"></i>
				</button>
			</div>

			<!-- Chat Messages -->
			<div id="chatMessages"
				style="height: 360px; overflow-y: auto; padding: 15px; background: #f8f9fa;">
				<div class="text-center text-muted small py-3">
					<i class="fas fa-info-circle"></i> Chọn một cuộc trò chuyện hoặc
					bắt đầu mới
				</div>
			</div>

			<!-- Chat Input -->
			<div
				style="padding: 12px 15px; background: #fff; border-top: 1px solid #e9ecef; display: flex; gap: 10px;">
				<input type="text" id="chatInput" class="form-control"
					placeholder="Nhập tin nhắn..."
					style="border-radius: 25px; border: 2px solid #e9ecef; padding: 8px 15px; flex: 1;">
				<button id="chatSend" class="btn btn-primary rounded-circle"
					style="width: 45px; height: 45px; background: linear-gradient(135deg, #667eea, #764ba2); border: none;">
					<i class="fas fa-paper-plane"></i>
				</button>
			</div>
		</div>
	</div>

	<style>
#chatToggle:hover {
	transform: scale(1.1);
	box-shadow: 0 8px 30px rgba(102, 126, 234, 0.7);
}

#chatWindow {
	animation: slideUp 0.3s ease;
}

@
keyframes slideUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.chat-message {
	animation: fadeIn 0.3s ease;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.typing-indicator {
	display: inline-block;
	padding: 8px 12px;
	background: #e9ecef;
	border-radius: 15px;
	font-size: 0.9rem;
}

.typing-indicator span {
	display: inline-block;
	width: 6px;
	height: 6px;
	background: #6c757d;
	border-radius: 50%;
	margin: 0 2px;
	animation: typing 1.2s infinite;
}

.typing-indicator span:nth-child(2) {
	animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
	animation-delay: 0.4s;
}

@
keyframes typing { 0%, 60%, 100% {
	transform: translateY(0);
	opacity: 0.4;
}
30
%
{
transform
:
translateY(
-5px
);
opacity
:
1;
}
}
</style>

	<!-- Chat JavaScript -->
	<script>
		$(document)
				.ready(
						function() {
							var isOpen = false;
							var currentTicketId = null;

							// Toggle chat window
							$('#chatToggle').click(
									function() {
										isOpen = !isOpen;
										$('#chatWindow').toggle(isOpen);
										if (isOpen) {
											$('#chatIcon').removeClass(
													'fa-comment-dots')
													.addClass('fa-times');
											loadTickets();
										} else {
											$('#chatIcon').removeClass(
													'fa-times').addClass(
													'fa-comment-dots');
										}
									});

							$('#chatClose').click(
									function() {
										isOpen = false;
										$('#chatWindow').hide();
										$('#chatIcon').removeClass('fa-times')
												.addClass('fa-comment-dots');
									});

							// Load tickets list
							function loadTickets() {
								$
										.ajax({
											url : '/api/support/tickets',
											type : 'GET',
											dataType : 'json',
											success : function(data) {
												renderTickets(data);
											},
											error : function() {
												$('#chatMessages')
														.html(
																'<div class="text-center text-muted small py-3"><i class="fas fa-exclamation-triangle"></i> Không thể tải danh sách hỗ trợ</div>');
											}
										});
							}

							// Render tickets
							function renderTickets(tickets) {
								var html = '';
								if (tickets.length === 0) {
									html = '<div class="text-center text-muted small py-3"><i class="fas fa-inbox"></i> Chưa có yêu cầu hỗ trợ</div>';
									html += '<div class="text-center mt-2"><a href="${pageContext.request.contextPath}/support/create" target="_blank" class="btn btn-sm btn-primary">Tạo yêu cầu mới</a></div>';
								} else {
									html = '<div class="list-group list-group-flush">';
									tickets
											.forEach(function(ticket) {
												var statusColor = ticket.status === 'open' ? '#28a745'
														: ticket.status === 'in_progress' ? '#ffc107'
																: '#6c757d';
												html += '<a href="#" class="list-group-item list-group-item-action chat-ticket" data-ticket-id="' + ticket.id + '" style="border-left: 4px solid ' + statusColor + '; padding: 10px 15px;">';
												html += '<div class="d-flex justify-content-between">';
												html += '<strong>'
														+ ticket.subject
														+ '</strong>';
												html += '<small class="text-muted">#'
														+ ticket.id
														+ '</small>';
												html += '</div>';
												html += '<div class="d-flex justify-content-between mt-1">';
												html += '<small class="text-muted">'
														+ ticket.status
														+ '</small>';
												html += '<small class="text-muted">'
														+ new Date(
																ticket.createdAt)
																.toLocaleDateString()
														+ '</small>';
												html += '</div>';
												html += '</a>';
											});
									html += '</div>';
								}
								$('#chatMessages').html(html);

								// Click on ticket
								$('.chat-ticket').click(function(e) {
									e.preventDefault();
									var ticketId = $(this).data('ticket-id');
									loadMessages(ticketId);
								});
							}

							// Load messages for a ticket
							function loadMessages(ticketId) {
								currentTicketId = ticketId;
								$
										.ajax({
											url : '/api/support/tickets/'
													+ ticketId + '/messages',
											type : 'GET',
											dataType : 'json',
											success : function(data) {
												renderMessages(data, ticketId);
											},
											error : function() {
												$('#chatMessages')
														.html(
																'<div class="text-center text-muted small py-3"><i class="fas fa-exclamation-triangle"></i> Không thể tải tin nhắn</div>');
											}
										});
							}

							// Render messages
							function renderMessages(messages, ticketId) {
								var html = '<div class="d-flex justify-content-between align-items-center mb-2">';
								html += '<button class="btn btn-sm btn-outline-secondary" onclick="loadTickets()"><i class="fas fa-arrow-left"></i> Quay lại</button>';
								html += '<small class="text-muted">#'
										+ ticketId + '</small>';
								html += '</div>';

								if (messages.length === 0) {
									html += '<div class="text-center text-muted small py-3">Chưa có tin nhắn</div>';
								} else {
									messages
											.forEach(function(msg) {
												var isUser = msg.senderId === $
												{
													sessionScope.currentUser.id
												}
												;
												html += '<div class="chat-message d-flex '
														+ (isUser ? 'justify-content-end'
																: 'justify-content-start')
														+ ' mb-2">';
												html += '<div style="max-width: 80%; padding: 8px 14px; border-radius: 15px; '
														+ (isUser ? 'background: #667eea; color: #fff; border-bottom-right-radius: 5px;'
																: 'background: #e9ecef; border-bottom-left-radius: 5px;')
														+ '">';
												html += '<div style="font-size: 0.7rem; opacity: 0.7;">'
														+ msg.senderName
														+ '</div>';
												html += '<div>' + msg.message
														+ '</div>';
												html += '<div style="font-size: 0.6rem; opacity: 0.7; text-align: right; margin-top: 2px;">'
														+ new Date(
																msg.createdAt)
																.toLocaleTimeString()
														+ '</div>';
												html += '</div>';
												html += '</div>';
											});
								}

								// Add reply form
								html += '<div style="margin-top: 10px; display: flex; gap: 8px;">';
								html += '<input type="text" id="chatReplyInput" class="form-control form-control-sm" placeholder="Trả lời..." style="border-radius: 20px; flex: 1;">';
								html += '<button class="btn btn-sm btn-primary chat-reply-btn" data-ticket-id="' + ticketId + '" style="border-radius: 20px;"><i class="fas fa-paper-plane"></i></button>';
								html += '</div>';

								$('#chatMessages').html(html);

								// Scroll to bottom
								var container = document
										.getElementById('chatMessages');
								container.scrollTop = container.scrollHeight;

								// Send reply
								$('.chat-reply-btn').click(function() {
									sendMessage(ticketId);
								});
								$('#chatReplyInput').keypress(function(e) {
									if (e.which === 13) {
										sendMessage(ticketId);
									}
								});
							}

							// Send message
							function sendMessage(ticketId) {
								var message = $('#chatReplyInput').val().trim();
								if (!message)
									return;

								$.ajax({
									url : '/api/support/tickets/' + ticketId
											+ '/messages',
									type : 'POST',
									contentType : 'application/json',
									data : JSON.stringify({
										message : message
									}),
									success : function() {
										$('#chatReplyInput').val('');
										loadMessages(ticketId);
									},
									error : function() {
										alert('Không thể gửi tin nhắn!');
									}
								});
							}

							// Send new message (without ticket)
							$('#chatSend')
									.click(
											function() {
												var message = $('#chatInput')
														.val().trim();
												if (!message)
													return;

												// Check if has ticket, if not create new
												if (currentTicketId) {
													sendMessage(currentTicketId);
												} else {
													// Redirect to create ticket page
													window.location.href = '${pageContext.request.contextPath}/support/create?message='
															+ encodeURIComponent(message);
												}
											});

							$('#chatInput').keypress(function(e) {
								if (e.which === 13) {
									$('#chatSend').click();
								}
							});
						});
	</script>
</c:if>