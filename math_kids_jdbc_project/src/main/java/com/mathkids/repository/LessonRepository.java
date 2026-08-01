package com.mathkids.repository;

import com.mathkids.model.Lesson;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

@Repository
public class LessonRepository {

    private final JdbcTemplate jdbcTemplate;

    public LessonRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Lesson> lessonRowMapper = new RowMapper<Lesson>() {
        @Override
        public Lesson mapRow(ResultSet rs, int rowNum) throws SQLException {
            Lesson lesson = new Lesson();
            lesson.setId(rs.getLong("id"));
            lesson.setTitle(rs.getString("title"));
            lesson.setDescription(rs.getString("description"));
            lesson.setGradeLevel(rs.getObject("grade_level") != null ? rs.getInt("grade_level") : null);
            lesson.setOrderIndex(rs.getObject("order_index") != null ? rs.getInt("order_index") : null);
            Timestamp createdAt = rs.getTimestamp("created_at");
            if (createdAt != null) {
                lesson.setCreatedAt(createdAt.toLocalDateTime());
            }
            return lesson;
        }
    };

    public List<Lesson> findAll() {
        String sql = "SELECT id, title, description, grade_level, order_index, created_at FROM lessons ORDER BY order_index, id";
        return jdbcTemplate.query(sql, lessonRowMapper);
    }

    public List<Lesson> findByGradeLevel(Integer gradeLevel) {
        String sql = "SELECT id, title, description, grade_level, order_index, created_at FROM lessons WHERE grade_level = ? ORDER BY order_index, id";
        return jdbcTemplate.query(sql, lessonRowMapper, gradeLevel);
    }

    public Optional<Lesson> findById(Long id) {
        String sql = "SELECT id, title, description, grade_level, order_index, created_at FROM lessons WHERE id = ?";
        List<Lesson> lessons = jdbcTemplate.query(sql, lessonRowMapper, id);
        return lessons.isEmpty() ? Optional.empty() : Optional.of(lessons.get(0));
    }

    public Lesson save(Lesson lesson) {
        if (lesson.getId() == null) {
            String sql = "INSERT INTO lessons (title, description, grade_level, order_index, created_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, lesson.getTitle());
                ps.setString(2, lesson.getDescription());
                if (lesson.getGradeLevel() != null) {
                    ps.setInt(3, lesson.getGradeLevel());
                } else {
                    ps.setNull(3, java.sql.Types.INTEGER);
                }
                if (lesson.getOrderIndex() != null) {
                    ps.setInt(4, lesson.getOrderIndex());
                } else {
                    ps.setNull(4, java.sql.Types.INTEGER);
                }
                return ps;
            }, keyHolder);
            Number key = keyHolder.getKey();
            if (key != null) {
                lesson.setId(key.longValue());
            }
        } else {
            String sql = "UPDATE lessons SET title = ?, description = ?, grade_level = ?, order_index = ? WHERE id = ?";
            jdbcTemplate.update(sql, lesson.getTitle(), lesson.getDescription(), lesson.getGradeLevel(), lesson.getOrderIndex(), lesson.getId());
        }
        return lesson;
    }

    public int deleteById(Long id) {
        String sql = "DELETE FROM lessons WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}