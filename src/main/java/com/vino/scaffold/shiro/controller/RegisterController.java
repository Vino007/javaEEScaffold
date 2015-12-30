package com.vino.scaffold.shiro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.UserDuplicateException;
import com.vino.scaffold.shiro.service.UserService;
@Controller
public class RegisterController extends BaseController{
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/prepareRegister",method=RequestMethod.GET)
	public String prepareRegister(){
		return "register";
	}
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public String register(Model model,User user){
		try {
			userService.saveWithCheckDuplicate(user);
		} catch (UserDuplicateException e) {
			model.addAttribute("isUserDuplicate", "用戶名已被佔用");
			return "register";
			
		}
		return "redirect:/login";
		
	}

}
