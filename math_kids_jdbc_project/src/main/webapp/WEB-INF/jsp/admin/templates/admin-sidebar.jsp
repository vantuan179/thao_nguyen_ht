<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Sidebar -->
<nav class="col-md-2 admin-sidebar">
	<div class="admin-sidebar-brand">
		<h4>🧮 Admin</h4>
		<small>Bé Học Toán</small>
	</div>

	<div class="nav-section">Điều hướng</div>
	<a href="${pageContext.request.contextPath}/admin"
		class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}"> <i
		class="fas fa-chart-pie"></i> Tổng quan
	</a>

	<div class="nav-section">Quản lý</div>
	<a href="${pageContext.request.contextPath}/admin/grades"
		class="nav-link ${currentPage == 'grades' ? 'active' : ''}"> <i
		class="fas fa-school"></i> Lớp học <span class="badge">${totalGrades}</span>
	</a> <a href="${pageContext.request.contextPath}/admin/lessons"
		class="nav-link ${currentPage == 'lessons' ? 'active' : ''}"> <i
		class="fas fa-book"></i> Bài học <span class="badge">${totalLessons}</span>
	</a> <a href="${pageContext.request.contextPath}/admin/quizzes"
		class="nav-link ${currentPage == 'quizzes' ? 'active' : ''}"> <i
		class="fas fa-question-circle"></i> Câu hỏi <span class="badge">${totalQuizzes}</span>
	</a> <a href="${pageContext.request.contextPath}/admin/users"
		class="nav-link ${currentPage == 'users' ? 'active' : ''}"> <i
		class="fas fa-users"></i> Người dùng <span class="badge">${totalUsers}</span>
	</a>

	<div class="nav-section">Thành viên</div>
	<a href="${pageContext.request.contextPath}/admin/membership"
		class="nav-link ${currentPage == 'membership' ? 'active' : ''}"> <i
		class="fas fa-crown"></i> Quản lý thành viên <span class="badge">${totalPremium}</span>
	</a> <a href="${pageContext.request.contextPath}/admin/membership/packages"
		class="nav-link ${currentPage == 'membership-packages' ? 'active' : ''}">
		<i class="fas fa-gift"></i> Gói thành viên
	</a> <a href="${pageContext.request.contextPath}/admin/membership/payments"
		class="nav-link ${currentPage == 'membership-payments' ? 'active' : ''}">
		<i class="fas fa-credit-card"></i> Thanh toán <%-- SỬA: Kiểm tra pendingPaymentsCount là Integer --%>
		<c:if
			test="${pendingPaymentsCount != null && pendingPaymentsCount > 0}">
			<span class="badge badge-danger">${pendingPaymentsCount}</span>
		</c:if>
	</a> <a href="${pageContext.request.contextPath}/admin/membership/history"
		class="nav-link ${currentPage == 'membership-history' ? 'active' : ''}">
		<i class="fas fa-history"></i> Lịch sử
	</a>

	<div class="nav-section">Email</div>
	<a href="${pageContext.request.contextPath}/admin/email"
		class="nav-link ${currentPage == 'email' ? 'active' : ''}"> <i
		class="fas fa-envelope"></i> Quản lý Email <span class="badge">${totalEmails}</span>
	</a> <a href="${pageContext.request.contextPath}/admin/email/send"
		class="nav-link ${currentPage == 'email-send' ? 'active' : ''}"> <i
		class="fas fa-paper-plane"></i> Gửi Email
	</a> <a href="${pageContext.request.contextPath}/admin/email/templates"
		class="nav-link ${currentPage == 'email-templates' ? 'active' : ''}">
		<i class="fas fa-file-alt"></i> Mẫu Email
	</a> <a href="${pageContext.request.contextPath}/admin/email/history"
		class="nav-link ${currentPage == 'email-history' ? 'active' : ''}">
		<i class="fas fa-history"></i> Lịch sử
	</a>

	<div class="nav-section">Hệ thống</div>
	<a href="${pageContext.request.contextPath}/" class="nav-link"> <i
		class="fas fa-home"></i> Về trang chủ
	</a> <a href="${pageContext.request.contextPath}/logout" class="nav-link">
		<i class="fas fa-sign-out-alt"></i> Đăng xuất
	</a>
</nav>