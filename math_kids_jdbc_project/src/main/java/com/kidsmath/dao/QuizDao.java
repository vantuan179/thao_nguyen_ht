package com.kidsmath.dao;

import com.kidsmath.mapper.QuizRowMapper;
import com.kidsmath.model.Lesson;
import com.kidsmath.model.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class QuizDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<Quiz> findAll() {
		String sql = "SELECT id, lesson_id, question, option_a, option_b, option_c, option_d, " + "correct_option, explanation, points, created_at " + "FROM public.quizzes ORDER BY lesson_id, id";
		return jdbcTemplate.query(sql, new QuizRowMapper());
	}

	public List<Quiz> findByLessonId(Integer lessonId) {
		String sql = "SELECT id, lesson_id, question, option_a, option_b, option_c, option_d, " + "correct_option, explanation, points, created_at " + "FROM public.quizzes WHERE lesson_id = ? ORDER BY id";
		return jdbcTemplate.query(sql, new QuizRowMapper(), lessonId);
	}

	public Quiz findById(Integer id) {
		String sql = "SELECT id, lesson_id, question, option_a, option_b, option_c, option_d, " + "correct_option, explanation, points, created_at " + "FROM public.quizzes WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new QuizRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public List<Quiz> findQuizzesWithLessonInfo() {
		String sql = "SELECT q.*, l.title as lesson_title, l.grade " + "FROM public.quizzes q " + "INNER JOIN public.lessons l ON q.lesson_id = l.id " + "ORDER BY l.grade, l.id, q.id";
		return jdbcTemplate.query(sql, (rs, rowNum) -> {
			Quiz quiz = new QuizRowMapper().mapRow(rs, rowNum);
			Lesson lesson = new Lesson();
			lesson.setId(rs.getInt("lesson_id"));
			lesson.setTitle(rs.getString("lesson_title"));
			lesson.setGrade(rs.getInt("grade"));
			quiz.setLesson(lesson);
			return quiz;
		});
	}

	public int save(Quiz quiz) {
		String sql = "INSERT INTO public.quizzes (lesson_id, question, option_a, option_b, option_c, option_d, " + "correct_option, explanation, points) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, quiz.getLessonId(), quiz.getQuestion(), quiz.getOptionA(), quiz.getOptionB(), quiz.getOptionC(), quiz.getOptionD(), quiz.getCorrectOption(), quiz.getExplanation(), quiz.getPoints() != null ? quiz.getPoints() : 10);
	}

	public int update(Quiz quiz) {
		String sql = "UPDATE public.quizzes SET lesson_id = ?, question = ?, option_a = ?, option_b = ?, " + "option_c = ?, option_d = ?, correct_option = ?, explanation = ?, points = ? " + "WHERE id = ?";
		return jdbcTemplate.update(sql, quiz.getLessonId(), quiz.getQuestion(), quiz.getOptionA(), quiz.getOptionB(), quiz.getOptionC(), quiz.getOptionD(), quiz.getCorrectOption(), quiz.getExplanation(), quiz.getPoints(), quiz.getId());
	}

	public int deleteById(Integer id) {
		String sql = "DELETE FROM public.quizzes WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	public int deleteByLessonId(Integer lessonId) {
		String sql = "DELETE FROM public.quizzes WHERE lesson_id = ?";
		return jdbcTemplate.update(sql, lessonId);
	}

	public int countByLessonId(Integer lessonId) {
		String sql = "SELECT COUNT(*) FROM public.quizzes WHERE lesson_id = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, lessonId);
		return count != null ? count : 0;
	}

	// ===== THÊM PHƯƠNG THỨC NÀY =====
	public int getTotalPointsByLessonId(Integer lessonId) {
		String sql = "SELECT COALESCE(SUM(points), 0) FROM public.quizzes WHERE lesson_id = ?";
		Integer total = jdbcTemplate.queryForObject(sql, Integer.class, lessonId);
		return total != null ? total : 0;
	}
}