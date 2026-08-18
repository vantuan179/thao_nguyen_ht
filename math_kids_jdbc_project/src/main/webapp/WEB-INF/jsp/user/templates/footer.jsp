<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Đóng main-content -->
</div>

<!-- Footer -->
<footer class="footer" id="footer">
	<div class="container">
		<div class="row">
			<!-- Cột 1: Thông tin trang web -->
			<div class="col-md-3">
				<h5>
					<i class="fas fa-graduation-cap"></i> Bé Học Toán
				</h5>
				<p style="font-size: 0.95rem; color: #0d47a1;">Nền tảng học toán
					trực tuyến dành cho trẻ em từ 4-10 tuổi. Giúp các bé yêu thích môn
					toán thông qua các bài học sinh động và trò chơi thú vị.</p>
				<div class="badge-math mt-2">
					<i class="fas fa-star"></i> Hơn 10.000 học sinh
				</div>
			</div>

			<!-- Cột 2: Liên kết nhanh -->
			<div class="col-md-3">
				<h5>
					<i class="fas fa-link"></i> Liên kết nhanh
				</h5>
				<ul class="list-unstyled">
					<li><i class="fas fa-chevron-right"></i> <a
						href="${pageContext.request.contextPath}/">Trang chủ</a></li>
					<li><i class="fas fa-chevron-right"></i> <a
						href="${pageContext.request.contextPath}/grades">Lớp học</a></li>
					<c:if test="${not empty sessionScope.currentUser}">
						<li><i class="fas fa-chevron-right"></i> <a
							href="${pageContext.request.contextPath}/support">Hỗ trợ</a></li>
					</c:if>
				</ul>
			</div>

			<!-- Cột 3: Hỗ trợ -->
			<div class="col-md-3">
				<h5>
					<i class="fas fa-life-ring"></i> Hỗ trợ
				</h5>
				<ul class="list-unstyled">
					<li><i class="fas fa-chevron-right"></i> <a
						href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
					<li><i class="fas fa-chevron-right"></i> <a
						href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
					<li><i class="fas fa-chevron-right"></i> <a
						href="${pageContext.request.contextPath}/faq">Câu hỏi thường
							gặp</a></li>
					<li><i class="fas fa-chevron-right"></i> <a
						href="${pageContext.request.contextPath}/privacy">Chính sách
							bảo mật</a></li>
					<li><i class="fas fa-chevron-right"></i> <a
						href="${pageContext.request.contextPath}/terms">Điều khoản sử
							dụng</a></li>
				</ul>
			</div>

			<!-- Cột 4: Kết nối và liên hệ -->
			<div class="col-md-3">
				<h5>
					<i class="fas fa-phone"></i> Kết nối với chúng tôi
				</h5>
				<div class="social-icons mb-3">
					<a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
					<a href="#" aria-label="YouTube"><i class="fab fa-youtube"></i></a>
					<a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
					<a href="#" aria-label="Zalo"><i class="fas fa-comment"></i></a>
				</div>
				<ul class="list-unstyled">
					<li><i class="fas fa-envelope"></i> <a
						href="mailto:support@behoctoan.com">support@behoctoan.com</a></li>
					<li><i class="fas fa-phone"></i> <a href="tel:19001234">1900
							1234</a></li>
					<li><i class="fas fa-clock"></i> <span style="color: #0d47a1;">T2-T7:
							8:00 - 20:00</span></li>
				</ul>
			</div>
		</div>

		<!-- Phân chia -->
		<div class="footer-bottom text-center">
			<div class="row">
				<div class="col-md-6 text-md-left">
					<p>
						© 2024 <strong>Bé Học Toán</strong>. Tất cả các quyền được bảo
						lưu.
					</p>
				</div>
				<div class="col-md-6 text-md-right">
					<p>
						<i class="fas fa-heart text-danger"></i> Phát triển với tình yêu
						dành cho trẻ em <i class="fas fa-heart text-danger"></i>
					</p>
				</div>
			</div>
		</div>
	</div>
</footer>

<!-- ============================================ -->
<!-- CHAT WIDGET - LUÔN HIỂN THỊ -->
<!-- ============================================ -->
<div class="chat-widget-container">
	<!-- Chat Button -->
	<button class="chat-toggle-btn" id="chatToggle">
		<i class="fas fa-comment-dots"></i> <i class="fas fa-times"></i>
	</button>

	<!-- Chat Window -->
	<div class="chat-window" id="chatWindow">
		<!-- Chat Header -->
		<div class="chat-header">
			<div class="chat-header-title">
				<i class="fas fa-headset"></i> Hỗ trợ
			</div>
			<button class="chat-close-btn" id="chatClose">
				<i class="fas fa-times"></i>
			</button>
		</div>

		<!-- Chat Messages -->
		<div class="chat-messages" id="chatMessages">
			<div class="empty-state">
				<i class="fas fa-info-circle"></i>
				<c:choose>
					<c:when test="${not empty sessionScope.currentUser}">
                        Chào bạn! Chúng tôi sẵn sàng hỗ trợ bạn.
                    </c:when>
					<c:otherwise>
                        Vui lòng <a
							href="${pageContext.request.contextPath}/login"
							style="color: #667eea; font-weight: bold;">đăng nhập</a> để sử dụng tính năng hỗ trợ.
                    </c:otherwise>
				</c:choose>
			</div>
		</div>

		<!-- Chat Input -->
		<div class="chat-input-area">
			<c:choose>
				<c:when test="${not empty sessionScope.currentUser}">
					<input type="text" id="chatInput" class="form-control"
						placeholder="Nhập tin nhắn...">
					<button class="chat-send-btn" id="chatSend">
						<i class="fas fa-paper-plane"></i>
					</button>
				</c:when>
				<c:otherwise>
					<input type="text" id="chatInput" class="form-control"
						placeholder="Vui lòng đăng nhập để chat..." disabled>
					<button class="chat-send-btn" id="chatSend" disabled
						style="opacity: 0.5; cursor: not-allowed;">
						<i class="fas fa-paper-plane"></i>
					</button>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<!-- ============================================ -->
