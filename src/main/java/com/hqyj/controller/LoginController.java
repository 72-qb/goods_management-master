package com.hqyj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/3 16:28
 */
@Controller
@RequestMapping("lc")
public class LoginController {
    //转到登陆界面
    @RequestMapping("login.do")
    public String login(){
        return "login";
    }
    //转到主界面
    @RequestMapping("loginIndex.do")
    public String loginIndex(){
        return "index";
    }
}
