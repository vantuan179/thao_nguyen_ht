package com.kidsmath.util;

import com.kidsmath.model.User;

public class AdSenseUtil {

	// Kiểm tra có hiển thị quảng cáo không
	public static boolean shouldShowAds(User user) {
		// Hiển thị quảng cáo nếu:
		// 1. Chưa đăng nhập
		// 2. Hoặc là user dùng thử (trial)
		// 3. KHÔNG hiển thị nếu là premium
		if (user == null) {
			return true; // Chưa đăng nhập -> hiện quảng cáo
		}
		return !"premium".equals(user.getMembershipType());
	}

	// Kiểm tra có phải user premium không
	public static boolean isPremium(User user) {
		return user != null && "premium".equals(user.getMembershipType());
	}

	// Lấy số câu hỏi mỗi trang
	public static int getQuestionsPerPage(User user) {
		if (isPremium(user)) {
			return Integer.MAX_VALUE; // Premium xem tất cả
		}
		return 5; // Dùng thử xem 5 câu/trang
	}

	// Kiểm tra user có phải dùng thử không
	public static boolean isTrial(User user) {
		if (user == null) {
			return true;
		}
		return "trial".equals(user.getMembershipType()) || user.getMembershipType() == null;
	}
}