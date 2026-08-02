$(document).ready(function() {
    console.log('Trang đăng ký đã sẵn sàng!');
    
    // ===== Variables =====
    var $password = $('#password');
    var $confirmPassword = $('#confirmPassword');
    var $passwordStrength = $('#passwordStrength');
    var $strengthText = $('#strengthText');
    var $passwordMatch = $('#passwordMatch');
    var $togglePassword = $('#togglePassword');
    var $registerForm = $('#registerForm');
    
    // ===== Toggle Password Visibility =====
    $togglePassword.click(function() {
        var type = $password.attr('type') === 'password' ? 'text' : 'password';
        $password.attr('type', type);
        $(this).find('i').toggleClass('fa-eye fa-eye-slash');
    });
    
    // ===== Password Strength Check =====
    $password.on('keyup', function() {
        var password = $(this).val();
        var strength = 0;
        var strengthText = '';
        var color = '';
        
        if (password.length === 0) {
            $passwordStrength.css('width', '0%');
            $strengthText.text('Độ mạnh: Chưa nhập');
            return;
        }
        
        // Kiểm tra độ dài
        if (password.length >= 6) strength += 1;
        if (password.length >= 10) strength += 1;
        
        // Kiểm tra chữ thường
        if (password.match(/[a-z]/)) strength += 1;
        
        // Kiểm tra chữ hoa
        if (password.match(/[A-Z]/)) strength += 1;
        
        // Kiểm tra số
        if (password.match(/\d/)) strength += 1;
        
        // Kiểm tra ký tự đặc biệt
        if (password.match(/[^a-zA-Z\d]/)) strength += 1;
        
        // Đánh giá độ mạnh
        if (strength <= 2) {
            strengthText = 'Yếu';
            color = '#e74c3c';
            $passwordStrength.css('width', '20%');
        } else if (strength <= 3) {
            strengthText = 'Trung bình';
            color = '#f39c12';
            $passwordStrength.css('width', '40%');
        } else if (strength <= 4) {
            strengthText = 'Khá';
            color = '#3498db';
            $passwordStrength.css('width', '60%');
        } else if (strength <= 5) {
            strengthText = 'Mạnh';
            color = '#2ecc71';
            $passwordStrength.css('width', '80%');
        } else {
            strengthText = 'Rất mạnh';
            color = '#27ae60';
            $passwordStrength.css('width', '100%');
        }
        
        $passwordStrength.css('background', color);
        $strengthText.text('Độ mạnh: ' + strengthText);
        $strengthText.css('color', color);
        
        // Kiểm tra lại xác nhận mật khẩu
        checkPasswordMatch();
    });
    
    // ===== Check Password Match =====
    function checkPasswordMatch() {
        var password = $password.val();
        var confirmPassword = $confirmPassword.val();
        
        if (confirmPassword.length === 0) {
            $passwordMatch.text('');
            return;
        }
        
        if (password === confirmPassword) {
            $passwordMatch.html('<i class="fas fa-check-circle text-success"></i> Mật khẩu khớp!');
            $passwordMatch.css('color', '#27ae60');
            $confirmPassword.css('border-color', '#27ae60');
        } else {
            $passwordMatch.html('<i class="fas fa-times-circle text-danger"></i> Mật khẩu không khớp!');
            $passwordMatch.css('color', '#e74c3c');
            $confirmPassword.css('border-color', '#e74c3c');
        }
    }
    
    $confirmPassword.on('keyup', function() {
        checkPasswordMatch();
    });
    
    // Reset border color khi focus
    $confirmPassword.on('focus', function() {
        $(this).css('border-color', '#667eea');
    });
    
    // ===== Form Validation =====
    $registerForm.on('submit', function(e) {
        var isValid = true;
        var errorMessage = '';
        
        // Validate Họ và tên
        var fullName = $('#fullName').val().trim();
        if (fullName.length < 2) {
            isValid = false;
            errorMessage = 'Họ và tên phải có ít nhất 2 ký tự!';
            $('#fullName').focus();
        }
        
        // Validate Tên đăng nhập
        var username = $('#username').val().trim();
        if (!isValid) {
            e.preventDefault();
            showError(errorMessage);
            return;
        }
        
        if (username.length < 3 || username.length > 20) {
            isValid = false;
            errorMessage = 'Tên đăng nhập phải từ 3-20 ký tự!';
            $('#username').focus();
        } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
            isValid = false;
            errorMessage = 'Tên đăng nhập chỉ bao gồm chữ, số và dấu gạch dưới!';
            $('#username').focus();
        }
        
        // Validate Email
        if (isValid) {
            var email = $('#email').val().trim();
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                isValid = false;
                errorMessage = 'Vui lòng nhập email hợp lệ!';
                $('#email').focus();
            }
        }
        
        // Validate Password
        if (isValid) {
            var password = $password.val();
            if (password.length < 6) {
                isValid = false;
                errorMessage = 'Mật khẩu phải có ít nhất 6 ký tự!';
                $password.focus();
            }
        }
        
        // Validate Confirm Password
        if (isValid) {
            if ($password.val() !== $confirmPassword.val()) {
                isValid = false;
                errorMessage = 'Mật khẩu xác nhận không khớp!';
                $confirmPassword.focus();
            }
        }
        
        // Validate Agree Terms
        if (isValid) {
            if (!$('#agreeTerms').is(':checked')) {
                isValid = false;
                errorMessage = 'Vui lòng đồng ý với điều khoản sử dụng!';
                $('#agreeTerms').focus();
            }
        }
        
        if (!isValid) {
            e.preventDefault();
            showError(errorMessage);
        }
    });
    
    // ===== Show Error Message =====
    function showError(message) {
        // Xóa alert cũ nếu có
        $('.alert-danger').remove();
        
        var alertHtml = `
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${message}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        `;
        
        $registerForm.prepend(alertHtml);
        
        // Auto dismiss sau 5s
        setTimeout(function() {
            $('.alert-danger').alert('close');
        }, 5000);
    }
    
    // ===== Real-time Username Validation =====
    var usernameTimeout;
    $('#username').on('keyup', function() {
        clearTimeout(usernameTimeout);
        var username = $(this).val().trim();
        
        if (username.length >= 3) {
            usernameTimeout = setTimeout(function() {
                // Gọi API kiểm tra username (nếu có)
                // $.ajax({
                //     url: '/api/check-username',
                //     type: 'POST',
                //     data: { username: username },
                //     success: function(response) {
                //         if (response.exists) {
                //             showError('Tên đăng nhập đã được sử dụng!');
                //         }
                //     }
                // });
                console.log('Kiểm tra username: ' + username);
            }, 500);
        }
    });
    
    // ===== Auto focus first input =====
    $('#fullName').focus();
    
    // ===== Smooth animation for input focus =====
    $('.form-control').on('focus', function() {
        $(this).parent().find('label').addClass('text-primary');
    }).on('blur', function() {
        $(this).parent().find('label').removeClass('text-primary');
    });
});