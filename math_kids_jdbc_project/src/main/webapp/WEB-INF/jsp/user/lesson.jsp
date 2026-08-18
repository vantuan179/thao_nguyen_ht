<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.kidsmath.util.AdSenseUtil"%>

<%
// Kiểm tra lesson có tồn tại không trước khi dùng
String pageTitle = "Bài học - Bé Học Toán";
Object lessonObj = request.getAttribute("lesson");
if (lessonObj != null) {
	com.kidsmath.model.Lesson lesson = (com.kidsmath.model.Lesson) lessonObj;
	pageTitle = lesson.getTitle() + " - Bé Học Toán";
}
pageContext.setAttribute("pageTitle", pageTitle);
pageContext.setAttribute("pageJs", "lesson.js");

// Kiểm tra hiển thị quảng cáo
com.kidsmath.model.User currentUser = (com.kidsmath.model.User) session.getAttribute("currentUser");
boolean showAds = AdSenseUtil.shouldShowAds(currentUser);
boolean isPremium = AdSenseUtil.isPremium(currentUser);

pageContext.setAttribute("showAds", showAds);
pageContext.setAttribute("isPremium", isPremium);
pageContext.setAttribute("isLoggedIn", currentUser != null);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle}</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Animate.css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

<!-- Google AdSense -->
<c:if test="${showAds}">
	<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-YOUR_PUBLISHER_ID" crossorigin="anonymous"></script>
</c:if>

<style>
body {
	font-family: 'Quicksand', sans-serif;
	background: linear-gradient(135deg, #fff1eb 0%, #ace0f9 100%);
	min-height: 100vh;
}

.lesson-box {
	background: #fff;
	border-radius: 30px;
	padding: 35px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
}

.quiz-card {
	background: #fff;
	border-radius: 25px;
	padding: 25px;
	margin-bottom: 25px;
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
	border-left: 8px solid #e8f0fe;
	transition: none !important;
}

.quiz-card:hover, .quiz-card:focus, .quiz-card:active {
	transform: none !important;
	transition: none !important;
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08) !important;
}

.quiz-card.selected {
	background: #f0f7ff !important;
	border-left-color: #667eea !important;
	border-left-width: 10px !important;
	box-shadow: 0 4px 15px rgba(102, 126, 234, 0.15) !important;
}

.quiz-card.selected h4 {
	color: #4a6cf7 !important;
}

.quiz-card.answered-correct {
	background: #e8f5e9 !important;
	border-left-color: #28a745 !important;
	border-left-width: 10px !important;
}

.quiz-card.answered-wrong {
	background: #fce4ec !important;
	border-left-color: #dc3545 !important;
	border-left-width: 10px !important;
}

.quiz-card.answered-skipped {
	background: #fff8e1 !important;
	border-left-color: #ffc107 !important;
	border-left-width: 10px !important;
}

.option-btn {
	border-radius: 15px;
	font-size: 1.1rem;
	font-weight: 600;
	padding: 14px 20px;
	margin: 6px 0;
	transition: all 0.3s;
	border: 3px solid #e8f0fe;
	background: #f8f9fa;
	cursor: pointer;
	width: 100%;
	text-align: left;
}

.option-btn:hover:not(.disabled) {
	transform: translateY(-2px);
	background: #e8f0fe;
	border-color: #667eea;
	box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
}

.option-btn.selected-option {
	border-color: #667eea;
	background: #e8f0fe;
	box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3);
}

.option-btn.disabled {
	cursor: not-allowed;
	opacity: 0.7;
}

.option-btn.correct {
	background: #d4edda;
	border-color: #28a745;
	color: #155724;
}

.option-btn.correct:hover {
	background: #d4edda;
	transform: none;
}

.option-btn.wrong {
	background: #f8d7da;
	border-color: #dc3545;
	color: #721c24;
}

.option-btn.wrong:hover {
	background: #f8d7da;
	transform: none;
}

.option-btn.skipped {
	background: #fff3cd;
	border-color: #ffc107;
	color: #856404;
}

.option-btn .option-label {
	display: inline-block;
	width: 30px;
	height: 30px;
	line-height: 30px;
	text-align: center;
	border-radius: 50%;
	background: #667eea;
	color: #fff;
	font-weight: 700;
	margin-right: 10px;
}

.option-btn.selected-option .option-label {
	background: #4a6cf7;
}

.option-btn.correct .option-label {
	background: #28a745;
}

.option-btn.wrong .option-label {
	background: #dc3545;
}

.option-btn.skipped .option-label {
	background: #ffc107;
	color: #856404;
}

.score-board {
	position: fixed;
	top: 20px;
	right: 20px;
	background: #fff;
	border-radius: 20px;
	padding: 15px 25px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
	font-weight: 700;
	z-index: 1000;
	border: 2px solid #e8f0fe;
}

.score-board .score-item {
	display: inline-block;
	margin: 0 10px;
}

.feedback {
	font-size: 1.1rem;
	font-weight: 600;
	min-height: 35px;
	padding: 10px;
	border-radius: 10px;
	margin-top: 10px;
}

.feedback.correct {
	color: #155724;
	background: #d4edda;
}

.feedback.wrong {
	color: #721c24;
	background: #f8d7da;
}

.feedback.skipped {
	color: #856404;
	background: #fff3cd;
}

.confirm-btn-wrapper {
	text-align: center;
	padding: 20px 0 10px 0;
}

