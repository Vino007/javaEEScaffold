package com.vino.scaffold.shiro.service;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vino.scaffold.service.base.AbstractBaseServiceImpl;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.repository.RoleRepository;
import com.vino.scaffold.shiro.repository.UserRepository;
@Transactional
@Service("userService")
public class UserServiceImpl extends AbstractBaseServiceImpl<User, Long>  implements UserService{
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private PasswordHelper passwordHelper;
    
    /**
     * 创建动态查询条件组合.
     */
    private Specification<User> buildSpecification(final User user) {
       // Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
      //  filters.put("user.id", new SearchFilter("user.id", Operator.EQ, userId));
        Specification<User> spec = new Specification<User>(){

			@Override
			public Predicate toPredicate(Root<User> root,
				CriteriaQuery<?> cq, CriteriaBuilder cb) {
				Predicate condition1=cb.like(root.get("username").as(String.class),"%"+user.getUsername()+"%");
				Predicate condition2=cb.like(root.get("userAlias").as(String.class),"%"+user.getUserAlias()+"%");
									
				return cb.and(condition1,condition2);
			}
        	
        };
        return spec;
    }
    
    
	@Override
	public Page<User> findUserByCondition(User user, Pageable pageable) {
		
		return userRepository.findAll(buildSpecification(user), pageable);
	}


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
    @Override
    public void save(User user) {
        //加密密码
        passwordHelper.encryptPassword(user);
        userRepository.save(user);
    }
    @Override
	public void update(User user){
		User user2=userRepository.findOne(user.getId());
		if(user.getUserAlias()!=null){
			user2.setUserAlias(user.getUserAlias());
		}
		if(user.getLocked()!=null){
			user2.setLocked(user.getLocked());
		}
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
	public void connectUserAndRole(Long userId, Long... roleId) {
		User user=userRepository.findOne(userId);
		Set<Role> roles=user.getRoles();
		for(Long id:roleId){
			roles.add(roleRepository.findOne(id));
		}
		
	}

	@Override
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

	@Override
	public void clearAllUserAndRoleConnection(Long userId) {
		User user=userRepository.findOne(userId);
		user.getRoles().clear();
	}

	/*@Override
	public List<User> findUserByContidionAndPage(User user,Pageable pageable) {
		
		return userRepository.getUsersByCondition(user,pageable);
	}*/

}
