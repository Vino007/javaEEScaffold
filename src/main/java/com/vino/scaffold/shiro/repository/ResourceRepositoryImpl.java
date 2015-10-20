package com.vino.scaffold.shiro.repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

public class ResourceRepositoryImpl {
	@PersistenceContext
	private EntityManager em;

	public void deleteAssociateById(Long... resourceIds){
		for(long resId:resourceIds){
		Query query=em.createNativeQuery("delete from t_role_resource where resource_id=?");
		query.setParameter(1, resId);
		query.executeUpdate();
		}
		
	}
	
	public EntityManager getEm() {
		return em;
	}

	public void setEm(EntityManager em) {
		this.em = em;
	}
	
}
