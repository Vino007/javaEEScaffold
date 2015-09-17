package com.vino.scaffold.shiro.service;


import java.util.Set;





import com.vino.scaffold.service.base.BaseService;
import com.vino.scaffold.shiro.entity.User;

public interface UserService extends  BaseService<User, Long>{
	//public List<Resource>findAllResources();
	public User findByUsername(String username);

	public Set<String> findAllRoleMarksByUsername(String username);
	public Set<String> findAllPermissionsByUsername(String username);
	void changePassword(Long userId, String newPassword);
	//关联User与Role,由于使用的是Set集合，即使多次插入相同的，数据库中也不会有重复的
	public void connectUserAndRole(Long userId,Long ...roleIds);
	//取消关联
	public void disconnectUserAndRole(Long userId,Long... roleIds);
}
