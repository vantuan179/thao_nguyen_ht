<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    pageContext.setAttribute("pageTitle", "Danh sách lớp học - Bé Học Toán");
    pageContext.setAttribute("pageJs", "home.js");
%>

<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container">
	<div class="hero animate__animated animate__bounceIn">
		<h1>📚 Danh sách lớp học</h1>
		<p class="lead mt-3">Chọn lớp học của bé để bắt đầu học toán nào!</p>
	</div>

	<div class="row mt-4">
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
								<p class="card-text text-muted">${grade.description}</p>
								<p class="text-muted">
									<i class="fas fa-book-open"></i> ${grade.lessons != null ? grade.lessons.size() : 0}
									bài học
								</p>
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
			</c:forEach>
	</div>
</div>

</div>

<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<c:if test="${not empty pageJs}">
	<script src="${pageContext.request.contextPath}/assets/js/${pageJs}"></script>
</c:if>

</body>
</html>