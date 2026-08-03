package com.kidsmath.service;

import com.kidsmath.dao.GradeDao;
import com.kidsmath.model.Grade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GradeService {

	@Autowired
	private GradeDao gradeDao;

	public List<Grade> findAll() {
		return gradeDao.findAll();
	}

	public List<Grade> findActiveGrades() {
		return gradeDao.findActiveGrades();
	}

	public Grade findById(Integer id) {
		return gradeDao.findById(id);
	}

	public Grade findByGradeName(String gradeName) {
		return gradeDao.findByGradeName(gradeName);
	}

	public void save(Grade grade) {
		if (grade.getDisplayOrder() == null || grade.getDisplayOrder() == 0) {
			int maxOrder = gradeDao.getMaxDisplayOrder();
			grade.setDisplayOrder(maxOrder + 1);
		}
		gradeDao.save(grade);
	}

	public void update(Grade grade) {
		gradeDao.update(grade);
	}

	public void softDelete(Integer id) {
		gradeDao.softDelete(id);
	}

	public boolean deleteById(Integer id) {
		int result = gradeDao.deleteById(id);
		return result > 0;
	}

	public boolean existsById(Integer id) {
		return gradeDao.existsById(id);
	}

	public boolean existsByGradeName(String gradeName) {
		return gradeDao.existsByGradeName(gradeName);
	}

	public int countLessonsByGradeId(Integer gradeId) {
		return gradeDao.countLessonsByGradeId(gradeId);
	}

	public int countAll() {
		return gradeDao.countAll();
	}

	public int countActive() {
		return gradeDao.countActive();
	}

	public List<Grade> searchByGradeName(String keyword) {
		return gradeDao.searchByGradeName(keyword);
	}

	public int getMaxDisplayOrder() {
		return gradeDao.getMaxDisplayOrder();
	}
}