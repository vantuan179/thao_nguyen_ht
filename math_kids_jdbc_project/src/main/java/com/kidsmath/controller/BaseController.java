package com.kidsmath.controller;

import com.kidsmath.service.EmailService;
import com.kidsmath.service.GradeService;
import com.kidsmath.service.LessonService;
import com.kidsmath.service.MembershipService;
import com.kidsmath.service.QuizService;
import com.kidsmath.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

public class BaseController {

	@Autowired
	protected GradeService gradeService;

	@Autowired
	protected LessonService lessonService;

	@Autowired
	protected QuizService quizService;

	@Autowired
	protected UserService userService;

	@Autowired
	protected EmailService emailService;

	@Autowired
	protected MembershipService membershipService;

	@ModelAttribute
	public void addCommonAttributes(Model model) {
		try {
			// Thống kê chung cho sidebar
			model.addAttribute("totalGrades", gradeService.countAll());
			model.addAttribute("activeGrades", gradeService.countActive());
			model.addAttribute("totalLessons", lessonService.findAll().size());
			model.addAttribute("totalQuizzes", quizService.findAll().size());
			model.addAttribute("totalUsers", userService.findAll().size());
			model.addAttribute("totalEmails", emailService.getTotalEmailsSent());

			// Thống kê thành viên
			model.addAttribute("totalPremium", userService.countByMembershipType("premium"));

			// Lấy số lượng thanh toán pending
			List<?> pendingList = membershipService.getPendingPayments();
			int pendingCount = (pendingList != null) ? pendingList.size() : 0;
			model.addAttribute("pendingPaymentsCount", pendingCount);

		} catch (Exception e) {
			// Giá trị mặc định nếu có lỗi
			model.addAttribute("totalGrades", 0);
			model.addAttribute("activeGrades", 0);
			model.addAttribute("totalLessons", 0);
			model.addAttribute("totalQuizzes", 0);
			model.addAttribute("totalUsers", 0);
			model.addAttribute("totalEmails", 0);
			model.addAttribute("totalPremium", 0);
			model.addAttribute("pendingPaymentsCount", 0);
		}
	}
}