/**
 * main.js - jQuery xử lý tương tác bài tập toán cho trẻ em
 * Hiệu ứng: animate__bounce (đúng), animate__shakeX (sai), pháo hoa confetti
 * Gọi AJAX đến backend Spring Boot không load lại trang
 */

$(function () {
    // Xử lý click đáp án
    $('.option-btn').on('click', function () {
        let $btn = $(this);
        let $card = $btn.closest('.quiz-card');
        let quizId = $card.data('quiz-id');
        let selectedOption = $btn.data('option');

        // Tránh click nhiều lần
        if ($card.hasClass('answered')) return;
        $card.addClass('answered');
        $card.find('.option-btn').prop('disabled', true);

        $.ajax({
            url: '/api/quizzes/' + quizId + '/answer',
            type: 'POST',
            data: { option: selectedOption },
            success: function (res) {
                let isCorrect = res.correct;
                let correctOption = res.correctOption;
                let feedbackBox = $card.find('.feedback');

                // Đánh dấu đáp án đúng/sai
                $card.find('.option-btn').each(function () {
                    let opt = $(this).data('option');
                    if (opt === correctOption) {
                        $(this).addClass('correct');
                    }
                });

                if (isCorrect) {
                    $btn.addClass('correct');
                    $btn.addClass('animate__animated animate__bounce');
                    feedbackBox.html('<span class="text-success">🎉 Chính xác! ' + (res.explanation || '') + '</span>');
                    feedbackBox.addClass('animate__animated animate__bounceIn');
                    fireConfetti($card);
                } else {
                    $btn.addClass('wrong');
                    $btn.addClass('animate__animated animate__shakeX');
                    feedbackBox.html('<span class="text-danger">😢 Sai rồi! Đáp án đúng là ' + correctOption + '. ' + (res.explanation || '') + '</span>');
                    feedbackBox.addClass('animate__animated animate__shakeX');
                }

                // Cập nhật điểm
                if (res.score !== undefined) {
                    $('#total-score').text(res.score);
                }
                if (res.correctCount !== undefined) {
                    $('#correct-count').text(res.correctCount);
                }

                // Xóa class animate sau khi chạy xong để có thể tái sử dụng
                setTimeout(function () {
                    $btn.removeClass('animate__animated animate__bounce animate__shakeX');
                    feedbackBox.removeClass('animate__animated animate__bounceIn animate__shakeX');
                }, 1200);
            },
            error: function () {
                $card.find('.feedback').html('<span class="text-danger">⚠️ Không kết nối được máy chủ, thử lại nhé!</span>');
                $card.removeClass('answered');
                $card.find('.option-btn').prop('disabled', false);
            }
        });
    });

    // Hiệu ứng pháo hoa confetti khi trả lời đúng
    function fireConfetti($target) {
        let colors = ['#ff6f91', '#ff9671', '#ffc75f', '#f9f871', '#845ec2', '#00c9a7'];
        let rect = $target[0].getBoundingClientRect();
        let centerX = rect.left + rect.width / 2;
        let centerY = rect.top + rect.height / 2;

        for (let i = 0; i < 40; i++) {
            let $confetti = $('<div class="confetti"></div>');
            $confetti.css({
                left: centerX + 'px',
                top: centerY + 'px',
                background: colors[Math.floor(Math.random() * colors.length)],
                transform: 'rotate(' + Math.random() * 360 + 'deg)'
            });
            $('body').append($confetti);

            // Bay ngẫu nhiên sang hai bên
            let xMove = (Math.random() - 0.5) * 300;
            $confetti.animate({
                top: centerY + 200 + Math.random() * 150,
                left: centerX + xMove,
                opacity: 0
            }, 1200 + Math.random() * 1000, function () {
                $(this).remove();
            });
        }
    }

    // Hiệu ứng hover sinh động cho các nút
    $(document).on('mouseenter', '.option-btn:not(:disabled)', function () {
        $(this).addClass('animate__animated animate__pulse');
    }).on('mouseleave', '.option-btn:not(:disabled)', function () {
        $(this).removeClass('animate__animated animate__pulse');
    });
});
