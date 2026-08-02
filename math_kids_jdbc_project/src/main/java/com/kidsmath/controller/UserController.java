package com.kidsmath.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.regex.Pattern;

@Controller
public class UserController {

	@Autowired
	private LessonService lessonService;

	@Autowired
	private QuizService quizService;

	@Autowired
	private UserService userService;

	@GetMapping("/")
	public String home(Model model) {
		List<Lesson> lessons = lessonService.findAll();
		model.addAttribute("lessons", lessons);
		return "user/home";
	}

	@GetMapping("/lesson/{id}")
	public String lessonDetail(@PathVariable("id") Integer id, Model model) {
		Lesson lesson = lessonService.findById(id);
		List<Quiz> quizzes = quizService.findByLessonId(id);
		model.addAttribute("lesson", lesson);
		model.addAttribute("quizzes", quizzes);
		return "user/lesson";
	}

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

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/register")
	public String registerPage() {
		return "user/register";
	}

	@PostMapping("/register")
	public String doRegister(@RequestParam String fullName, @RequestParam String username, @RequestParam String email, @RequestParam String password, @RequestParam String confirmPassword, @RequestParam(value = "agreeTerms", defaultValue = "false") boolean agreeTerms, Model model, RedirectAttributes redirectAttributes) {

		// 1. Kiểm tra điều khoản
		if (!agreeTerms) {
			model.addAttribute("error", "Vui lòng đồng ý với điều khoản sử dụng!");
			return "user/register";
		}

		// 2. Kiểm tra mật khẩu khớp
		if (!password.equals(confirmPassword)) {
			model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
			return "user/register";
		}

		// 3. Kiểm tra độ dài mật khẩu
		if (password.length() < 6) {
			model.addAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
			return "user/register";
		}

		// 4. Kiểm tra tên đăng nhập đã tồn tại chưa
		User existingUser = userService.findByUsername(username);
		if (existingUser != null) {
			model.addAttribute("error", "Tên đăng nhập đã được sử dụng! Vui lòng chọn tên khác.");
			// Giữ lại các giá trị đã nhập
			model.addAttribute("fullName", fullName);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			return "user/register";
		}

		User existingEmail = userService.findByEmail(email);
		if (existingEmail != null) {
			model.addAttribute("error", "Email đã được sử dụng!");
			return "user/register";
		}

		// 6. Validate email
		if (!isValidEmail(email)) {
			model.addAttribute("error", "Email không hợp lệ!");
			return "user/register";
		}

		// 7. Validate username (chỉ cho phép chữ, số và dấu gạch dưới)
		if (!isValidUsername(username)) {
			model.addAttribute("error", "Tên đăng nhập chỉ bao gồm chữ, số và dấu gạch dưới, từ 3-20 ký tự!");
			return "user/register";
		}

		try {
			User newUser = new User();
			newUser.setFullName(fullName.trim());
			newUser.setUsername(username.trim());
			newUser.setEmail(email.trim());
			newUser.setPassword(password); // Trong thực tế, nên mã hóa mật khẩu
			newUser.setRole("USER");
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

	private boolean isValidEmail(String email) {
		if (email == null || email.trim().isEmpty()) {
			return false;
		}
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
		Pattern pattern = Pattern.compile(emailRegex);
		return pattern.matcher(email.trim()).matches();
	}

	private boolean isValidUsername(String username) {
		if (username == null || username.trim().isEmpty()) {
			return false;
		}
		String usernameRegex = "^[a-zA-Z0-9_]{3,20}$";
		Pattern pattern = Pattern.compile(usernameRegex);
		return pattern.matcher(username.trim()).matches();
	}

	@GetMapping("/forgot-password")
	public String forgotPasswordPage() {
		return "user/forgot-password";
	}

	@PostMapping("/forgot-password")
	public String doForgotPassword(@RequestParam String email, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("success", "Hướng dẫn đặt lại mật khẩu đã được gửi đến email của bạn!");
		return "redirect:/login";
	}
}
