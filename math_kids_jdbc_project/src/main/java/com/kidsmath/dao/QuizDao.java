package com.kidsmath.dao;

import com.kidsmath.mapper.QuizRowMapper;
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
        String sql = "SELECT id, lesson_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, points FROM quizzes ORDER BY id";
        return jdbcTemplate.query(sql, new QuizRowMapper());
    }

    public List<Quiz> findByLessonId(Integer lessonId) {
        String sql = "SELECT id, lesson_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, points FROM quizzes WHERE lesson_id = ? ORDER BY id";
        return jdbcTemplate.query(sql, new QuizRowMapper(), lessonId);
    }

    public Quiz findById(Integer id) {
        String sql = "SELECT id, lesson_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, points FROM quizzes WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new QuizRowMapper(), id);
    }

    public int save(Quiz quiz) {
        String sql = "INSERT INTO quizzes (lesson_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, points) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
                quiz.getLessonId(),
                quiz.getQuestion(),
                quiz.getOptionA(),
                quiz.getOptionB(),
                quiz.getOptionC(),
                quiz.getOptionD(),
                quiz.getCorrectOption(),
                quiz.getExplanation(),
                quiz.getPoints());
    }

    public int update(Quiz quiz) {
        String sql = "UPDATE quizzes SET lesson_id = ?, question = ?, option_a = ?, option_b = ?, option_c = ?, option_d = ?, correct_option = ?, explanation = ?, points = ? WHERE id = ?";
        return jdbcTemplate.update(sql,
                quiz.getLessonId(),
                quiz.getQuestion(),
                quiz.getOptionA(),
                quiz.getOptionB(),
                quiz.getOptionC(),
                quiz.getOptionD(),
                quiz.getCorrectOption(),
                quiz.getExplanation(),
                quiz.getPoints(),
                quiz.getId());
    }

    public int deleteById(Integer id) {
        String sql = "DELETE FROM quizzes WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}
