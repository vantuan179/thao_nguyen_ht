package com.mathkids.repository;

import com.mathkids.model.Progress;
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
public class ProgressRepository {

    private final JdbcTemplate jdbcTemplate;

    public ProgressRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Progress> progressRowMapper = new RowMapper<Progress>() {
        @Override
        public Progress mapRow(ResultSet rs, int rowNum) throws SQLException {
            Progress progress = new Progress();
            progress.setId(rs.getLong("id"));
            progress.setUserId(rs.getLong("user_id"));
            progress.setLessonId(rs.getObject("lesson_id") != null ? rs.getLong("lesson_id") : null);
            progress.setQuizId(rs.getObject("quiz_id") != null ? rs.getLong("quiz_id") : null);
            progress.setScore(rs.getObject("score") != null ? rs.getInt("score") : null);
            progress.setCompleted(rs.getBoolean("completed"));
            progress.setAttempts(rs.getObject("attempts") != null ? rs.getInt("attempts") : null);
            Timestamp lastAttempt = rs.getTimestamp("last_attempt_at");
            if (lastAttempt != null) {
                progress.setLastAttemptAt(lastAttempt.toLocalDateTime());
            }
            return progress;
        }
    };

    public List<Progress> findAll() {
        String sql = "SELECT id, user_id, lesson_id, quiz_id, score, completed, attempts, last_attempt_at FROM progress ORDER BY id";
        return jdbcTemplate.query(sql, progressRowMapper);
    }

    public List<Progress> findByUserId(Long userId) {
        String sql = "SELECT id, user_id, lesson_id, quiz_id, score, completed, attempts, last_attempt_at FROM progress WHERE user_id = ? ORDER BY last_attempt_at DESC";
        return jdbcTemplate.query(sql, progressRowMapper, userId);
    }

    public Optional<Progress> findById(Long id) {
        String sql = "SELECT id, user_id, lesson_id, quiz_id, score, completed, attempts, last_attempt_at FROM progress WHERE id = ?";
        List<Progress> list = jdbcTemplate.query(sql, progressRowMapper, id);
        return list.isEmpty() ? Optional.empty() : Optional.of(list.get(0));
    }

    public Optional<Progress> findByUserAndQuiz(Long userId, Long quizId) {
        String sql = "SELECT id, user_id, lesson_id, quiz_id, score, completed, attempts, last_attempt_at FROM progress WHERE user_id = ? AND quiz_id = ?";
        List<Progress> list = jdbcTemplate.query(sql, progressRowMapper, userId, quizId);
        return list.isEmpty() ? Optional.empty() : Optional.of(list.get(0));
    }

    public Progress save(Progress progress) {
        if (progress.getId() == null) {
            String sql = "INSERT INTO progress (user_id, lesson_id, quiz_id, score, completed, attempts, last_attempt_at) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setLong(1, progress.getUserId());
                if (progress.getLessonId() != null) {
                    ps.setLong(2, progress.getLessonId());
                } else {
                    ps.setNull(2, java.sql.Types.BIGINT);
                }
                if (progress.getQuizId() != null) {
                    ps.setLong(3, progress.getQuizId());
                } else {
                    ps.setNull(3, java.sql.Types.BIGINT);
                }
                if (progress.getScore() != null) {
                    ps.setInt(4, progress.getScore());
                } else {
                    ps.setNull(4, java.sql.Types.INTEGER);
                }
                ps.setBoolean(5, progress.getCompleted() != null && progress.getCompleted());
                if (progress.getAttempts() != null) {
                    ps.setInt(6, progress.getAttempts());
                } else {
                    ps.setInt(6, 1);
                }
                return ps;
            }, keyHolder);
            Number key = keyHolder.getKey();
            if (key != null) {
                progress.setId(key.longValue());
            }
        } else {
            String sql = "UPDATE progress SET user_id = ?, lesson_id = ?, quiz_id = ?, score = ?, completed = ?, attempts = ?, last_attempt_at = CURRENT_TIMESTAMP WHERE id = ?";
            jdbcTemplate.update(sql, progress.getUserId(), progress.getLessonId(), progress.getQuizId(), progress.getScore(), progress.getCompleted(), progress.getAttempts(), progress.getId());
        }
        return progress;
    }

    public int deleteById(Long id) {
        String sql = "DELETE FROM progress WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}