package com.kidsmath.controller;

import com.kidsmath.model.Lesson;
import com.kidsmath.model.Quiz;
import com.kidsmath.model.User;
import com.kidsmath.service.LessonService;
import com.kidsmath.service.QuizService;
import com.kidsmath.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private LessonService lessonService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String home(Model model) {
        List<Lesson> lessons = lessonService.findAll();
        model.addAttribute("lessons", lessons);
        return "user/home";
    }

    @GetMapping("/lesson/{id}")
    public String lessonDetail(@PathVariable("id") Integer id, Model model) {
        Lesson lesson = lessonService.findById(id);
        List<Quiz> quizzes = quizService.findByLessonId(id);
        model.addAttribute("lesson", lesson);
        model.addAttribute("quizzes", quizzes);
        return "user/lesson";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {
        User user = userService.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("currentUser", user);
            if ("ADMIN".equals(user.getRole())) {
                return "redirect:/admin";
            }
            return "redirect:/";
        }
        model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
        return "user/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
