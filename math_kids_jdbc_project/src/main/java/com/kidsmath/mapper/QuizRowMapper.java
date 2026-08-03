package com.kidsmath.mapper;

import com.kidsmath.model.Quiz;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class QuizRowMapper implements RowMapper<Quiz> {
	@Override
	public Quiz mapRow(ResultSet rs, int rowNum) throws SQLException {
		Quiz quiz = new Quiz();
		quiz.setId(rs.getInt("id"));
		quiz.setLessonId(rs.getInt("lesson_id"));
		quiz.setQuestion(rs.getString("question"));
		quiz.setOptionA(rs.getString("option_a"));
		quiz.setOptionB(rs.getString("option_b"));
		quiz.setOptionC(rs.getString("option_c"));
		quiz.setOptionD(rs.getString("option_d"));
		quiz.setCorrectOption(rs.getString("correct_option"));
		quiz.setExplanation(rs.getString("explanation"));
		quiz.setPoints(rs.getInt("points"));
		return quiz;
	}
}
