package com.kidsmath.mapper;

import com.kidsmath.model.EmailTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class EmailTemplateRowMapper implements RowMapper<EmailTemplate> {
	@Override
	public EmailTemplate mapRow(ResultSet rs, int rowNum) throws SQLException {
		EmailTemplate template = new EmailTemplate();
		template.setId(rs.getInt("id"));
		template.setName(rs.getString("name"));
		template.setSubject(rs.getString("subject"));
		template.setBody(rs.getString("body"));
		template.setDescription(rs.getString("description"));
		template.setType(rs.getString("type"));
		template.setActive(rs.getBoolean("active"));
		template.setCreatedAt(rs.getTimestamp("created_at"));
		template.setUpdatedAt(rs.getTimestamp("updated_at"));
		return template;
	}
}