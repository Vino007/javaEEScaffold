package com.vino.scaffold.shiro.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.logging.SimpleFormatter;

import javax.annotation.Resource;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vino.scaffold.service.base.AbstractBaseServiceImpl;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.UserDuplicateException;
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
    private Specification<User> buildSpecification(final Map<String,Object> searchParams) {
    	
		
        Specification<User> spec = new Specification<User>(){           
			@Override
			public Predicate toPredicate(Root<User> root,
				CriteriaQuery<?> cq, CriteriaBuilder cb) {
				Predicate allCondition = null;
				String username=(String) searchParams.get("username");
				String userAlias=(String) searchParams.get("userAlias");
				String createTimeRange=(String) searchParams.get("createTimeRange");
				if(username!=null&&!"".equals(username)){
					Predicate condition=cb.like(root.get("username").as(String.class),"%"+searchParams.get("username")+"%");
					if(null==allCondition)
						allCondition=cb.and(condition);//此处初始化allCondition,若按cb.and(allCondition,condition)这种写法，会导致空指针
					else
						allCondition=cb.and(allCondition,condition);
					}
				if(userAlias!=null&&!"".equals(userAlias)){
					Predicate condition=cb.like(root.get("userAlias").as(String.class),"%"+searchParams.get("userAlias")+"%");
					if(null==allCondition)
						allCondition=cb.and(condition);//此处初始化allCondition,若按cb.and(allCondition,condition)这种写法，会导致空指针
					else
						allCondition=cb.and(allCondition,condition);
					
					}
											
				if(createTimeRange!=null&&!"".equals(createTimeRange)){			
					String createTimeStartStr=createTimeRange.split(" - ")[0]+":00:00:00";
					String createTimeEndStr=createTimeRange.split(" - ")[1]+":23:59:59";
					SimpleDateFormat format=new SimpleDateFormat("MM/dd/yyyy:hh:mm:ss");
					System.out.println(createTimeStartStr);
					try {
						Date createTimeStart = format.parse(createTimeStartStr);
						Date createTimeEnd=format.parse(createTimeEndStr);
						Predicate condition=cb.between(root.get("createTime").as(Date.class),createTimeStart, createTimeEnd);
						if(null==allCondition)
							allCondition=cb.and(condition);//此处初始化allCondition,若按cb.and(allCondition,condition)这种写法，会导致空指针
						else
							allCondition=cb.and(allCondition,condition);
						
					} catch (ParseException e) {
						e.printStackTrace();
						Logger log =LoggerFactory.getLogger(this.getClass());
						log.error("createTime 转换时间出错");
					}
					
				
				}					
				return allCondition;
			}
        	
        };
        return spec;
    }
    
    
	@Override
	public Page<User> findUserByCondition(Map<String,Object> searchParams, Pageable pageable) {
	
		return userRepository.findAll(buildSpecification(searchParams), pageable);
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
	public Set<String> findAllRoleNamesByUsername(String username) {
		User user=userRepository.findByUsername(username);
		Set<Role> roles=user.getRoles();
		Set<String> roleNames=new HashSet<String>();
		if(!roles.isEmpty()){
		for(Role r : roles){
			roleNames.add(r.getName());
		}
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
	 * @throws UserDuplicateException 
     */
    
    public void saveWithCheckDuplicate(User user) throws UserDuplicateException{
    	//校验是否用户重复
    	if(userRepository.findByUsername(user.getUsername())!=null)
    		throw new UserDuplicateException();
        //加密密码
        passwordHelper.encryptPassword(user);
        user.setCreateTime(new Date());
        if(getCurrentUser()!=null)
        user.setCreatorName(getCurrentUser().getUsername());
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
		if(user.getLastLoginTime()!=null){
			user2.setLastLoginTime(user.getLastLoginTime());
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


	@Override
	public void saveWithCheckDuplicate(List<User> users)
			throws UserDuplicateException {
		if(null==users||0==users.size())
			return;
		//校验是否用户重复
		for(User user:users){
    	if(userRepository.findByUsername(user.getUsername())!=null)
    		throw new UserDuplicateException();
        //加密密码
        passwordHelper.encryptPassword(user);
        user.setCreateTime(new Date());
        user.setCreatorName(getCurrentUser().getUsername());
        userRepository.save(user);
		}
	}

	

}
