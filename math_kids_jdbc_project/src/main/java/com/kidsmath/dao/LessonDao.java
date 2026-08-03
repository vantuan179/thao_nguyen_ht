package com.kidsmath.dao;

import com.kidsmath.mapper.LessonRowMapper;
import com.kidsmath.model.Grade;
import com.kidsmath.model.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LessonDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	// ===== LẤY TẤT CẢ =====
	public List<Lesson> findAll() {
		String sql = "SELECT id, title, description, grade, content, video_url, created_at " + "FROM public.lessons ORDER BY grade, id";
		return jdbcTemplate.query(sql, new LessonRowMapper());
	}

	// ===== TÌM THEO ID =====
	public Lesson findById(Integer id) {
		String sql = "SELECT id, title, description, grade, content, video_url, created_at " + "FROM public.lessons WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new LessonRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	// ===== TÌM THEO GRADE (LỚP) =====
	public List<Lesson> findByGrade(Integer grade) {
		String sql = "SELECT id, title, description, grade, content, video_url, created_at " + "FROM public.lessons WHERE grade = ? ORDER BY id";
		return jdbcTemplate.query(sql, new LessonRowMapper(), grade);
	}

	// ===== TÌM THEO GRADE KÈM THÔNG TIN GRADE =====
	public List<Lesson> findByGradeWithInfo(Integer grade) {
		String sql = "SELECT l.*, g.grade_name, g.icon, g.display_order " + "FROM public.lessons l " + "INNER JOIN public.grade g ON l.grade = g.id " + "WHERE l.grade = ? " + "ORDER BY l.id";
		return jdbcTemplate.query(sql, (rs, rowNum) -> {
			Lesson lesson = new LessonRowMapper().mapRow(rs, rowNum);
			// Set grade info
			Grade gradeInfo = new Grade();
			gradeInfo.setId(rs.getInt("grade"));
			gradeInfo.setGradeName(rs.getString("grade_name"));
			gradeInfo.setIcon(rs.getString("icon"));
			gradeInfo.setDisplayOrder(rs.getInt("display_order"));
			lesson.setGradeInfo(gradeInfo);
			return lesson;
		}, grade);
	}

	// ===== LẤY TẤT CẢ KÈM THÔNG TIN GRADE =====
	public List<Lesson> findAllWithGradeInfo() {
		String sql = "SELECT l.*, g.grade_name, g.icon, g.display_order " + "FROM public.lessons l " + "INNER JOIN public.grade g ON l.grade = g.id " + "ORDER BY g.display_order, l.id";
		return jdbcTemplate.query(sql, (rs, rowNum) -> {
			Lesson lesson = new LessonRowMapper().mapRow(rs, rowNum);
			// Set grade info
			Grade gradeInfo = new Grade();
			gradeInfo.setId(rs.getInt("grade"));
			gradeInfo.setGradeName(rs.getString("grade_name"));
			gradeInfo.setIcon(rs.getString("icon"));
			gradeInfo.setDisplayOrder(rs.getInt("display_order"));
			lesson.setGradeInfo(gradeInfo);
			return lesson;
		});
	}

	// ===== LƯU BÀI HỌC MỚI =====
	public int save(Lesson lesson) {
		String sql = "INSERT INTO public.lessons (title, description, grade, content, video_url) " + "VALUES (?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, lesson.getTitle(), lesson.getDescription(), lesson.getGrade(), lesson.getContent(), lesson.getVideoUrl());
	}

	// ===== CẬP NHẬT BÀI HỌC =====
	public int update(Lesson lesson) {
		String sql = "UPDATE public.lessons SET title = ?, description = ?, grade = ?, content = ?, video_url = ? " + "WHERE id = ?";
		return jdbcTemplate.update(sql, lesson.getTitle(), lesson.getDescription(), lesson.getGrade(), lesson.getContent(), lesson.getVideoUrl(), lesson.getId());
	}

	// ===== XÓA BÀI HỌC =====
	public int deleteById(Integer id) {
		// Kiểm tra có câu hỏi nào thuộc bài học này không
		String checkSql = "SELECT COUNT(*) FROM public.quizzes WHERE lesson_id = ?";
		Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, id);
		if (count != null && count > 0) {
			return -1; // Không thể xóa vì có câu hỏi con
		}
		String sql = "DELETE FROM public.lessons WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	// ===== KIỂM TRA TỒN TẠI =====
	public boolean existsById(Integer id) {
		String sql = "SELECT COUNT(*) FROM public.lessons WHERE id = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, id);
		return count != null && count > 0;
	}

	// ===== ĐẾM SỐ BÀI HỌC THEO GRADE =====
	public int countByGrade(Integer grade) {
		String sql = "SELECT COUNT(*) FROM public.lessons WHERE grade = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, grade);
		return count != null ? count : 0;
	}

	// ===== TÌM KIẾM THEO TIÊU ĐỀ =====
	public List<Lesson> searchByTitle(String keyword) {
		String sql = "SELECT id, title, description, grade, content, video_url, created_at " + "FROM public.lessons WHERE LOWER(title) LIKE LOWER(?) ORDER BY grade, id";
		String searchKeyword = "%" + keyword + "%";
		return jdbcTemplate.query(sql, new LessonRowMapper(), searchKeyword);
	}

	// ===== LẤY BÀI HỌC MỚI NHẤT THEO GRADE =====
	public List<Lesson> findRecentByGrade(Integer grade, int limit) {
		String sql = "SELECT id, title, description, grade, content, video_url, created_at " + "FROM public.lessons WHERE grade = ? " + "ORDER BY created_at DESC LIMIT ?";
		return jdbcTemplate.query(sql, new LessonRowMapper(), grade, limit);
	}

	// ===== LẤY BÀI HỌC MỚI NHẤT =====
	public List<Lesson> findRecent(int limit) {
		String sql = "SELECT id, title, description, grade, content, video_url, created_at " + "FROM public.lessons ORDER BY created_at DESC LIMIT ?";
		return jdbcTemplate.query(sql, new LessonRowMapper(), limit);
	}
}