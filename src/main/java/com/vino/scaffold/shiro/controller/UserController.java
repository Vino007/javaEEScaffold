package com.vino.scaffold.shiro.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String getALLUsers(){
		userService.findAll();
		return "index2";
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
}
