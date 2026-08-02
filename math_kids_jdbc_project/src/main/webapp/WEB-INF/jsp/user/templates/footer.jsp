<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer class="footer" id="footer">
    <div class="container">
        <div class="row">
            <!-- Cột 1: Thông tin trang web -->
            <div class="col-md-3">
                <h5><i class="fas fa-graduation-cap"></i> Bé Học Toán</h5>
                <p style="font-size: 0.95rem; color: #1b5e20;">
                    Nền tảng học toán trực tuyến dành cho trẻ em từ 4-10 tuổi. 
                    Giúp các bé yêu thích môn toán thông qua các bài học sinh động và trò chơi thú vị.
                </p>
                <div class="badge-math mt-2">
                    <i class="fas fa-star"></i> Hơn 10.000 học sinh
                </div>
            </div>
            
            <!-- Cột 2: Liên kết nhanh -->
            <div class="col-md-3">
                <h5><i class="fas fa-link"></i> Liên kết nhanh</h5>
                <ul class="list-unstyled">
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/lessons">Bài học</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/games">Trò chơi</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/exercises">Bài tập</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/ranking">Bảng xếp hạng</a></li>
                </ul>
            </div>
            
            <!-- Cột 3: Hỗ trợ -->
            <div class="col-md-3">
                <h5><i class="fas fa-life-ring"></i> Hỗ trợ</h5>
                <ul class="list-unstyled">
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/faq">Câu hỏi thường gặp</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/privacy">Chính sách bảo mật</a></li>
                    <li><i class="fas fa-chevron-right"></i> <a href="${pageContext.request.contextPath}/terms">Điều khoản sử dụng</a></li>
                </ul>
            </div>
            
            <!-- Cột 4: Kết nối và liên hệ -->
            <div class="col-md-3">
                <h5><i class="fas fa-phone"></i> Kết nối với chúng tôi</h5>
                <div class="social-icons mb-3">
                    <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" aria-label="YouTube"><i class="fab fa-youtube"></i></a>
                    <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                    <a href="#" aria-label="Zalo"><i class="fas fa-comment"></i></a>
                </div>
                <ul class="list-unstyled">
                    <li><i class="fas fa-envelope"></i> <a href="mailto:support@behoctoan.com">support@behoctoan.com</a></li>
                    <li><i class="fas fa-phone"></i> <a href="tel:19001234">1900 1234</a></li>
                    <li><i class="fas fa-clock"></i> <span style="color: #1b5e20;">T2-T7: 8:00 - 20:00</span></li>
                </ul>
            </div>
        </div>
        
        <!-- Phân chia -->
        <div class="footer-bottom text-center">
            <div class="row">
                <div class="col-md-6 text-md-left">
                    <p>© 2024 <strong>Bé Học Toán</strong>. Tất cả các quyền được bảo lưu.</p>
                </div>
                <div class="col-md-6 text-md-right">
                    <p>
                        <i class="fas fa-heart text-danger"></i> 
                        Phát triển với tình yêu dành cho trẻ em
                        <i class="fas fa-heart text-danger"></i>
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Nút Scroll to Top -->
<button class="scroll-top" id="scrollTopBtn" aria-label="Lên đầu trang">
    <i class="fas fa-arrow-up"></i>
</button>

<script>
    $(document).ready(function() {
        // ===== Footer Animation khi scroll =====
        function checkFooterVisibility() {
            var footer = $('.footer');
            var windowHeight = $(window).height();
            var scrollY = $(window).scrollTop();
            var footerOffset = footer.offset().top;
            
            // Nếu footer xuất hiện trong viewport
            if (scrollY + windowHeight > footerOffset + 100) {
                footer.addClass('visible');
            }
        }
        
        // Kiểm tra khi load và scroll
        $(window).on('scroll', function() {
            checkFooterVisibility();
            
            // ===== Scroll to Top Button =====
            if ($(window).scrollTop() > 300) {
                $('#scrollTopBtn').addClass('visible');
            } else {
                $('#scrollTopBtn').removeClass('visible');
            }
        });
        
        // Trigger kiểm tra lần đầu
        checkFooterVisibility();
        
        // ===== Scroll to Top =====
        $('#scrollTopBtn').click(function() {
            $('html, body').animate({
                scrollTop: 0
            }, 600);
        });
    });
</script>