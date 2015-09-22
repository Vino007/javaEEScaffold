package com.vino.scaffold.shiro.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String getALLUsers(Model model){
		
		model.addAttribute("users", userService.findAll());
		return "user/list";
	}
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String addUser(Model model ,User user){
		userService.save(user);
		model.addAttribute("users", userService.findAll());
		return "user/list";	
	}
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public  String deleteUsers(Model model,@RequestParam("deleteIds[]")Long[] deleteIds){
		userService.delete(deleteIds);
		model.addAttribute("users", userService.findAll());
		return "user/list";
		
	}
	
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	
}
