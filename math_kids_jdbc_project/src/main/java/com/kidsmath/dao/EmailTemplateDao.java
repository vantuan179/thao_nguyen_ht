package com.kidsmath.dao;

import com.kidsmath.mapper.EmailTemplateRowMapper;
import com.kidsmath.model.EmailTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class EmailTemplateDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<EmailTemplate> findAll() {
		String sql = "SELECT id, name, subject, body, description, type, active, created_at, updated_at " + "FROM public.email_templates ORDER BY name";
		return jdbcTemplate.query(sql, new EmailTemplateRowMapper());
	}

	public List<EmailTemplate> findActive() {
		String sql = "SELECT id, name, subject, body, description, type, active, created_at, updated_at " + "FROM public.email_templates WHERE active = true ORDER BY name";
		return jdbcTemplate.query(sql, new EmailTemplateRowMapper());
	}

	public EmailTemplate findById(Integer id) {
		String sql = "SELECT id, name, subject, body, description, type, active, created_at, updated_at " + "FROM public.email_templates WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new EmailTemplateRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public EmailTemplate findByType(String type) {
		String sql = "SELECT id, name, subject, body, description, type, active, created_at, updated_at " + "FROM public.email_templates WHERE type = ? AND active = true";
		List<EmailTemplate> templates = jdbcTemplate.query(sql, new EmailTemplateRowMapper(), type);
		return templates.isEmpty() ? null : templates.get(0);
	}

	public int save(EmailTemplate template) {
		Timestamp now = Timestamp.valueOf(LocalDateTime.now());
		String sql = "INSERT INTO public.email_templates (name, subject, body, description, type, active, created_at, updated_at) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, template.getName(), template.getSubject(), template.getBody(), template.getDescription(), template.getType(), template.isActive(), now, now);
	}

	public int update(EmailTemplate template) {
		Timestamp now = Timestamp.valueOf(LocalDateTime.now());
		String sql = "UPDATE public.email_templates SET name = ?, subject = ?, body = ?, description = ?, type = ?, active = ?, updated_at = ? " + "WHERE id = ?";
		return jdbcTemplate.update(sql, template.getName(), template.getSubject(), template.getBody(), template.getDescription(), template.getType(), template.isActive(), now, template.getId());
	}

	public int deleteById(Integer id) {
		String sql = "DELETE FROM public.email_templates WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	public int countAll() {
		String sql = "SELECT COUNT(*) FROM public.email_templates";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}
}