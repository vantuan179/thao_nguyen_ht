package com.mathkids.controller;

import com.mathkids.model.Lesson;
import com.mathkids.model.Progress;
import com.mathkids.model.Quiz;
import com.mathkids.model.QuizOption;
import com.mathkids.model.User;
import com.mathkids.repository.LessonRepository;
import com.mathkids.repository.ProgressRepository;
import com.mathkids.repository.QuizRepository;
import com.mathkids.repository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final LessonRepository lessonRepository;
    private final QuizRepository quizRepository;
    private final ProgressRepository progressRepository;
    private final UserRepository userRepository;

    public AdminController(LessonRepository lessonRepository, QuizRepository quizRepository,
                           ProgressRepository progressRepository, UserRepository userRepository) {
        this.lessonRepository = lessonRepository;
        this.quizRepository = quizRepository;
        this.progressRepository = progressRepository;
        this.userRepository = userRepository;
    }

    // Lessons
    @GetMapping("/lessons")
    public List<Lesson> getAllLessons() {
        return lessonRepository.findAll();
    }

    @GetMapping("/lessons/{id}")
    public ResponseEntity<Lesson> getLesson(@PathVariable Long id) {
        Optional<Lesson> lesson = lessonRepository.findById(id);
        return lesson.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("/lessons")
    public Lesson createLesson(@RequestBody Lesson lesson) {
        return lessonRepository.save(lesson);
    }

    @PutMapping("/lessons/{id}")
    public ResponseEntity<Lesson> updateLesson(@PathVariable Long id, @RequestBody Lesson lesson) {
        if (lessonRepository.findById(id).isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        lesson.setId(id);
        return ResponseEntity.ok(lessonRepository.save(lesson));
    }

    @DeleteMapping("/lessons/{id}")
    public ResponseEntity<Void> deleteLesson(@PathVariable Long id) {
        lessonRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    // Quizzes
    @GetMapping("/quizzes")
    public List<Quiz> getAllQuizzes() {
        return quizRepository.findAll();
    }

    @GetMapping("/quizzes/{id}")
    public ResponseEntity<Quiz> getQuiz(@PathVariable Long id) {
        Optional<Quiz> quiz = quizRepository.findById(id);
        return quiz.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("/quizzes")
    public ResponseEntity<Quiz> createQuiz(@RequestBody Quiz quiz) {
        Quiz saved = quizRepository.save(quiz);
        if (quiz.getOptions() != null) {
            for (QuizOption option : quiz.getOptions()) {
                option.setQuizId(saved.getId());
                quizRepository.saveOption(option);
            }
        }
        return ResponseEntity.ok(quizRepository.findById(saved.getId()).orElse(saved));
    }

    @PutMapping("/quizzes/{id}")
    public ResponseEntity<Quiz> updateQuiz(@PathVariable Long id, @RequestBody Quiz quiz) {
        if (quizRepository.findById(id).isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        quiz.setId(id);
        Quiz saved = quizRepository.save(quiz);
        if (quiz.getOptions() != null) {
            quizRepository.deleteOptionsByQuizId(id);
            for (QuizOption option : quiz.getOptions()) {
                option.setId(null);
                option.setQuizId(id);
                quizRepository.saveOption(option);
            }
        }
        return ResponseEntity.ok(quizRepository.findById(saved.getId()).orElse(saved));
    }

    @DeleteMapping("/quizzes/{id}")
    public ResponseEntity<Void> deleteQuiz(@PathVariable Long id) {
        quizRepository.deleteOptionsByQuizId(id);
        quizRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    // Options
    @PostMapping("/quizzes/{quizId}/options")
    public ResponseEntity<QuizOption> addOption(@PathVariable Long quizId, @RequestBody QuizOption option) {
        if (quizRepository.findById(quizId).isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        option.setQuizId(quizId);
        return ResponseEntity.ok(quizRepository.saveOption(option));
    }

    @DeleteMapping("/options/{id}")
    public ResponseEntity<Void> deleteOption(@PathVariable Long id) {
        quizRepository.deleteOptionById(id);
        return ResponseEntity.noContent().build();
    }

    // Users
    @GetMapping("/users")
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @PostMapping("/users")
    public User createUser(@RequestBody User user) {
        return userRepository.save(user);
    }

    @DeleteMapping("/users/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    // Progress
    @GetMapping("/progress")
    public List<Progress> getAllProgress() {
        return progressRepository.findAll();
    }

    @DeleteMapping("/progress/{id}")
    public ResponseEntity<Void> deleteProgress(@PathVariable Long id) {
        progressRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}