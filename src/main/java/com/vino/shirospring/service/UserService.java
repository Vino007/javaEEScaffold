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
	//关联User与Role,由于使用的是Set集合，即使多次插入相同的，数据库中也不会有重复的
	public void connectUserAndRole(Long userId,Long ...roleIds);
	//取消关联
	public void disconnectUserAndRole(Long userId,Long... roleIds);
}
