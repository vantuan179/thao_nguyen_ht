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

    public List<Lesson> findAll() {
        return lessonDao.findAll();
    }

    public Lesson findById(Integer id) {
        return lessonDao.findById(id);
    }

    public int save(Lesson lesson) {
        return lessonDao.save(lesson);
    }

    public int update(Lesson lesson) {
        return lessonDao.update(lesson);
    }

    public int deleteById(Integer id) {
        return lessonDao.deleteById(id);
    }
}
