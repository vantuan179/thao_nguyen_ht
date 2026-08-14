package com.kidsmath.model;

import java.sql.Timestamp;

public class EmailSubscriber {
	private Integer id;
	private String email;
	private String fullName;
	private Timestamp subscribedAt;
	private boolean active;

	public EmailSubscriber() {
	}

	public EmailSubscriber(String email, String fullName) {
		this.email = email;
		this.fullName = fullName;
		this.active = true;
	}

	// Getters and Setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public Timestamp getSubscribedAt() {
		return subscribedAt;
	}

	public void setSubscribedAt(Timestamp subscribedAt) {
		this.subscribedAt = subscribedAt;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "EmailSubscriber{" + "id=" + id + ", email='" + email + '\'' + ", fullName='" + fullName + '\'' + ", active=" + active + '}';
	}
}