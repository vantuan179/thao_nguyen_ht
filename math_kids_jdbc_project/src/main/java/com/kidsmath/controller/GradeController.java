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

	// Hiển thị danh sách lớp học cho user
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

	// Hiển thị chi tiết lớp học và danh sách bài học
	@GetMapping("/{id}")
	public String gradeDetail(@PathVariable("id") Integer id, Model model) {
		Grade grade = gradeService.findById(id);
		if (grade == null) {
			return "redirect:/grades";
		}

		List<Lesson> lessons = lessonService.findByGrade(id);
		model.addAttribute("grade", grade);
		model.addAttribute("lessons", lessons);
		return "user/grade-detail";
	}
}