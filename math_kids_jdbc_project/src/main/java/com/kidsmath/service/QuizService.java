package com.kidsmath.service;

import com.kidsmath.dao.QuizDao;
import com.kidsmath.model.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuizService {

	@Autowired
	private QuizDao quizDao;

	public List<Quiz> findAll() {
		return quizDao.findAll();
	}

	public List<Quiz> findByLessonId(Integer lessonId) {
		return quizDao.findByLessonId(lessonId);
	}

	public Quiz findById(Integer id) {
		return quizDao.findById(id);
	}

	public List<Quiz> findQuizzesWithLessonInfo() {
		return quizDao.findQuizzesWithLessonInfo();
	}

	public void save(Quiz quiz) {
		quizDao.save(quiz);
	}

	public void update(Quiz quiz) {
		quizDao.update(quiz);
	}

	public void deleteById(Integer id) {
		quizDao.deleteById(id);
	}

	public void deleteByLessonId(Integer lessonId) {
		quizDao.deleteByLessonId(lessonId);
	}

	public int countByLessonId(Integer lessonId) {
		return quizDao.countByLessonId(lessonId);
	}

	public int getTotalPointsByLessonId(Integer lessonId) {
		return quizDao.getTotalPointsByLessonId(lessonId);
	}
}