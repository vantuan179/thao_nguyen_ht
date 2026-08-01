package com.kidsmath.controller;

import com.kidsmath.dao.QuizDao;
import com.kidsmath.model.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/quizzes")
public class QuizAdminRestController {

    @Autowired
    private QuizDao quizDao;

    @GetMapping
    public List<Quiz> getAll() {
        return quizDao.findAll();
    }

    @GetMapping("/{id}")
    public Quiz getOne(@PathVariable Integer id) {
        return quizDao.findById(id);
    }

    @PostMapping
    public int create(@RequestBody Quiz quiz) {
        return quizDao.save(quiz);
    }

    @PutMapping("/{id}")
    public int update(@PathVariable Integer id, @RequestBody Quiz quiz) {
        quiz.setId(id);
        return quizDao.update(quiz);
    }

    @DeleteMapping("/{id}")
    public int delete(@PathVariable Integer id) {
        return quizDao.deleteById(id);
    }
}
