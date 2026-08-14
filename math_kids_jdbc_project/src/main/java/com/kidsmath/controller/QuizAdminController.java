package com.kidsmath.controller;

import com.kidsmath.model.Lesson;
import com.kidsmath.model.Quiz;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/quizzes")
public class QuizAdminController extends BaseController {

	@GetMapping
	public String listQuizzes(Model model) {
		try {
			List<Quiz> quizzes = quizService.findAll();
			List<Lesson> lessons = lessonService.findAll();

			model.addAttribute("quizzes", quizzes);
			model.addAttribute("lessons", lessons);
			return "admin/quiz-list";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "admin/quiz-list";
		}
	}

	@GetMapping("/add")
	public String showAddForm(Model model) {
		List<Lesson> lessons = lessonService.findAll();
		model.addAttribute("quiz", new Quiz());
		model.addAttribute("lessons", lessons);
		return "admin/quiz-form";
	}

	@PostMapping("/add")
	public String addQuiz(@ModelAttribute Quiz quiz, RedirectAttributes redirectAttributes) {
		try {
			quizService.save(quiz);
			redirectAttributes.addFlashAttribute("success", "Thêm câu hỏi thành công!");
			return "redirect:/admin/quizzes";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/quizzes/add";
		}
	}

	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		try {
			Quiz quiz = quizService.findById(id);
			if (quiz == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy câu hỏi!");
				return "redirect:/admin/quizzes";
			}
			List<Lesson> lessons = lessonService.findAll();

			model.addAttribute("quiz", quiz);
			model.addAttribute("lessons", lessons);
			return "admin/quiz-form";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/quizzes";
		}
	}

	@PostMapping("/edit/{id}")
	public String updateQuiz(@PathVariable Integer id, @ModelAttribute Quiz quiz, RedirectAttributes redirectAttributes) {
		try {
			quiz.setId(id);
			quizService.update(quiz);
			redirectAttributes.addFlashAttribute("success", "Cập nhật câu hỏi thành công!");
			return "redirect:/admin/quizzes";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/quizzes/edit/" + id;
		}
	}

	@GetMapping("/delete/{id}")
	public String deleteQuiz(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			Quiz quiz = quizService.findById(id);
			if (quiz == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy câu hỏi!");
				return "redirect:/admin/quizzes";
			}

			quizService.deleteById(id);
			redirectAttributes.addFlashAttribute("success", "Xóa câu hỏi thành công!");
			return "redirect:/admin/quizzes";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/quizzes";
		}
	}
}