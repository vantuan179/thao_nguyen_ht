<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    pageContext.setAttribute("pageTitle", "🌈 Bé Học Toán Vui Vẻ - Trang chủ");
%>

<!-- Include Header -->
<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container">
    <!-- Hero Section -->
    <div class="hero animate__animated animate__bounceIn">
        <h1>🌟 Chào mừng bé đến thế giới Toán học! 🌟</h1>
        <p class="lead mt-3">Học toán thật vui qua những bài học sinh động và câu đố thú vị.</p>
        <a href="#lessons" class="btn btn-fun btn-fun-warning mt-3 animate__animated animate__pulse animate__infinite">
            Bắt đầu học nào! 🚀
        </a>
    </div>

    <!-- Lessons Section -->
    <h2 id="lessons" class="text-center mt-5 mb-4 text-primary font-weight-bold">📚 Chọn bài học yêu thích</h2>
    <div class="row">
        <c:forEach var="lesson" items="${lessons}" varStatus="loop">
            <div class="col-md-4 mb-4">
                <div class="lesson-card animate__animated animate__fadeInUp" 
                     style="animation-delay:${loop.index * 0.15}s">
                    <div class="card-body text-center">
                        <div class="lesson-icon">
                            <c:choose>
                                <c:when test="${loop.index % 3 == 0}">➕</c:when>
                                <c:when test="${loop.index % 3 == 1}">➖</c:when>
                                <c:otherwise>🔺</c:otherwise>
                            </c:choose>
                        </div>
                        <h4 class="card-title text-info font-weight-bold">${lesson.title}</h4>
                        <p class="card-text text-muted">${lesson.description}</p>
                        <a href="${pageContext.request.contextPath}/lesson/${lesson.id}" 
                           class="btn btn-fun btn-fun-success">
                            Vào học 🎒
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Đóng main-content -->
</div>

<!-- Include Footer -->
<jsp:include page="/WEB-INF/jsp/user/templates/footer.jsp" />

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Page-specific JavaScript -->
<c:if test="${not empty pageJs}">
    <script src="${pageContext.request.contextPath}/assets/js/${pageJs}"></script>
</c:if>

</body>
</html>