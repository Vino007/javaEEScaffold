package com.vino.shirospring.service;

import com.vino.shirospring.entity.Resource;



public interface ResourceService {
	public Resource find(Long id);
	void save(Resource resource);
	void delete(Long id);
}
