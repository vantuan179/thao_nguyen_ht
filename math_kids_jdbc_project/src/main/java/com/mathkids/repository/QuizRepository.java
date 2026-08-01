package com.mathkids.repository;

import com.mathkids.model.Quiz;
import com.mathkids.model.QuizOption;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class QuizRepository {

    private final JdbcTemplate jdbcTemplate;

    public QuizRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Quiz> quizRowMapper = new RowMapper<Quiz>() {
        @Override
        public Quiz mapRow(ResultSet rs, int rowNum) throws SQLException {
            Quiz quiz = new Quiz();
            quiz.setId(rs.getLong("id"));
            quiz.setLessonId(rs.getLong("lesson_id"));
            quiz.setQuestionText(rs.getString("question_text"));
            quiz.setQuestionType(rs.getString("question_type"));
            quiz.setCorrectAnswer(rs.getString("correct_answer"));
            quiz.setPoints(rs.getObject("points") != null ? rs.getInt("points") : null);
            quiz.setOrderIndex(rs.getObject("order_index") != null ? rs.getInt("order_index") : null);
            return quiz;
        }
    };

    private final RowMapper<QuizOption> optionRowMapper = new RowMapper<QuizOption>() {
        @Override
        public QuizOption mapRow(ResultSet rs, int rowNum) throws SQLException {
            QuizOption option = new QuizOption();
            option.setId(rs.getLong("id"));
            option.setQuizId(rs.getLong("quiz_id"));
            option.setOptionText(rs.getString("option_text"));
            option.setCorrect(rs.getBoolean("is_correct"));
            return option;
        }
    };

    public List<Quiz> findAll() {
        String sql = "SELECT id, lesson_id, question_text, question_type, correct_answer, points, order_index FROM quizzes ORDER BY order_index, id";
        List<Quiz> quizzes = jdbcTemplate.query(sql, quizRowMapper);
        attachOptions(quizzes);
        return quizzes;
    }

    public List<Quiz> findByLessonId(Long lessonId) {
        String sql = "SELECT id, lesson_id, question_text, question_type, correct_answer, points, order_index FROM quizzes WHERE lesson_id = ? ORDER BY order_index, id";
        List<Quiz> quizzes = jdbcTemplate.query(sql, quizRowMapper, lessonId);
        attachOptions(quizzes);
        return quizzes;
    }

    public Optional<Quiz> findById(Long id) {
        String sql = "SELECT id, lesson_id, question_text, question_type, correct_answer, points, order_index FROM quizzes WHERE id = ?";
        List<Quiz> quizzes = jdbcTemplate.query(sql, quizRowMapper, id);
        if (quizzes.isEmpty()) {
            return Optional.empty();
        }
        Quiz quiz = quizzes.get(0);
        quiz.setOptions(findOptionsByQuizId(quiz.getId()));
        return Optional.of(quiz);
    }

    public List<QuizOption> findOptionsByQuizId(Long quizId) {
        String sql = "SELECT id, quiz_id, option_text, is_correct FROM quiz_options WHERE quiz_id = ? ORDER BY id";
        return jdbcTemplate.query(sql, optionRowMapper, quizId);
    }

    private void attachOptions(List<Quiz> quizzes) {
        for (Quiz quiz : quizzes) {
            quiz.setOptions(findOptionsByQuizId(quiz.getId()));
        }
    }

    public Quiz save(Quiz quiz) {
        if (quiz.getId() == null) {
            String sql = "INSERT INTO quizzes (lesson_id, question_text, question_type, correct_answer, points, order_index) VALUES (?, ?, ?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setLong(1, quiz.getLessonId());
                ps.setString(2, quiz.getQuestionText());
                ps.setString(3, quiz.getQuestionType());
                ps.setString(4, quiz.getCorrectAnswer());
                if (quiz.getPoints() != null) {
                    ps.setInt(5, quiz.getPoints());
                } else {
                    ps.setNull(5, java.sql.Types.INTEGER);
                }
                if (quiz.getOrderIndex() != null) {
                    ps.setInt(6, quiz.getOrderIndex());
                } else {
                    ps.setNull(6, java.sql.Types.INTEGER);
                }
                return ps;
            }, keyHolder);
            Number key = keyHolder.getKey();
            if (key != null) {
                quiz.setId(key.longValue());
            }
        } else {
            String sql = "UPDATE quizzes SET lesson_id = ?, question_text = ?, question_type = ?, correct_answer = ?, points = ?, order_index = ? WHERE id = ?";
            jdbcTemplate.update(sql, quiz.getLessonId(), quiz.getQuestionText(), quiz.getQuestionType(), quiz.getCorrectAnswer(), quiz.getPoints(), quiz.getOrderIndex(), quiz.getId());
        }
        return quiz;
    }

    public QuizOption saveOption(QuizOption option) {
        if (option.getId() == null) {
            String sql = "INSERT INTO quiz_options (quiz_id, option_text, is_correct) VALUES (?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setLong(1, option.getQuizId());
                ps.setString(2, option.getOptionText());
                ps.setBoolean(3, option.getCorrect() != null && option.getCorrect());
                return ps;
            }, keyHolder);
            Number key = keyHolder.getKey();
            if (key != null) {
                option.setId(key.longValue());
            }
        } else {
            String sql = "UPDATE quiz_options SET quiz_id = ?, option_text = ?, is_correct = ? WHERE id = ?";
            jdbcTemplate.update(sql, option.getQuizId(), option.getOptionText(), option.getCorrect(), option.getId());
        }
        return option;
    }

    public int deleteById(Long id) {
        String sql = "DELETE FROM quizzes WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }

    public int deleteOptionById(Long id) {
        String sql = "DELETE FROM quiz_options WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }

    public int deleteOptionsByQuizId(Long quizId) {
        String sql = "DELETE FROM quiz_options WHERE quiz_id = ?";
        return jdbcTemplate.update(sql, quizId);
    }
}