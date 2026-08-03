package com.kidsmath.controller;

import com.kidsmath.model.Grade;
import com.kidsmath.model.Lesson;
import com.kidsmath.service.GradeService;
import com.kidsmath.service.LessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/grades")
public class GradeController {

	@Autowired
	private GradeService gradeService;

	@Autowired
	private LessonService lessonService;

	// Danh sách lớp học
	@GetMapping
	public String listGrades(Model model) {
		List<Grade> grades = gradeService.findActiveGrades();
		for (Grade grade : grades) {
			List<Lesson> lessons = lessonService.findByGrade(grade.getId());
			grade.setLessons(lessons);
		}
		model.addAttribute("grades", grades);
		return "user/grade-list";
	}

	// Chi tiết lớp học - QUAN TRỌNG: Đây là method xử lý /grades/{id}
	@GetMapping("/{id}")
	public String gradeDetail(@PathVariable("id") Integer id, Model model) {
		System.out.println("=== GRADE DETAIL CALLED ===");
		System.out.println("Grade ID: " + id);

		Grade grade = gradeService.findById(id);
		if (grade == null) {
			System.out.println("Grade not found for ID: " + id);
			return "redirect:/grades";
		}

		List<Lesson> lessons = lessonService.findByGrade(id);
		System.out.println("Found lessons: " + (lessons != null ? lessons.size() : 0));

		model.addAttribute("grade", grade);
		model.addAttribute("lessons", lessons);
		return "user/grade-detail";
	}
}