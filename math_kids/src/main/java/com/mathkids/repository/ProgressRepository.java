package com.mathkids.repository;

import com.mathkids.entity.Progress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProgressRepository extends JpaRepository<Progress, Long> {

    List<Progress> findByStudentIdOrderByCompletedAtDesc(Long studentId);

    @Query("SELECT p.student.id, p.student.fullName, SUM(p.score), SUM(p.totalQuestions), " +
           "COUNT(p.id), AVG(100.0 * p.score / p.totalQuestions) " +
           "FROM Progress p GROUP BY p.student.id, p.student.fullName")
    List<Object[]> findStudentStatistics();

    @Query("SELECT p.lesson.id, p.lesson.title, AVG(100.0 * p.score / p.totalQuestions), COUNT(p.id) " +
           "FROM Progress p GROUP BY p.lesson.id, p.lesson.title")
    List<Object[]> findLessonStatistics();
}
