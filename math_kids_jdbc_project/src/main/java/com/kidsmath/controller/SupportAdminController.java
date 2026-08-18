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
@RequestMapping("/admin/support")
public class SupportAdminController extends BaseController {

	@Autowired
	private SupportService supportService;

	// ===== DANH SÁCH TICKET =====
	@GetMapping
	public String listTickets(Model model) {
		List<SupportTicket> tickets = supportService.getAllTickets();
		model.addAttribute("tickets", tickets);
		return "admin/support/list";
	}

	// ===== XEM CHI TIẾT TICKET =====
	@GetMapping("/{id}")
	public String viewTicket(@PathVariable Integer id, Model model) {
		SupportTicket ticket = supportService.getTicketById(id);
		if (ticket == null) {
			return "redirect:/admin/support";
		}

		List<SupportMessage> messages = supportService.getMessagesByTicket(id);
		model.addAttribute("ticket", ticket);
		model.addAttribute("messages", messages);
		return "admin/support/view";
	}

	// ===== TRẢ LỜI TIN NHẮN =====
	@PostMapping("/{id}/reply")
	public String replyMessage(@PathVariable Integer id, @RequestParam String message, HttpSession session, RedirectAttributes redirectAttributes) {
		User admin = (User) session.getAttribute("currentUser");
		if (admin == null) {
			return "redirect:/login";
		}

		SupportMessage msg = supportService.sendMessage(id, admin.getId(), message);
		if (msg != null) {
			redirectAttributes.addFlashAttribute("success", "Trả lời thành công!");
		} else {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra!");
		}
		return "redirect:/admin/support/" + id;
	}

	// ===== CẬP NHẬT TRẠNG THÁI =====
	@PostMapping("/{id}/status")
	public String updateStatus(@PathVariable Integer id, @RequestParam String status, RedirectAttributes redirectAttributes) {
		boolean success = supportService.updateTicketStatus(id, status);
		if (success) {
			redirectAttributes.addFlashAttribute("success", "Cập nhật trạng thái thành công!");
		} else {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra!");
		}
		return "redirect:/admin/support/" + id;
	}

	// ===== ĐÓNG TICKET =====
	@PostMapping("/{id}/close")
	public String closeTicket(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		boolean success = supportService.closeTicket(id);
		if (success) {
			redirectAttributes.addFlashAttribute("success", "Đóng ticket thành công!");
		} else {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra!");
		}
		return "redirect:/admin/support/" + id;
	}
}