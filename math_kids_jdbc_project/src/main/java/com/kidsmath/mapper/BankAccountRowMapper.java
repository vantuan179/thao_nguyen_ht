package com.kidsmath.mapper;

import com.kidsmath.model.BankAccount;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BankAccountRowMapper implements RowMapper<BankAccount> {
	@Override
	public BankAccount mapRow(ResultSet rs, int rowNum) throws SQLException {
		BankAccount account = new BankAccount();
		account.setId(rs.getInt("id"));
		account.setBankName(rs.getString("bank_name"));
		account.setAccountNumber(rs.getString("account_number"));
		account.setAccountHolder(rs.getString("account_holder"));
		account.setBranch(rs.getString("branch"));
		account.setActive(rs.getBoolean("active"));
		account.setCreatedAt(rs.getTimestamp("created_at"));
		return account;
	}
}