package com.kidsmath.mapper;

import com.kidsmath.model.Grade;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GradeRowMapper implements RowMapper<Grade> {
	@Override
	public Grade mapRow(ResultSet rs, int rowNum) throws SQLException {
		Grade grade = new Grade();
		grade.setId(rs.getInt("id"));
		grade.setGradeName(rs.getString("grade_name"));
		grade.setDisplayOrder(rs.getInt("display_order"));
		grade.setDescription(rs.getString("description"));
		grade.setIcon(rs.getString("icon"));
		grade.setActive(rs.getBoolean("active"));
		grade.setCreatedAt(rs.getTimestamp("created_at"));
		return grade;
	}
}