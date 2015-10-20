package com.vino.scaffold.shiro.repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

public class RoleRepositoryImpl {
	@PersistenceContext
	private EntityManager em;
	/**
	 * 删除关联表中的对应roleid的行
	 * @param roleIds
	 */
	public void deleteAssociateById(Long... roleIds){
		for(Long roleId:roleIds){
		Query query=em.createNativeQuery("delete from t_user_role where role_id=?");
		query.setParameter(1,roleId);
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
