<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Quản trị - Bé Học Toán");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle}</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap"
	rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<!-- ===== SIDEBAR ===== -->
			<!-- Include Sidebar -->
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<!-- ===== MAIN CONTENT ===== -->
			<main class="col-md-10 admin-content">

				<!-- Header -->
				<div
					class="admin-header d-flex justify-content-between align-items-center mb-4 flex-wrap">
					<div>
						<h2 class="font-weight-bold text-primary mb-0">
							<i class="fas fa-chart-pie"></i> Bảng điều khiển
						</h2>
						<p class="text-muted mb-0">Quản lý hệ thống Bé Học Toán</p>
					</div>
					<div class="mt-2 mt-sm-0">
						<span class="text-muted"> <i class="far fa-calendar-alt"></i>
							<%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date())%>
						</span>
					</div>
				</div>

				<!-- ===== STATISTICS ===== -->
				<div class="row mb-4">
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card">
							<div class="icon blue">
								<i class="fas fa-school"></i>
							</div>
							<div class="info">
								<div class="label">Lớp học</div>
								<div class="number">${totalGrades}</div>
								<div class="sub">
									<i class="fas fa-check-circle text-success"></i>
									${activeGrades} đang hoạt động
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #28a745;">
							<div class="icon green">
								<i class="fas fa-book"></i>
							</div>
							<div class="info">
								<div class="label">Bài học</div>
								<div class="number">${totalLessons}</div>
								<div class="sub">${totalGrades}lớphọc</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #ffc107;">
							<div class="icon orange">
								<i class="fas fa-question-circle"></i>
							</div>
							<div class="info">
								<div class="label">Câu hỏi</div>
								<div class="number">${totalQuizzes}</div>
								<div class="sub">Trung bình ${totalLessons > 0 ? Math.round(totalQuizzes / totalLessons) : 0}
									câu/bài</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 mb-3">
						<div class="admin-stat-card" style="border-left-color: #6c757d;">
							<div class="icon purple">
								<i class="fas fa-users"></i>
							</div>
							<div class="info">
								<div class="label">Người dùng</div>
								<div class="number">${totalUsers}</div>
								<div class="sub">
									<i class="fas fa-user-graduate"></i> Học sinh
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== QUICK ACTIONS ===== -->
				<div class="row mb-4">
					<div class="col-12">
						<div class="admin-table-container">
							<div class="header">
								<h5>
									<i class="fas fa-bolt"></i> Thao tác nhanh
								</h5>
							</div>
							<div class="row">
								<div class="col-md-3 col-sm-6 mb-2">
									<a
										href="${pageContext.request.contextPath}/admin/grades/create"
										class="btn btn-primary btn-block"> <i class="fas fa-plus"></i>
										Thêm lớp học
									</a>
								</div>
								<div class="col-md-3 col-sm-6 mb-2">
									<a href="${pageContext.request.contextPath}/admin/lessons/add"
										class="btn btn-success btn-block"> <i class="fas fa-plus"></i>
										Thêm bài học
									</a>
								</div>
								<div class="col-md-3 col-sm-6 mb-2">
									<a href="${pageContext.request.contextPath}/admin/quizzes/add"
										class="btn btn-warning btn-block"> <i class="fas fa-plus"></i>
										Thêm câu hỏi
									</a>
								</div>
								<div class="col-md-3 col-sm-6 mb-2">
									<a href="${pageContext.request.contextPath}/admin/users"
										class="btn btn-info btn-block"> <i class="fas fa-users"></i>
										Quản lý user
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== GRADE LIST ===== -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-school"></i> Danh sách lớp học
						</h5>
						<div class="actions">
							<a href="${pageContext.request.contextPath}/admin/grades"
								class="btn btn-sm btn-primary"> <i
								class="fas fa-arrow-right"></i> Xem tất cả
							</a>
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">#</th>
									<th style="width: 60px;">Icon</th>
									<th>Tên lớp</th>
									<th>Mô tả</th>
									<th style="width: 120px;">Trạng thái</th>
									<th style="width: 120px;">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty grades}">
										<c:forEach var="grade" items="${grades}" varStatus="loop"
											end="4">
											<tr>
												<td>${loop.index + 1}</td>
												<td style="font-size: 1.8rem;">${grade.icon}</td>
												<td><strong>${grade.gradeName}</strong></td>
												<td>${grade.description}</td>
												<td><span
													class="badge-status ${grade.active ? 'badge-active' : 'badge-inactive'}">
														<i
														class="fas ${grade.active ? 'fa-check-circle' : 'fa-times-circle'}"></i>
														${grade.active ? 'Hoạt động' : 'Vô hiệu'}
												</span></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/grades/edit/${grade.id}"
													class="btn btn-sm btn-warning btn-action" title="Sửa">
														<i class="fas fa-edit"></i>
												</a> <a
													href="${pageContext.request.contextPath}/admin/grades/view/${grade.id}"
													class="btn btn-sm btn-info btn-action" title="Xem chi tiết">
														<i class="fas fa-eye"></i>
												</a> <a
													href="${pageContext.request.contextPath}/admin/grades/delete/${grade.id}"
													class="btn btn-sm btn-danger btn-action" title="Xóa"
													onclick="return confirm('Bạn có chắc muốn xóa lớp ${grade.gradeName}?')">
														<i class="fas fa-trash"></i>
												</a></td>
											</tr>
										</c:forEach>
										<c:if test="${grades.size() > 5}">
											<tr>
												<td colspan="6" class="text-center text-muted"><i
													class="fas fa-ellipsis-h"></i> Còn ${grades.size() - 5} lớp
													học khác. <a
													href="${pageContext.request.contextPath}/admin/grades">Xem
														tất cả</a></td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="6" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có lớp học nào</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>

				<!-- ===== LESSON LIST ===== -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-book"></i> Danh sách bài học gần đây
						</h5>
						<div class="actions">
							<a href="${pageContext.request.contextPath}/admin/lessons"
								class="btn btn-sm btn-primary"> <i
								class="fas fa-arrow-right"></i> Xem tất cả
							</a>
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">ID</th>
									<th>Tiêu đề</th>
									<th style="width: 100px;">Lớp</th>
									<th style="width: 100px;">Số câu hỏi</th>
									<th style="width: 130px;">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty lessons}">
										<c:forEach var="lesson" items="${lessons}" varStatus="loop"
											end="4">
											<tr>
												<td>${lesson.id}</td>
												<td><strong>${lesson.title}</strong></td>
												<td><span class="badge badge-info">Lớp
														${lesson.grade}</span></td>
												<td><span class="badge badge-secondary">
														${quizService.countByLessonId(lesson.id)} </span></td>
												<td><a
													href="${pageContext.request.contextPath}/admin/lessons/edit/${lesson.id}"
													class="btn btn-sm btn-warning btn-action" title="Sửa">
														<i class="fas fa-edit"></i>
												</a> <a
													href="${pageContext.request.contextPath}/admin/lessons/delete/${lesson.id}"
													class="btn btn-sm btn-danger btn-action" title="Xóa"
													onclick="return confirm('Xóa bài học này?')"> <i
														class="fas fa-trash"></i>
												</a></td>
											</tr>
										</c:forEach>
										<c:if test="${lessons.size() > 5}">
											<tr>
												<td colspan="5" class="text-center text-muted"><i
													class="fas fa-ellipsis-h"></i> Còn ${lessons.size() - 5}
													bài học khác. <a
													href="${pageContext.request.contextPath}/admin/lessons">Xem
														tất cả</a></td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có bài học nào</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>

				<!-- ===== QUIZ LIST ===== -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-question-circle"></i> Câu hỏi mới nhất
						</h5>
						<div class="actions">
							<a href="${pageContext.request.contextPath}/admin/quizzes"
								class="btn btn-sm btn-primary"> <i
								class="fas fa-arrow-right"></i> Xem tất cả
							</a>
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">ID</th>
									<th>Câu hỏi</th>
									<th style="width: 80px;">Đáp án</th>
									<th style="width: 80px;">Điểm</th>
									<th style="width: 100px;">Bài học</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty quizzes}">
										<c:forEach var="quiz" items="${quizzes}" varStatus="loop"
											end="4">
											<tr>
												<td>${quiz.id}</td>
												<td>${quiz.question}</td>
												<td><span class="badge badge-success">${quiz.correctOption}</span></td>
												<td>${quiz.points}</td>
												<td><span class="badge badge-secondary"> Bài
														${quiz.lessonId} </span></td>
											</tr>
										</c:forEach>
										<c:if test="${quizzes.size() > 5}">
											<tr>
												<td colspan="5" class="text-center text-muted"><i
													class="fas fa-ellipsis-h"></i> Còn ${quizzes.size() - 5}
													câu hỏi khác. <a
													href="${pageContext.request.contextPath}/admin/quizzes">Xem
														tất cả</a></td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có câu hỏi nào</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>

				<!-- ===== USER LIST (Short) ===== -->
				<div class="admin-table-container">
					<div class="header">
						<h5>
							<i class="fas fa-users"></i> Người dùng mới nhất
						</h5>
						<div class="actions">
							<a href="${pageContext.request.contextPath}/admin/users"
								class="btn btn-sm btn-primary"> <i
								class="fas fa-arrow-right"></i> Xem tất cả
							</a>
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th style="width: 50px;">ID</th>
									<th>Họ tên</th>
									<th>Tên đăng nhập</th>
									<th>Email</th>
									<th style="width: 100px;">Vai trò</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty users}">
										<c:forEach var="user" items="${users}" varStatus="loop"
											end="4">
											<tr>
												<td>${user.id}</td>
												<td><strong>${user.fullName}</strong></td>
												<td>${user.username}</td>
												<td>${user.email}</td>
												<td><span
													class="badge ${user.role == 'ADMIN' ? 'badge-danger' : 'badge-info'}">
														${user.role} </span></td>
											</tr>
										</c:forEach>
										<c:if test="${users.size() > 5}">
											<tr>
												<td colspan="5" class="text-center text-muted"><i
													class="fas fa-ellipsis-h"></i> Còn ${users.size() - 5}
													người dùng khác. <a
													href="${pageContext.request.contextPath}/admin/users">Xem
														tất cả</a></td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" class="text-center py-3 text-muted"><i
												class="fas fa-inbox"></i> Chưa có người dùng nào</td>
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

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		$(document)
				.ready(
						function() {
							// Tự động active menu item dựa trên URL
							var currentPath = window.location.pathname;
							$('.admin-sidebar .nav-link')
									.each(
											function() {
												var link = $(this).attr('href');
												if (link === currentPath
														|| (link !== '/'
																&& currentPath
																		.startsWith(link) && link !== '/admin')) {
													$(
															'.admin-sidebar .nav-link')
															.removeClass(
																	'active');
													$(this).addClass('active');
												}
											});

							// Đặc biệt cho dashboard
							if (currentPath === '/admin'
									|| currentPath === '/admin/') {
								$('.admin-sidebar .nav-link').removeClass(
										'active');
								$('.admin-sidebar .nav-link[href="/admin"]')
										.addClass('active');
							}

							// Auto dismiss alerts
							setTimeout(function() {
								$('.alert').alert('close');
							}, 5000);
						});
	</script>

</body>
</html>