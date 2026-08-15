package com.kidsmath.service;

import com.kidsmath.dao.BankAccountDao;
import com.kidsmath.dao.MembershipHistoryDao;
import com.kidsmath.dao.MembershipPackageDao;
import com.kidsmath.dao.UserDao;
import com.kidsmath.model.BankAccount;
import com.kidsmath.model.MembershipHistory;
import com.kidsmath.model.MembershipPackage;
import com.kidsmath.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MembershipService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private MembershipPackageDao membershipPackageDao;

	@Autowired
	private MembershipHistoryDao membershipHistoryDao;

	@Autowired
	private BankAccountDao bankAccountDao;

	// ===== LẤY DANH SÁCH GÓI THÀNH VIÊN =====
	public List<MembershipPackage> getAllPackages() {
		return membershipPackageDao.findActive();
	}

	public MembershipPackage getPackageById(Integer id) {
		return membershipPackageDao.findById(id);
	}

	public MembershipPackage getPackageByType(String packageType) {
		return membershipPackageDao.findByType(packageType);
	}

	// ===== KIỂM TRA TRẠNG THÁI THÀNH VIÊN =====
	public boolean isPremiumUser(Integer userId) {
		User user = userDao.findById(userId);
		if (user == null)
			return false;
		return user.isPremium();
	}

	public boolean isMembershipExpired(Integer userId) {
		User user = userDao.findById(userId);
		if (user == null)
			return true;

		Timestamp expiry = user.getMembershipExpiryDate();
		if (expiry == null)
			return true;

		return expiry.before(Timestamp.valueOf(LocalDateTime.now()));
	}

	// ===== TẠO ĐƠN HÀNG (CHỜ THANH TOÁN) =====
	@Transactional
	public MembershipHistory createPendingOrder(Integer userId, String packageType, String paymentNote) {
		try {
			User user = userDao.findById(userId);
			if (user == null)
				return null;

			MembershipPackage pkg = membershipPackageDao.findByType(packageType);
			if (pkg == null)
				return null;

			// Kiểm tra user đã có đơn hàng pending chưa
			List<MembershipHistory> pendingOrders = membershipHistoryDao.findByUserId(userId);
			for (MembershipHistory h : pendingOrders) {
				if ("pending".equals(h.getPaymentStatus())) {
					// Nếu có đơn hàng pending, cập nhật lại
					h.setPackageType(packageType);
					h.setPackageMonths(pkg.getMonths());
					h.setAmount(pkg.getPrice());
					h.setPaymentNote(paymentNote);
					// Không cần update vì chúng ta sẽ tạo mới
				}
			}

			MembershipHistory history = new MembershipHistory();
			history.setUserId(userId);
			history.setActionType("REGISTER");
			history.setPackageType(packageType);
			history.setPackageMonths(pkg.getMonths());
			history.setAmount(pkg.getPrice());
			history.setPaymentStatus("pending");
			history.setPaymentNote(paymentNote);
			history.setStartDate(Timestamp.valueOf(LocalDateTime.now()));
			history.setExpiryDate(calculateExpiryDate(Timestamp.valueOf(LocalDateTime.now()), pkg.getMonths()));
			history.setProcessedAt(Timestamp.valueOf(LocalDateTime.now()));

			membershipHistoryDao.save(history);

			return history;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// ===== XÁC NHẬN THANH TOÁN =====
	@Transactional
	public boolean confirmPayment(Integer historyId, Integer processedBy) {
		try {
			MembershipHistory history = membershipHistoryDao.findById(historyId);
			if (history == null) {
				return false;
			}

			if (!"pending".equals(history.getPaymentStatus())) {
				return false;
			}

			// Cập nhật trạng thái thanh toán
			membershipHistoryDao.updatePaymentStatus(historyId, "completed", processedBy);

			// Kích hoạt hoặc gia hạn thành viên
			User user = userDao.findById(history.getUserId());
			if (user == null)
				return false;

			MembershipPackage pkg = membershipPackageDao.findByType(history.getPackageType());
			if (pkg == null)
				return false;

			// Tính ngày bắt đầu và kết thúc
			Timestamp startDate;
			Timestamp expiryDate;

			if (user.getMembershipExpiryDate() != null && user.getMembershipExpiryDate().after(Timestamp.valueOf(LocalDateTime.now()))) {
				// Nếu còn hạn, gia hạn từ ngày hết hạn
				startDate = user.getMembershipExpiryDate();
				expiryDate = calculateExpiryDate(startDate, pkg.getMonths());
			} else {
				// Nếu hết hạn hoặc chưa có, bắt đầu từ hôm nay
				startDate = Timestamp.valueOf(LocalDateTime.now());
				expiryDate = calculateExpiryDate(startDate, pkg.getMonths());
			}

			// Cập nhật user
			user.setMembershipType("premium");
			user.setMembershipStartDate(startDate);
			user.setMembershipExpiryDate(expiryDate);
			user.setMembershipStatus("active");
			userDao.update(user);

			// Cập nhật lại lịch sử với ngày chính xác
			history.setStartDate(startDate);
			history.setExpiryDate(expiryDate);
			// Không cần update vì đã lưu từ trước

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ===== ĐĂNG KÝ THÀNH VIÊN (TRỰC TIẾP) =====
	@Transactional
	public boolean registerMembershipDirect(Integer userId, String packageType, Integer processedBy) {
		try {
			User user = userDao.findById(userId);
			if (user == null)
				return false;

			MembershipPackage pkg = membershipPackageDao.findByType(packageType);
			if (pkg == null)
				return false;

			// Tính ngày bắt đầu và kết thúc
			Timestamp startDate = Timestamp.valueOf(LocalDateTime.now());
			Timestamp expiryDate = calculateExpiryDate(startDate, pkg.getMonths());

			// Cập nhật user
			user.setMembershipType("premium");
			user.setMembershipStartDate(startDate);
			user.setMembershipExpiryDate(expiryDate);
			user.setMembershipStatus("active");
			userDao.update(user);

			// Lưu lịch sử
			MembershipHistory history = new MembershipHistory();
			history.setUserId(userId);
			history.setActionType("REGISTER");
			history.setPackageType(packageType);
			history.setPackageMonths(pkg.getMonths());
			history.setAmount(pkg.getPrice());
			history.setPaymentStatus("completed");
			history.setStartDate(startDate);
			history.setExpiryDate(expiryDate);
			history.setProcessedBy(processedBy);
			history.setProcessedAt(Timestamp.valueOf(LocalDateTime.now()));
			membershipHistoryDao.save(history);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ===== GIA HẠN THÀNH VIÊN =====
	@Transactional
	public boolean renewMembershipDirect(Integer userId, String packageType, Integer processedBy) {
		try {
			User user = userDao.findById(userId);
			if (user == null)
				return false;

			MembershipPackage pkg = membershipPackageDao.findByType(packageType);
			if (pkg == null)
				return false;

			// Tính ngày hết hạn mới
			Timestamp currentExpiry = user.getMembershipExpiryDate();
			Timestamp newStartDate;
			Timestamp newExpiryDate;

			if (currentExpiry != null && currentExpiry.after(Timestamp.valueOf(LocalDateTime.now()))) {
				newStartDate = currentExpiry;
				newExpiryDate = calculateExpiryDate(currentExpiry, pkg.getMonths());
			} else {
				newStartDate = Timestamp.valueOf(LocalDateTime.now());
				newExpiryDate = calculateExpiryDate(newStartDate, pkg.getMonths());
			}

			// Cập nhật user
			user.setMembershipStartDate(newStartDate);
			user.setMembershipExpiryDate(newExpiryDate);
			user.setMembershipStatus("active");
			userDao.update(user);

			// Lưu lịch sử
			MembershipHistory history = new MembershipHistory();
			history.setUserId(userId);
			history.setActionType("RENEW");
			history.setPackageType(packageType);
			history.setPackageMonths(pkg.getMonths());
			history.setAmount(pkg.getPrice());
			history.setPaymentStatus("completed");
			history.setStartDate(newStartDate);
			history.setExpiryDate(newExpiryDate);
			history.setProcessedBy(processedBy);
			history.setProcessedAt(Timestamp.valueOf(LocalDateTime.now()));
			membershipHistoryDao.save(history);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ===== HỦY THÀNH VIÊN =====
	@Transactional
	public boolean cancelMembership(Integer userId, Integer processedBy) {
		try {
			User user = userDao.findById(userId);
			if (user == null)
				return false;

			user.setMembershipStatus("cancelled");
			userDao.update(user);

			MembershipHistory history = new MembershipHistory();
			history.setUserId(userId);
			history.setActionType("CANCEL");
			history.setPaymentStatus("completed");
			history.setProcessedBy(processedBy);
			history.setProcessedAt(Timestamp.valueOf(LocalDateTime.now()));
			membershipHistoryDao.save(history);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ===== LẤY LỊCH SỬ =====
	public List<MembershipHistory> getHistoryByUser(Integer userId) {
		return membershipHistoryDao.findByUserId(userId);
	}

	public List<MembershipHistory> getAllHistory() {
		return membershipHistoryDao.findAll();
	}

	public List<MembershipHistory> getPendingPayments() {
		return membershipHistoryDao.findPendingPayments();
	}

	public MembershipHistory getHistoryById(Integer id) {
		return membershipHistoryDao.findById(id);
	}

	// ===== THỐNG KÊ =====
	public Map<String, Object> getMembershipStats() {
		Map<String, Object> stats = new HashMap<>();

		long totalUsers = userDao.findAll().size();
		long trialUsers = userDao.countByMembershipType("trial");
		long premiumUsers = userDao.countByMembershipType("premium");
		long expiredUsers = userDao.findExpiredMemberships().size();

		stats.put("totalUsers", totalUsers);
		stats.put("trialUsers", trialUsers);
		stats.put("premiumUsers", premiumUsers);
		stats.put("expiredUsers", expiredUsers);

		// Thống kê doanh thu
		List<MembershipHistory> allHistory = membershipHistoryDao.findAll();
		double totalRevenue = 0;
		double monthlyRevenue = 0;

		LocalDateTime now = LocalDateTime.now();
		LocalDateTime monthStart = now.withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0);

		for (MembershipHistory h : allHistory) {
			if ("completed".equals(h.getPaymentStatus())) {
				totalRevenue += h.getAmount() != null ? h.getAmount() : 0;

				if (h.getProcessedAt() != null && h.getProcessedAt().toLocalDateTime().isAfter(monthStart)) {
					monthlyRevenue += h.getAmount() != null ? h.getAmount() : 0;
				}
			}
		}

		stats.put("totalRevenue", totalRevenue);
		stats.put("monthlyRevenue", monthlyRevenue);

		return stats;
	}

	// ===== TÍNH TOÁN NGÀY HẾT HẠN =====
	private Timestamp calculateExpiryDate(Timestamp startDate, int months) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(startDate);
		calendar.add(Calendar.MONTH, months);
		// Trừ 1 ngày để hết hạn vào cuối ngày
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		return new Timestamp(calendar.getTimeInMillis());
	}

	// ===== KIỂM TRA VÀ CẬP NHẬT THÀNH VIÊN HẾT HẠN =====
	@Transactional
	public void checkAndUpdateExpiredMemberships() {
		List<User> expiredUsers = userDao.findExpiredMemberships();
		for (User user : expiredUsers) {
			user.setMembershipStatus("expired");
			userDao.update(user);
		}
	}

	public void updatePackage(MembershipPackage pkg) {
		membershipPackageDao.update(pkg);
	}

	public void savePackage(MembershipPackage pkg) {
		membershipPackageDao.save(pkg);
	}

	// ===== HỦY THANH TOÁN =====
	public boolean cancelPayment(Integer historyId) {
		try {
			MembershipHistory history = membershipHistoryDao.findById(historyId);
			if (history == null) {
				return false;
			}
			// Cập nhật trạng thái thành cancelled
			// membershipHistoryDao.updatePaymentStatus(historyId, "cancelled", null);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ===== LẤY DANH SÁCH NGÂN HÀNG =====
	public List<BankAccount> getBankAccounts() {
		return bankAccountDao.findActive();
	}
}