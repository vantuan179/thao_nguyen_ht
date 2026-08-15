package com.kidsmath.dao;

import com.kidsmath.mapper.MembershipPackageRowMapper;
import com.kidsmath.model.MembershipPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MembershipPackageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<MembershipPackage> findAll() {
		String sql = "SELECT id, package_name, package_type, months, price, description, active, created_at FROM public.membership_packages ORDER BY months";
		return jdbcTemplate.query(sql, new MembershipPackageRowMapper());
	}

	public List<MembershipPackage> findActive() {
		String sql = "SELECT id, package_name, package_type, months, price, description, active, created_at FROM public.membership_packages WHERE active = true ORDER BY months";
		return jdbcTemplate.query(sql, new MembershipPackageRowMapper());
	}

	public MembershipPackage findById(Integer id) {
		String sql = "SELECT id, package_name, package_type, months, price, description, active, created_at FROM public.membership_packages WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new MembershipPackageRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public MembershipPackage findByType(String packageType) {
		String sql = "SELECT id, package_name, package_type, months, price, description, active, created_at FROM public.membership_packages WHERE package_type = ? AND active = true";
		List<MembershipPackage> packages = jdbcTemplate.query(sql, new MembershipPackageRowMapper(), packageType);
		return packages.isEmpty() ? null : packages.get(0);
	}

	public int update(MembershipPackage pkg) {
		String sql = "UPDATE public.membership_packages SET package_name = ?, package_type = ?, months = ?, price = ?, description = ?, active = ? WHERE id = ?";
		return jdbcTemplate.update(sql, pkg.getPackageName(), pkg.getPackageType(), pkg.getMonths(), pkg.getPrice(), pkg.getDescription(), pkg.getActive(), pkg.getId());
	}

	public int save(MembershipPackage pkg) {
		String sql = "INSERT INTO public.membership_packages (package_name, package_type, months, price, description, active) VALUES (?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, pkg.getPackageName(), pkg.getPackageType(), pkg.getMonths(), pkg.getPrice(), pkg.getDescription(), pkg.getActive());
	}
}