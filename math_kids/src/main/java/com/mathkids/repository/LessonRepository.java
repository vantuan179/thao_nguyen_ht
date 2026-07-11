package com.mathkids.repository;

import com.mathkids.entity.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
    List<Lesson> findAllByOrderByOrderIndexAsc();

    @Query("SELECT l FROM Lesson l LEFT JOIN FETCH l.quizzes")
    List<Lesson> findAllWithQuizzes();
}
