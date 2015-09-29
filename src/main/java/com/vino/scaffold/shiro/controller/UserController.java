package com.vino.scaffold.shiro.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.service.RoleService;
import com.vino.scaffold.shiro.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String getALLUsers(Model model){
		
		model.addAttribute("users", userService.findAll());
		return "user/list";
	}
	@RequestMapping(value="/search",method=RequestMethod.GET)
	public String getUsersByCondition(Model model,User user,int pageNumber){
		//List<User> users=userService.findUserByContidionAndPage(user,buildPageRequest(pageNumber));
		Page<User> userPage=userService.findUserByCondition(user, buildPageRequest(pageNumber));
		model.addAttribute("users",userPage.getContent());
		model.addAttribute("pager", buildPageRequest(pageNumber));
		//System.out.println(users);
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
	@RequestMapping(value="/update",method=RequestMethod.POST)	
	public String updateUser(Model model,User user){
		userService.update(user);
		model.addAttribute("users", userService.findAll());
		return "user/list";
		
	}
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String prepareUpdateUser(Model model,@PathVariable("id") Long id){
		model.addAttribute("user", userService.findOne(id));
		return "user/edit";
		
	}
	@RequestMapping(value="/detail/{id}",method=RequestMethod.GET)
	public String findUser(Model model,@PathVariable("id") Long id){
		model.addAttribute("user", userService.findOne(id));
		return "user/detail";
		
	}
	/**
	 * 
	 * @param model return availableRoles and user
	 * @param id
	 * @return 
	 */
	@RequestMapping(value="/prepareBind/{id}",method=RequestMethod.GET)
	public String prepareBind(Model model,@PathVariable("id") Long id){
	
		User user=userService.findOne(id);
		model.addAttribute("user", user);
		List<Role> roles=roleService.findAll();
		for(Role r:user.getRoles())
			roles.remove(r);
		model.addAttribute("availableRoles",roles);
		return "user/bind";
		
	}
	
	@RequestMapping(value="/bind",method=RequestMethod.POST)
	public String bind(Model model,@RequestParam("userId")Long userId,@RequestParam(value="roleIds[]",required=false)Long[] roleIds){
		userService.clearAllUserAndRoleConnection(userId);
		if(roleIds!=null){
			userService.connectUserAndRole(userId,roleIds);
		}				
		model.addAttribute("users", userService.findAll());
		return "user/list";
		
	}
	
	
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	
}
