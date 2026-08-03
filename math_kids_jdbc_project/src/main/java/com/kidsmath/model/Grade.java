package com.kidsmath.model;

import java.sql.Timestamp;
import java.util.List;

public class Grade {
	private Integer id;
	private String gradeName;
	private Integer displayOrder;
	private String description;
	private String icon;
	private Boolean active;
	private Timestamp createdAt;
	private List<Lesson> lessons;

	public Grade() {
		this.active = true;
	}

	public Grade(String gradeName, Integer displayOrder, String description, String icon) {
		this.gradeName = gradeName;
		this.displayOrder = displayOrder;
		this.description = description;
		this.icon = icon;
		this.active = true;
	}

	// Getters and Setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public Integer getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public List<Lesson> getLessons() {
		return lessons;
	}

	public void setLessons(List<Lesson> lessons) {
		this.lessons = lessons;
	}
}