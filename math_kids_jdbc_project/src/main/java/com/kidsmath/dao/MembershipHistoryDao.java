package com.kidsmath.dao;

import com.kidsmath.mapper.MembershipHistoryRowMapper;
import com.kidsmath.model.MembershipHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class MembershipHistoryDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<MembershipHistory> findAll() {
		String sql = "SELECT mh.*, u.full_name as user_name, p.full_name as processed_by_name " + "FROM public.membership_history mh " + "LEFT JOIN public.users u ON mh.user_id = u.id " + "LEFT JOIN public.users p ON mh.processed_by = p.id " + "ORDER BY mh.created_at DESC";
		return jdbcTemplate.query(sql, new MembershipHistoryRowMapper());
	}

	public List<MembershipHistory> findByUserId(Integer userId) {
		String sql = "SELECT mh.*, u.full_name as user_name, p.full_name as processed_by_name " + "FROM public.membership_history mh " + "LEFT JOIN public.users u ON mh.user_id = u.id " + "LEFT JOIN public.users p ON mh.processed_by = p.id " + "WHERE mh.user_id = ? " + "ORDER BY mh.created_at DESC";
		return jdbcTemplate.query(sql, new MembershipHistoryRowMapper(), userId);
	}

	public List<MembershipHistory> findPendingPayments() {
		String sql = "SELECT mh.*, u.full_name as user_name, p.full_name as processed_by_name " + "FROM public.membership_history mh " + "LEFT JOIN public.users u ON mh.user_id = u.id " + "LEFT JOIN public.users p ON mh.processed_by = p.id " + "WHERE mh.payment_status = 'pending' " + "ORDER BY mh.created_at DESC";
		return jdbcTemplate.query(sql, new MembershipHistoryRowMapper());
	}

	public MembershipHistory findById(Integer id) {
		String sql = "SELECT mh.*, u.full_name as user_name, p.full_name as processed_by_name " + "FROM public.membership_history mh " + "LEFT JOIN public.users u ON mh.user_id = u.id " + "LEFT JOIN public.users p ON mh.processed_by = p.id " + "WHERE mh.id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new MembershipHistoryRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public int save(MembershipHistory history) {
		String sql = "INSERT INTO public.membership_history (user_id, action_type, package_type, package_months, amount, payment_status, payment_note, start_date, expiry_date, processed_by, processed_at) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, history.getUserId(), history.getActionType(), history.getPackageType(), history.getPackageMonths(), history.getAmount(), history.getPaymentStatus() != null ? history.getPaymentStatus() : "pending", history.getPaymentNote(), history.getStartDate(), history.getExpiryDate(), history.getProcessedBy(), history.getProcessedAt() != null ? history.getProcessedAt() : Timestamp.valueOf(LocalDateTime.now()));
	}

	public int updatePaymentStatus(Integer id, String status, Integer processedBy) {
		String sql = "UPDATE public.membership_history SET payment_status = ?, processed_by = ?, processed_at = ? WHERE id = ?";
		return jdbcTemplate.update(sql, status, processedBy, Timestamp.valueOf(LocalDateTime.now()), id);
	}
}