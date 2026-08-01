package com.kidsmath.dao;

import com.kidsmath.mapper.LessonRowMapper;
import com.kidsmath.model.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LessonDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Lesson> findAll() {
        String sql = "SELECT id, title, description, grade, content, video_url, created_at FROM lessons ORDER BY id";
        return jdbcTemplate.query(sql, new LessonRowMapper());
    }

    public Lesson findById(Integer id) {
        String sql = "SELECT id, title, description, grade, content, video_url, created_at FROM lessons WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new LessonRowMapper(), id);
    }

    public int save(Lesson lesson) {
        String sql = "INSERT INTO lessons (title, description, grade, content, video_url) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
                lesson.getTitle(),
                lesson.getDescription(),
                lesson.getGrade(),
                lesson.getContent(),
                lesson.getVideoUrl());
    }

    public int update(Lesson lesson) {
        String sql = "UPDATE lessons SET title = ?, description = ?, grade = ?, content = ?, video_url = ? WHERE id = ?";
        return jdbcTemplate.update(sql,
                lesson.getTitle(),
                lesson.getDescription(),
                lesson.getGrade(),
                lesson.getContent(),
                lesson.getVideoUrl(),
                lesson.getId());
    }

    public int deleteById(Integer id) {
        String sql = "DELETE FROM lessons WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}
