package com.kidsmath.model;

import java.sql.Timestamp;

public class MembershipHistory {
	private Integer id;
	private Integer userId;
	private String actionType; // REGISTER, RENEW, UPGRADE, CANCEL
	private String packageType;
	private Integer packageMonths;
	private Double amount;
	private String paymentStatus; // pending, completed, cancelled
	private String paymentNote;
	private Timestamp startDate;
	private Timestamp expiryDate;
	private Integer processedBy;
	private Timestamp processedAt;
	private Timestamp createdAt;

	// Thông tin thêm (join)
	private String userName;
	private String processedByName;

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

	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	public String getPackageType() {
		return packageType;
	}

	public void setPackageType(String packageType) {
		this.packageType = packageType;
	}

	public Integer getPackageMonths() {
		return packageMonths;
	}

	public void setPackageMonths(Integer packageMonths) {
		this.packageMonths = packageMonths;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getPaymentNote() {
		return paymentNote;
	}

	public void setPaymentNote(String paymentNote) {
		this.paymentNote = paymentNote;
	}

	public Timestamp getStartDate() {
		return startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	public Timestamp getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Timestamp expiryDate) {
		this.expiryDate = expiryDate;
	}

	public Integer getProcessedBy() {
		return processedBy;
	}

	public void setProcessedBy(Integer processedBy) {
		this.processedBy = processedBy;
	}

	public Timestamp getProcessedAt() {
		return processedAt;
	}

	public void setProcessedAt(Timestamp processedAt) {
		this.processedAt = processedAt;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProcessedByName() {
		return processedByName;
	}

	public void setProcessedByName(String processedByName) {
		this.processedByName = processedByName;
	}
}