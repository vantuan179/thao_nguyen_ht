package com.kidsmath.controller.admin;

import com.kidsmath.model.Lesson;
import com.kidsmath.model.Quiz;
import com.kidsmath.model.User;
import com.kidsmath.service.LessonService;
import com.kidsmath.service.QuizService;
import com.kidsmath.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private LessonService lessonService;

	@Autowired
	private QuizService quizService;

	@Autowired
	private UserService userService;

	private boolean isAdmin(HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		return user != null && "ADMIN".equals(user.getRole());
	}

	@GetMapping("")
	public String adminHome(HttpSession session, Model model) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("lessons", lessonService.findAll());
		model.addAttribute("quizzes", quizService.findAll());
		model.addAttribute("users", userService.findAll());
		return "admin/dashboard";
	}

	@GetMapping("/lessons/add")
	public String addLessonForm(HttpSession session, Model model) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("lesson", new Lesson());
		return "admin/lesson-form";
	}

	@PostMapping("/lessons/save")
	public String saveLesson(HttpSession session, @ModelAttribute Lesson lesson) {
		if (!isAdmin(session))
			return "redirect:/login";
		if (lesson.getId() == null) {
			lessonService.save(lesson);
		} else {
			lessonService.update(lesson);
		}
		return "redirect:/admin";
	}

	@GetMapping("/lessons/edit/{id}")
	public String editLessonForm(HttpSession session, @PathVariable Integer id, Model model) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("lesson", lessonService.findById(id));
		return "admin/lesson-form";
	}

	@GetMapping("/lessons/delete/{id}")
	public String deleteLesson(HttpSession session, @PathVariable Integer id) {
		if (!isAdmin(session))
			return "redirect:/login";
		lessonService.deleteById(id);
		return "redirect:/admin";
	}

	@GetMapping("/quizzes/add")
	public String addQuizForm(HttpSession session, Model model) {
		if (!isAdmin(session))
			return "redirect:/login";
		model.addAttribute("quiz", new Quiz());
		model.addAttribute("lessons", lessonService.findAll());
		return "admin/quiz-form";
	}

	@PostMapping("/quizzes/save")
	public String saveQuiz(HttpSession session, @ModelAttribute Quiz quiz) {
		if (!isAdmin(session))
			return "redirect:/login";
		if (quiz.getId() == null) {
			quizService.findAll();
			// Không có save trong QuizService, gọi trực tiếp DAO hoặc thêm service
		}
		return "redirect:/admin";
	}
}
