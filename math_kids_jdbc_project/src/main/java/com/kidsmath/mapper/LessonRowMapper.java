package com.kidsmath.mapper;

import com.kidsmath.model.Lesson;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LessonRowMapper implements RowMapper<Lesson> {
	@Override
	public Lesson mapRow(ResultSet rs, int rowNum) throws SQLException {
		Lesson lesson = new Lesson();
		lesson.setId(rs.getInt("id"));
		lesson.setTitle(rs.getString("title"));
		lesson.setDescription(rs.getString("description"));
		lesson.setGrade(rs.getInt("grade"));
		lesson.setContent(rs.getString("content"));
		lesson.setVideoUrl(rs.getString("video_url"));
		lesson.setCreatedAt(rs.getTimestamp("created_at"));
		return lesson;
	}
}