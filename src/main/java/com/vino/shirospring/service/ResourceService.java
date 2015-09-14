package com.vino.shirospring.service;

import org.springframework.stereotype.Service;

import com.vino.shirospring.repository.ResourceRepository;

@Service("resourceService")
public class ResourceService {
	private ResourceRepository resourceRepository;
}
