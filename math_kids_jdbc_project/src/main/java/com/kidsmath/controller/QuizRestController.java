package com.kidsmath.controller;

import com.kidsmath.model.Quiz;
import com.kidsmath.model.User;
import com.kidsmath.service.QuizService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/quizzes")
public class QuizRestController {

	@Autowired
	private QuizService quizService;

	/**
	 * Kiểm tra đáp án của câu hỏi URL: POST /api/quizzes/{quizId}/answer Body:
	 * option=A (hoặc B, C, D)
	 */
	@PostMapping("/{quizId}/answer")
	public Map<String, Object> submitAnswer(@PathVariable Integer quizId, @RequestParam String option, HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		try {
			Quiz quiz = quizService.findById(quizId);
			if (quiz == null) {
				response.put("success", false);
				response.put("message", "Không tìm thấy câu hỏi!");
				return response;
			}

			boolean isCorrect = quiz.getCorrectOption().equalsIgnoreCase(option);

			response.put("success", true);
			response.put("isCorrect", isCorrect);
			response.put("correctOption", quiz.getCorrectOption());
			response.put("explanation", quiz.getExplanation());
			response.put("points", isCorrect ? quiz.getPoints() : 0);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}

		return response;
	}

	/**
	 * Lấy thông tin chi tiết của câu hỏi URL: GET /api/quizzes/{quizId}
	 */
	@GetMapping("/{quizId}")
	public Map<String, Object> getQuizDetail(@PathVariable Integer quizId) {
		Map<String, Object> response = new HashMap<>();

		try {
			Quiz quiz = quizService.findById(quizId);
			if (quiz == null) {
				response.put("success", false);
				response.put("message", "Không tìm thấy câu hỏi!");
				return response;
			}

			response.put("success", true);
			response.put("quiz", quiz);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Có lỗi xảy ra: " + e.getMessage());
		}

		return response;
	}

	/**
	 * Lấy tất cả câu hỏi của một bài học URL: GET /api/quizzes/lesson/{lessonId}
	 */
	@GetMapping("/lesson/{lessonId}")
	public Map<String, Object> getQuizzesByLesson(@PathVariable Integer lessonId) {
		Map<String, Object> response = new HashMap<>();

		try {
			java.util.List<Quiz> quizzes = quizService.findByLessonId(lessonId);
			int totalPoints = quizService.getTotalPointsByLessonId(lessonId);

			response.put("success", true);
			response.put("quizzes", quizzes);
			response.put("totalPoints", totalPoints);
			response.put("questionCount", quizzes.size());

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Có lỗi xảy ra: " + e.getMessage());
		}

		return response;
	}
}