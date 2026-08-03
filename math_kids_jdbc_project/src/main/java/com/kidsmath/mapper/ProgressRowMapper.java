package com.kidsmath.mapper;

import com.kidsmath.model.Progress;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProgressRowMapper implements RowMapper<Progress> {
	@Override
	public Progress mapRow(ResultSet rs, int rowNum) throws SQLException {
		Progress progress = new Progress();
		progress.setId(rs.getInt("id"));
		progress.setUserId(rs.getInt("user_id"));
		progress.setQuizId(rs.getInt("quiz_id"));
		progress.setSelectedOption(rs.getString("selected_option"));
		progress.setIsCorrect(rs.getBoolean("is_correct"));
		progress.setScore(rs.getInt("score"));
		progress.setCompletedAt(rs.getTimestamp("completed_at"));
		return progress;
	}
}
