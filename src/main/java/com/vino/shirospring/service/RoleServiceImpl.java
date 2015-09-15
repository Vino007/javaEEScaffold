package com.vino.shirospring.service;

import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vino.shirospring.entity.Resource;
import com.vino.shirospring.entity.Role;
import com.vino.shirospring.repository.ResourceRepository;
import com.vino.shirospring.repository.RoleRepository;
@Service("roleService")
public class RoleServiceImpl implements RoleService {
	@PersistenceContext(name="userPU")
	private EntityManager em;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private ResourceRepository resourceRepository;
	@Override
	public Role findRole(Long id) {
		// TODO Auto-generated method stub
		return roleRepository.findOne(id);
	}

	@Override
	public List<Role> findAllRole() {
		// TODO Auto-generated method stub
		return roleRepository.findAll();
	}
	
	@Override
	@Transactional
	public void save(Role role) {
		// TODO Auto-generated method stub
		roleRepository.save(role);
	}


	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		
	}

	public RoleRepository getRoleRepository() {
		return roleRepository;
	}

	public void setRoleRepository(RoleRepository roleRepository) {
		this.roleRepository = roleRepository;
	}

	
	@Override
	@Transactional
	public void connectRoleAndResource(Long roleId, Long... resourceIds) {
		Role role=findRole(roleId);
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
