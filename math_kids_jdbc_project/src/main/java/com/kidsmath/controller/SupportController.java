package com.kidsmath.controller;

import com.kidsmath.model.SupportMessage;
import com.kidsmath.model.SupportTicket;
import com.kidsmath.model.User;
import com.kidsmath.service.SupportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/support")
public class SupportController {

	@Autowired
	private SupportService supportService;

	// ===== DANH SÁCH TICKET CỦA USER =====
	@GetMapping
	public String listTickets(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}

		List<SupportTicket> tickets = supportService.getTicketsByUser(user.getId());

		// Đếm số tin nhắn chưa đọc cho mỗi ticket
		for (SupportTicket ticket : tickets) {
			int unreadCount = supportService.getUnreadCountByTicket(ticket.getId(), user.getId());
			ticket.setUnreadCount(unreadCount);
		}

		model.addAttribute("tickets", tickets);
		return "user/support/list";
	}

	// ===== TẠO TICKET MỚI =====
	@GetMapping("/create")
	public String showCreateForm(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}
		model.addAttribute("ticket", new SupportTicket());
		return "user/support/create";
	}

	@PostMapping("/create")
	public String createTicket(@RequestParam String subject, @RequestParam String message, @RequestParam(required = false) String email, HttpSession session, RedirectAttributes redirectAttributes) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}

		// Cập nhật email nếu thay đổi
		if (email != null && !email.trim().isEmpty() && !email.equals(user.getEmail())) {
			user.setEmail(email.trim());
			// Cần thêm method updateUser trong UserService
			// userService.update(user);
		}

		SupportTicket ticket = supportService.createTicket(user.getId(), subject, message);
		if (ticket != null) {
			redirectAttributes.addFlashAttribute("success", "Tạo yêu cầu hỗ trợ thành công!");
		} else {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra!");
		}
		return "redirect:/support";
	}

	// ===== XEM CHI TIẾT TICKET =====
	@GetMapping("/{id}")
	public String viewTicket(@PathVariable Integer id, HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}

		SupportTicket ticket = supportService.getTicketById(id);
		if (ticket == null || !ticket.getUserId().equals(user.getId())) {
			return "redirect:/support";
		}

		List<SupportMessage> messages = supportService.getMessagesByTicket(id);
		// Đánh dấu đã đọc
		supportService.markAllMessagesAsRead(id, user.getId());

		model.addAttribute("ticket", ticket);
		model.addAttribute("messages", messages);
		return "user/support/view";
	}

	// ===== GỬI TIN NHẮN =====
	@PostMapping("/{id}/send")
	public String sendMessage(@PathVariable Integer id, @RequestParam String message, HttpSession session, RedirectAttributes redirectAttributes) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}

		SupportMessage msg = supportService.sendMessage(id, user.getId(), message);
		if (msg != null) {
			redirectAttributes.addFlashAttribute("success", "Gửi tin nhắn thành công!");
		} else {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra!");
		}
		return "redirect:/support/" + id;
	}
}