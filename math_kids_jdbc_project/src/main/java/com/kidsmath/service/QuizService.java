package com.kidsmath.service;

import com.kidsmath.dao.ProgressDao;
import com.kidsmath.dao.QuizDao;
import com.kidsmath.model.Progress;
import com.kidsmath.model.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class QuizService {

    @Autowired
    private QuizDao quizDao;

    @Autowired
    private ProgressDao progressDao;

    public List<Quiz> findAll() {
        return quizDao.findAll();
    }

    public List<Quiz> findByLessonId(Integer lessonId) {
        return quizDao.findByLessonId(lessonId);
    }

    public Quiz findById(Integer id) {
        return quizDao.findById(id);
    }

    public Map<String, Object> checkAnswer(Integer quizId, String selectedOption, Integer userId) {
        Quiz quiz = quizDao.findById(quizId);
        boolean isCorrect = quiz.getCorrectOption().equalsIgnoreCase(selectedOption);

        Progress progress = new Progress();
        progress.setUserId(userId);
        progress.setQuizId(quizId);
        progress.setSelectedOption(selectedOption);
        progress.setIsCorrect(isCorrect);
        progress.setScore(isCorrect ? quiz.getPoints() : 0);
        progressDao.saveOrUpdate(progress);

        Map<String, Object> result = new HashMap<>();
        result.put("correct", isCorrect);
        result.put("correctOption", quiz.getCorrectOption());
        result.put("explanation", quiz.getExplanation());
        result.put("score", progressDao.getTotalScoreByUserId(userId));
        result.put("correctCount", progressDao.countCorrectByUserId(userId));
        return result;
    }
}
