package com.kidsmath.dao;

import com.kidsmath.mapper.BankAccountRowMapper;
import com.kidsmath.model.BankAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BankAccountDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<BankAccount> findAll() {
		String sql = "SELECT id, bank_name, account_number, account_holder, branch, active, created_at FROM public.bank_accounts ORDER BY id";
		return jdbcTemplate.query(sql, new BankAccountRowMapper());
	}

	public List<BankAccount> findActive() {
		String sql = "SELECT id, bank_name, account_number, account_holder, branch, active, created_at FROM public.bank_accounts WHERE active = true ORDER BY id";
		return jdbcTemplate.query(sql, new BankAccountRowMapper());
	}

	public BankAccount findById(Integer id) {
		String sql = "SELECT id, bank_name, account_number, account_holder, branch, active, created_at FROM public.bank_accounts WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new BankAccountRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}
}