package com.vino.scaffold.shiro.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.vino.scaffold.service.base.AbstractBaseServiceImpl;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.repository.ResourceRepository;
@Service("resourceService")
public class ResourceServiceImpl extends AbstractBaseServiceImpl<Resource, Long>  implements ResourceService {
	@Autowired
	@Qualifier("resourceRepository")
	private ResourceRepository resourceRepository;

	public ResourceRepository getResourceRepository() {
		return resourceRepository;
	}

	public void setResourceRepository(ResourceRepository resourceRepository) {
		this.resourceRepository = resourceRepository;
	}



	

}
