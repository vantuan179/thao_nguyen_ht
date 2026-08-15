package com.kidsmath.model;

import java.sql.Timestamp;

public class User {
	private Integer id;
	private String username;
	private String password;
	private String fullName;
	private String email;
	private String role;
	private String membershipType; // trial, premium
	private Timestamp membershipStartDate;
	private Timestamp membershipExpiryDate;
	private String membershipStatus; // active, expired, cancelled
	private Timestamp createdAt;

	public User() {
	}

	// Getters and Setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getMembershipType() {
		return membershipType;
	}

	public void setMembershipType(String membershipType) {
		this.membershipType = membershipType;
	}

	public Timestamp getMembershipStartDate() {
		return membershipStartDate;
	}

	public void setMembershipStartDate(Timestamp membershipStartDate) {
		this.membershipStartDate = membershipStartDate;
	}

	public Timestamp getMembershipExpiryDate() {
		return membershipExpiryDate;
	}

	public void setMembershipExpiryDate(Timestamp membershipExpiryDate) {
		this.membershipExpiryDate = membershipExpiryDate;
	}

	public String getMembershipStatus() {
		return membershipStatus;
	}

	public void setMembershipStatus(String membershipStatus) {
		this.membershipStatus = membershipStatus;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	// Helper methods
	public boolean isPremium() {
		return "premium".equals(membershipType) && "active".equals(membershipStatus) && membershipExpiryDate != null && membershipExpiryDate.after(new Timestamp(System.currentTimeMillis()));
	}

	public boolean isTrial() {
		return "trial".equals(membershipType) || (membershipExpiryDate == null || membershipExpiryDate.before(new Timestamp(System.currentTimeMillis())));
	}
}