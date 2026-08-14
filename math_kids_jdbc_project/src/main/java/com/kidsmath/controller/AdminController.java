package com.kidsmath.controller;

import com.kidsmath.model.Grade;
import com.kidsmath.model.Lesson;
import com.kidsmath.model.Quiz;
import com.kidsmath.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {

	@GetMapping
	public String adminDashboard(Model model) {
		List<Grade> grades = gradeService.findAll();
		List<Lesson> lessons = lessonService.findAll();
		List<Quiz> quizzes = quizService.findAll();
		List<User> users = userService.findAll();

		model.addAttribute("grades", grades);
		model.addAttribute("lessons", lessons);
		model.addAttribute("quizzes", quizzes);
		model.addAttribute("users", users);

		return "admin/dashboard";
	}
}