.btn-confirm-answer {
	border-radius: 50px;
	padding: 15px 50px;
	font-size: 1.2rem;
	font-weight: 700;
	background: linear-gradient(135deg, #667eea, #764ba2);
	color: #fff;
	border: none;
	box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
	transition: all 0.3s ease;
	opacity: 1;
	cursor: pointer;
}

.btn-confirm-answer:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 30px rgba(102, 126, 234, 0.6);
}

.btn-confirm-answer:disabled {
	opacity: 0.5;
	cursor: not-allowed;
	transform: none;
}

.btn-confirm-answer:disabled:hover {
	transform: none;
	box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
}

.btn-confirm-answer.loading {
	opacity: 0.7;
	cursor: wait;
}

.btn-check-all {
	border-radius: 50px;
	padding: 15px 40px;
	font-size: 1.1rem;
	font-weight: 700;
	background: linear-gradient(135deg, #f093fb, #f5576c);
	color: #fff;
	border: none;
	box-shadow: 0 5px 20px rgba(245, 87, 108, 0.4);
	transition: all 0.3s ease;
}

.btn-check-all:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 30px rgba(245, 87, 108, 0.6);
}

.btn-check-all:disabled {
	opacity: 0.5;
	cursor: not-allowed;
	transform: none;
}

.question-status {
	display: inline-block;
	width: 12px;
	height: 12px;
	border-radius: 50%;
	margin-left: 10px;
}

.question-status.unanswered {
	background: #e8f0fe;
}

.question-status.answered-correct {
	background: #28a745;
}

.question-status.answered-wrong {
	background: #dc3545;
}

.question-status.answered-skipped {
	background: #ffc107;
}

.progress-bar-custom {
	height: 8px;
	border-radius: 10px;
	background-color: #e9ecef;
	overflow: hidden;
	margin-top: 15px;
}

.progress-bar-custom .progress-fill {
	height: 100%;
	border-radius: 10px;
	background: linear-gradient(90deg, #28a745, #20c997);
	transition: width 0.5s ease;
	width: 0%;
}

.quiz-card.not-selected {
	border-left-color: #ff6b6b !important;
	background: #fff5f5 !important;
}

#confirmHint {
	min-height: 30px;
}

#confirmHint.empty-hint {
	visibility: hidden;
}

/* ===== ADS POPUP CENTER ===== */
.ad-popup-overlay {
	position: fixed !important;
	top: 0 !important;
	left: 0 !important;
	right: 0 !important;
	bottom: 0 !important;
	width: 100% !important;
	height: 100% !important;
	min-width: 100vw !important;
	min-height: 100vh !important;
	max-width: 100vw !important;
	max-height: 100vh !important;
	background: rgba(0, 0, 0, 0.85) !important;
	z-index: 999999 !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	padding: 20px !important;
	margin: 0 !important;
	overflow: hidden !important;
	box-sizing: border-box !important;
	animation: overlayFadeIn 0.3s ease !important;
}

@
keyframes overlayFadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
keyframes popupSlideIn {from { opacity:0;
	transform: translateY(30px) scale(0.95);
}

to {
	opacity: 1;
	transform: translateY(0) scale(1);
}

}
.ad-popup-content {
	background: #ffffff !important;
	border-radius: 20px !important;
	max-width: 560px !important;
	width: 100% !important;
	padding: 30px !important;
	box-shadow: 0 30px 80px rgba(0, 0, 0, 0.5) !important;
	animation: popupSlideIn 0.4s ease !important;
	position: relative !important;
	max-height: 85vh !important;
	overflow-y: auto !important;
	margin: 0 auto !important;
}

/* Scrollbar cho popup */
.ad-popup-content::-webkit-scrollbar {
	width: 4px;
}

.ad-popup-content::-webkit-scrollbar-track {
	background: #f1f1f1;
	border-radius: 10px;
}

.ad-popup-content::-webkit-scrollbar-thumb {
	background: #667eea;
	border-radius: 10px;
}

.ad-popup-content .ad-close-btn {
	position: absolute !important;
	top: 12px !important;
	right: 15px !important;
	background: none !important;
	border: none !important;
	font-size: 1.2rem !important;
	color: #adb5bd !important;
	cursor: not-allowed !important;
	opacity: 0.3 !important;
	transition: all 0.3s !important;
	padding: 5px 10px !important;
	border-radius: 8px !important;
	z-index: 10 !important;
}

.ad-popup-content .ad-close-btn.active {
	cursor: pointer !important;
	opacity: 1 !important;
	color: #495057 !important;
}

.ad-popup-content .ad-close-btn.active:hover {
	background: #f8d7da !important;
	color: #dc3545 !important;
}

.ad-popup-content .ad-popup-header {
	text-align: center !important;
	margin-bottom: 18px !important;
	padding-right: 30px !important;
}

.ad-popup-content .ad-popup-header .ad-icon {
	font-size: 2rem !important;
	color: #667eea !important;
	display: block !important;
	margin-bottom: 5px !important;
}

.ad-popup-content .ad-popup-header h5 {
	font-weight: 700 !important;
	color: #2d3436 !important;
	margin-bottom: 2px !important;
	font-size: 1.2rem !important;
}

.ad-popup-content .ad-popup-header p {
	font-size: 0.85rem !important;
	color: #6c757d !important;
	margin-bottom: 0 !important;
}

