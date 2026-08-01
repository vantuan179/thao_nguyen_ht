package com.mathkids.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "forward:/app/index.html";
    }

    @GetMapping("/admin")
    public String admin() {
        return "forward:/admin/index.html";
    }
}