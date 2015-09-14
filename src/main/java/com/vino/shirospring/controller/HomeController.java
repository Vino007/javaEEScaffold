package com.vino.shirospring.controller;

import java.util.Arrays;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vino.shirospring.service.UserService;


@Controller
public class HomeController {

	@Resource
	private UserService userService;

	@RequestMapping("/")
	public String home(Model model){
		//怎么从session中获取当前用户
		
		Subject curUser=SecurityUtils.getSubject();
		Session session=curUser.getSession();
		String username=(String) curUser.getPrincipal();
		Set<String> permissionList=userService.findAllPermissionsByUsername(username);
		model.addAttribute("permissionList", permissionList);
		System.out.println(Arrays.toString(permissionList.toArray()));
		return "index";
	}
	
	public UserService getUserService() {
		return userService;
	}


	public void setUserService(UserService userService) {
		this.userService = userService;
	}


	
}
