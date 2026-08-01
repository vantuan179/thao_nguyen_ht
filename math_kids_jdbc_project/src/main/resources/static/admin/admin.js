angular.module('adminApp', [])
    .controller('AdminController', ['$scope', '$http', function($scope, $http) {
        $scope.tab = 'lessons';
        $scope.pageTitle = 'Quản lý bài học';
        $scope.lessons = [];
        $scope.quizzes = [];
        $scope.users = [];
        $scope.progressList = [];
        $scope.quizFilter = { lessonId: '' };

        $scope.lessonForm = { open: false, id: null, title: '', description: '', gradeLevel: null, orderIndex: 0 };
        $scope.quizForm = { open: false, id: null, lessonId: '', questionText: '', correctAnswer: '', points: 10, orderIndex: 0, options: [] };

        var API = '/api/admin';

        $scope.setTab = function(tab) {
            $scope.tab = tab;
            switch(tab) {
                case 'lessons':
                    $scope.pageTitle = 'Quản lý bài học';
                    loadLessons();
                    break;
                case 'quizzes':
                    $scope.pageTitle = 'Quản lý câu hỏi';
                    loadLessons();
                    loadQuizzes();
                    break;
                case 'users':
                    $scope.pageTitle = 'Quản lý người dùng';
                    loadUsers();
                    break;
                case 'progress':
                    $scope.pageTitle = 'Theo dõi tiến độ';
                    loadProgress();
                    break;
            }
        };

        function loadLessons() {
            $http.get(API + '/lessons').then(function(res) {
                $scope.lessons = res.data;
            });
        }

        $scope.loadQuizzes = function() {
            var url = API + '/quizzes';
            if ($scope.quizFilter.lessonId) {
                url = '/api/student/lessons/' + $scope.quizFilter.lessonId + '/quizzes';
            }
            $http.get(url).then(function(res) {
                $scope.quizzes = res.data;
            });
        };

        function loadUsers() {
            $http.get(API + '/users').then(function(res) {
                $scope.users = res.data;
            });
        }

        function loadProgress() {
            $http.get(API + '/progress').then(function(res) {
                $scope.progressList = res.data;
            });
        }

        $scope.getLessonTitle = function(lessonId) {
            var lesson = $scope.lessons.find(function(l) { return l.id === lessonId; });
            return lesson ? lesson.title : lessonId;
        };

        // Lesson form
        $scope.openLessonForm = function(lesson) {
            if (lesson) {
                $scope.lessonForm = { open: true, id: lesson.id, title: lesson.title, description: lesson.description, gradeLevel: lesson.gradeLevel, orderIndex: lesson.orderIndex };
            } else {
                $scope.lessonForm = { open: true, id: null, title: '', description: '', gradeLevel: null, orderIndex: 0 };
            }
        };

        $scope.closeLessonForm = function() {
            $scope.lessonForm.open = false;
        };

        $scope.saveLesson = function() {
            var lesson = {
                id: $scope.lessonForm.id,
                title: $scope.lessonForm.title,
                description: $scope.lessonForm.description,
                gradeLevel: $scope.lessonForm.gradeLevel,
                orderIndex: $scope.lessonForm.orderIndex
            };
            var req = lesson.id ? $http.put(API + '/lessons/' + lesson.id, lesson) : $http.post(API + '/lessons', lesson);
            req.then(function() {
                $scope.closeLessonForm();
                loadLessons();
            });
        };

        $scope.deleteLesson = function(id) {
            if (!confirm('Xóa bài học này?')) return;
            $http.delete(API + '/lessons/' + id).then(function() {
                loadLessons();
            });
        };

        // Quiz form
        $scope.openQuizForm = function(quiz) {
            if (quiz) {
                $scope.quizForm = {
                    open: true,
                    id: quiz.id,
                    lessonId: quiz.lessonId,
                    questionText: quiz.questionText,
                    correctAnswer: quiz.correctAnswer,
                    points: quiz.points,
                    orderIndex: quiz.orderIndex,
                    options: quiz.options ? quiz.options.map(function(o) { return { id: o.id, optionText: o.optionText, correct: o.correct }; }) : []
                };
            } else {
                $scope.quizForm = { open: true, id: null, lessonId: '', questionText: '', correctAnswer: '', points: 10, orderIndex: 0, options: [] };
            }
        };

        $scope.closeQuizForm = function() {
            $scope.quizForm.open = false;
        };

        $scope.addOption = function() {
            $scope.quizForm.options.push({ optionText: '', correct: false });
        };

        $scope.removeOption = function(index) {
            $scope.quizForm.options.splice(index, 1);
        };

        $scope.saveQuiz = function() {
            var quiz = {
                id: $scope.quizForm.id,
                lessonId: $scope.quizForm.lessonId,
                questionText: $scope.quizForm.questionText,
                questionType: $scope.quizForm.options.length > 0 ? 'MULTIPLE_CHOICE' : 'INPUT',
                correctAnswer: $scope.quizForm.correctAnswer,
                points: $scope.quizForm.points,
                orderIndex: $scope.quizForm.orderIndex,
                options: $scope.quizForm.options
            };
            var req = quiz.id ? $http.put(API + '/quizzes/' + quiz.id, quiz) : $http.post(API + '/quizzes', quiz);
            req.then(function() {
                $scope.closeQuizForm();
                $scope.loadQuizzes();
            });
        };

        $scope.deleteQuiz = function(id) {
            if (!confirm('Xóa câu hỏi này?')) return;
            $http.delete(API + '/quizzes/' + id).then(function() {
                $scope.loadQuizzes();
            });
        };

        $scope.deleteUser = function(id) {
            if (!confirm('Xóa người dùng này?')) return;
            $http.delete(API + '/users/' + id).then(function() {
                loadUsers();
            });
        };

        // Init
        loadLessons();
    }]);