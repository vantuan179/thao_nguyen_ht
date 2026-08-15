package com.kidsmath.controller;

import com.kidsmath.model.Grade;
import com.kidsmath.model.Lesson;
import com.kidsmath.model.User;
import com.kidsmath.service.GradeService;
import com.kidsmath.service.LessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
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

	// Chi tiết lớp học - XỬ LÝ /grades/{id}
	@GetMapping("/{id}")
	public String gradeDetail(@PathVariable("id") Integer id, Model model, HttpSession session) {

		User user = (User) session.getAttribute("currentUser");
		Grade grade = gradeService.findById(id);

		if (grade == null) {
			return "redirect:/grades";
		}

		List<Lesson> lessons = lessonService.findByGrade(id);

		// Kiểm tra quyền truy cập
		boolean isLoggedIn = user != null;
		boolean isTrial = false;

		if (user != null) {
			isTrial = "trial".equals(user.getMembershipType()) || user.getMembershipType() == null;
		}

		// Đánh dấu bài học có thể xem
		for (int i = 0; i < lessons.size(); i++) {
			Lesson lesson = lessons.get(i);
			if (isTrial && i > 0) {
				// Trial user chỉ xem được bài đầu tiên
				lesson.setTitle(lesson.getTitle() + " 🔒");
			}
		}

		model.addAttribute("grade", grade);
		model.addAttribute("lessons", lessons);
		model.addAttribute("isLoggedIn", isLoggedIn);
		model.addAttribute("isTrial", isTrial);

		return "user/grade-detail";
	}
}