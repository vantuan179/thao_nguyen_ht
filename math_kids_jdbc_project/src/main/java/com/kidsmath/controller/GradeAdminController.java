package com.kidsmath.controller;

import com.kidsmath.model.Grade;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/grades")
public class GradeAdminController extends BaseController {

	@GetMapping
	public String listGrades(Model model) {
		try {
			List<Grade> grades = gradeService.findAll();
			model.addAttribute("grades", grades);
			return "admin/grade-list";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "admin/grade-list";
		}
	}

	@GetMapping("/create")
	public String showCreateForm(Model model) {
		model.addAttribute("grade", new Grade());
		model.addAttribute("maxOrder", gradeService.getMaxDisplayOrder());
		return "admin/grade-form";
	}

	@PostMapping("/create")
	public String createGrade(@ModelAttribute Grade grade, RedirectAttributes redirectAttributes) {
		try {
			if (gradeService.existsByGradeName(grade.getGradeName())) {
				redirectAttributes.addFlashAttribute("error", "Tên lớp '" + grade.getGradeName() + "' đã tồn tại!");
				return "redirect:/admin/grades/create";
			}
			gradeService.save(grade);
			redirectAttributes.addFlashAttribute("success", "Thêm lớp học '" + grade.getGradeName() + "' thành công!");
			return "redirect:/admin/grades";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/grades/create";
		}
	}

	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		try {
			Grade grade = gradeService.findById(id);
			if (grade == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy lớp học!");
				return "redirect:/admin/grades";
			}
			model.addAttribute("grade", grade);
			model.addAttribute("lessonCount", gradeService.countLessonsByGradeId(id));
			return "admin/grade-form";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/grades";
		}
	}

	@PostMapping("/edit/{id}")
	public String updateGrade(@PathVariable Integer id, @ModelAttribute Grade grade, RedirectAttributes redirectAttributes) {
		try {
			Grade existing = gradeService.findById(id);
			if (existing == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy lớp học!");
				return "redirect:/admin/grades";
			}

			if (!existing.getGradeName().equals(grade.getGradeName()) && gradeService.existsByGradeName(grade.getGradeName())) {
				redirectAttributes.addFlashAttribute("error", "Tên lớp '" + grade.getGradeName() + "' đã tồn tại!");
				return "redirect:/admin/grades/edit/" + id;
			}

			grade.setId(id);
			gradeService.update(grade);
			redirectAttributes.addFlashAttribute("success", "Cập nhật lớp học '" + grade.getGradeName() + "' thành công!");
			return "redirect:/admin/grades";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/grades/edit/" + id;
		}
	}

	@GetMapping("/view/{id}")
	public String viewGrade(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		try {
			Grade grade = gradeService.findById(id);
			if (grade == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy lớp học!");
				return "redirect:/admin/grades";
			}
			model.addAttribute("grade", grade);
			model.addAttribute("lessonCount", gradeService.countLessonsByGradeId(id));
			return "admin/grade-view";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/grades";
		}
	}

	@GetMapping("/delete/{id}")
	public String deleteGrade(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			Grade grade = gradeService.findById(id);
			if (grade == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy lớp học!");
				return "redirect:/admin/grades";
			}

			int lessonCount = gradeService.countLessonsByGradeId(id);
			if (lessonCount > 0) {
				redirectAttributes.addFlashAttribute("error", "Không thể xóa lớp '" + grade.getGradeName() + "' vì có " + lessonCount + " bài học!");
				return "redirect:/admin/grades";
			}

			boolean deleted = gradeService.deleteById(id);
			if (deleted) {
				redirectAttributes.addFlashAttribute("success", "Xóa lớp học '" + grade.getGradeName() + "' thành công!");
			} else {
				redirectAttributes.addFlashAttribute("error", "Không thể xóa lớp học!");
			}
			return "redirect:/admin/grades";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/grades";
		}
	}

	@GetMapping("/search")
	public String searchGrades(@RequestParam String keyword, Model model) {
		try {
			List<Grade> grades = gradeService.searchByGradeName(keyword);
			model.addAttribute("grades", grades);
			model.addAttribute("keyword", keyword);
			return "admin/grade-list";
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "admin/grade-list";
		}
	}

	@GetMapping("/soft-delete/{id}")
	public String softDeleteGrade(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			Grade grade = gradeService.findById(id);
			if (grade == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy lớp học!");
				return "redirect:/admin/grades";
			}

			if (!grade.getActive()) {
				redirectAttributes.addFlashAttribute("warning", "Lớp học '" + grade.getGradeName() + "' đã bị vô hiệu hóa!");
				return "redirect:/admin/grades";
			}

			gradeService.softDelete(id);
			redirectAttributes.addFlashAttribute("success", "Đã vô hiệu hóa lớp học '" + grade.getGradeName() + "'!");
			return "redirect:/admin/grades";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/grades";
		}
	}

	@GetMapping("/restore/{id}")
	public String restoreGrade(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			Grade grade = gradeService.findById(id);
			if (grade == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy lớp học!");
				return "redirect:/admin/grades";
			}

			if (grade.getActive()) {
				redirectAttributes.addFlashAttribute("warning", "Lớp học '" + grade.getGradeName() + "' đang hoạt động!");
				return "redirect:/admin/grades";
			}

			grade.setActive(true);
			gradeService.update(grade);
			redirectAttributes.addFlashAttribute("success", "Đã khôi phục lớp học '" + grade.getGradeName() + "'!");
			return "redirect:/admin/grades";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/grades";
		}
	}
}