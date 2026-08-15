package com.kidsmath.controller;

import com.kidsmath.model.BankAccount;
import com.kidsmath.model.MembershipHistory;
import com.kidsmath.model.MembershipPackage;
import com.kidsmath.model.User;
import com.kidsmath.service.MembershipService;
import com.kidsmath.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/membership")
public class MembershipAdminController extends BaseController {

	@Autowired
	private MembershipService membershipService;

	@Autowired
	private UserService userService;

	// ===== DASHBOARD THÀNH VIÊN =====
	@GetMapping
	public String membershipDashboard(Model model) {
		Map<String, Object> stats = membershipService.getMembershipStats();
		model.addAttribute("stats", stats);

		// Lấy danh sách user premium
		List<User> premiumUsers = userService.findByMembershipType("premium");
		model.addAttribute("premiumUsers", premiumUsers);

		// Lấy danh sách user trial
		List<User> trialUsers = userService.findByMembershipType("trial");
		model.addAttribute("trialUsers", trialUsers);

		// Lấy danh sách thanh toán pending
		List<MembershipHistory> pendingPayments = membershipService.getPendingPayments();
		model.addAttribute("pendingPayments", pendingPayments);

		return "admin/membership/dashboard";
	}

	// ===== QUẢN LÝ GÓI THÀNH VIÊN =====
	@GetMapping("/packages")
	public String listPackages(Model model) {
		List<MembershipPackage> packages = membershipService.getAllPackages();
		model.addAttribute("packages", packages);
		return "admin/membership/packages";
	}

	// ===== FORM THÊM GÓI THÀNH VIÊN =====
	@GetMapping("/packages/create")
	public String createPackage(Model model) {
		model.addAttribute("packageObj", new MembershipPackage());
		return "admin/membership/package-form";
	}

