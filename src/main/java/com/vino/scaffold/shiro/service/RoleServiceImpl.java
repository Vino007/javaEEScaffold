package com.vino.scaffold.shiro.service;


import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vino.scaffold.service.base.AbstractBaseServiceImpl;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.repository.ResourceRepository;
import com.vino.scaffold.shiro.repository.RoleRepository;
@Service("roleService")
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

	
	@Override
	@Transactional
	public void connectRoleAndResource(Long roleId, Long... resourceIds) {
		Role role=findOne(roleId);
		role.setDescription("访客，拥有查看的部分内容的权限");
		Set<Resource> resources=role.getResources();
		for(Long resId:resourceIds){
			resources.add(resourceRepository.findOne(resId));
		}
		role.setResources(resources);
		em.flush();
	}

	@Override
	@Transactional
	public void disconnnectRoleAndResource(Long roledId, Long... resourceIds) {
		for(Long resourceId : resourceIds)
		roleRepository.findOne(roledId).getResources().remove(resourceRepository.findOne(resourceId));
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
	

}
