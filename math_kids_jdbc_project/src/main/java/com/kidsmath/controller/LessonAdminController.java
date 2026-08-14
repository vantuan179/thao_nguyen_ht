package com.kidsmath.controller;

import com.kidsmath.model.Lesson;
import com.kidsmath.model.Grade;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/lessons")
public class LessonAdminController extends BaseController {

	@GetMapping
	public String listLessons(Model model) {
		try {
			List<Lesson> lessons = lessonService.findAll();
			List<Grade> grades = gradeService.findAll();

			model.addAttribute("lessons", lessons);
			model.addAttribute("grades", grades);
			return "admin/lesson-list";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "admin/lesson-list";
		}
	}

	@GetMapping("/add")
	public String showAddForm(Model model) {
		List<Grade> grades = gradeService.findAll();
		model.addAttribute("lesson", new Lesson());
		model.addAttribute("grades", grades);
		return "admin/lesson-form";
	}

	@PostMapping("/add")
	public String addLesson(@ModelAttribute Lesson lesson, RedirectAttributes redirectAttributes) {
		try {
			lessonService.save(lesson);
			redirectAttributes.addFlashAttribute("success", "Thêm bài học '" + lesson.getTitle() + "' thành công!");
			return "redirect:/admin/lessons";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/lessons/add";
		}
	}

	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		try {
			Lesson lesson = lessonService.findById(id);
			if (lesson == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy bài học!");
				return "redirect:/admin/lessons";
			}
			List<Grade> grades = gradeService.findAll();
			int quizCount = quizService.countByLessonId(id);

			model.addAttribute("lesson", lesson);
			model.addAttribute("grades", grades);
			model.addAttribute("quizCount", quizCount);
			return "admin/lesson-form";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/lessons";
		}
	}

	@PostMapping("/edit/{id}")
	public String updateLesson(@PathVariable Integer id, @ModelAttribute Lesson lesson, RedirectAttributes redirectAttributes) {
		try {
			lesson.setId(id);
			lessonService.update(lesson);
			redirectAttributes.addFlashAttribute("success", "Cập nhật bài học '" + lesson.getTitle() + "' thành công!");
			return "redirect:/admin/lessons";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/lessons/edit/" + id;
		}
	}

	@GetMapping("/delete/{id}")
	public String deleteLesson(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			Lesson lesson = lessonService.findById(id);
			if (lesson == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy bài học!");
				return "redirect:/admin/lessons";
			}

			int quizCount = quizService.countByLessonId(id);
			if (quizCount > 0) {
				redirectAttributes.addFlashAttribute("error", "Không thể xóa bài học '" + lesson.getTitle() + "' vì có " + quizCount + " câu hỏi!");
				return "redirect:/admin/lessons";
			}

			lessonService.deleteById(id);
			redirectAttributes.addFlashAttribute("success", "Xóa bài học '" + lesson.getTitle() + "' thành công!");
			return "redirect:/admin/lessons";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/lessons";
		}
	}
}