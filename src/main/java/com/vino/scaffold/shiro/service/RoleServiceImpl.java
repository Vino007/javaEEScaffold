package com.vino.scaffold.shiro.service;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.vino.scaffold.service.base.AbstractBaseServiceImpl;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.RoleDuplicateException;
import com.vino.scaffold.shiro.repository.ResourceRepository;
import com.vino.scaffold.shiro.repository.RoleRepository;
@Service("roleService")
@Transactional
public class RoleServiceImpl extends AbstractBaseServiceImpl<Role, Long> implements RoleService{
	@PersistenceContext(name="userPU")
	private EntityManager em;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private ResourceRepository resourceRepository;

	public RoleRepository getRoleRepository() {
		return roleRepository;
	}

	public void setRoleRepository(RoleRepository roleRepository) {
		this.roleRepository = roleRepository;
	}
	public EntityManager getEm() {
		return em;
	}

	public void setEm(EntityManager em) {
		this.em = em;
	}

	public ResourceRepository getResourceRepository() {
		return resourceRepository;
	}

	public void setResourceRepository(ResourceRepository resourceRepository) {
		this.resourceRepository = resourceRepository;
	}

	
	@Override
	public void update(Role role) {
		Role role2=roleRepository.findOne(role.getId());
		if(role.getDescription()!=null&&!role.getDescription().equals("")){
			role2.setDescription(role.getDescription());;
		}
		if(role.getAvailable()!=null){
			role2.setAvailable(role.getAvailable());
		}
	}

	@Override
	public void connectRoleAndResource(Long roleId, Long... resourceIds) {
		Role role=findOne(roleId);
		
		Set<Resource> resources=role.getResources();
		for(Long resId:resourceIds){
			resources.add(resourceRepository.findOne(resId));
		}
		role.setResources(resources);
	}

	@Override
	public void disconnnectRoleAndResource(Long roledId, Long... resourceIds) {
		for(Long resourceId : resourceIds)
		roleRepository.findOne(roledId).getResources().remove(resourceRepository.findOne(resourceId));
	}

	
	@Override
	public void clearAllRoleAndResourceConnection(Long roleId) {
		Role role=roleRepository.findOne(roleId);
		role.getResources().clear();
	}

	@Override
	public void saveWithCheckDuplicate(Role role,User user) throws RoleDuplicateException {
		if(roleRepository.findByName(role.getName())!=null)
			throw new RoleDuplicateException();
		else{
			role.setCreateTime(new Date());
			role.setCreatorName(user.getUsername());
			roleRepository.save(role);
			
		}
	}
	 /**
     * 创建动态查询条件组合.
     */
    private Specification<Role> buildSpecification(final Map<String,Object> searchParams) {
    	
		
        Specification<Role> spec = new Specification<Role>(){           
			@Override
			public Predicate toPredicate(Root<Role> root,
				CriteriaQuery<?> cq, CriteriaBuilder cb) {
				Predicate allCondition = null;
				String name=(String) searchParams.get("name");			
				String createTimeRange=(String) searchParams.get("createTimeRange");
				if(name!=null&&!"".equals(name)){
					Predicate condition=cb.like(root.get("name").as(String.class),"%"+searchParams.get("name")+"%");
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
	public Page<Role> findRoleByCondition(Map<String, Object> searchParams,
			Pageable pageable) {
		return roleRepository.findAll(buildSpecification(searchParams), pageable);
	}

	@Override
	public void delete(Long... ids) {
		roleRepository.deleteAssociateById(ids);
		super.delete(ids);
	}
	

}
