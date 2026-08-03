$(document).ready(function() {
    // ===== XỬ LÝ CHỌN ĐÁP ÁN =====
    $('.option-item').click(function() {
        const $card = $(this).closest('.quiz-card');
        const $resultArea = $card.find('.result-area');
        const quizId = $card.data('quiz-id');
        const selectedOption = $(this).data('option');
        
        // Nếu đã trả lời rồi thì không cho chọn lại
        if ($resultArea.is(':visible')) {
            return;
        }
        
        // Gọi API kiểm tra
        $.ajax({
            url: '/api/quizzes/' + quizId + '/answer',
            type: 'POST',
            data: { option: selectedOption },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // Hiển thị kết quả
                    $resultArea.show();
                    
                    const $alert = $resultArea.find('.alert');
                    const $icon = $resultArea.find('.result-icon');
                    const $text = $resultArea.find('.result-text');
                    const $points = $resultArea.find('.result-points');
                    const $explanation = $resultArea.find('.explanation-text');
                    
                    if (response.isCorrect) {
                        $alert.removeClass('alert-danger').addClass('alert-success');
                        $icon.html('✅');
                        $text.text('Chính xác! 🎉');
                        $text.css('color', '#28a745');
                        $points.text('+' + response.points + ' điểm');
                        $points.css('color', '#28a745');
                    } else {
                        $alert.removeClass('alert-success').addClass('alert-danger');
                        $icon.html('❌');
                        $text.text('Chưa đúng!');
                        $text.css('color', '#dc3545');
                        $points.text('+0 điểm');
                        $points.css('color', '#dc3545');
                    }
                    
                    // Hiển thị giải thích
                    if (response.explanation) {
                        $explanation.html('<i class="fas fa-info-circle"></i> ' + response.explanation);
                    } else {
                        $explanation.html('<i class="fas fa-info-circle"></i> Đáp án đúng là: ' + response.correctOption);
                    }
                    
                    // Highlight đáp án đúng và sai
                    $card.find('.option-item').each(function() {
                        const $opt = $(this);
                        if ($opt.data('option') === response.correctOption) {
                            $opt.addClass('correct-answer');
                        }
                        if ($opt.data('option') === selectedOption && !response.isCorrect) {
                            $opt.addClass('wrong-answer');
                        }
                    });
                    
                    // Cập nhật tiến độ
                    updateProgress();
                    
                } else {
                    alert(response.message || 'Có lỗi xảy ra!');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('Có lỗi xảy ra! Vui lòng thử lại.');
            }
        });
    });
    
    // ===== HIỂN THỊ ĐÁP ÁN =====
    $('.show-answer-btn').click(function() {
        const $answerText = $(this).siblings('.answer-text');
        if ($answerText.is(':visible')) {
            $answerText.hide();
            $(this).html('<i class="fas fa-eye"></i> Xem đáp án');
        } else {
            $answerText.show();
            $(this).html('<i class="fas fa-eye-slash"></i> Ẩn đáp án');
        }
    });
    
    // ===== CẬP NHẬT TIẾN ĐỘ =====
    function updateProgress() {
        const totalQuestions = $('.quiz-card').length;
        const answered = $('.result-area:visible').length;
        const progress = (answered / totalQuestions) * 100;
        
        $('#progressBar').css('width', progress + '%');
        $('#answeredCount').text(answered);
    }
});