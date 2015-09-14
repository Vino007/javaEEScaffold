package com.vino.shirospring.service;

import java.util.List;

import com.vino.shirospring.entity.Role;

public interface RoleService {
	public Role findRole();
	public List<Role> findAllRole();
	public void save();
	public void update();
	public void delete();
}
