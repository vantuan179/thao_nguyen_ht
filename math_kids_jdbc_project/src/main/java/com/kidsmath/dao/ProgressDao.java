package com.kidsmath.dao;

import com.kidsmath.mapper.ProgressRowMapper;
import com.kidsmath.model.Progress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProgressDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Progress> findByUserId(Integer userId) {
        String sql = "SELECT id, user_id, quiz_id, selected_option, is_correct, score, completed_at FROM progress WHERE user_id = ? ORDER BY completed_at DESC";
        return jdbcTemplate.query(sql, new ProgressRowMapper(), userId);
    }

    public Progress findByUserIdAndQuizId(Integer userId, Integer quizId) {
        String sql = "SELECT id, user_id, quiz_id, selected_option, is_correct, score, completed_at FROM progress WHERE user_id = ? AND quiz_id = ?";
        List<Progress> list = jdbcTemplate.query(sql, new ProgressRowMapper(), userId, quizId);
        return list.isEmpty() ? null : list.get(0);
    }

    public int saveOrUpdate(Progress progress) {
        Progress existing = findByUserIdAndQuizId(progress.getUserId(), progress.getQuizId());
        if (existing == null) {
            String sql = "INSERT INTO progress (user_id, quiz_id, selected_option, is_correct, score) VALUES (?, ?, ?, ?, ?)";
            return jdbcTemplate.update(sql,
                    progress.getUserId(),
                    progress.getQuizId(),
                    progress.getSelectedOption(),
                    progress.getIsCorrect(),
                    progress.getScore());
        } else {
            String sql = "UPDATE progress SET selected_option = ?, is_correct = ?, score = ?, completed_at = CURRENT_TIMESTAMP WHERE id = ?";
            return jdbcTemplate.update(sql,
                    progress.getSelectedOption(),
                    progress.getIsCorrect(),
                    progress.getScore(),
                    existing.getId());
        }
    }

    public int getTotalScoreByUserId(Integer userId) {
        String sql = "SELECT COALESCE(SUM(score), 0) FROM progress WHERE user_id = ? AND is_correct = true";
        Integer total = jdbcTemplate.queryForObject(sql, Integer.class, userId);
        return total == null ? 0 : total;
    }

    public int countCorrectByUserId(Integer userId) {
        String sql = "SELECT COUNT(*) FROM progress WHERE user_id = ? AND is_correct = true";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId);
        return count == null ? 0 : count;
    }
}
