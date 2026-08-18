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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserController {

	@Autowired
	private LessonService lessonService;

	@Autowired
	private QuizService quizService;

	@Autowired
	private UserService userService;

	@Autowired
	private GradeService gradeService;

	// ===== HOME - Hiển thị danh sách lớp học =====
	@GetMapping("/")
	public String home(Model model, HttpSession session) {
		List<Grade> grades = gradeService.findActiveGrades();
		for (Grade grade : grades) {
			List<Lesson> lessons = lessonService.findByGrade(grade.getId());
			grade.setLessons(lessons);
		}
		model.addAttribute("grades", grades);
		return "user/home";
	}

	// ===== XÓA METHOD NÀY - ĐÃ CÓ TRONG GradeController =====
	/*
	 * @GetMapping("/grades/{id}") public String gradeDetail(@PathVariable("id")
	 * Integer id, Model model, HttpSession session) { // ... code ... return
	 * "user/grade-detail"; }
	 */

	// ===== LESSON DETAIL =====
	@GetMapping("/lesson/{id}")
	public String lessonDetail(@PathVariable("id") Integer id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {

		User user = (User) session.getAttribute("currentUser");
		Lesson lesson = lessonService.findById(id);

		if (lesson == null) {
			return "redirect:/";
		}

		// Kiểm tra quyền truy cập
		if (user == null) {
			redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem nội dung bài học!");
			return "redirect:/login";
		}

		// Nếu là user dùng thử (trial)
		if ("trial".equals(user.getMembershipType()) || user.getMembershipType() == null) {
			List<Lesson> lessonsInGrade = lessonService.findByGrade(lesson.getGrade());
			if (lessonsInGrade != null && !lessonsInGrade.isEmpty()) {
				Lesson firstLesson = lessonsInGrade.get(0);
				if (!firstLesson.getId().equals(id)) {
					redirectAttributes.addFlashAttribute("error", "Bạn đang sử dụng gói dùng thử. Chỉ có thể xem bài học đầu tiên của mỗi lớp. Vui lòng đăng ký thành viên để xem tất cả bài học!");
					return "redirect:/lesson/" + firstLesson.getId();
				}
			}
		}

		// Lấy danh sách câu hỏi
		List<Quiz> quizzes = quizService.findByLessonId(id);
		int totalPoints = quizService.getTotalPointsByLessonId(id);

		// Kiểm tra quyền xem câu hỏi
		boolean canViewQuizzes = false;
		boolean isTrialUser = false;
		boolean isPremiumUser = false;
		boolean isAdmin = false;

		if (user != null) {
			isTrialUser = "trial".equals(user.getMembershipType()) || user.getMembershipType() == null;
			isPremiumUser = "premium".equals(user.getMembershipType());
			isAdmin = "ADMIN".equals(user.getRole());

			if (isPremiumUser || isAdmin) {
				canViewQuizzes = true;
			} else if (isTrialUser) {
				// Trial user chỉ xem được 3 câu hỏi đầu tiên
				if (quizzes != null && quizzes.size() > 3) {
					quizzes = quizzes.subList(0, 3);
				}
				canViewQuizzes = true;
			}
		}

		model.addAttribute("lesson", lesson);
		model.addAttribute("quizzes", quizzes);
		model.addAttribute("totalPoints", totalPoints);
		model.addAttribute("questionCount", quizzes != null ? quizzes.size() : 0);
		model.addAttribute("canViewQuizzes", canViewQuizzes);
		model.addAttribute("isTrialUser", isTrialUser);
		model.addAttribute("isPremiumUser", isPremiumUser);
		model.addAttribute("isLoggedIn", user != null);
		model.addAttribute("isAdmin", isAdmin);

		return "user/lesson";
	}

	// ===== LOGIN =====
	@GetMapping("/login")
	public String loginPage() {
		return "user/login";
	}

	@PostMapping("/login")
	public String doLogin(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
		User user = userService.findByUsername(username);
		if (user != null && user.getPassword().equals(password)) {
			session.setAttribute("currentUser", user);
			if ("ADMIN".equals(user.getRole())) {
				return "redirect:/admin";
			}
			return "redirect:/";
		}
		model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
		return "user/login";
	}

	// ===== REGISTER =====
	@GetMapping("/register")
	public String registerPage() {
		return "user/register";
	}

	@PostMapping("/register")
	public String doRegister(@RequestParam String fullName, @RequestParam String username, @RequestParam String email, @RequestParam String password, @RequestParam String confirmPassword, @RequestParam(value = "agreeTerms", defaultValue = "false") boolean agreeTerms, Model model, RedirectAttributes redirectAttributes) {

		if (!agreeTerms) {
			model.addAttribute("error", "Vui lòng đồng ý với điều khoản sử dụng!");
			model.addAttribute("fullName", fullName);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			return "user/register";
		}

		if (!password.equals(confirmPassword)) {
			model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
			model.addAttribute("fullName", fullName);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			return "user/register";
		}

		if (password.length() < 6) {
			model.addAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
			model.addAttribute("fullName", fullName);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			return "user/register";
		}

		if (userService.existsByUsername(username)) {
			model.addAttribute("error", "Tên đăng nhập '" + username + "' đã được sử dụng!");
			model.addAttribute("fullName", fullName);
			model.addAttribute("email", email);
			return "user/register";
		}

		if (userService.existsByEmail(email)) {
			model.addAttribute("error", "Email '" + email + "' đã được sử dụng!");
			model.addAttribute("fullName", fullName);
			model.addAttribute("username", username);
			return "user/register";
		}

		if (!isValidEmail(email)) {
			model.addAttribute("error", "Email không hợp lệ!");
			model.addAttribute("fullName", fullName);
			model.addAttribute("username", username);
			return "user/register";
		}

		if (!isValidUsername(username)) {
			model.addAttribute("error", "Tên đăng nhập chỉ bao gồm chữ, số và dấu gạch dưới, từ 3-20 ký tự!");
			model.addAttribute("fullName", fullName);
			model.addAttribute("email", email);
			return "user/register";
		}

		try {
			User newUser = new User();
			newUser.setFullName(fullName.trim());
			newUser.setUsername(username.trim());
			newUser.setEmail(email.trim());
			newUser.setPassword(password);
			newUser.setRole("USER");
			newUser.setMembershipType("trial");
			newUser.setMembershipStatus("active");

			userService.save(newUser);

			redirectAttributes.addFlashAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập để bắt đầu học.");

			return "redirect:/login";

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi đăng ký! Vui lòng thử lại.");
			model.addAttribute("fullName", fullName);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			return "user/register";
		}
	}

	// ===== LOGOUT =====
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	// ===== VALIDATION METHODS =====
	private boolean isValidEmail(String email) {
		if (email == null || email.trim().isEmpty()) {
			return false;
		}
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
		return email.trim().matches(emailRegex);
	}

	private boolean isValidUsername(String username) {
		if (username == null || username.trim().isEmpty()) {
			return false;
		}
		String usernameRegex = "^[a-zA-Z0-9_]{3,20}$";
		return username.trim().matches(usernameRegex);
	}

	// ===== PROFILE =====
	@GetMapping("/profile")
	public String profilePage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}
		return "user/profile";
	}

	@PostMapping("/profile/update")
	public String updateProfile(@RequestParam String fullName, @RequestParam String email, HttpSession session, RedirectAttributes redirectAttributes) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}

		try {
			user.setFullName(fullName);
			user.setEmail(email);
			userService.update(user);
			session.setAttribute("currentUser", user);
			redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}
		return "redirect:/profile";
	}

	@PostMapping("/profile/change-password")
	public String changePassword(@RequestParam String oldPassword, @RequestParam String newPassword, @RequestParam String confirmPassword, HttpSession session, RedirectAttributes redirectAttributes) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}

		if (!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("error", "Mật khẩu xác nhận không khớp!");
			return "redirect:/profile";
		}

		if (newPassword.length() < 6) {
			redirectAttributes.addFlashAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
			return "redirect:/profile";
		}

		boolean success = userService.changePassword(user.getUsername(), oldPassword, newPassword);
		if (success) {
			redirectAttributes.addFlashAttribute("success", "Đổi mật khẩu thành công!");
		} else {
			redirectAttributes.addFlashAttribute("error", "Mật khẩu hiện tại không đúng!");
		}
		return "redirect:/profile";
	}
}