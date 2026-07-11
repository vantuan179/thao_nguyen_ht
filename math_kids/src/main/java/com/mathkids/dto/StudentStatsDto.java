package com.mathkids.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudentStatsDto {
    private Long studentId;
    private String fullName;
    private Long totalScore;
    private Long totalQuestions;
    private Long completedLessons;
    private Double averagePercentage;
}
