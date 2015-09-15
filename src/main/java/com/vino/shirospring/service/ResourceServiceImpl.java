package com.vino.shirospring.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.vino.shirospring.entity.Resource;
import com.vino.shirospring.repository.ResourceRepository;
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService {
	@Autowired
	@Qualifier("resourceRepository")
	private ResourceRepository resourceRepository;
	@Override
	public Resource find(Long id) {
		// TODO Auto-generated method stub
		return resourceRepository.findOne(id);
	}

	@Override
	@Transactional
	public void save(Resource resource) {
		// TODO Auto-generated method stub
		resourceRepository.save(resource);
	}


	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		resourceRepository.delete(id);

	}

	public ResourceRepository getResourceRepository() {
		return resourceRepository;
	}

	public void setResourceRepository(ResourceRepository resourceRepository) {
		this.resourceRepository = resourceRepository;
	}

	

}
