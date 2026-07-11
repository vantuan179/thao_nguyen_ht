package com.mathkids.dto;

import com.mathkids.entity.Quiz;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class QuizRequest {
    @NotBlank
    private String question;

    @NotNull
    private Quiz.QuizType type;

    @NotBlank
    private String correctAnswer;

    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;

    private Integer points;

    @NotNull
    private Long lessonId;
}
