<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.kidsmath.util.AdSenseUtil"%>

<%
String pageTitle = "Lớp học - Bé Học Toán";
Object gradeObj = request.getAttribute("grade");
if (gradeObj != null) {
	com.kidsmath.model.Grade grade = (com.kidsmath.model.Grade) gradeObj;
	if (grade.getGradeName() != null) {
		pageTitle = grade.getGradeName() + " - Bé Học Toán";
	}
}
pageContext.setAttribute("pageTitle", pageTitle);

com.kidsmath.model.User currentUser = (com.kidsmath.model.User) session.getAttribute("currentUser");
boolean showAds = AdSenseUtil.shouldShowAds(currentUser);
pageContext.setAttribute("showAds", showAds);
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
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

	<c:if test="${showAds}">
		<!-- ===== CÓ QUẢNG CÁO ===== -->
		<div class="container-fluid px-0">
			<div class="row no-gutters">
				<!-- Left Ad -->
				<div class="col-lg-2 d-none d-lg-block"
					style="padding-left: 0; padding-right: 0;">
					<div class="ad-outer-left">
						<div class="ad-container-outer">
							<span class="ad-label">Quảng cáo</span>
							<ins class="adsbygoogle"
								style="display: block; width: 160px; height: 600px;"
								data-ad-client="ca-pub-YOUR_PUBLISHER_ID"
								data-ad-slot="YOUR_AD_SLOT_LEFT" data-ad-format="rectangle"></ins>
							<script>
								(adsbygoogle = window.adsbygoogle || [])
										.push({});
							</script>
						</div>
					</div>
				</div>

				<!-- Main Content -->
				<div class="col-lg-8">
					<div class="container py-4">
						<!-- Grade Header -->
						<div
							class="grade-header text-center py-4 animate__animated animate__fadeInDown">
							<div style="font-size: 5rem;">${grade != null ? grade.icon : '📚'}</div>
							<h1 class="text-primary font-weight-bold mt-2">${grade != null ? grade.gradeName : 'Lớp học'}</h1>
							<p class="text-muted">${grade != null ? grade.description : ''}</p>

							<c:if test="${isTrial && isLoggedIn}">
								<div class="alert alert-info mt-3">
									<i class="fas fa-info-circle"></i> Bạn đang sử dụng gói <strong>Dùng
										thử</strong>. Chỉ có thể xem <strong>1 bài học đầu tiên</strong> của
									mỗi lớp. <a
										href="${pageContext.request.contextPath}/membership/packages"
										class="alert-link">Nâng cấp ngay</a>
								</div>
							</c:if>

							<c:if test="${!isLoggedIn}">
								<div class="alert alert-warning mt-3">
									<i class="fas fa-exclamation-triangle"></i> Vui lòng <a
										href="${pageContext.request.contextPath}/login"
										class="alert-link">đăng nhập</a> để xem nội dung bài học.
								</div>
							</c:if>

							<a href="${pageContext.request.contextPath}/"
								class="btn btn-outline-primary btn-fun mt-2"> <i
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

													<c:choose>
														<c:when test="${isTrial && loop.index > 0}">
															<div class="mb-2">
																<span class="badge badge-secondary"> <i
																	class="fas fa-lock"></i> Cần nâng cấp
																</span>
															</div>
															<a
																href="${pageContext.request.contextPath}/membership/packages"
																class="btn btn-warning btn-fun"> <i
																class="fas fa-crown"></i> Nâng cấp
															</a>
														</c:when>
														<c:when test="${!isLoggedIn}">
															<div class="mb-2">
																<span class="badge badge-secondary"> <i
																	class="fas fa-lock"></i> Cần đăng nhập
																</span>
															</div>
															<a href="${pageContext.request.contextPath}/login"
																class="btn btn-primary btn-fun"> <i
																class="fas fa-sign-in-alt"></i> Đăng nhập
															</a>
														</c:when>
														<c:otherwise>
															<a
																href="${pageContext.request.contextPath}/lesson/${lesson.id}"
																class="btn btn-fun btn-fun-primary"> <i
																class="fas fa-play"></i> Học ngay
															</a>
														</c:otherwise>
													</c:choose>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="col-12 text-center py-5">
										<div style="font-size: 4rem;">📭</div>
										<h4 class="text-muted mt-3">Chưa có bài học nào cho lớp
											này</h4>
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
				</div>

				<!-- Right Ad -->
				<div class="col-lg-2 d-none d-lg-block"
					style="padding-left: 0; padding-right: 0;">
					<div class="ad-outer-right">
						<div class="ad-container-outer">
							<span class="ad-label">Quảng cáo</span>
							<ins class="adsbygoogle"
								style="display: block; width: 160px; height: 600px;"
								data-ad-client="ca-pub-YOUR_PUBLISHER_ID"
								data-ad-slot="YOUR_AD_SLOT_RIGHT" data-ad-format="rectangle"></ins>
							<script>
								(adsbygoogle = window.adsbygoogle || [])
										.push({});
							</script>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<c:if test="${!showAds}">
		<!-- ===== KHÔNG QUẢNG CÁO (PREMIUM) ===== -->
		<div class="container py-4">
			<!-- Grade Header -->
			<div
				class="grade-header text-center py-4 animate__animated animate__fadeInDown">
				<div style="font-size: 5rem;">${grade != null ? grade.icon : '📚'}</div>
				<h1 class="text-primary font-weight-bold mt-2">${grade != null ? grade.gradeName : 'Lớp học'}</h1>
				<p class="text-muted">${grade != null ? grade.description : ''}</p>

				<c:if test="${isTrial && isLoggedIn}">
					<div class="alert alert-info mt-3">
						<i class="fas fa-info-circle"></i> Bạn đang sử dụng gói <strong>Dùng
							thử</strong>. Chỉ có thể xem <strong>1 bài học đầu tiên</strong> của mỗi
						lớp. <a
							href="${pageContext.request.contextPath}/membership/packages"
							class="alert-link">Nâng cấp ngay</a>
					</div>
				</c:if>

				<c:if test="${!isLoggedIn}">
					<div class="alert alert-warning mt-3">
						<i class="fas fa-exclamation-triangle"></i> Vui lòng <a
							href="${pageContext.request.contextPath}/login"
							class="alert-link">đăng nhập</a> để xem nội dung bài học.
					</div>
				</c:if>

				<a href="${pageContext.request.contextPath}/"
					class="btn btn-outline-primary btn-fun mt-2"> <i
					class="fas fa-arrow-left"></i> Quay lại trang chủ
				</a>
			</div>

			<!-- Lessons List -->
			<h2 class="text-center mt-4 mb-4 text-info font-weight-bold">
				<i class="fas fa-book"></i> Bài học trong ${grade != null ? grade.gradeName : ''}
			</h2>

			<div class="row">
				<!-- Nội dung lessons -->
			</div>
		</div>
	</c:if>

	<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>