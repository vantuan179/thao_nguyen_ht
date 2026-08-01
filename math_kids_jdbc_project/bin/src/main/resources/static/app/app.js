angular.module('mathKidsApp', [])
    .controller('MainController', ['$scope', '$http', '$timeout', function($scope, $http, $timeout) {
        $scope.currentUser = null;
        $scope.studentName = '';
        $scope.lessons = [];
        $scope.selectedLesson = null;
        $scope.quizzes = [];
        $scope.currentIndex = 0;
        $scope.currentQuiz = null;
        $scope.studentAnswer = '';
        $scope.answered = false;
        $scope.feedbackMessage = '';
        $scope.feedbackClass = '';
        $scope.finished = false;
        $scope.correctCount = 0;
        $scope.encourageText = '';
        $scope.lessonIcons = ['🔢', '➕', '➖', '✖️', '➗', '📐', '🧮', '🎓'];

        var API = '/api/student';

        $scope.login = function() {
            if (!$scope.studentName.trim()) return;
            var user = {
                username: $scope.studentName.trim().toLowerCase().replace(/\s+/g, ''),
                fullName: $scope.studentName.trim(),
                passwordHash: 'kid123'
            };
            $http.post(API + '/register', user).then(function(res) {
                $scope.currentUser = res.data;
                loadLessons();
            }, function(err) {
                // If exists, try to fetch by username (simplified)
                $scope.currentUser = { id: 1, username: user.username, fullName: user.fullName };
                loadLessons();
            });
        };

        function loadLessons() {
            $http.get(API + '/lessons').then(function(res) {
                $scope.lessons = res.data;
            });
        }

        $scope.selectLesson = function(lesson) {
            $scope.selectedLesson = lesson;
            $scope.currentIndex = 0;
            $scope.correctCount = 0;
            $scope.finished = false;
            $scope.feedbackMessage = '';
            $http.get(API + '/lessons/' + lesson.id + '/quizzes').then(function(res) {
                $scope.quizzes = res.data;
                $scope.loadCurrentQuiz();
            });
        };

        $scope.loadCurrentQuiz = function() {
            $scope.answered = false;
            $scope.studentAnswer = '';
            $scope.feedbackMessage = '';
            if ($scope.currentIndex < $scope.quizzes.length) {
                $scope.currentQuiz = $scope.quizzes[$scope.currentIndex];
            } else {
                $scope.finished = true;
                $scope.encourageText = getEncourageText($scope.correctCount, $scope.quizzes.length);
                if ($scope.correctCount === $scope.quizzes.length) {
                    launchFireworks();
                }
            }
        };

        $scope.submitAnswer = function(answer) {
            if ($scope.answered || !answer) return;
            var payload = {
                userId: $scope.currentUser.id,
                quizId: $scope.currentQuiz.id,
                answer: answer
            };
            $http.post(API + '/submit', payload).then(function(res) {
                var result = res.data;
                $scope.answered = true;
                if (result.correct) {
                    $scope.correctCount++;
                    $scope.feedbackMessage = '🎉 Chính xác! Bé giỏi quá!';
                    $scope.feedbackClass = 'feedback-success animate__animated animate__bounceIn';
                    launchBalloons(8);
                    launchFireworks();
                } else {
                    $scope.feedbackMessage = '😅 Chưa đúng rồi! Đáp án đúng là: ' + result.correctAnswer;
                    $scope.feedbackClass = 'feedback-error animate__animated animate__shakeX';
                }
            });
        };

        $scope.nextQuestion = function() {
            $scope.currentIndex++;
            $scope.loadCurrentQuiz();
        };

        $scope.backToLessons = function() {
            $scope.selectedLesson = null;
            $scope.quizzes = [];
            $scope.currentQuiz = null;
            $scope.finished = false;
            $scope.currentIndex = 0;
            $scope.correctCount = 0;
            loadLessons();
        };

        function getEncourageText(correct, total) {
            if (correct === total) return '🌟 Tuyệt vời! Bé đã trả lời đúng tất cả!';
            if (correct >= total * 0.7) return '👏 Rất tốt! Bé cố gắng thêm nhé!';
            if (correct >= total * 0.4) return '💪 Khá lắm! Luyện tập thêm để giỏi hơn!';
            return '🌱 Cố lên bé nhé! Thử lại một lần nữa!';
        }

        function launchBalloons(count) {
            var layer = document.getElementById('effects');
            var colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#a18cd1', '#74b9ff', '#55efc4'];
            for (var i = 0; i < count; i++) {
                var b = document.createElement('div');
                b.className = 'balloon';
                b.style.left = Math.random() * 100 + 'vw';
                b.style.background = colors[Math.floor(Math.random() * colors.length)];
                b.style.animationDuration = (3 + Math.random() * 2) + 's';
                b.style.animationDelay = (Math.random() * 0.5) + 's';
                layer.appendChild(b);
                $timeout(function(el) { return function() { if (el.parentNode) el.parentNode.removeChild(el); }; }(b), 5000);
            }
        }

        function launchFireworks() {
            var layer = document.getElementById('effects');
            var colors = ['#ff6b6b', '#ffe66d', '#4ecdc4', '#a18cd1', '#74b9ff', '#55efc4', '#fd79a8'];
            var originX = Math.random() * 80 + 10;
            var originY = Math.random() * 50 + 20;
            for (var i = 0; i < 30; i++) {
                var p = document.createElement('div');
                p.className = 'firework';
                p.style.left = originX + 'vw';
                p.style.top = originY + 'vh';
                p.style.background = colors[Math.floor(Math.random() * colors.length)];
                var angle = Math.random() * Math.PI * 2;
                var distance = Math.random() * 150 + 50;
                p.style.setProperty('--tx', Math.cos(angle) * distance + 'px');
                p.style.setProperty('--ty', Math.sin(angle) * distance + 'px');
                layer.appendChild(p);
                $timeout(function(el) { return function() { if (el.parentNode) el.parentNode.removeChild(el); }; }(p), 1100);
            }
        }
    }]);