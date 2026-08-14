<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
pageContext.setAttribute("pageTitle", "Chi tiết Email - Admin");
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
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="admin-body">

	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<!-- Include Sidebar -->
			<jsp:include page="/WEB-INF/jsp/admin/templates/admin-sidebar.jsp" />

			<!-- Main Content -->
			<main class="col-md-10 admin-content">
				<div style="max-width: 900px; margin: 0 auto;">
					<div
						class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
						<div>
							<h2 class="font-weight-bold text-primary mb-0">
								<i class="fas fa-envelope-open-text"></i> Chi tiết email
							</h2>
						</div>
						<div class="mt-2 mt-sm-0">
							<a href="${pageContext.request.contextPath}/admin/email/history"
								class="btn btn-outline-secondary btn-sm"> <i
								class="fas fa-arrow-left"></i> Quay lại
							</a>
							<button class="btn btn-info btn-sm" onclick="window.print()">
								<i class="fas fa-print"></i> In
							</button>
						</div>
					</div>

					<div class="card shadow-sm border-0 rounded-lg">
						<div class="card-body p-4">
							<!-- Thông tin chung -->
							<div class="row mb-3">
								<div class="col-md-6">
									<div class="info-item">
										<span class="font-weight-bold text-secondary">ID:</span> <span>#${email.id}</span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Trạng
											thái:</span> <span
											class="badge-status badge-${email.status.toLowerCase()}">
											${email.status} </span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Loại:</span> <span
											class="badge badge-info">${email.type}</span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Người
											gửi:</span> <span>${email.fromEmail}</span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Người
											nhận:</span> <span>${email.toEmail}</span>
									</div>
									<div class="info-item">
										<span class="font-weight-bold text-secondary">Thời
											gian:</span> <span><fmt:formatDate value="${email.sentAt}"
												pattern="dd/MM/yyyy HH:mm:ss" /></span>
									</div>
								</div>
							</div>

							<hr>

							<!-- Tiêu đề -->
							<div class="mb-3">
								<span class="font-weight-bold text-secondary">Tiêu đề:</span>
								<h4 class="mt-1">${email.subject}</h4>
							</div>

							<!-- Nội dung -->
							<div class="mb-3">
								<span class="font-weight-bold text-secondary">Nội dung:</span>
								<div class="border p-3 rounded bg-light mt-2"
									style="min-height: 100px;">${email.content}</div>
							</div>

							<!-- Thông tin thêm -->
							<div class="text-muted small mt-3">
								<i class="far fa-calendar-alt"></i> Tạo lúc:
								<fmt:formatDate value="${email.createdAt}"
									pattern="dd/MM/yyyy HH:mm:ss" />
							</div>
						</div>
					</div>

					<!-- Actions -->
					<div class="text-center mt-4">
						<a
							href="${pageContext.request.contextPath}/admin/email/send?reply=${email.id}"
							class="btn btn-primary btn-fun"> <i class="fas fa-reply"></i>
							Trả lời
						</a> <a
							href="${pageContext.request.contextPath}/admin/email/send?forward=${email.id}"
							class="btn btn-info btn-fun"> <i class="fas fa-share"></i>
							Chuyển tiếp
						</a>
					</div>
				</div>
			</main>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>