.ad-popup-content .ad-popup-body {
	min-height: 200px !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	background: #fafafa !important;
	border-radius: 12px !important;
	padding: 15px !important;
	margin-bottom: 18px !important;
}

.ad-popup-content .ad-popup-body ins {
	width: 100% !important;
	min-height: 200px !important;
	display: block !important;
}

.ad-popup-content .ad-popup-footer {
	display: flex !important;
	justify-content: space-between !important;
	align-items: center !important;
	flex-wrap: wrap !important;
	gap: 12px !important;
	border-top: 1px solid #f0f2f5 !important;
	padding-top: 16px !important;
}

.ad-popup-content .ad-timer {
	font-size: 0.9rem !important;
	color: #6c757d !important;
}

.ad-popup-content .ad-timer span {
	font-weight: 700 !important;
	color: #667eea !important;
	font-size: 1.1rem !important;
}

.ad-popup-content .ad-actions {
	display: flex !important;
	align-items: center !important;
	gap: 12px !important;
}

.ad-popup-content .ad-countdown-circle {
	position: relative !important;
	width: 44px !important;
	height: 44px !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	flex-shrink: 0 !important;
}

.ad-popup-content .ad-countdown-circle .progress-ring {
	position: absolute !important;
	top: 0 !important;
	left: 0 !important;
	transform: rotate(-90deg) !important;
}

.ad-popup-content .ad-countdown-circle .progress-ring-circle {
	transition: stroke-dashoffset 0.5s ease !important;
}

.ad-popup-content .ad-countdown-circle .countdown-text {
	font-size: 1rem !important;
	font-weight: 700 !important;
	color: #667eea !important;
	z-index: 1 !important;
}

.ad-popup-content .btn-skip-ad {
	border-radius: 50px !important;
	padding: 8px 22px !important;
	font-weight: 700 !important;
	font-size: 0.85rem !important;
	background: #e9ecef !important;
	color: #adb5bd !important;
	border: none !important;
	opacity: 0.5 !important;
	cursor: not-allowed !important;
	transition: all 0.3s !important;
}

.ad-popup-content .btn-skip-ad.active {
	opacity: 1 !important;
	cursor: pointer !important;
	background: linear-gradient(135deg, #28a745, #20c997) !important;
	color: #fff !important;
}

.ad-popup-content .btn-skip-ad.active:hover {
	transform: translateY(-2px) !important;
	box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4) !important;
}

.ad-sidebar {
	position: sticky;
	top: 100px;
}

.ad-sidebar .ad-container {
	background: #f8f9fa;
	border-radius: 10px;
	padding: 15px 10px;
	min-height: 250px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	border: 1px solid #e9ecef;
	margin-bottom: 15px;
}

.ad-container .ad-label {
	font-size: 0.6rem;
	color: #adb5bd;
	text-transform: uppercase;
	letter-spacing: 1px;
	display: block;
	margin-bottom: 8px;
}

@media ( max-width : 768px) {
	.score-board {
		top: 10px;
		right: 10px;
		padding: 10px 15px;
		font-size: 0.9rem;
	}
	.score-board .score-item {
		margin: 0 5px;
	}
	.lesson-box {
		padding: 20px;
	}
	.quiz-card {
		padding: 18px;
	}
	.option-btn {
		font-size: 1rem;
		padding: 12px 15px;
	}
	.btn-confirm-answer {
		padding: 12px 30px;
		font-size: 1rem;
	}
	.btn-check-all {
		padding: 12px 25px;
		font-size: 1rem;
	}
	.ad-sidebar {
		display: none;
	}
	.ad-popup-content {
		padding: 20px !important;
		max-width: 100% !important;
		margin: 15px !important;
		border-radius: 15px !important;
	}
	.ad-popup-content .ad-popup-body {
		min-height: 180px !important;
	}
	.ad-popup-content .ad-popup-body ins {
		min-height: 180px !important;
	}
	.ad-popup-content .ad-popup-footer {
		flex-direction: column !important;
		align-items: stretch !important;
	}
	.ad-popup-content .ad-timer {
		text-align: center !important;
	}
	.ad-popup-content .ad-actions {
		justify-content: center !important;
	}
}

