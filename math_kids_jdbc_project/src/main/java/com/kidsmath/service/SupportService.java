package com.kidsmath.service;

import com.kidsmath.dao.SupportMessageDao;
import com.kidsmath.dao.SupportTicketDao;
import com.kidsmath.model.SupportMessage;
import com.kidsmath.model.SupportTicket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class SupportService {

	@Autowired
	private SupportTicketDao supportTicketDao;

	@Autowired
	private SupportMessageDao supportMessageDao;

	// ===== TICKET =====
	public List<SupportTicket> getAllTickets() {
		return supportTicketDao.findAll();
	}

	public List<SupportTicket> getTicketsByUser(Integer userId) {
		return supportTicketDao.findByUserId(userId);
	}

	public List<SupportTicket> getTicketsByStatus(String status) {
		return supportTicketDao.findByStatus(status);
	}

	public SupportTicket getTicketById(Integer id) {
		return supportTicketDao.findById(id);
	}

	@Transactional
	public SupportTicket createTicket(Integer userId, String subject, String message) {
		SupportTicket ticket = new SupportTicket();
		ticket.setUserId(userId);
		ticket.setSubject(subject);
		ticket.setStatus("open");
		ticket.setPriority("normal");

		supportTicketDao.save(ticket);

		// Lấy ticket vừa tạo
		List<SupportTicket> tickets = supportTicketDao.findByUserId(userId);
		SupportTicket newTicket = tickets.isEmpty() ? null : tickets.get(0);

		if (newTicket != null) {
			// Thêm tin nhắn đầu tiên
			SupportMessage msg = new SupportMessage();
			msg.setTicketId(newTicket.getId());
			msg.setSenderId(userId);
			msg.setMessage(message);
			supportMessageDao.save(msg);
		}

		return newTicket;
	}

	public boolean updateTicketStatus(Integer ticketId, String status) {
		return supportTicketDao.updateStatus(ticketId, status) > 0;
	}

	public boolean updateTicketPriority(Integer ticketId, String priority) {
		return supportTicketDao.updatePriority(ticketId, priority) > 0;
	}

	public boolean closeTicket(Integer ticketId) {
		return supportTicketDao.closeTicket(ticketId) > 0;
	}

	// ===== MESSAGE =====
	public List<SupportMessage> getMessagesByTicket(Integer ticketId) {
		return supportMessageDao.findByTicketId(ticketId);
	}

	@Transactional
	public SupportMessage sendMessage(Integer ticketId, Integer senderId, String message) {
		// Kiểm tra ticket tồn tại
		SupportTicket ticket = supportTicketDao.findById(ticketId);
		if (ticket == null) {
			return null;
		}

		// Nếu ticket đã đóng, mở lại
		if ("closed".equals(ticket.getStatus())) {
			supportTicketDao.updateStatus(ticketId, "open");
		}

		SupportMessage msg = new SupportMessage();
		msg.setTicketId(ticketId);
		msg.setSenderId(senderId);
		msg.setMessage(message);

		supportMessageDao.save(msg);

		return msg;
	}

	public boolean markMessageAsRead(Integer messageId) {
		return supportMessageDao.markAsRead(messageId) > 0;
	}

	public int markAllMessagesAsRead(Integer ticketId, Integer userId) {
		return supportMessageDao.markAllAsRead(ticketId, userId);
	}

	public int getUnreadCount(Integer userId) {
		return supportTicketDao.countUnreadByUser(userId);
	}

	public int getUnreadCountByTicket(Integer ticketId, Integer userId) {
		return supportMessageDao.countUnreadByTicket(ticketId, userId);
	}
}