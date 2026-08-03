package com.kidsmath.controller;

import com.kidsmath.model.Quiz;
import com.kidsmath.model.User;
import com.kidsmath.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
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
			// Lấy user hiện tại từ session
			User user = (User) session.getAttribute("currentUser");
			Integer userId = (user != null) ? user.getId() : null;

			// Tìm câu hỏi
			Quiz quiz = quizService.findById(quizId);
			if (quiz == null) {
				response.put("success", false);
				response.put("message", "Không tìm thấy câu hỏi!");
				return response;
			}

			// Kiểm tra đáp án
			boolean isCorrect = quiz.getCorrectOption().equalsIgnoreCase(option);

			// Xây dựng response
			response.put("success", true);
			response.put("isCorrect", isCorrect);
			response.put("correctOption", quiz.getCorrectOption());
			response.put("explanation", quiz.getExplanation() != null ? quiz.getExplanation() : "Không có giải thích");
			response.put("points", isCorrect ? quiz.getPoints() : 0);

			if (isCorrect) {
				response.put("message", "🎉 Chính xác! Bạn đã trả lời đúng!");

				// TODO: Lưu kết quả đúng vào database nếu có user
				if (userId != null) {
					// quizService.saveUserAnswer(userId, quizId, option, true);
					// quizService.updateUserScore(userId, quiz.getPoints());
				}
			} else {
				response.put("message", "❌ Chưa đúng! Đáp án đúng là " + quiz.getCorrectOption());

				// TODO: Lưu kết quả sai vào database nếu có user
				if (userId != null) {
					// quizService.saveUserAnswer(userId, quizId, option, false);
				}
			}

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Có lỗi xảy ra: " + e.getMessage());
			e.printStackTrace();
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