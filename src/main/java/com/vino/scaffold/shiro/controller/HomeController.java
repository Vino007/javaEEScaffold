package com.vino.scaffold.shiro.controller;

import java.util.Arrays;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.entity.Constants;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.service.UserService;


@Controller
public class HomeController extends BaseController{

	@Resource
	private UserService userService;

	@RequestMapping("/")
	public String home(Model model){
		
		Subject curUser=SecurityUtils.getSubject();
		Session session=curUser.getSession();	
		String username=(String) curUser.getPrincipal();
		User currentUser=userService.findByUsername(username);
		session.setAttribute(Constants.CURRENT_USER, currentUser);//将当前用户放入session
		return "index";
	}
	
	public UserService getUserService() {
		return userService;
	}


	public void setUserService(UserService userService) {
		this.userService = userService;
	}


	
}
