package com.kidsmath.controller;

import com.kidsmath.model.SupportMessage;
import com.kidsmath.model.SupportTicket;
import com.kidsmath.model.User;
import com.kidsmath.service.SupportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/support")
public class SupportApiController {

	@Autowired
	private SupportService supportService;

	@GetMapping("/tickets")
	public List<SupportTicket> getTickets(HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return List.of();
		}
		return supportService.getTicketsByUser(user.getId());
	}

	@GetMapping("/tickets/{id}/messages")
	public List<SupportMessage> getMessages(@PathVariable Integer id, HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return List.of();
		}
		// Đánh dấu đã đọc
		supportService.markAllMessagesAsRead(id, user.getId());
		return supportService.getMessagesByTicket(id);
	}

	@PostMapping("/tickets/{id}/messages")
	public Map<String, Object> sendMessage(@PathVariable Integer id, @RequestBody Map<String, String> payload, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		User user = (User) session.getAttribute("currentUser");

		if (user == null) {
			response.put("success", false);
			response.put("message", "Vui lòng đăng nhập!");
			return response;
		}

		String message = payload.get("message");
		SupportMessage msg = supportService.sendMessage(id, user.getId(), message);

		if (msg != null) {
			response.put("success", true);
			response.put("message", "Gửi tin nhắn thành công!");
		} else {
			response.put("success", false);
			response.put("message", "Có lỗi xảy ra!");
		}
		return response;
	}
}