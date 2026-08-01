package com.kidsmath.model;

import java.sql.Timestamp;

public class Progress {
    private Integer id;
    private Integer userId;
    private Integer quizId;
    private String selectedOption;
    private Boolean isCorrect;
    private Integer score;
    private Timestamp completedAt;

    public Progress() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getQuizId() { return quizId; }
    public void setQuizId(Integer quizId) { this.quizId = quizId; }

    public String getSelectedOption() { return selectedOption; }
    public void setSelectedOption(String selectedOption) { this.selectedOption = selectedOption; }

    public Boolean getIsCorrect() { return isCorrect; }
    public void setIsCorrect(Boolean isCorrect) { this.isCorrect = isCorrect; }

    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }

    public Timestamp getCompletedAt() { return completedAt; }
    public void setCompletedAt(Timestamp completedAt) { this.completedAt = completedAt; }
}
