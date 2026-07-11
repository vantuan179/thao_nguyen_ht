package com.mathkids.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "quizzes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Quiz {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 1000)
    private String question;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private QuizType type;

    @Column(nullable = false)
    private String correctAnswer;

    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;

    private Integer points;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id", nullable = false)
    private Lesson lesson;

    public enum QuizType {
        ADDITION, SUBTRACTION, SHAPE_IDENTIFICATION, SHAPE_COUNTING
    }
}
