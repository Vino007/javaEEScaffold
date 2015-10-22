package com.vino.scaffold.shiro.service;


import java.util.List;
import java.util.Map;
import java.util.Set;











import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.vino.scaffold.service.base.BaseService;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.UserDuplicateException;

public interface UserService extends  BaseService<User, Long>{
	//public List<Resource>findAllResources();
	public User findByUsername(String username);
//	public List<User> findUserByContidionAndPage(User user,Pageable pageable);
	public Page<User> findUserByCondition(Map<String,Object> searchParams,Pageable pageable);
	public Set<String> findAllRoleNamesByUsername(String username);
	public Set<String> findAllPermissionsByUsername(String username);
	void changePassword(Long userId, String newPassword);
	public void clearAllUserAndRoleConnection(Long userId);
	//关联User与Role,由于使用的是Set集合，即使多次插入相同的，数据库中也不会有重复的
	public void connectUserAndRole(Long userId,Long ...roleIds);
	//取消关联
	public void disconnectUserAndRole(Long userId,Long... roleIds);
	public void update(User user);
	public void saveWithCheckDuplicate(User user) throws UserDuplicateException;
	public void saveWithCheckDuplicate(List<User> users)throws UserDuplicateException;
}