<!-- SCRIPTS -->
<!-- ============================================ -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Footer Animation -->
<script>
    $(document).ready(function() {
        function checkFooterVisibility() {
            var footer = $('.footer');
            var windowHeight = $(window).height();
            var scrollY = $(window).scrollTop();
            var footerOffset = footer.offset().top;
            
            if (scrollY + windowHeight > footerOffset + 100) {
                footer.addClass('visible');
            }
        }
        
        $(window).on('scroll', function() {
            checkFooterVisibility();
            
            // Scroll to top button
            if ($(window).scrollTop() > 300) {
                $('#scrollTopBtn').addClass('visible');
            } else {
                $('#scrollTopBtn').removeClass('visible');
            }
        });
        
        checkFooterVisibility();
        
        // Scroll to top
        $('#scrollTopBtn').click(function() {
            $('html, body').animate({
                scrollTop: 0
            }, 600);
        });
    });
</script>

<!-- Chat JavaScript -->
<script>
    $(document).ready(function() {
        var isOpen = false;
        var currentTicketId = null;
        var isLoggedIn = ${not empty sessionScope.currentUser};
        var userId = ${not empty sessionScope.currentUser ? sessionScope.currentUser.id : 0};
        var userFullName = '${not empty sessionScope.currentUser ? sessionScope.currentUser.fullName : ""}';
        
        // Toggle chat window
        $('#chatToggle').click(function() {
            isOpen = !isOpen;
            $('#chatWindow').toggleClass('open');
            $(this).toggleClass('active');
            if (isOpen && isLoggedIn) {
                loadTickets();
            } else if (isOpen && !isLoggedIn) {
                $('#chatMessages').html('<div class="empty-state"><i class="fas fa-exclamation-triangle"></i> Vui lòng <a href="${pageContext.request.contextPath}/login" style="color: #667eea; font-weight: bold;">đăng nhập</a> để sử dụng tính năng hỗ trợ.</div>');
            }
        });
        
        $('#chatClose').click(function() {
            isOpen = false;
            $('#chatWindow').removeClass('open');
            $('#chatToggle').removeClass('active');
        });
        
        // Load tickets list (only if logged in)
        function loadTickets() {
            if (!isLoggedIn) return;
            
            $.ajax({
                url: '/api/support/tickets',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    renderTickets(data);
                },
                error: function(xhr) {
                    var errorMsg = 'Không thể tải danh sách hỗ trợ';
                    if (xhr.status === 401 || xhr.status === 403) {
                        errorMsg = 'Vui lòng đăng nhập để sử dụng tính năng này';
                    }
                    $('#chatMessages').html('<div class="empty-state"><i class="fas fa-exclamation-triangle"></i> ' + errorMsg + '</div>');
                }
            });
        }
        
        // Render tickets
        function renderTickets(tickets) {
            var html = '';
            if (!tickets || tickets.length === 0) {
                html = '<div class="empty-state"><i class="fas fa-inbox"></i> Chưa có yêu cầu hỗ trợ</div>';
                html += '<div class="text-center mt-2"><a href="${pageContext.request.contextPath}/support/create" target="_blank" class="btn btn-sm btn-primary">Tạo yêu cầu mới</a></div>';
            } else {
                html = '<div style="max-height: 300px; overflow-y: auto;">';
                tickets.forEach(function(ticket) {
                    var statusColor = ticket.status === 'open' ? '#28a745' : ticket.status === 'in_progress' ? '#ffc107' : '#6c757d';
                    var isUnread = ticket.unreadCount > 0;
                    html += '<a href="#" class="chat-ticket-item ' + (isUnread ? 'unread' : '') + '" data-ticket-id="' + ticket.id + '" style="border-left-color: ' + statusColor + ';">';
                    html += '<div class="d-flex justify-content-between">';
                    html += '<span class="ticket-subject">' + ticket.subject + '</span>';
                    if (isUnread) {
                        html += '<span class="unread-badge">' + ticket.unreadCount + '</span>';
                    }
                    html += '</div>';
                    html += '<div class="d-flex justify-content-between">';
                    html += '<span class="ticket-status">' + ticket.status + '</span>';
                    html += '<span class="ticket-date">' + new Date(ticket.createdAt).toLocaleDateString('vi-VN') + '</span>';
                    html += '</div>';
                    html += '</a>';
                });
                html += '</div>';
            }
            $('#chatMessages').html(html);
            
            $('.chat-ticket-item').click(function(e) {
                e.preventDefault();
                var ticketId = $(this).data('ticket-id');
                loadMessages(ticketId);
            });
        }
        
        // Load messages for a ticket
        function loadMessages(ticketId) {
            if (!isLoggedIn) return;
            
            currentTicketId = ticketId;
            $.ajax({
                url: '/api/support/tickets/' + ticketId + '/messages',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    renderMessages(data, ticketId);
                },
                error: function() {
                    $('#chatMessages').html('<div class="empty-state"><i class="fas fa-exclamation-triangle"></i> Không thể tải tin nhắn</div>');
                }
            });
        }
        
        // Render messages
        function renderMessages(messages, ticketId) {
            var html = '<div class="d-flex justify-content-between align-items-center mb-2">';
            html += '<button class="chat-back-btn" onclick="loadTickets()"><i class="fas fa-arrow-left"></i> Quay lại</button>';
            html += '<small class="text-muted">#' + ticketId + '</small>';
            html += '</div>';
            
            if (!messages || messages.length === 0) {
                html += '<div class="empty-state">Chưa có tin nhắn</div>';
            } else {
                messages.forEach(function(msg) {
                    var isUser = msg.senderId === userId;
                    html += '<div class="chat-message d-flex ' + (isUser ? 'justify-content-end' : 'justify-content-start') + '">';
                    html += '<div class="bubble ' + (isUser ? 'user' : 'admin') + '">';
                    html += '<div class="sender">' + (isUser ? 'Bạn' : msg.senderName) + '</div>';
                    html += '<div>' + msg.message + '</div>';
                    html += '<div class="time">' + new Date(msg.createdAt).toLocaleTimeString('vi-VN') + '</div>';
                    html += '</div>';
                    html += '</div>';
                });
            }
            
            // Add reply form
            html += '<div class="chat-reply-area">';
            html += '<input type="text" id="chatReplyInput" class="form-control form-control-sm" placeholder="Trả lời...">';
            html += '<button class="chat-reply-btn" data-ticket-id="' + ticketId + '"><i class="fas fa-paper-plane"></i></button>';
            html += '</div>';
            
            $('#chatMessages').html(html);
            
            // Scroll to bottom
            var container = document.getElementById('chatMessages');
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
            
            $('#chatReplyInput').focus();
        }
        
        // Send message
        function sendMessage(ticketId) {
            if (!isLoggedIn) {
                alert('Vui lòng đăng nhập để sử dụng tính năng này!');
                return;
            }
            
            var message = $('#chatReplyInput').val().trim();
            if (!message) return;
            
            var $btn = $('.chat-reply-btn');
            $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i>');
            
            $.ajax({
                url: '/api/support/tickets/' + ticketId + '/messages',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ message: message }),
                success: function() {
                    $('#chatReplyInput').val('');
                    loadMessages(ticketId);
                },
                error: function() {
                    alert('Không thể gửi tin nhắn! Vui lòng thử lại.');
                },
                complete: function() {
                    $btn.prop('disabled', false).html('<i class="fas fa-paper-plane"></i>');
                }
            });
        }
        
        // Send new message (without ticket)
        $('#chatSend').click(function() {
            if (!isLoggedIn) {
                alert('Vui lòng đăng nhập để sử dụng tính năng này!');
                return;
            }
            
            var message = $('#chatInput').val().trim();
            if (!message) return;
            
            if (currentTicketId) {
                sendMessage(currentTicketId);
                $('#chatInput').val('');
            } else {
                window.location.href = '${pageContext.request.contextPath}/support/create?message=' + encodeURIComponent(message);
            }
        });
        
        $('#chatInput').keypress(function(e) {
            if (e.which === 13) {
                $('#chatSend').click();
            }
        });
    });
</script>

<script>
    $(document).ready(function() {
        // ===== DROPDOWN MANUAL TOGGLE =====
        var dropdownToggle = document.querySelector('.dropdown-toggle');
        var dropdownMenu = document.querySelector('.dropdown-menu');
        
        if (dropdownToggle && dropdownMenu) {
            dropdownToggle.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                // Toggle class 'show' trên dropdown menu
                dropdownMenu.classList.toggle('show');
                
                // Thêm class 'show' cho dropdown toggle
                this.classList.toggle('show');
                
                // Cập nhật aria-expanded
                var expanded = this.getAttribute('aria-expanded') === 'true' ? 'false' : 'true';
                this.setAttribute('aria-expanded', expanded);
            });
            
            // Đóng dropdown khi click ra ngoài
            document.addEventListener('click', function(e) {
                if (!dropdownToggle.contains(e.target) && !dropdownMenu.contains(e.target)) {
                    dropdownMenu.classList.remove('show');
                    dropdownToggle.classList.remove('show');
                    dropdownToggle.setAttribute('aria-expanded', 'false');
                }
            });
        }
    });
</script>

</body>
</html>