package com.kidsmath.controller;

import com.kidsmath.model.Quiz;
import com.kidsmath.model.User;
import com.kidsmath.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/quizzes")
public class QuizRestController {

	@Autowired
	private QuizService quizService;

	@GetMapping("/lesson/{lessonId}")
	public List<Quiz> getQuizzesByLesson(@PathVariable Integer lessonId) {
		return quizService.findByLessonId(lessonId);
	}

	@PostMapping("/{quizId}/answer")
	public Map<String, Object> submitAnswer(@PathVariable Integer quizId, @RequestParam String option, HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		Integer userId = (user != null) ? user.getId() : 1; // mặc định user 1 nếu chưa đăng nhập
		return quizService.checkAnswer(quizId, option, userId);
	}
}
