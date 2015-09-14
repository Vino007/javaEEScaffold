package com.vino.shirospring.service;

import java.util.List;
import java.util.Set;

import com.vino.shirospring.entity.Role;
import com.vino.shirospring.entity.User;

public interface UserService {
	//public List<Resource>findAllResources();
	public User findByUsername(String username);
	public void save(User user);
	public void update(User user);
	public void delete(Long id);
	public Set<String> findAllRoleMarksByUsername(String username);
	public Set<String> findAllPermissionsByUsername(String username);
	void changePassword(Long userId, String newPassword);
	
}
