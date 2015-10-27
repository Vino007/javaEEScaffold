package com.vino.scaffold.shiro.controller;


import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vino.scaffold.controller.base.BaseController;

@Controller
public class LoginController extends BaseController{
	//不能重复登录
	
	  @RequestMapping(value = "/login")
	    public String showLoginForm(HttpServletRequest req, Model model) {
	        String exceptionClassName = (String)req.getAttribute("shiroLoginFailure");
	       
	        String error = null;
	        if(UnknownAccountException.class.getName().equals(exceptionClassName)) {
	            error = "用户名/密码错误";
	        } else if(IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
	            error = "用户名/密码错误";
	        }else if(LockedAccountException.class.getName().equals(exceptionClassName)){
	        	error = "账户被锁定，请联系管理员";
	        	
	        }else if(exceptionClassName != null) {
	            error = "其他错误：" + exceptionClassName;
	        }
	        model.addAttribute("loginError", error);
	        return "login";
	    }

}