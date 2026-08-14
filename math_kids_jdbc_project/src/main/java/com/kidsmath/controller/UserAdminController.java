package com.kidsmath.controller;

import com.kidsmath.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/users")
public class UserAdminController extends BaseController {

	@GetMapping
	public String listUsers(Model model) {
		try {
			List<User> users = userService.findAll();
			model.addAttribute("users", users);

			long adminCount = userService.countByRole("ADMIN");
			long teacherCount = userService.countByRole("TEACHER");
			long userCount = userService.countByRole("USER");

			model.addAttribute("adminCount", adminCount);
			model.addAttribute("teacherCount", teacherCount);
			model.addAttribute("userCount", userCount);

			return "admin/user-list";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "admin/user-list";
		}
	}

	@GetMapping("/search")
	public String searchUsers(@RequestParam String keyword, Model model) {
		try {
			List<User> users = userService.searchByUsername(keyword);
			model.addAttribute("users", users);
			model.addAttribute("keyword", keyword);

			long adminCount = userService.countByRole("ADMIN");
			long teacherCount = userService.countByRole("TEACHER");
			long userCount = userService.countByRole("USER");

			model.addAttribute("adminCount", adminCount);
			model.addAttribute("teacherCount", teacherCount);
			model.addAttribute("userCount", userCount);

			return "admin/user-list";
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "admin/user-list";
		}
	}

	@GetMapping("/view/{id}")
	public String viewUser(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(id);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
				return "redirect:/admin/users";
			}
			model.addAttribute("user", user);
			return "admin/user-view";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/users";
		}
	}

	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(id);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
				return "redirect:/admin/users";
			}
			model.addAttribute("user", user);
			return "admin/user-form";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/users";
		}
	}

	@PostMapping("/edit/{id}")
	public String updateUser(@PathVariable Integer id, @RequestParam String fullName, @RequestParam String email, @RequestParam String role, @RequestParam(required = false) String password, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(id);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
				return "redirect:/admin/users";
			}

			user.setFullName(fullName);
			user.setEmail(email);
			user.setRole(role);

			if (password != null && !password.trim().isEmpty()) {
				user.setPassword(password);
			}

			userService.update(user);
			redirectAttributes.addFlashAttribute("success", "Cập nhật người dùng '" + user.getUsername() + "' thành công!");
			return "redirect:/admin/users";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/users/edit/" + id;
		}
	}

	@GetMapping("/delete/{id}")
	public String deleteUser(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(id);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
				return "redirect:/admin/users";
			}

			if ("ADMIN".equals(user.getRole())) {
				redirectAttributes.addFlashAttribute("error", "Không thể xóa tài khoản Admin!");
				return "redirect:/admin/users";
			}

			userService.deleteById(id);
			redirectAttributes.addFlashAttribute("success", "Xóa người dùng '" + user.getUsername() + "' thành công!");
			return "redirect:/admin/users";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/users";
		}
	}
}