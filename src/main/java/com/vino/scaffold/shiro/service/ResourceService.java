package com.vino.scaffold.shiro.service;


import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.vino.scaffold.service.base.BaseService;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.ResourceDuplicateException;
import com.vino.scaffold.shiro.exception.RoleDuplicateException;



public interface ResourceService extends  BaseService<Resource, Long> {

	void update(Resource resource);

	void saveWithCheckDuplicate(Resource resource,User user) throws ResourceDuplicateException;

	Page<Resource> findResourceByCondition(Map<String, Object> searchParams,
			Pageable pageable);
	Resource findByName(String name);

}
