package com.kidsmath.service;

import com.kidsmath.dao.UserDao;
import com.kidsmath.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    public List<User> findAll() {
        return userDao.findAll();
    }

    public User findById(Integer id) {
        return userDao.findById(id);
    }

    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    public int save(User user) {
        return userDao.save(user);
    }

    public int update(User user) {
        return userDao.update(user);
    }

    public int deleteById(Integer id) {
        return userDao.deleteById(id);
    }
}
