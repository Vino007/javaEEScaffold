package com.vino.shirospring.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vino.shirospring.entity.User;

public interface UserRepository extends JpaRepository<User, Long>{
	public User findByUsername(String username);
	
}
