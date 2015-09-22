package com.vino.scaffold.shiro.service;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vino.scaffold.service.base.AbstractBaseServiceImpl;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.repository.RoleRepository;
import com.vino.scaffold.shiro.repository.UserRepository;

@Service("userService")
public class UserServiceImpl extends AbstractBaseServiceImpl<User, Long>  implements UserService{
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private PasswordHelper passwordHelper;
    
	
	public UserRepository getUserRepository() {
		return userRepository;
	}

	public void setUserRepository(UserRepository userRepository) {
		this.userRepository = userRepository;
	}




	@Override
	public User findByUsername(String username) {
		// TODO Auto-generated method stub
		return userRepository.findByUsername(username);
	}

	@Override
	public Set<String> findAllRoleMarksByUsername(String username) {
		User user=userRepository.findByUsername(username);
		Set<Role> roles=user.getRoles();
		Set<String> roleNames=new HashSet<String>();
		for(Role r : roles){
			roleNames.add(r.getMark());
		}
		return roleNames;
	}

	@Override
	public Set<String> findAllPermissionsByUsername(String username) {
		User user=userRepository.findByUsername(username);
		Set<Role> roles=user.getRoles();
		Set<String> permissions=new HashSet<String>();
		for(Role r:roles){
			Set<com.vino.scaffold.shiro.entity.Resource> resources=r.getResources();
			for(com.vino.scaffold.shiro.entity.Resource res:resources){
				permissions.add(res.getPermission());
			}
		}
		return permissions;
	}
	 /**
     * 创建用户
     * @param user
     */
	@Transactional
    @Override
    public void save(User user) {
        //加密密码
        passwordHelper.encryptPassword(user);
        userRepository.save(user);
    }

    /**
     * 修改密码
     * @param userId
     * @param newPassword
     */
    @Override
    public void changePassword(Long userId, String newPassword) {
        User user =userRepository.findOne(userId);
        user.setPassword(newPassword);
        passwordHelper.encryptPassword(user);//对密码进行加密,修改后等待flush就会持久化到数据库
        
    }

	@Override
	@Transactional
	public void connectUserAndRole(Long userId, Long... roleId) {
		User user=userRepository.findOne(userId);
		Set<Role> roles=user.getRoles();
		for(Long id:roleId){
			roles.add(roleRepository.findOne(id));
		}
		
	}

	@Override
	@Transactional
	public void disconnectUserAndRole(Long userId, Long... roleIds) {
		for(Long id:roleIds){
			userRepository.findOne(userId).getRoles().remove(roleRepository.findOne(id));
		}
	}

	public RoleRepository getRoleRepository() {
		return roleRepository;
	}

	public void setRoleRepository(RoleRepository roleRepository) {
		this.roleRepository = roleRepository;
	}

	public PasswordHelper getPasswordHelper() {
		return passwordHelper;
	}

	public void setPasswordHelper(PasswordHelper passwordHelper) {
		this.passwordHelper = passwordHelper;
	}

}
