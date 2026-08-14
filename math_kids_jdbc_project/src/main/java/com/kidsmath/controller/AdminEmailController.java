package com.kidsmath.controller;

import com.kidsmath.model.Email;
import com.kidsmath.model.EmailTemplate;
import com.kidsmath.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/email")
public class AdminEmailController extends BaseController {

	@GetMapping
	public String emailDashboard(Model model) {
		model.addAttribute("recentEmails", emailService.getRecentEmails(10));
		model.addAttribute("templates", emailService.getAllTemplates());
		return "admin/email/dashboard";
	}

	@GetMapping("/history")
	public String emailHistory(Model model) {
		model.addAttribute("emails", emailService.getEmailHistory());
		return "admin/email/history";
	}

	@GetMapping("/send")
	public String showSendForm(Model model) {
		List<User> users = userService.findAll();
		List<EmailTemplate> templates = emailService.getAllTemplates();
		model.addAttribute("users", users);
		model.addAttribute("templates", templates);
		model.addAttribute("email", new Email());
		return "admin/email/send";
	}

	@PostMapping("/send")
	public String sendEmail(@RequestParam String to, @RequestParam String subject, @RequestParam String content, @RequestParam(required = false) String templateType, RedirectAttributes redirectAttributes) {
		try {
			boolean success;
			if (templateType != null && !templateType.isEmpty()) {
				Map<String, Object> variables = new HashMap<>();
				variables.put("content", content);
				variables.put("title", subject);
				success = emailService.sendEmailWithTemplate(to, templateType, variables);
			} else {
				success = emailService.sendHtmlEmail(to, subject, content);
			}

			if (success) {
				redirectAttributes.addFlashAttribute("success", "Gửi email thành công!");
			} else {
				redirectAttributes.addFlashAttribute("error", "Gửi email thất bại!");
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
		}
		return "redirect:/admin/email/history";
	}

	@GetMapping("/view/{id}")
	public String viewEmail(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		Email email = emailService.getEmailDetail(id);
		if (email == null) {
			redirectAttributes.addFlashAttribute("error", "Không tìm thấy email!");
			return "redirect:/admin/email/history";
		}
		model.addAttribute("email", email);
		return "admin/email/view";
	}

	@GetMapping("/templates")
	public String listTemplates(Model model) {
		model.addAttribute("templates", emailService.getAllTemplates());
		return "admin/email/templates";
	}

	@GetMapping("/templates/create")
	public String showCreateTemplateForm(Model model) {
		model.addAttribute("template", new EmailTemplate());
		return "admin/email/template-form";
	}

	@PostMapping("/templates/create")
	public String createTemplate(@ModelAttribute EmailTemplate template, RedirectAttributes redirectAttributes) {
		try {
			emailService.saveTemplate(template);
			redirectAttributes.addFlashAttribute("success", "Tạo template thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
		}
		return "redirect:/admin/email/templates";
	}

	@GetMapping("/templates/edit/{id}")
	public String showEditTemplateForm(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		EmailTemplate template = emailService.getTemplateById(id);
		if (template == null) {
			redirectAttributes.addFlashAttribute("error", "Không tìm thấy template!");
			return "redirect:/admin/email/templates";
		}
		model.addAttribute("template", template);
		return "admin/email/template-form";
	}

	@PostMapping("/templates/edit/{id}")
	public String updateTemplate(@PathVariable Integer id, @ModelAttribute EmailTemplate template, RedirectAttributes redirectAttributes) {
		try {
			template.setId(id);
			emailService.updateTemplate(template);
			redirectAttributes.addFlashAttribute("success", "Cập nhật template thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
		}
		return "redirect:/admin/email/templates";
	}

	@GetMapping("/templates/delete/{id}")
	public String deleteTemplate(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			emailService.deleteTemplate(id);
			redirectAttributes.addFlashAttribute("success", "Xóa template thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
		}
		return "redirect:/admin/email/templates";
	}
}