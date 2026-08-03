<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
pageContext.setAttribute("pageTitle", "🌈 Bé Học Toán Vui Vẻ - Trang chủ");
pageContext.setAttribute("pageJs", "home.js");
%>

<!-- Include Header -->
<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container">
	<!-- Hero Section -->
	<div class="hero animate__animated animate__bounceIn">
		<h1>🌟 Chào mừng bé đến thế giới Toán học! 🌟</h1>
		<p class="lead mt-3">Học toán thật vui qua những bài học sinh động
			và câu đố thú vị.</p>
		<p class="mt-2">Chọn lớp học của bé để bắt đầu nào!</p>
		<a href="#grades"
			class="btn btn-fun btn-fun-warning mt-3 animate__animated animate__pulse animate__infinite">
			Chọn lớp ngay 🚀 </a>
	</div>

	<!-- Grade Selection Section -->
	<h2 id="grades"
		class="text-center mt-5 mb-4 text-primary font-weight-bold">📚
		Chọn lớp học của bé</h2>

	<div class="row">
		<c:choose>
			<c:when test="${not empty grades}">
				<c:forEach var="grade" items="${grades}" varStatus="loop">
					<div class="col-md-4 col-lg-3 mb-4">
						<div class="lesson-card animate__animated animate__fadeInUp"
							style="animation-delay:${loop.index * 0.1}s">
							<div class="card-body text-center">
								<div class="lesson-icon" style="font-size: 4rem;">
									${grade.icon}</div>
								<h4 class="card-title text-info font-weight-bold">${grade.gradeName}</h4>
								<p class="card-text text-muted" style="font-size: 0.9rem;">${grade.description}</p>
								<div class="mb-2">
									<span class="badge badge-info"> <i class="fas fa-book"></i>
										${grade.lessons != null ? grade.lessons.size() : 0} bài học
									</span>
								</div>
								<a href="${pageContext.request.contextPath}/grades/${grade.id}"
									class="btn btn-fun btn-fun-success"> Vào học 🎒 </a>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="col-12 text-center py-5">
					<div style="font-size: 4rem;">📭</div>
					<h4 class="text-muted mt-3">Chưa có lớp học nào</h4>
					<p class="text-muted">Vui lòng quay lại sau nhé!</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<!-- Features Section -->
	<div class="row mt-5 mb-4">
		<div class="col-md-4">
			<div class="text-center feature-item p-4">
				<i class="fas fa-graduation-cap text-primary"
					style="font-size: 2.5rem;"></i>
				<h5 class="mt-3 font-weight-bold">Học mà chơi</h5>
				<p class="text-muted">Các bài học được thiết kế sinh động, giúp
					bé học toán một cách tự nhiên</p>
			</div>
		</div>
		<div class="col-md-4">
			<div class="text-center feature-item p-4">
				<i class="fas fa-trophy text-warning" style="font-size: 2.5rem;"></i>
				<h5 class="mt-3 font-weight-bold">Thử thách bản thân</h5>
				<p class="text-muted">Nhiều câu đố và bài tập giúp bé rèn luyện
					tư duy toán học</p>
			</div>
		</div>
		<div class="col-md-4">
			<div class="text-center feature-item p-4">
				<i class="fas fa-chart-line text-success" style="font-size: 2.5rem;"></i>
				<h5 class="mt-3 font-weight-bold">Tiến bộ mỗi ngày</h5>
				<p class="text-muted">Theo dõi sự tiến bộ của bé qua từng bài
					học và câu hỏi</p>
			</div>
		</div>
	</div>
</div>

<!-- Đóng main-content -->
</div>

<!-- Include Footer -->
<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Page-specific JavaScript -->
<c:if test="${not empty pageJs}">
	<script src="${pageContext.request.contextPath}/assets/js/${pageJs}"></script>
</c:if>

<script>
	$(document).ready(function() {
		// Smooth scroll to grades section
		$('.hero .btn').click(function(e) {
			e.preventDefault();
			var target = $(this).attr('href');
			$('html, body').animate({
				scrollTop : $(target).offset().top - 80
			}, 800);
		});
	});
</script>

</body>
</html>