	@PostMapping("/packages/create")
	public String addPackage(@RequestParam String packageName, @RequestParam String packageType, @RequestParam Integer months, @RequestParam Double price, @RequestParam String description, @RequestParam(required = false) Boolean active, RedirectAttributes redirectAttributes) {
		try {
			MembershipPackage pkg = new MembershipPackage();
			pkg.setPackageName(packageName);
			pkg.setPackageType(packageType);
			pkg.setMonths(months);
			pkg.setPrice(price);
			pkg.setDescription(description);
			pkg.setActive(active != null ? active : true);

			membershipService.savePackage(pkg);

			redirectAttributes.addFlashAttribute("success", "Thêm gói thành viên '" + packageName + "' thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}
		return "redirect:/admin/membership/packages";
	}

	// ===== FORM SỬA GÓI THÀNH VIÊN =====
	@GetMapping("/packages/edit/{id}")
	public String editPackage(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
		try {
			MembershipPackage pkg = membershipService.getPackageById(id);
			if (pkg == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy gói thành viên!");
				return "redirect:/admin/membership/packages";
			}
			model.addAttribute("packageObj", pkg);
			return "admin/membership/package-form";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/membership/packages";
		}
	}

	@PostMapping("/packages/edit/{id}")
	public String updatePackage(@PathVariable Integer id, @RequestParam String packageName, @RequestParam String packageType, @RequestParam Integer months, @RequestParam Double price, @RequestParam String description, @RequestParam(required = false) Boolean active, RedirectAttributes redirectAttributes) {
		try {
			MembershipPackage pkg = membershipService.getPackageById(id);
			if (pkg == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy gói thành viên!");
				return "redirect:/admin/membership/packages";
			}

			pkg.setPackageName(packageName);
			pkg.setPackageType(packageType);
			pkg.setMonths(months);
			pkg.setPrice(price);
			pkg.setDescription(description);
			pkg.setActive(active != null ? active : true);

			membershipService.updatePackage(pkg);

			redirectAttributes.addFlashAttribute("success", "Cập nhật gói thành viên '" + packageName + "' thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}
		return "redirect:/admin/membership/packages";
	}

	// ===== QUẢN LÝ THANH TOÁN =====
	@GetMapping("/payments")
	public String listPayments(Model model) {
		List<MembershipHistory> pendingPayments = membershipService.getPendingPayments();
		List<MembershipHistory> allPayments = membershipService.getAllHistory();

		model.addAttribute("pendingPayments", pendingPayments);
		model.addAttribute("allPayments", allPayments);
		return "admin/membership/payments";
	}

	@PostMapping("/payments/confirm/{id}")
	public String confirmPayment(@PathVariable Integer id, HttpSession session, RedirectAttributes redirectAttributes) {
		try {
			User admin = (User) session.getAttribute("currentUser");
			if (admin == null) {
				redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
				return "redirect:/login";
			}

			boolean success = membershipService.confirmPayment(id, admin.getId());
			if (success) {
				redirectAttributes.addFlashAttribute("success", "Xác nhận thanh toán thành công!");
			} else {
				redirectAttributes.addFlashAttribute("error", "Xác nhận thanh toán thất bại!");
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}
		return "redirect:/admin/membership/payments";
	}

	@PostMapping("/payments/cancel/{id}")
	public String cancelPayment(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
		try {
			// Cập nhật trạng thái thanh toán thành cancelled
			membershipService.cancelPayment(id);
			redirectAttributes.addFlashAttribute("success", "Đã hủy thanh toán!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}
		return "redirect:/admin/membership/payments";
	}

	@GetMapping("/activate/{userId}")
	public String showActivateFormForUser(@PathVariable Integer userId, Model model, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(userId);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
				return "redirect:/admin/membership";
			}

			List<MembershipPackage> packages = membershipService.getAllPackages();
			model.addAttribute("user", user);
			model.addAttribute("packages", packages);
			return "admin/membership/activate";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/membership";
		}
	}

	// ===== LỊCH SỬ =====
	@GetMapping("/history")
	public String listHistory(Model model) {
		List<MembershipHistory> history = membershipService.getAllHistory();
		model.addAttribute("history", history);
		return "admin/membership/history";
	}

	@GetMapping("/history/user/{userId}")
	public String historyByUser(@PathVariable Integer userId, Model model, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(userId);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
				return "redirect:/admin/membership/history";
			}

			List<MembershipHistory> history = membershipService.getHistoryByUser(userId);
			model.addAttribute("user", user);
			model.addAttribute("history", history);
			return "admin/membership/history-user";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/membership/history";
		}
	}

	// ===== HỦY THÀNH VIÊN =====
	@PostMapping("/cancel/{userId}")
	public String cancelMembership(@PathVariable Integer userId, HttpSession session, RedirectAttributes redirectAttributes) {
		try {
			User admin = (User) session.getAttribute("currentUser");
			if (admin == null) {
				redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
				return "redirect:/login";
			}

			boolean success = membershipService.cancelMembership(userId, admin.getId());
			if (success) {
				redirectAttributes.addFlashAttribute("success", "Hủy thành viên thành công!");
			} else {
				redirectAttributes.addFlashAttribute("error", "Hủy thành viên thất bại!");
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}
		return "redirect:/admin/membership";
	}

	// ===== THÔNG TIN NGÂN HÀNG =====
	@GetMapping("/bank-accounts")
	public String listBankAccounts(Model model) {
		List<BankAccount> bankAccounts = membershipService.getBankAccounts();
		model.addAttribute("bankAccounts", bankAccounts);
		return "admin/membership/bank-accounts";
	}

	// ===== FORM KÍCH HOẠT (CHỌN USER) =====
	@GetMapping("/activate")
	public String showActivateForm(Model model) {
		List<User> users = userService.findAll();
		List<MembershipPackage> packages = membershipService.getAllPackages();
		model.addAttribute("users", users);
		model.addAttribute("packages", packages);
		return "admin/membership/activate";
	}

	// ===== CHUYỂN ĐẾN FORM KÍCH HOẠT CHO USER CỤ THỂ =====
	@GetMapping("/activate/select")
	public String selectUserForActivation(@RequestParam Integer userId, Model model, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(userId);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
				return "redirect:/admin/membership/activate";
			}

			List<MembershipPackage> packages = membershipService.getAllPackages();
			model.addAttribute("user", user);
			model.addAttribute("packages", packages);
			return "admin/membership/activate";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
			return "redirect:/admin/membership/activate";
		}
	}

	// ===== KÍCH HOẠT CHO USER CỤ THỂ =====
	@PostMapping("/activate/{userId}")
	public String activateMembership(@PathVariable Integer userId, @RequestParam String packageType, @RequestParam(required = false) String action, HttpSession session, RedirectAttributes redirectAttributes) {
		try {
			User admin = (User) session.getAttribute("currentUser");
			if (admin == null) {
				redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
				return "redirect:/login";
			}

			boolean success;
			if ("renew".equals(action)) {
				success = membershipService.renewMembershipDirect(userId, packageType, admin.getId());
			} else {
				success = membershipService.registerMembershipDirect(userId, packageType, admin.getId());
			}

			if (success) {
				redirectAttributes.addFlashAttribute("success", "Kích hoạt thành viên thành công!");
			} else {
				redirectAttributes.addFlashAttribute("error", "Kích hoạt thất bại!");
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}
		return "redirect:/admin/membership";
	}
}