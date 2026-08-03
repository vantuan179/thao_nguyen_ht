package com.kidsmath.dao;

import com.kidsmath.mapper.GradeRowMapper;
import com.kidsmath.model.Grade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GradeDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	// Lấy tất cả lớp học
	public List<Grade> findAll() {
		String sql = "SELECT id, grade_name, display_order, description, icon, active, created_at " + "FROM public.grade ORDER BY display_order, id";
		return jdbcTemplate.query(sql, new GradeRowMapper());
	}

	// Lấy các lớp học đang active
	public List<Grade> findActiveGrades() {
		String sql = "SELECT id, grade_name, display_order, description, icon, active, created_at " + "FROM public.grade WHERE active = true ORDER BY display_order, id";
		return jdbcTemplate.query(sql, new GradeRowMapper());
	}

	// Tìm lớp học theo ID
	public Grade findById(Integer id) {
		String sql = "SELECT id, grade_name, display_order, description, icon, active, created_at " + "FROM public.grade WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new GradeRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	// Tìm lớp học theo tên
	public Grade findByGradeName(String gradeName) {
		String sql = "SELECT id, grade_name, display_order, description, icon, active, created_at " + "FROM public.grade WHERE grade_name = ?";
		List<Grade> grades = jdbcTemplate.query(sql, new GradeRowMapper(), gradeName);
		return grades.isEmpty() ? null : grades.get(0);
	}

	// Thêm mới lớp học
	public int save(Grade grade) {
		String sql = "INSERT INTO public.grade (grade_name, display_order, description, icon, active) " + "VALUES (?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, grade.getGradeName(), grade.getDisplayOrder(), grade.getDescription(), grade.getIcon(), grade.getActive());
	}

	// Cập nhật lớp học
	public int update(Grade grade) {
		String sql = "UPDATE public.grade SET grade_name = ?, display_order = ?, description = ?, icon = ?, active = ? " + "WHERE id = ?";
		return jdbcTemplate.update(sql, grade.getGradeName(), grade.getDisplayOrder(), grade.getDescription(), grade.getIcon(), grade.getActive(), grade.getId());
	}

	// Xóa lớp học (soft delete - set active = false)
	public int softDelete(Integer id) {
		String sql = "UPDATE public.grade SET active = false WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	// Xóa lớp học (hard delete - xóa hẳn)
	public int deleteById(Integer id) {
		// Kiểm tra xem có bài học nào thuộc lớp này không
		String checkSql = "SELECT COUNT(*) FROM public.lessons WHERE grade = ?";
		Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, id);
		if (count != null && count > 0) {
			return -1; // Không thể xóa vì có bài học con
		}
		String sql = "DELETE FROM public.grade WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	// Kiểm tra tồn tại
	public boolean existsById(Integer id) {
		String sql = "SELECT COUNT(*) FROM public.grade WHERE id = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, id);
		return count != null && count > 0;
	}

	public boolean existsByGradeName(String gradeName) {
		String sql = "SELECT COUNT(*) FROM public.grade WHERE grade_name = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, gradeName);
		return count != null && count > 0;
	}

	// Đếm số lượng bài học trong lớp
	public int countLessonsByGradeId(Integer gradeId) {
		String sql = "SELECT COUNT(*) FROM public.lessons WHERE grade = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, gradeId);
		return count != null ? count : 0;
	}

	// Lấy số lượng lớp học
	public int countAll() {
		String sql = "SELECT COUNT(*) FROM public.grade";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}

	// Lấy số lượng lớp học active
	public int countActive() {
		String sql = "SELECT COUNT(*) FROM public.grade WHERE active = true";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}

	// Tìm kiếm lớp học theo tên
	public List<Grade> searchByGradeName(String keyword) {
		String sql = "SELECT id, grade_name, display_order, description, icon, active, created_at " + "FROM public.grade WHERE LOWER(grade_name) LIKE LOWER(?) ORDER BY display_order";
		String searchKeyword = "%" + keyword + "%";
		return jdbcTemplate.query(sql, new GradeRowMapper(), searchKeyword);
	}

	// Lấy lớp học có thứ tự sắp xếp cao nhất
	public int getMaxDisplayOrder() {
		String sql = "SELECT COALESCE(MAX(display_order), 0) FROM public.grade";
		Integer maxOrder = jdbcTemplate.queryForObject(sql, Integer.class);
		return maxOrder != null ? maxOrder : 0;
	}
}