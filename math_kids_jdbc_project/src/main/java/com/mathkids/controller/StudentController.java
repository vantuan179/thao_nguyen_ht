package com.mathkids.controller;

import com.mathkids.model.Lesson;
import com.mathkids.model.Progress;
import com.mathkids.model.Quiz;
import com.mathkids.model.User;
import com.mathkids.repository.LessonRepository;
import com.mathkids.repository.ProgressRepository;
import com.mathkids.repository.QuizRepository;
import com.mathkids.repository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/student")
public class StudentController {

    private final LessonRepository lessonRepository;
    private final QuizRepository quizRepository;
    private final ProgressRepository progressRepository;
    private final UserRepository userRepository;

    public StudentController(LessonRepository lessonRepository, QuizRepository quizRepository,
                             ProgressRepository progressRepository, UserRepository userRepository) {
        this.lessonRepository = lessonRepository;
        this.quizRepository = quizRepository;
        this.progressRepository = progressRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("/lessons")
    public List<Lesson> getLessons(@RequestParam(required = false) Integer gradeLevel) {
        if (gradeLevel != null) {
            return lessonRepository.findByGradeLevel(gradeLevel);
        }
        return lessonRepository.findAll();
    }

    @GetMapping("/lessons/{id}")
    public ResponseEntity<Lesson> getLesson(@PathVariable Long id) {
        Optional<Lesson> lesson = lessonRepository.findById(id);
        return lesson.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/lessons/{lessonId}/quizzes")
    public List<Quiz> getQuizzesByLesson(@PathVariable Long lessonId) {
        return quizRepository.findByLessonId(lessonId);
    }

    @GetMapping("/quizzes/{id}")
    public ResponseEntity<Quiz> getQuiz(@PathVariable Long id) {
        Optional<Quiz> quiz = quizRepository.findById(id);
        return quiz.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("/submit")
    public ResponseEntity<Map<String, Object>> submitAnswer(@RequestBody Map<String, Object> payload) {
        Long userId = Long.valueOf(payload.get("userId").toString());
        Long quizId = Long.valueOf(payload.get("quizId").toString());
        String answer = payload.get("answer").toString();

        Optional<Quiz> quizOpt = quizRepository.findById(quizId);
        if (quizOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Quiz quiz = quizOpt.get();
        boolean correct = quiz.getCorrectAnswer().equalsIgnoreCase(answer.trim());
        int score = correct ? (quiz.getPoints() != null ? quiz.getPoints() : 10) : 0;

        Optional<Progress> existing = progressRepository.findByUserAndQuiz(userId, quizId);
        Progress progress;
        if (existing.isPresent()) {
            progress = existing.get();
            progress.setAttempts(progress.getAttempts() + 1);
            if (score > progress.getScore()) {
                progress.setScore(score);
            }
            progress.setCompleted(correct || progress.getCompleted());
        } else {
            progress = new Progress();
            progress.setUserId(userId);
            progress.setLessonId(quiz.getLessonId());
            progress.setQuizId(quizId);
            progress.setScore(score);
            progress.setCompleted(correct);
            progress.setAttempts(1);
        }
        progressRepository.save(progress);

        Map<String, Object> result = new HashMap<>();
        result.put("correct", correct);
        result.put("score", score);
        result.put("correctAnswer", quiz.getCorrectAnswer());
        return ResponseEntity.ok(result);
    }

    @GetMapping("/progress/{userId}")
    public List<Progress> getProgress(@PathVariable Long userId) {
        return progressRepository.findByUserId(userId);
    }

    @PostMapping("/register")
    public ResponseEntity<User> registerStudent(@RequestBody User user) {
        user.setRole("STUDENT");
        user.setPasswordHash(user.getPasswordHash());
        User saved = userRepository.save(user);
        saved.setPasswordHash(null);
        return ResponseEntity.ok(saved);
    }
}