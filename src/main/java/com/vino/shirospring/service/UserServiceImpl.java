package com.vino.shirospring.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.vino.shirospring.entity.Role;
import com.vino.shirospring.entity.User;
import com.vino.shirospring.repository.UserRepository;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Resource
	private UserRepository userRepository;
	@Resource
    private PasswordHelper passwordHelper;
	public UserRepository getUserRepository() {
		return userRepository;
	}

	public void setUserRepository(UserRepository userRepository) {
		this.userRepository = userRepository;
	}



	

	@Override
	public void update(User user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		
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
			Set<com.vino.shirospring.entity.Resource> resources=r.getResources();
			for(com.vino.shirospring.entity.Resource res:resources){
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
        userRepository.save(user);;
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
	
}
