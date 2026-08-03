<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${grade != null ? grade.gradeName : 'Lớp học'}- Bé Học
	Toán</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Animate.css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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
<body>

	<div class="container py-4">
		<!-- Grade Header -->
		<div
			class="grade-header text-center py-4 animate__animated animate__fadeInDown">
			<div style="font-size: 5rem;">${grade != null ? grade.icon : '📚'}</div>
			<h1 class="text-primary font-weight-bold mt-2">${grade != null ? grade.gradeName : 'Lớp học'}</h1>
			<p class="text-muted">${grade != null ? grade.description : ''}</p>
			<a href="${pageContext.request.contextPath}/"
				class="btn btn-outline-primary btn-fun"> <i
				class="fas fa-arrow-left"></i> Quay lại trang chủ
			</a>
		</div>

		<!-- Lessons List -->
		<h2 class="text-center mt-4 mb-4 text-info font-weight-bold">
			<i class="fas fa-book"></i> Bài học trong ${grade != null ? grade.gradeName : ''}
		</h2>

		<div class="row">
			<c:choose>
				<c:when test="${not empty lessons}">
					<c:forEach var="lesson" items="${lessons}" varStatus="loop">
						<div class="col-md-6 col-lg-4 mb-4">
							<div class="lesson-card animate__animated animate__fadeInUp"
								style="animation-delay:${loop.index * 0.1}s">
								<div class="card-body text-center">
									<div class="lesson-icon">
										<c:choose>
											<c:when test="${loop.index % 4 == 0}">📖</c:when>
											<c:when test="${loop.index % 4 == 1}">✏️</c:when>
											<c:when test="${loop.index % 4 == 2}">🧮</c:when>
											<c:otherwise>📐</c:otherwise>
										</c:choose>
									</div>
									<h4 class="card-title text-info font-weight-bold">${lesson.title}</h4>
									<p class="card-text text-muted">${lesson.description}</p>
									<a
										href="${pageContext.request.contextPath}/lesson/${lesson.id}"
										class="btn btn-fun btn-fun-primary"> <i
										class="fas fa-play"></i> Học ngay
									</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="col-12 text-center py-5">
						<div style="font-size: 4rem;">📭</div>
						<h4 class="text-muted mt-3">Chưa có bài học nào cho lớp này</h4>
						<p class="text-muted">Vui lòng quay lại sau nhé!</p>
						<a href="${pageContext.request.contextPath}/"
							class="btn btn-fun btn-fun-warning mt-3"> <i
							class="fas fa-arrow-left"></i> Quay lại trang chủ
						</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>