<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle != null ? pageTitle : '🌈 Bé Học Toán Vui Vẻ'}</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Animate.css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap"
	rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">

<!-- Page-specific CSS -->
<c:if test="${not empty pageCss}">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/assets/css/${pageCss}">
</c:if>
</head>
<body>
	<!-- Floating Shapes -->
	<div class="floating-shape" style="top: 10%; left: 5%"></div>
	<div class="floating-shape"
		style="top: 60%; right: 8%; animation-delay: 2s"></div>
	<div class="floating-shape"
		style="bottom: 10%; left: 15%; animation-delay: 4s"></div>

	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg navbar-light navbar-custom container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">🧮
			Bé Học Toán</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/">Trang chủ</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/grades">Lớp học</a></li>

				<!-- Support Link - Chỉ hiện khi đã đăng nhập -->
				<c:if test="${not empty sessionScope.currentUser}">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/support"> <i
							class="fas fa-headset"></i> Hỗ trợ
					</a></li>
				</c:if>

				<c:choose>
					<c:when test="${not empty sessionScope.currentUser}">
						<li class="nav-item"><span
							class="nav-link text-success font-weight-bold"> 👋
								${sessionScope.currentUser.fullName} </span></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
						<li class="nav-item"><a
							class="nav-link btn btn-fun btn-fun-primary text-white px-3"
							href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>

	<!-- Main Content Wrapper -->
	<div class="main-content">