@media ( max-width : 576px) {
	.score-board {
		top: 5px;
		right: 5px;
		padding: 8px 12px;
		font-size: 0.75rem;
	}
	.score-board .score-item {
		margin: 0 3px;
	}
	.lesson-box {
		padding: 15px;
	}
	.quiz-card {
		padding: 15px;
	}
	.option-btn {
		font-size: 0.9rem;
		padding: 10px 12px;
	}
	.option-btn .option-label {
		width: 24px;
		height: 24px;
		line-height: 24px;
		font-size: 0.8rem;
	}
	.btn-confirm-answer {
		padding: 10px 20px;
		font-size: 0.9rem;
	}
	.btn-check-all {
		padding: 10px 20px;
		font-size: 0.9rem;
	}
	.ad-popup-content {
		padding: 15px !important;
		margin: 10px !important;
		border-radius: 12px !important;
	}
	.ad-popup-content .ad-popup-body {
		min-height: 150px !important;
		padding: 10px !important;
	}
	.ad-popup-content .ad-popup-body ins {
		min-height: 150px !important;
	}
	.ad-popup-content .ad-popup-header h5 {
		font-size: 1rem !important;
	}
	.ad-popup-content .ad-popup-header p {
		font-size: 0.75rem !important;
	}
	.ad-popup-content .btn-skip-ad {
		padding: 6px 16px !important;
		font-size: 0.75rem !important;
	}
	.ad-popup-content .ad-countdown-circle {
		width: 36px !important;
		height: 36px !important;
	}
	.ad-popup-content .ad-countdown-circle .countdown-text {
		font-size: 0.85rem !important;
	}
}
</style>
</head>
<body>

	<!-- ===== ADS POPUP CENTER ===== -->
	<c:if test="${showAds}">
		<div class="ad-popup-overlay" id="adOverlay">
			<div class="ad-popup-content">
				<!-- Close Button -->
				<button class="ad-close-btn" id="adCloseBtn" disabled>
					<i class="fas fa-times"></i>
				</button>

				<!-- Header -->
				<div class="ad-popup-header">
					<span class="ad-icon"><i class="fas fa-ad"></i></span>
					<h5>Quảng cáo</h5>
					<p>Vui lòng xem quảng cáo để tiếp tục học</p>
				</div>

				<!-- Ad Body -->
				<div class="ad-popup-body">
					<ins class="adsbygoogle" style="display: block; width: 100%; min-height: 200px;" data-ad-client="ca-pub-YOUR_PUBLISHER_ID" data-ad-slot="YOUR_AD_SLOT_POPUP" data-ad-format="rectangle" data-full-width-responsive="true"></ins>
					<script>
						(adsbygoogle = window.adsbygoogle || []).push({});
					</script>
				</div>

				<!-- Footer -->
				<div class="ad-popup-footer">
					<div class="ad-timer">
						<i class="fas fa-clock"></i> Quảng cáo sẽ kết thúc sau <span id="adCountdown">5</span> giây
					</div>
					<div class="ad-actions">
						<div class="ad-countdown-circle" id="countdownCircle">
							<svg class="progress-ring" width="44" height="44">
                                <circle class="progress-ring-circle" stroke="#667eea" stroke-width="4" fill="transparent" r="18" cx="22" cy="22" stroke-dasharray="113.1" stroke-dashoffset="0" />
                            </svg>
							<span id="countdownNumber" class="countdown-text">5</span>
						</div>
						<button class="btn-skip-ad" id="skipAdBtn" disabled>
							<i class="fas fa-forward"></i> Bỏ qua
						</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<!-- ===== SCORE BOARD ===== -->
	<div class="score-board animate__animated animate__bounceIn">
		<span class="score-item"> <i class="fas fa-star text-warning"></i> Điểm: <span id="total-score" class="text-warning font-weight-bold">0</span>
		</span> <span class="score-item"> <i class="fas fa-check-circle text-success"></i> Đúng: <span id="correct-count" class="text-success font-weight-bold">0</span>
		</span> <span class="score-item"> <i class="fas fa-clock text-info"></i> Còn: <span id="remaining-count" class="text-info font-weight-bold">${questionCount}</span>
		</span>
	</div>

	<!-- ===== MAIN CONTENT ===== -->
	<div class="container py-4">
		<div class="row">
			<!-- Main Content -->
			<div class="${showAds ? 'col-lg-9' : 'col-12'}">
				<!-- Back Button -->
				<a href="${pageContext.request.contextPath}/grades/${lesson.grade}" class="btn btn-light rounded-pill mb-3 font-weight-bold shadow-sm"> <i class="fas fa-arrow-left"></i> Quay lại
				</a>

				<!-- Thông báo -->
				<c:if test="${!isPremium}">
					<div class="alert alert-warning animate__animated animate__fadeInDown">
						<i class="fas fa-info-circle"></i> Bạn đang xem bài học với quảng cáo. Để trải nghiệm không quảng cáo, vui lòng <a href="${pageContext.request.contextPath}/membership/packages" class="alert-link font-weight-bold">nâng cấp lên Premium</a>.
					</div>
				</c:if>

				<!-- Lesson Box -->
				<div class="lesson-box animate__animated animate__fadeInDown">
					<div class="text-center">
						<div style="font-size: 3rem;">📚</div>
						<h1 class="text-primary font-weight-bold mb-3">${lesson.title}</h1>
						<p class="lead text-muted">${lesson.description}</p>
						<c:if test="${!isPremium}">
							<span class="badge badge-warning"><i class="fas fa-ad"></i> Có quảng cáo</span>
						</c:if>
						<c:if test="${isPremium}">
							<span class="badge badge-success"><i class="fas fa-crown"></i> Premium</span>
						</c:if>
					</div>

					<c:if test="${not empty lesson.content}">
						<div class="bg-light p-4 rounded-lg mt-3">
							<h5 class="font-weight-bold text-info">
								<i class="fas fa-book-open"></i> Nội dung bài học:
							</h5>
							<p style="white-space: pre-line;">${lesson.content}</p>
						</div>
					</c:if>

					<c:if test="${not empty lesson.videoUrl}">
						<div class="mt-3">
							<h5 class="font-weight-bold text-info">
								<i class="fas fa-video"></i> Video bài học:
							</h5>
							<div class="embed-responsive embed-responsive-16by9" style="border-radius: 15px; overflow: hidden;">
								<iframe class="embed-responsive-item" src="${lesson.videoUrl}" allowfullscreen></iframe>
							</div>
						</div>
					</c:if>
				</div>

				<!-- Quiz List -->
				<h2 class="text-center mt-5 mb-4 text-info font-weight-bold">
					<i class="fas fa-pencil-alt"></i> Câu hỏi luyện tập
				</h2>

				<div id="quiz-list">
					<c:choose>
						<c:when test="${not empty quizzes}">
							<c:forEach var="quiz" items="${quizzes}" varStatus="loop">
								<div class="quiz-card animate__animated animate__zoomIn" data-quiz-id="${quiz.id}" data-points="${quiz.points}" data-index="${loop.index}" style="animation-delay:${loop.index * 0.1}s">

									<div class="d-flex align-items-start">
										<span class="badge badge-primary badge-pill mr-3" style="font-size: 1.2rem; padding: 8px 16px; min-width: 40px; background: linear-gradient(135deg, #667eea, #764ba2);"> ${loop.index + 1} <span class="question-status unanswered" id="status-${quiz.id}"></span>
										</span>
										<div class="flex-grow-1">
											<h4 class="font-weight-bold text-dark mb-3">${quiz.question}</h4>
											<p class="text-muted small">
												<i class="fas fa-star text-warning"></i> Điểm: ${quiz.points}
											</p>

											<div class="row">
												<div class="col-md-6">
													<button class="option-btn" data-option="A" data-quiz-id="${quiz.id}">
														<span class="option-label">A</span> ${quiz.optionA}
													</button>
												</div>
												<div class="col-md-6">
													<button class="option-btn" data-option="B" data-quiz-id="${quiz.id}">
														<span class="option-label">B</span> ${quiz.optionB}
													</button>
												</div>
												<div class="col-md-6">
													<button class="option-btn" data-option="C" data-quiz-id="${quiz.id}">
														<span class="option-label">C</span> ${quiz.optionC}
													</button>
												</div>
												<div class="col-md-6">
													<button class="option-btn" data-option="D" data-quiz-id="${quiz.id}">
														<span class="option-label">D</span> ${quiz.optionD}
													</button>
												</div>
											</div>

											<div class="feedback mt-3 text-center" id="feedback-${quiz.id}"></div>

											<div class="mt-2">
												<button class="btn btn-sm btn-outline-secondary show-answer-btn" data-answer="${quiz.correctOption}" data-quiz-id="${quiz.id}" style="display: none;">
													<i class="fas fa-eye"></i> Xem đáp án
												</button>
												<span class="answer-text ml-2" style="display: none;" id="answer-${quiz.id}"> <span class="badge badge-success">Đáp án đúng: ${quiz.correctOption}</span> <c:if test="${not empty quiz.explanation}">
														<br>
														<span class="text-muted small"><i class="fas fa-info-circle"></i> ${quiz.explanation}</span>
													</c:if>
												</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="text-center py-5">
								<div style="font-size: 4rem;">📝</div>
								<h4 class="text-muted mt-3">Chưa có câu hỏi cho bài học này</h4>
								<p class="text-muted">Vui lòng quay lại sau nhé!</p>
								<a href="${pageContext.request.contextPath}/grades/${lesson.grade}" class="btn btn-fun btn-fun-primary mt-3"> <i class="fas fa-arrow-left"></i> Quay lại bài học
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- Progress Bar -->
				<div class="progress-bar-custom">
					<div class="progress-fill" id="progressFill"></div>
				</div>

				<!-- Buttons -->
				<div class="confirm-btn-wrapper">
					<button class="btn-confirm-answer" id="confirmAnswerBtn">
						<i class="fas fa-check-circle"></i> Xác nhận câu trả lời
					</button>
					<button class="btn-check-all ml-3" id="checkAllBtn" style="display: none;">
						<i class="fas fa-flag-checkered"></i> Hoàn thành bài kiểm tra
					</button>
					<p class="text-muted small mt-2" id="confirmHint"></p>
				</div>

				<!-- Back to Lessons -->
				<div class="text-center mt-2">
					<a href="${pageContext.request.contextPath}/grades/${lesson.grade}" class="btn btn-outline-primary btn-fun"> <i class="fas fa-arrow-left"></i> Quay lại danh sách bài học
					</a>
				</div>
			</div>

			<!-- Right Sidebar - Ads -->
			<c:if test="${showAds}">
				<div class="col-lg-3">
					<div class="ad-sidebar">
						<div class="ad-container">
							<span class="ad-label">Quảng cáo</span>
							<ins class="adsbygoogle" style="display: block" data-ad-client="ca-pub-YOUR_PUBLISHER_ID" data-ad-slot="YOUR_AD_SLOT_SIDEBAR" data-ad-format="rectangle" data-full-width-responsive="true"></ins>
							<script>
								(adsbygoogle = window.adsbygoogle || [])
										.push({});
							</script>
						</div>
						<div class="ad-container mt-3">
							<span class="ad-label">Quảng cáo</span>
							<ins class="adsbygoogle" style="display: block" data-ad-client="ca-pub-YOUR_PUBLISHER_ID" data-ad-slot="YOUR_AD_SLOT_SIDEBAR_2" data-ad-format="rectangle" data-full-width-responsive="true"></ins>
							<script>
								(adsbygoogle = window.adsbygoogle || [])
										.push({});
							</script>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    $(document).ready(function() {
        // ===== ADS POPUP TIMER =====
        var showAds = ${showAds};
        var adOverlay = document.getElementById('adOverlay');
        var adCloseBtn = document.getElementById('adCloseBtn');
        var skipAdBtn = document.getElementById('skipAdBtn');
        var countdownNumber = document.getElementById('countdownNumber');
        var adCountdown = document.getElementById('adCountdown');
        var countdown = 5;
        var totalCountdown = 5;
        var adTimerInterval;
        var adClosed = false;
        
        if (showAds && adOverlay) {
            // Ngăn scroll khi có overlay
            document.body.style.overflow = 'hidden';
            document.documentElement.style.overflow = 'hidden';
            
            // Bắt đầu đếm ngược
            adTimerInterval = setInterval(function() {
                countdown--;
                if (countdownNumber) countdownNumber.textContent = countdown;
                if (adCountdown) adCountdown.textContent = countdown;
                
                // Cập nhật vòng tròn tiến trình
                var circle = document.querySelector('.progress-ring-circle');
                if (circle) {
                    var circumference = 2 * Math.PI * 18;
                    var offset = circumference - (countdown / totalCountdown) * circumference;
                    circle.style.strokeDashoffset = offset;
                }
                
                if (countdown <= 0) {
                    clearInterval(adTimerInterval);
                    // Kích hoạt nút đóng và bỏ qua
                    if (adCloseBtn) {
                        adCloseBtn.disabled = false;
                        adCloseBtn.classList.add('active');
                    }
                    if (skipAdBtn) {
                        skipAdBtn.disabled = false;
                        skipAdBtn.classList.add('active');
                    }
                    if (adCountdown) adCountdown.textContent = '0';
                    if (countdownNumber) countdownNumber.textContent = '0';
                }
            }, 1000);
            
            // Hàm đóng quảng cáo
            function closeAd() {
                if (adClosed) return;
                adClosed = true;
                
                if (adOverlay) {
                    adOverlay.style.display = 'none';
                    adOverlay.style.visibility = 'hidden';
                    adOverlay.style.opacity = '0';
                }
                document.body.style.overflow = 'auto';
                document.documentElement.style.overflow = 'auto';
                
                // KHÔNG push lại quảng cáo khi đóng
                // Chỉ push lại nếu cần thiết và chưa có quảng cáo
                if (typeof adsbygoogle !== 'undefined') {
                    // Kiểm tra xem đã có quảng cáo chưa
                    var adElements = document.querySelectorAll('ins.adsbygoogle');
                    var hasAd = false;
                    adElements.forEach(function(el) {
                        if (el.innerHTML && el.innerHTML.trim() !== '') {
                            hasAd = true;
                        }
                    });
                    // Chỉ push nếu chưa có quảng cáo
                    if (!hasAd) {
                        try {
                            (adsbygoogle = window.adsbygoogle || []).push({});
                        } catch(e) {
                            console.log('Ad push error:', e);
                        }
                    }
                }
            }
            
            // Đóng quảng cáo - Click nút X
            if (adCloseBtn) {
                adCloseBtn.addEventListener('click', function() {
                    if (!this.disabled && !adClosed) {
                        closeAd();
                    }
                });
            }
            
            // Bỏ qua quảng cáo - Click nút Bỏ qua
            if (skipAdBtn) {
                skipAdBtn.addEventListener('click', function() {
                    if (!this.disabled && !adClosed) {
                        closeAd();
                    }
                });
            }
            
            // Đóng khi click ra ngoài popup (nếu đã hết timer)
            adOverlay.addEventListener('click', function(e) {
                if (e.target === this && countdown <= 0 && !adClosed) {
                    closeAd();
                }
            });
        }

        // ===== BIẾN TOÀN CỤC =====
        var totalScore = 0;
        var correctCount = 0;
        var totalQuestions = $('.quiz-card').length;
        var answeredCount = 0;
        var selectedCount = 0;
        var isChecking = false;
        var isAllChecked = false;
        var hasUserInteracted = false;

        console.log('Total questions:', totalQuestions);

        // ===== CẬP NHẬT SỐ CÂU CÒN LẠI =====
        function updateRemainingCount() {
            var remaining = totalQuestions - (answeredCount + selectedCount);
            $('#remaining-count').text(remaining);

            var progress = totalQuestions > 0 ? ((answeredCount + selectedCount) / totalQuestions) * 100 : 0;
            $('#progressFill').css('width', progress + '%');

            if (!hasUserInteracted) {
                $('#confirmHint').html('').addClass('empty-hint');
                return;
            }

            $('#confirmHint').removeClass('empty-hint');

            if (isAllChecked) {
                $('#confirmHint').html('<i class="fas fa-trophy text-warning"></i> Bài kiểm tra đã hoàn thành!');
                return;
            }

            if (isChecking) {
                $('#confirmHint').html('<i class="fas fa-spinner fa-spin text-primary"></i> Đang kiểm tra câu trả lời...');
                return;
            }

            var unanswered = $('.quiz-card:not(.answered)');

            if (unanswered.length === 0) {
                $('#confirmHint').html('<i class="fas fa-check-circle text-success"></i> Tất cả câu hỏi đã được trả lời! Nhấn "Hoàn thành" để kết thúc.');
                $('#checkAllBtn').show();
                return;
            }

            var hasUnselected = false;
            unanswered.each(function() {
                var $card = $(this);
                var hasSelected = $card.find('.option-btn.selected-option').length > 0;
                if (!hasSelected) {
                    hasUnselected = true;
                }
            });

            if (!hasUnselected) {
                $('#confirmHint').html('<i class="fas fa-check-circle text-success"></i> Tất cả câu hỏi đã được chọn đáp án! Nhấn "Xác nhận" để kiểm tra.');
            } else {
                $('#confirmHint').html('<i class="fas fa-info-circle"></i> Còn <strong>' + remaining + '</strong> câu chưa làm. Vui lòng chọn đáp án cho tất cả câu hỏi.');
            }
        }

        // ===== CHỌN ĐÁP ÁN =====
        $('.option-btn').on('click', function() {
            var $btn = $(this);
            var $card = $btn.closest('.quiz-card');
            var quizId = $btn.data('quiz-id');

            if ($card.hasClass('answered') || isChecking || isAllChecked) {
                return;
            }

            var hadSelected = $card.find('.option-btn.selected-option').length > 0;

            $card.find('.option-btn').removeClass('selected-option');
            $btn.addClass('selected-option');

            if (!hadSelected) {
                $card.addClass('selected');
                selectedCount++;
            }

            if (!hasUserInteracted) {
                hasUserInteracted = true;
            }

            updateRemainingCount();
        });

        // ===== XÁC NHẬN TẤT CẢ CÂU TRẢ LỜI =====
        $('#confirmAnswerBtn').on('click', function() {
            var $btn = $(this);

            if (!hasUserInteracted) {
                $('#confirmHint').removeClass('empty-hint').html('<i class="fas fa-info-circle"></i> Vui lòng chọn đáp án cho các câu hỏi trước!');
                return;
            }

            if (isChecking || isAllChecked) {
                return;
            }

            $('.quiz-card.not-selected').removeClass('not-selected');

            var unanswered = $('.quiz-card:not(.answered)');

            if (unanswered.length === 0) {
                alert('Tất cả câu hỏi đã được trả lời! Vui lòng nhấn "Hoàn thành" để kết thúc.');
                return;
            }

            var hasUnselected = false;
            var unselectedCards = [];
            unanswered.each(function() {
                var $card = $(this);
                var hasSelected = $card.find('.option-btn.selected-option').length > 0;
                if (!hasSelected) {
                    hasUnselected = true;
                    unselectedCards.push($card);
                }
            });

            if (hasUnselected) {
                $(unselectedCards).each(function() {
                    $(this).addClass('not-selected');
                });

                if (unselectedCards.length > 0) {
                    $('html, body').animate({
                        scrollTop: $(unselectedCards[0]).offset().top - 150
                    }, 500);
                }

                alert('Vui lòng chọn đáp án cho tất cả các câu hỏi trước khi xác nhận!');
                return;
            }

            isChecking = true;
            $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Đang kiểm tra...');
            $('#confirmHint').html('<i class="fas fa-spinner fa-spin text-primary"></i> Đang kiểm tra câu trả lời...');

            var cardsToCheck = $('.quiz-card:not(.answered)');
            var totalToCheck = cardsToCheck.length;
            var checkedCount = 0;

            cardsToCheck.each(function() {
                var $card = $(this);
                var quizId = $card.data('quiz-id');
                var $selectedBtn = $card.find('.option-btn.selected-option');

                if ($selectedBtn.length === 0) {
                    checkedCount++;
                    return true;
                }

                var selectedOption = $selectedBtn.data('option');
                var $feedback = $('#feedback-' + quizId);
                var $showAnswerBtn = $card.find('.show-answer-btn');
                var $answerText = $('#answer-' + quizId);
                var points = parseInt($card.data('points')) || 0;
                var $status = $('#status-' + quizId);

                $card.find('.option-btn').addClass('disabled').prop('disabled', true);

                $.ajax({
                    url: '/api/quizzes/' + quizId + '/answer',
                    type: 'POST',
                    data: { option: selectedOption },
                    dataType: 'json',
                    timeout: 10000,
                    success: function(response) {
                        if (response.success) {
                            var isCorrect = response.isCorrect;
                            var correctOption = response.correctOption;
                            var explanation = response.explanation;

                            $card.addClass('answered');
                            $card.removeClass('selected');
                            answeredCount++;
                            selectedCount--;

                            $card.find('.option-btn').each(function() {
                                var $opt = $(this);
                                if ($opt.data('option') === correctOption) {
                                    $opt.addClass('correct');
                                }
                                if ($opt.data('option') === selectedOption && !isCorrect) {
                                    $opt.addClass('wrong');
                                }
                            });

                            if (isCorrect) {
                                $feedback.removeClass('wrong skipped').addClass('correct');
                                $feedback.html('🎉 Chính xác! +' + points + ' điểm');
                                totalScore += points;
                                correctCount++;
                                $card.addClass('answered-correct');
                                $status.removeClass('unanswered').addClass('answered-correct');
                            } else {
                                $feedback.removeClass('correct skipped').addClass('wrong');
                                $feedback.html('❌ Chưa đúng! Đáp án đúng là ' + correctOption);
                                $card.addClass('answered-wrong');
                                $status.removeClass('unanswered').addClass('answered-wrong');
                            }

                            if (explanation) {
                                $feedback.append('<br><small class="text-muted"><i class="fas fa-info-circle"></i> ' + explanation + '</small>');
                            }

                            $showAnswerBtn.show();

                            $('#total-score').text(totalScore);
                            $('#correct-count').text(correctCount);
                        }

                        checkedCount++;

                        if (checkedCount >= totalToCheck) {
                            isChecking = false;
                            $btn.prop('disabled', false).html('<i class="fas fa-check-circle"></i> Xác nhận câu trả lời');
                            updateRemainingCount();

                            if (answeredCount === totalQuestions) {
                                $('#checkAllBtn').show();
                                $('#confirmHint').html('<i class="fas fa-check-circle text-success"></i> Tất cả câu hỏi đã được trả lời! Nhấn "Hoàn thành" để kết thúc.');
                                $btn.prop('disabled', true);
                            }
                        }
                    },
                    error: function(xhr, status, error) {
                        checkedCount++;

                        if (checkedCount >= totalToCheck) {
                            isChecking = false;
                            $btn.prop('disabled', false).html('<i class="fas fa-check-circle"></i> Xác nhận câu trả lời');
                            updateRemainingCount();
                            alert('Có lỗi xảy ra khi kiểm tra một số câu hỏi! Vui lòng thử lại.');
                        }
                    }
                });
            });
        });

        // ===== HOÀN THÀNH BÀI KIỂM TRA =====
        $('#checkAllBtn').on('click', function() {
            if (isAllChecked) return;

            var unansweredCards = $('.quiz-card:not(.answered)');
            var remaining = unansweredCards.length;

            if (remaining > 0) {
                if (!confirm('Còn ' + remaining + ' câu chưa làm. Những câu này sẽ được tính là sai. Bạn có muốn tiếp tục?')) {
                    return;
                }

                unansweredCards.each(function() {
                    var $card = $(this);
                    var quizId = $card.data('quiz-id');
                    var $feedback = $('#feedback-' + quizId);
                    var $showAnswerBtn = $card.find('.show-answer-btn');
                    var $status = $('#status-' + quizId);

                    $card.addClass('answered answered-skipped');
                    $card.removeClass('selected');
                    answeredCount++;

                    var hasSelected = $card.find('.option-btn.selected-option').length > 0;
                    if (hasSelected) {
                        selectedCount--;
                    }

                    $card.find('.option-btn').addClass('disabled skipped').prop('disabled', true);

                    $feedback.removeClass('correct wrong').addClass('skipped');
                    $feedback.html('⏭️ Bỏ qua! Không chọn đáp án. Điểm: 0');

                    $status.removeClass('unanswered').addClass('answered-skipped');

                    $showAnswerBtn.show();
                });
            }

            isAllChecked = true;
            $(this).prop('disabled', true).html('<i class="fas fa-check-circle"></i> Đã hoàn thành');
            $('#confirmAnswerBtn').prop('disabled', true);
            $('#confirmHint').html('<i class="fas fa-trophy text-warning"></i> Bài kiểm tra đã hoàn thành!');

            updateRemainingCount();
            showCompletionMessage();
        });

        // ===== HIỂN THỊ ĐÁP ÁN =====
        $('.show-answer-btn').on('click', function() {
            var quizId = $(this).data('quiz-id');
            var $answerText = $('#answer-' + quizId);
            if ($answerText.is(':visible')) {
                $answerText.slideUp();
                $(this).html('<i class="fas fa-eye"></i> Xem đáp án');
            } else {
                $answerText.slideDown();
                $(this).html('<i class="fas fa-eye-slash"></i> Ẩn đáp án');
            }
        });

        // ===== HOÀN THÀNH =====
        function showCompletionMessage() {
            var totalCorrect = correctCount;
            var totalSkipped = $('.quiz-card.answered-skipped').length;
            var totalWrong = totalQuestions - totalCorrect - totalSkipped;

            var message = '<div class="alert alert-success text-center mt-4 animate__animated animate__bounceIn" style="border-radius: 20px;">';
            message += '<h4 class="font-weight-bold">🎉 Chúc mừng bạn đã hoàn thành bài kiểm tra!</h4>';
            message += '<div class="row mt-3">';
            message += '  <div class="col-4">';
            message += '    <div class="text-success"><i class="fas fa-check-circle" style="font-size: 2rem;"></i></div>';
            message += '    <strong>' + totalCorrect + '</strong> câu đúng';
            message += '  </div>';
            message += '  <div class="col-4">';
            message += '    <div class="text-danger"><i class="fas fa-times-circle" style="font-size: 2rem;"></i></div>';
            message += '    <strong>' + totalWrong + '</strong> câu sai';
            message += '  </div>';
            message += '  <div class="col-4">';
            message += '    <div class="text-warning"><i class="fas fa-clock" style="font-size: 2rem;"></i></div>';
            message += '    <strong>' + totalSkipped + '</strong> câu bỏ qua';
            message += '  </div>';
            message += '</div>';
            message += '<hr>';
            message += '<p>Tổng điểm: <strong class="text-warning" style="font-size: 1.5rem;">' + totalScore + '</strong> điểm</p>';
            message += '</div>';
            $('#quiz-list').after(message);

            $('html, body').animate({
                scrollTop: $('#quiz-list').offset().top - 100
            }, 500);
        }

        // ===== KHỞI TẠO =====
        $('#confirmHint').html('').addClass('empty-hint');
        console.log('Lesson page initialized');
        console.log('Total questions:', totalQuestions);
        console.log('Quiz cards found:', $('.quiz-card').length);
    });
</script>

</body>
</html>