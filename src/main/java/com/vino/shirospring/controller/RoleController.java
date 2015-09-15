package com.vino.shirospring.controller;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vino.shirospring.entity.Role;
import com.vino.shirospring.service.RoleService;

@Controller
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	@RequestMapping(value="/role/all",method=RequestMethod.GET)
	@ResponseBody
	public List<Role> getRoles(){
		
		return roleService.findAllRole();
	}
	public RoleService getRoleService() {
		return roleService;
	}
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	
}
