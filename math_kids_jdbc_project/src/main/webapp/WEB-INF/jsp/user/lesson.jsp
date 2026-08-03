<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", lesson != null ? lesson.getTitle() + " - Bé Học Toán" : "Bài học - Bé Học Toán");
pageContext.setAttribute("pageJs", "lesson.js");
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

<style>
/* ===== LESSON SPECIFIC STYLES ===== */
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
	border-left: 8px solid #ffd93d;
	transition: all 0.3s ease;
}

.quiz-card:hover {
	transform: translateX(5px);
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
}

.quiz-card.answered-correct {
	border-left-color: #28a745;
}

.quiz-card.answered-wrong {
	border-left-color: #dc3545;
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

.option-btn:hover {
	transform: translateY(-2px);
	background: #e8f0fe;
	border-color: #667eea;
	box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
}

.option-btn:disabled {
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

.option-btn.correct .option-label {
	background: #28a745;
}

.option-btn.wrong .option-label {
	background: #dc3545;
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

/* ===== CONFETTI ===== */
.confetti {
	position: fixed;
	width: 12px;
	height: 12px;
	border-radius: 2px;
	animation: confetti-fall 3s linear forwards;
	z-index: 9999;
	pointer-events: none;
}

@
keyframes confetti-fall { 0% {
	transform: translateY(-10vh) rotate(0deg) scale(1);
	opacity: 1;
}

100


%
{
transform


:


translateY
(


110vh


)


rotate
(


720deg


)


scale
(


0
.5


)
;


opacity


:


0
;


}
}

/* ===== RESPONSIVE ===== */
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
}

@media ( max-width : 576px) {
	.score-board {
		position: relative;
		top: 0;
		right: 0;
		margin-bottom: 20px;
		display: flex;
		justify-content: space-around;
	}
}
</style>
</head>
<body>

	<!-- ===== SCORE BOARD ===== -->
	<div class="score-board animate__animated animate__bounceIn">
		<span class="score-item"> <i class="fas fa-star text-warning"></i>
			Điểm: <span id="total-score" class="text-warning font-weight-bold">0</span>
		</span> <span class="score-item"> <i
			class="fas fa-check-circle text-success"></i> Đúng: <span
			id="correct-count" class="text-success font-weight-bold">0</span>
		</span> <span class="score-item"> <i
			class="fas fa-question-circle text-info"></i> Còn: <span
			id="remaining-count" class="text-info font-weight-bold">${quizzes.size()}</span>
		</span>
	</div>

	<div class="container py-4">
		<!-- ===== BACK BUTTON ===== -->
		<a href="${pageContext.request.contextPath}/grades/${lesson.grade}"
			class="btn btn-light rounded-pill mb-3 font-weight-bold shadow-sm">
			<i class="fas fa-arrow-left"></i> Quay lại
		</a>

		<!-- ===== LESSON BOX ===== -->
		<div class="lesson-box animate__animated animate__fadeInDown">
			<div class="text-center">
				<div style="font-size: 3rem;">📚</div>
				<h1 class="text-primary font-weight-bold mb-3">${lesson.title}</h1>
				<p class="lead text-muted">${lesson.description}</p>
			</div>

			<c:if test="${not empty lesson.content}">
				<div class="bg-light p-4 rounded-lg mt-3"
					style="border-radius: 15px;">
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
					<div class="embed-responsive embed-responsive-16by9"
						style="border-radius: 15px; overflow: hidden;">
						<iframe class="embed-responsive-item" src="${lesson.videoUrl}"
							allowfullscreen></iframe>
					</div>
				</div>
			</c:if>
		</div>

		<!-- ===== QUIZ LIST ===== -->
		<h2 class="text-center mt-5 mb-4 text-info font-weight-bold">
			<i class="fas fa-pencil-alt"></i> Câu hỏi luyện tập
		</h2>

		<div id="quiz-list">
			<c:choose>
				<c:when test="${not empty quizzes}">
					<c:forEach var="quiz" items="${quizzes}" varStatus="loop">
						<div class="quiz-card animate__animated animate__zoomIn"
							data-quiz-id="${quiz.id}" data-points="${quiz.points}"
							style="animation-delay:${loop.index * 0.1}s">

							<div class="d-flex align-items-start">
								<span class="badge badge-primary badge-pill mr-3"
									style="font-size: 1.2rem; padding: 8px 16px; min-width: 40px; background: linear-gradient(135deg, #667eea, #764ba2);">
									${loop.index + 1} </span>
								<div class="flex-grow-1">
									<h4 class="font-weight-bold text-dark mb-3">${quiz.question}</h4>
									<p class="text-muted small">
										<i class="fas fa-star text-warning"></i> Điểm: ${quiz.points}
									</p>

									<div class="row">
										<div class="col-md-6">
											<button class="option-btn" data-option="A">
												<span class="option-label">A</span> ${quiz.optionA}
											</button>
										</div>
										<div class="col-md-6">
											<button class="option-btn" data-option="B">
												<span class="option-label">B</span> ${quiz.optionB}
											</button>
										</div>
										<div class="col-md-6">
											<button class="option-btn" data-option="C">
												<span class="option-label">C</span> ${quiz.optionC}
											</button>
										</div>
										<div class="col-md-6">
											<button class="option-btn" data-option="D">
												<span class="option-label">D</span> ${quiz.optionD}
											</button>
										</div>
									</div>

									<div class="feedback mt-3 text-center"></div>

									<div class="mt-2">
										<button
											class="btn btn-sm btn-outline-secondary show-answer-btn"
											data-answer="${quiz.correctOption}" style="display: none;">
											<i class="fas fa-eye"></i> Xem đáp án
										</button>
										<span class="answer-text ml-2" style="display: none;">
											<span class="badge badge-success">Đáp án đúng:
												${quiz.correctOption}</span> <c:if
												test="${not empty quiz.explanation}">
												<br>
												<span class="text-muted small"><i
													class="fas fa-info-circle"></i> ${quiz.explanation}</span>
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
						<a
							href="${pageContext.request.contextPath}/grades/${lesson.grade}"
							class="btn btn-fun btn-fun-primary mt-3"> <i
							class="fas fa-arrow-left"></i> Quay lại bài học
						</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- ===== BACK TO LESSONS ===== -->
		<div class="text-center mt-4">
			<a href="${pageContext.request.contextPath}/grades/${lesson.grade}"
				class="btn btn-outline-primary btn-fun"> <i
				class="fas fa-arrow-left"></i> Quay lại danh sách bài học
			</a>
		</div>
	</div>

	<!-- ===== SCRIPTS ===== -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- ===== LESSON JS ===== -->
	<script>
		$(document)
				.ready(
						function() {
							// ===== VARIABLES =====
							var totalScore = 0;
							var correctCount = 0;
							var totalQuestions = $('.quiz-card').length;
							var answeredQuestions = 0;

							// ===== OPTION CLICK =====
							$('.option-btn')
									.click(
											function() {
												var $btn = $(this);
												var $card = $btn
														.closest('.quiz-card');
												var $feedback = $card
														.find('.feedback');
												var $showAnswerBtn = $card
														.find('.show-answer-btn');
												var $answerText = $card
														.find('.answer-text');
												var quizId = $card
														.data('quiz-id');
												var selectedOption = $btn
														.data('option');
												var points = $card
														.data('points');

												// Nếu đã trả lời rồi thì không cho chọn lại
												if ($card.hasClass('answered')) {
													return;
												}

												// Disable tất cả các option trong card này
												$card.find('.option-btn').prop(
														'disabled', true);

												// Gọi API kiểm tra
												$
														.ajax({
															url : '/api/quizzes/'
																	+ quizId
																	+ '/answer',
															type : 'POST',
															data : {
																option : selectedOption
															},
															dataType : 'json',
															success : function(
																	response) {
																if (response.success) {
																	var isCorrect = response.isCorrect;
																	var correctOption = response.correctOption;
																	var explanation = response.explanation;

																	// Đánh dấu đã trả lời
																	$card
																			.addClass('answered');
																	answeredQuestions++;

																	// Hiển thị đáp án đúng
																	$card
																			.find(
																					'.option-btn')
																			.each(
																					function() {
																						var $opt = $(this);
																						if ($opt
																								.data('option') === correctOption) {
																							$opt
																									.addClass('correct');
																						}
																						if ($opt
																								.data('option') === selectedOption
																								&& !isCorrect) {
																							$opt
																									.addClass('wrong');
																						}
																					});

																	// Cập nhật feedback
																	if (isCorrect) {
																		$feedback
																				.removeClass(
																						'wrong')
																				.addClass(
																						'correct');
																		$feedback
																				.html('🎉 Chính xác! +'
																						+ points
																						+ ' điểm');
																		totalScore += points;
																		correctCount++;
																		$card
																				.addClass('answered-correct');

																		// Confetti effect
																		createConfetti();
																	} else {
																		$feedback
																				.removeClass(
																						'correct')
																				.addClass(
																						'wrong');
																		$feedback
																				.html('❌ Chưa đúng! Đáp án đúng là '
																						+ correctOption);
																		$card
																				.addClass('answered-wrong');
																	}

																	// Hiển thị giải thích nếu có
																	if (explanation) {
																		$feedback
																				.append('<br><small class="text-muted"><i class="fas fa-info-circle"></i> '
																						+ explanation
																						+ '</small>');
																	}

																	// Hiển thị nút xem đáp án
																	$showAnswerBtn
																			.show();

																	// Cập nhật điểm
																	$(
																			'#total-score')
																			.text(
																					totalScore);
																	$(
																			'#correct-count')
																			.text(
																					correctCount);
																	$(
																			'#remaining-count')
																			.text(
																					totalQuestions
																							- answeredQuestions);

																	// Cập nhật progress
																	updateProgress();

																	// Kiểm tra hoàn thành
																	if (answeredQuestions === totalQuestions) {
																		showCompletionMessage();
																	}
																} else {
																	alert(response.message
																			|| 'Có lỗi xảy ra!');
																	// Enable lại các option
																	$card
																			.find(
																					'.option-btn')
																			.prop(
																					'disabled',
																					false);
																	$card
																			.removeClass('answered');
																	answeredQuestions--;
																}
															},
															error : function(
																	xhr,
																	status,
																	error) {
																console
																		.error(
																				'Error:',
																				error);
																alert('Có lỗi xảy ra! Vui lòng thử lại.');
																// Enable lại các option
																$card
																		.find(
																				'.option-btn')
																		.prop(
																				'disabled',
																				false);
																$card
																		.removeClass('answered');
																answeredQuestions--;
															}
														});
											});

							// ===== SHOW ANSWER =====
							$('.show-answer-btn')
									.click(
											function() {
												var $answerText = $(this)
														.siblings(
																'.answer-text');
												if ($answerText.is(':visible')) {
													$answerText.slideUp();
													$(this)
															.html(
																	'<i class="fas fa-eye"></i> Xem đáp án');
												} else {
													$answerText.slideDown();
													$(this)
															.html(
																	'<i class="fas fa-eye-slash"></i> Ẩn đáp án');
												}
											});

							// ===== UPDATE PROGRESS =====
							function updateProgress() {
								var progress = (answeredQuestions / totalQuestions) * 100;
								// Tạo hoặc cập nhật progress bar
								if ($('#progress-bar').length === 0) {
									var progressHtml = '<div class="progress mt-3" style="height: 8px; border-radius: 10px;">';
									progressHtml += '<div id="progress-bar" class="progress-bar bg-success" role="progressbar" style="width: 0%; border-radius: 10px;"></div>';
									progressHtml += '</div>';
									$('#quiz-list').after(progressHtml);
								}
								$('#progress-bar').css('width', progress + '%');
							}

							// ===== CONFETTI =====
							function createConfetti() {
								var colors = [ '#ff6b6b', '#ffd93d', '#6bcb77',
										'#4d96ff', '#ff6fb7', '#a66cff' ];
								for (var i = 0; i < 50; i++) {
									var confetti = $('<div class="confetti"></div>');
									var color = colors[Math.floor(Math.random()
											* colors.length)];
									var left = Math.random() * 100;
									var size = Math.random() * 8 + 6;
									var duration = Math.random() * 2 + 2;
									var delay = Math.random() * 1;

									confetti.css({
										'left' : left + '%',
										'width' : size + 'px',
										'height' : size + 'px',
										'background' : color,
										'animation-duration' : duration + 's',
										'animation-delay' : delay + 's'
									});

									$('body').append(confetti);

									// Tự động xóa sau khi animation kết thúc
									setTimeout(function() {
										confetti.remove();
									}, (duration + delay) * 1000 + 100);
								}
							}

							// ===== COMPLETION MESSAGE =====
							function showCompletionMessage() {
								var message = '<div class="alert alert-success text-center mt-4 animate__animated animate__bounceIn" style="border-radius: 20px;">';
								message += '<h4 class="font-weight-bold">🎉 Chúc mừng bạn đã hoàn thành tất cả câu hỏi!</h4>';
								message += '<p class="mb-0">Bạn đã trả lời đúng <strong>'
										+ correctCount
										+ '/'
										+ totalQuestions
										+ '</strong> câu hỏi.</p>';
								message += '<p>Tổng điểm: <strong class="text-warning">'
										+ totalScore + '</strong> điểm</p>';
								message += '</div>';
								$('#quiz-list').after(message);
							}
						});
	</script>

	<!-- Page-specific JavaScript -->
	<c:if test="${not empty pageJs}">
		<script src="${pageContext.request.contextPath}/assets/js/${pageJs}"></script>
	</c:if>

</body>
</html>