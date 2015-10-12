package com.vino.scaffold.shiro.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vino.scaffold.repository.base.BaseRepository;
import com.vino.scaffold.shiro.entity.Resource;

public interface ResourceRepository extends BaseRepository<Resource, Long>{

}