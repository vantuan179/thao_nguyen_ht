package com.kidsmath.controller;

import com.kidsmath.model.Grade;
import com.kidsmath.model.Lesson;
import com.kidsmath.model.Quiz;
import com.kidsmath.model.User;
import com.kidsmath.service.GradeService;
import com.kidsmath.service.LessonService;
import com.kidsmath.service.QuizService;
import com.kidsmath.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private LessonService lessonService;

	@Autowired
	private QuizService quizService;

	@Autowired
	private UserService userService;

	@Autowired
	private GradeService gradeService;

	@GetMapping
	public String adminDashboard(Model model) {
		// Thống kê
		List<Lesson> lessons = lessonService.findAll();
		List<Quiz> quizzes = quizService.findAll();
		List<User> users = userService.findAll();
		List<Grade> grades = gradeService.findAll();

		model.addAttribute("lessons", lessons);
		model.addAttribute("quizzes", quizzes);
		model.addAttribute("users", users);
		model.addAttribute("grades", grades);

		// Thống kê số lượng
		model.addAttribute("totalLessons", lessons.size());
		model.addAttribute("totalQuizzes", quizzes.size());
		model.addAttribute("totalUsers", users.size());
		model.addAttribute("totalGrades", grades.size());
		model.addAttribute("activeGrades", gradeService.countActive());

		return "admin/dashboard";
	}
}