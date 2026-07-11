package com.mathkids.dto;

import com.mathkids.entity.Lesson;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class LessonRequest {
    @NotBlank
    private String title;

    private String description;

    @NotNull
    private Lesson.LessonType type;

    private Integer orderIndex;

    private String imageUrl;
}
