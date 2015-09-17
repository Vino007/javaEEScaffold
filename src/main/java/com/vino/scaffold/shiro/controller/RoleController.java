package com.vino.scaffold.shiro.controller;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.service.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController{
	
	@Autowired
	private RoleService roleService;
	@RequestMapping(value="/all",method=RequestMethod.GET)
	@ResponseBody
	public List<Role> getRoles(){	
		return roleService.findAll();
	}
	
	
	
	

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	
}
