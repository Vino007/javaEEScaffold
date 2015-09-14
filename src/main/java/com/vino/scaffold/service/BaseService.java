package com.vino.scaffold.service;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;


public abstract class BaseService<T,PK extends Serializable,R extends JpaRepository<T,PK>> {
	
	public void save(){
		
	}
}
