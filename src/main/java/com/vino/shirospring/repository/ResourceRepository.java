package com.vino.shirospring.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vino.shirospring.entity.Resource;

public interface ResourceRepository extends JpaRepository<Resource, Long>{

}
