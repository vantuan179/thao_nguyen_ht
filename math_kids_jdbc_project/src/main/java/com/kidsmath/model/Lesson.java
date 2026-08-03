package com.kidsmath.model;

import java.sql.Timestamp;
import java.util.List;

public class Lesson {
	private Integer id;
	private String title;
	private String description;
	private Integer grade; // grade id (khớp với bảng lessons)
	private String content;
	private String videoUrl;
	private Timestamp createdAt;

	// Thông tin phụ trợ
	private Grade gradeInfo; // Thông tin chi tiết về grade
	private List<Quiz> quizzes; // Danh sách câu hỏi

	public Lesson() {
	}

	// Getters and Setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getVideoUrl() {
		return videoUrl;
	}

	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Grade getGradeInfo() {
		return gradeInfo;
	}

	public void setGradeInfo(Grade gradeInfo) {
		this.gradeInfo = gradeInfo;
	}

	public List<Quiz> getQuizzes() {
		return quizzes;
	}

	public void setQuizzes(List<Quiz> quizzes) {
		this.quizzes = quizzes;
	}
}