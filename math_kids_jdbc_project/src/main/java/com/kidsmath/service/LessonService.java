package com.kidsmath.service;

import com.kidsmath.dao.LessonDao;
import com.kidsmath.model.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LessonService {

	@Autowired
	private LessonDao lessonDao;

	// Lấy tất cả bài học
	public List<Lesson> findAll() {
		return lessonDao.findAll();
	}

	// Tìm bài học theo ID
	public Lesson findById(Integer id) {
		return lessonDao.findById(id);
	}

	// Tìm bài học theo grade (lớp)
	public List<Lesson> findByGrade(Integer grade) {
		return lessonDao.findByGrade(grade);
	}

	// Tìm bài học theo grade với thông tin grade
	public List<Lesson> findByGradeWithInfo(Integer grade) {
		return lessonDao.findByGradeWithInfo(grade);
	}

	// Lấy tất cả bài học kèm thông tin grade
	public List<Lesson> findAllWithGradeInfo() {
		return lessonDao.findAllWithGradeInfo();
	}

	// Lưu bài học mới
	public void save(Lesson lesson) {
		lessonDao.save(lesson);
	}

	// Cập nhật bài học
	public void update(Lesson lesson) {
		lessonDao.update(lesson);
	}

	// Xóa bài học theo ID
	public void deleteById(Integer id) {
		lessonDao.deleteById(id);
	}

	// Kiểm tra tồn tại
	public boolean existsById(Integer id) {
		return lessonDao.existsById(id);
	}

	// Đếm số bài học theo grade
	public int countByGrade(Integer grade) {
		return lessonDao.countByGrade(grade);
	}

	// Tìm kiếm bài học theo tiêu đề
	public List<Lesson> searchByTitle(String keyword) {
		return lessonDao.searchByTitle(keyword);
	}

	// Lấy bài học mới nhất theo grade
	public List<Lesson> findRecentByGrade(Integer grade, int limit) {
		return lessonDao.findRecentByGrade(grade, limit);
	}

	// Lấy bài học mới nhất
	public List<Lesson> findRecent(int limit) {
		return lessonDao.findRecent(limit);
	}
}