package com.kidsmath.model;

import java.sql.Timestamp;
import java.util.List;

public class SupportTicket {
	private Integer id;
	private Integer userId;
	private String subject;
	private String status; // open, in_progress, closed
	private String priority; // low, normal, high, urgent
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private Timestamp closedAt;

	// Thông tin thêm
	private String userName;
	private String userEmail;
	private List<SupportMessage> messages;
	private int unreadCount;

	// Getters and Setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Timestamp getClosedAt() {
		return closedAt;
	}

	public void setClosedAt(Timestamp closedAt) {
		this.closedAt = closedAt;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public List<SupportMessage> getMessages() {
		return messages;
	}

	public void setMessages(List<SupportMessage> messages) {
		this.messages = messages;
	}

	public int getUnreadCount() {
		return unreadCount;
	}

	public void setUnreadCount(int unreadCount) {
		this.unreadCount = unreadCount;
	}
}