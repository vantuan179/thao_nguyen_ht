$(document).ready(function() {
    console.log('Home page loaded');

    // Smooth scroll to grades section
    $('.hero .btn').click(function(e) {
        e.preventDefault();
        var target = $(this).attr('href');
        $('html, body').animate({
            scrollTop: $(target).offset().top - 80
        }, 800);
    });

    // Animation for lesson cards
    $('.lesson-card').each(function(index) {
        $(this).css('animation-delay', (index * 0.1) + 's');
    });
});