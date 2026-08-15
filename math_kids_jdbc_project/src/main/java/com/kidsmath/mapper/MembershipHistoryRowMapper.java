package com.kidsmath.mapper;

import com.kidsmath.model.MembershipHistory;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MembershipHistoryRowMapper implements RowMapper<MembershipHistory> {
	@Override
	public MembershipHistory mapRow(ResultSet rs, int rowNum) throws SQLException {
		MembershipHistory history = new MembershipHistory();
		history.setId(rs.getInt("id"));
		history.setUserId(rs.getInt("user_id"));
		history.setActionType(rs.getString("action_type"));
		history.setPackageType(rs.getString("package_type"));
		history.setPackageMonths(rs.getInt("package_months"));
		history.setAmount(rs.getDouble("amount"));
		history.setPaymentStatus(rs.getString("payment_status"));
		history.setPaymentNote(rs.getString("payment_note"));
		history.setStartDate(rs.getTimestamp("start_date"));
		history.setExpiryDate(rs.getTimestamp("expiry_date"));
		history.setProcessedBy(rs.getInt("processed_by"));
		history.setProcessedAt(rs.getTimestamp("processed_at"));
		history.setCreatedAt(rs.getTimestamp("created_at"));
		history.setUserName(rs.getString("user_name"));
		history.setProcessedByName(rs.getString("processed_by_name"));
		return history;
	}
}