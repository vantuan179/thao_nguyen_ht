package com.kidsmath.model;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
	private Integer id;
	private String username;
	private String password;
	private String fullName;
	private String email;
	private String role;
	private Integer gradeId;

	// Thông tin cá nhân
	private Date dateOfBirth;
	private String street; // Đường/Phố
	private String hamlet; // Thôn/Xóm/Ấp
	private String commune; // Xã/Phường
	private String district; // Huyện/Quận
	private String province; // Tỉnh/Thành phố
	private String phone;
	private String gender;
	private String avatar;

	// Thành viên
	private String membershipType;
	private Timestamp membershipStartDate;
	private Timestamp membershipExpiryDate;
	private String membershipStatus;
	private Timestamp createdAt;

	public User() {
	}

	// Getters and Setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Integer getGradeId() {
		return gradeId;
	}

	public void setGradeId(Integer gradeId) {
		this.gradeId = gradeId;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getHamlet() {
		return hamlet;
	}

	public void setHamlet(String hamlet) {
		this.hamlet = hamlet;
	}

	public String getCommune() {
		return commune;
	}

	public void setCommune(String commune) {
		this.commune = commune;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getMembershipType() {
		return membershipType;
	}

	public void setMembershipType(String membershipType) {
		this.membershipType = membershipType;
	}

	public Timestamp getMembershipStartDate() {
		return membershipStartDate;
	}

	public void setMembershipStartDate(Timestamp membershipStartDate) {
		this.membershipStartDate = membershipStartDate;
	}

	public Timestamp getMembershipExpiryDate() {
		return membershipExpiryDate;
	}

	public void setMembershipExpiryDate(Timestamp membershipExpiryDate) {
		this.membershipExpiryDate = membershipExpiryDate;
	}

	public String getMembershipStatus() {
		return membershipStatus;
	}

	public void setMembershipStatus(String membershipStatus) {
		this.membershipStatus = membershipStatus;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	// Helper method - Lấy địa chỉ đầy đủ
	public String getFullAddress() {
		StringBuilder sb = new StringBuilder();

		// Đường/Phố
		if (street != null && !street.isEmpty()) {
			sb.append(street);
		}

		// Thôn/Xóm/Ấp
		if (hamlet != null && !hamlet.isEmpty()) {
			if (sb.length() > 0)
				sb.append(", ");
			sb.append(hamlet);
		}

		// Xã/Phường
		if (commune != null && !commune.isEmpty()) {
			if (sb.length() > 0)
				sb.append(", ");
			sb.append(commune);
		}

		// Huyện/Quận
		if (district != null && !district.isEmpty()) {
			if (sb.length() > 0)
				sb.append(", ");
			sb.append(district);
		}

		// Tỉnh/Thành phố
		if (province != null && !province.isEmpty()) {
			if (sb.length() > 0)
				sb.append(", ");
			sb.append(province);
		}

		return sb.toString();
	}

	public boolean isPremium() {
		return "premium".equals(membershipType) && "active".equals(membershipStatus) && membershipExpiryDate != null && membershipExpiryDate.after(new Timestamp(System.currentTimeMillis()));
	}
}