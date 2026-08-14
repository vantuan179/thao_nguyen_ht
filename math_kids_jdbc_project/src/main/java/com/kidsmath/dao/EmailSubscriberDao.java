package com.kidsmath.dao;

import com.kidsmath.model.EmailSubscriber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmailSubscriberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<String> findAllActiveEmails() {
		String sql = "SELECT email FROM public.email_subscribers WHERE active = true";
		return jdbcTemplate.queryForList(sql, String.class);
	}

	public int save(String email, String fullName) {
		String sql = "INSERT INTO public.email_subscribers (email, full_name) VALUES (?, ?) " + "ON CONFLICT (email) DO UPDATE SET active = true, subscribed_at = CURRENT_TIMESTAMP";
		return jdbcTemplate.update(sql, email, fullName);
	}

	public int unsubscribe(String email) {
		String sql = "UPDATE public.email_subscribers SET active = false WHERE email = ?";
		return jdbcTemplate.update(sql, email);
	}

	public boolean existsByEmail(String email) {
		String sql = "SELECT COUNT(*) FROM public.email_subscribers WHERE email = ? AND active = true";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
		return count != null && count > 0;
	}
}