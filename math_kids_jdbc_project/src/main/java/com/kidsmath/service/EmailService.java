package com.kidsmath.service;

import com.kidsmath.dao.EmailDao;
import com.kidsmath.dao.EmailTemplateDao;
import com.kidsmath.model.Email;
import com.kidsmath.model.EmailTemplate;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
public class EmailService {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private EmailDao emailDao;

	@Autowired
	private EmailTemplateDao emailTemplateDao;

	@Value("${app.mail.from}")
	private String fromEmail;

	@Value("${app.mail.from-name}")
	private String fromName;

	// ===== GỬI EMAIL ĐƠN GIẢN (Text) =====
	public boolean sendSimpleEmail(String to, String subject, String content) {
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setFrom(fromEmail);
			message.setTo(to);
			message.setSubject(subject);
			message.setText(content);
			mailSender.send(message);

			saveEmailHistory(to, subject, content, "SENT", "SIMPLE");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			saveEmailHistory(to, subject, content, "FAILED", "SIMPLE");
			return false;
		}
	}

	// ===== GỬI EMAIL HTML =====
	public boolean sendHtmlEmail(String to, String subject, String htmlContent) throws UnsupportedEncodingException {
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
			helper.setFrom(fromEmail, fromName);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(htmlContent, true);

			mailSender.send(mimeMessage);

			saveEmailHistory(to, subject, htmlContent, "SENT", "HTML");
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			saveEmailHistory(to, subject, htmlContent, "FAILED", "HTML");
			return false;
		}
	}

	// ===== GỬI EMAIL VỚI TEMPLATE =====
	public boolean sendEmailWithTemplate(String to, String templateType, Map<String, Object> variables) throws UnsupportedEncodingException {
		try {
			EmailTemplate template = emailTemplateDao.findByType(templateType);
			if (template == null) {
				return false;
			}

			String subject = replaceVariables(template.getSubject(), variables);
			String body = replaceVariables(template.getBody(), variables);

			// Gửi email HTML
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
			helper.setFrom(fromEmail, fromName);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(body, true);

			mailSender.send(mimeMessage);

			saveEmailHistory(to, subject, body, "SENT", templateType);
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
	}

	// ===== GỬI EMAIL ĐẾN NHIỀU NGƯỜI =====
	public int sendBulkEmail(List<String> recipients, String subject, String content, String templateType) throws UnsupportedEncodingException {
		int successCount = 0;
		for (String to : recipients) {
			if (sendHtmlEmail(to, subject, content)) {
				successCount++;
			}
		}
		return successCount;
	}

	// ===== GỬI EMAIL CÓ FILE ĐÍNH KÈM =====
	public boolean sendEmailWithAttachment(String to, String subject, String content, String attachmentPath, String attachmentName) throws UnsupportedEncodingException {
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
			helper.setFrom(fromEmail, fromName);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(content, true);

			if (attachmentPath != null && !attachmentPath.isEmpty()) {
				// helper.addAttachment(attachmentName, new File(attachmentPath));
			}

			mailSender.send(mimeMessage);

			saveEmailHistory(to, subject, content, "SENT", "ATTACHMENT");
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			saveEmailHistory(to, subject, content, "FAILED", "ATTACHMENT");
			return false;
		}
	}

	// ===== THAY THẾ BIẾN =====
	private String replaceVariables(String text, Map<String, Object> variables) {
		if (variables == null)
			return text;
		for (Map.Entry<String, Object> entry : variables.entrySet()) {
			String key = "{" + entry.getKey() + "}";
			String value = entry.getValue() != null ? entry.getValue().toString() : "";
			text = text.replace(key, value);
		}
		return text;
	}

	// ===== LƯU LỊCH SỬ EMAIL =====
	private void saveEmailHistory(String to, String subject, String content, String status, String type) {
		Email email = new Email();
		email.setFromEmail(fromEmail);
		email.setToEmail(to);
		email.setSubject(subject);
		email.setContent(content);
		email.setStatus(status);
		email.setType(type);
		email.setSentAt(Timestamp.valueOf(LocalDateTime.now()));
		emailDao.save(email);
	}

	// ===== LẤY LỊCH SỬ EMAIL =====
	public List<Email> getEmailHistory() {
		return emailDao.findAll();
	}

	public List<Email> getRecentEmails(int limit) {
		return emailDao.findRecent(limit);
	}

	public Email getEmailDetail(Integer id) {
		return emailDao.findById(id);
	}

	// ===== QUẢN LÝ TEMPLATE =====
	public List<EmailTemplate> getAllTemplates() {
		return emailTemplateDao.findAll();
	}

	public EmailTemplate getTemplateById(Integer id) {
		return emailTemplateDao.findById(id);
	}

	public void saveTemplate(EmailTemplate template) {
		emailTemplateDao.save(template);
	}

	public void updateTemplate(EmailTemplate template) {
		emailTemplateDao.update(template);
	}

	public void deleteTemplate(Integer id) {
		emailTemplateDao.deleteById(id);
	}

	// ===== THỐNG KÊ =====
	public int getTotalEmailsSent() {
		return emailDao.countAll();
	}

	public int getTodayEmailsSent() {
		return emailDao.countToday();
	}
}