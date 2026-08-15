package com.kidsmath.mapper;

import com.kidsmath.model.MembershipPackage;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MembershipPackageRowMapper implements RowMapper<MembershipPackage> {
	@Override
	public MembershipPackage mapRow(ResultSet rs, int rowNum) throws SQLException {
		MembershipPackage pkg = new MembershipPackage();
		pkg.setId(rs.getInt("id"));
		pkg.setPackageName(rs.getString("package_name"));
		pkg.setPackageType(rs.getString("package_type"));
		pkg.setMonths(rs.getInt("months"));
		pkg.setPrice(rs.getDouble("price"));
		pkg.setDescription(rs.getString("description"));
		pkg.setActive(rs.getBoolean("active"));
		pkg.setCreatedAt(rs.getTimestamp("created_at"));
		return pkg;
	}
}