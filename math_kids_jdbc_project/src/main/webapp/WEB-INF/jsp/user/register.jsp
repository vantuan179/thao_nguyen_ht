<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    pageContext.setAttribute("pageTitle", "Đăng ký - Bé Học Toán");
    pageContext.setAttribute("pageJs", "register.js");
    pageContext.setAttribute("pageCss", "register.css");
%>

<!-- Include Header -->
<jsp:include page="/WEB-INF/jsp/user/templates/header.jsp" />

<div class="container">
    <div class="row justify-content-center mt-4">
        <div class="col-md-8 col-lg-6">
            <!-- Card đăng ký -->
            <div class="card shadow-lg border-0 rounded-lg register-card animate__animated animate__fadeInUp">
                <div class="card-header bg-transparent border-0 text-center pt-4">
                    <div class="register-icon mb-3">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <h3 class="font-weight-bold text-primary">🌟 Tạo tài khoản mới</h3>
                    <p class="text-muted">Tham gia cộng đồng học toán vui vẻ nào!</p>
                </div>
                
                <div class="card-body p-4 p-md-5">
                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle"></i> ${success}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    
                    <form id="registerForm" action="${pageContext.request.contextPath}/register" method="POST">
                        <!-- Họ và tên -->
                        <div class="form-group">
                            <label for="fullName" class="font-weight-bold text-secondary">
                                <i class="fas fa-user"></i> Họ và tên
                            </label>
                            <input type="text" 
                                   class="form-control form-control-lg" 
                                   id="fullName" 
                                   name="fullName" 
                                   placeholder="Nhập họ và tên của bé" 
                                   value="${param.fullName}"
                                   required>
                            <small class="form-text text-muted">Tên sẽ hiển thị trên bảng xếp hạng</small>
                        </div>
                        
                        <!-- Tên đăng nhập -->
                        <div class="form-group">
                            <label for="username" class="font-weight-bold text-secondary">
                                <i class="fas fa-id-card"></i> Tên đăng nhập
                            </label>
                            <input type="text" 
                                   class="form-control form-control-lg" 
                                   id="username" 
                                   name="username" 
                                   placeholder="Chọn tên đăng nhập" 
                                   value="${param.username}"
                                   required>
                            <small class="form-text text-muted">Từ 3-20 ký tự, chỉ bao gồm chữ và số</small>
                        </div>
                        
                        <!-- Email -->
                        <div class="form-group">
                            <label for="email" class="font-weight-bold text-secondary">
                                <i class="fas fa-envelope"></i> Email
                            </label>
                            <input type="email" 
                                   class="form-control form-control-lg" 
                                   id="email" 
                                   name="email" 
                                   placeholder="Nhập email của phụ huynh" 
                                   value="${param.email}"
                                   required>
                            <small class="form-text text-muted">Chúng tôi sẽ gửi thông tin qua email này</small>
                        </div>
                        
                        <!-- Mật khẩu -->
                        <div class="form-group">
                            <label for="password" class="font-weight-bold text-secondary">
                                <i class="fas fa-lock"></i> Mật khẩu
                            </label>
                            <div class="input-group">
                                <input type="password" 
                                       class="form-control form-control-lg" 
                                       id="password" 
                                       name="password" 
                                       placeholder="Tạo mật khẩu" 
                                       required>
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            <small class="form-text text-muted">Tối thiểu 6 ký tự, bao gồm chữ và số</small>
                            <div class="password-strength mt-2">
                                <div class="progress" style="height: 5px;">
                                    <div class="progress-bar" id="passwordStrength" role="progressbar" style="width: 0%"></div>
                                </div>
                                <small class="text-muted" id="strengthText">Độ mạnh: Yếu</small>
                            </div>
                        </div>
                        
                        <!-- Xác nhận mật khẩu -->
                        <div class="form-group">
                            <label for="confirmPassword" class="font-weight-bold text-secondary">
                                <i class="fas fa-check-circle"></i> Xác nhận mật khẩu
                            </label>
                            <input type="password" 
                                   class="form-control form-control-lg" 
                                   id="confirmPassword" 
                                   name="confirmPassword" 
                                   placeholder="Nhập lại mật khẩu" 
                                   required>
                            <small class="form-text" id="passwordMatch"></small>
                        </div>
                        
                        <!-- Đồng ý điều khoản -->
                        <div class="form-group form-check">
                            <input type="checkbox" 
                                   class="form-check-input" 
                                   id="agreeTerms" 
                                   name="agreeTerms" 
                                   required>
                            <label class="form-check-label" for="agreeTerms">
                                Tôi đồng ý với 
                                <a href="${pageContext.request.contextPath}/terms" target="_blank">Điều khoản sử dụng</a> 
                                và 
                                <a href="${pageContext.request.contextPath}/privacy" target="_blank">Chính sách bảo mật</a>
                            </label>
                        </div>
                        
                        <!-- Nút đăng ký -->
                        <button type="submit" class="btn btn-fun btn-fun-primary btn-block btn-lg mt-3">
                            <i class="fas fa-user-plus"></i> Đăng ký ngay
                        </button>
                    </form>
                    
                    <!-- Link đăng nhập -->
                    <div class="text-center mt-4">
                        <p class="text-muted">
                            Đã có tài khoản? 
                            <a href="${pageContext.request.contextPath}/login" class="font-weight-bold text-primary">
                                Đăng nhập ngay
                            </a>
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Ưu điểm -->
            <div class="row mt-4 mb-5">
                <div class="col-md-4">
                    <div class="text-center feature-item">
                        <i class="fas fa-shield-alt text-primary" style="font-size: 2rem;"></i>
                        <h6 class="mt-2 font-weight-bold">An toàn</h6>
                        <small class="text-muted">Bảo mật thông tin tuyệt đối</small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center feature-item">
                        <i class="fas fa-graduation-cap text-success" style="font-size: 2rem;"></i>
                        <h6 class="mt-2 font-weight-bold">Miễn phí</h6>
                        <small class="text-muted">Hoàn toàn miễn phí cho bé</small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center feature-item">
                        <i class="fas fa-trophy text-warning" style="font-size: 2rem;"></i>
                        <h6 class="mt-2 font-weight-bold">Thú vị</h6>
                        <small class="text-muted">Học mà chơi, chơi mà học</small>
                    </div>
                </div>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Page-specific JavaScript -->
<c:if test="${not empty pageJs}">
    <script src="${pageContext.request.contextPath}/assets/js/${pageJs}"></script>
</c:if>

</body>
</html>