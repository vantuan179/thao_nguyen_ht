package com.mathkids.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LessonStatsDto {
    private Long lessonId;
    private String lessonTitle;
    private Double averagePercentage;
    private Long totalAttempts;
}
