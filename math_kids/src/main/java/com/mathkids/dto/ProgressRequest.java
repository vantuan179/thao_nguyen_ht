package com.mathkids.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ProgressRequest {
    @NotNull
    private Long studentId;

    private Long lessonId;

    private Long quizId;

    @NotNull
    private Integer score;

    @NotNull
    private Integer totalQuestions;
}
