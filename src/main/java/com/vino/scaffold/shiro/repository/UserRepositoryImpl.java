package com.vino.scaffold.shiro.repository;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import com.vino.scaffold.shiro.entity.User;

/**
 * criteria学习视频  http://www.jikexueyuan.com/course/1449.html
 * http://blog.csdn.net/dracotianlong/article/details/28445725
 * spring data会自动选择该实现类作为UserRepository的补充
 * @author Joker
 *
 */
public class UserRepositoryImpl {
	@PersistenceContext
	private EntityManager em;
/**
 * 
 * 废弃
 * @param user
 * @param pageable
 * @return
 */
	public Page<User> getUsersByCondition(User user,Pageable pageable){
		System.out.println(user);
		CriteriaBuilder cb=em.getCriteriaBuilder();
		CriteriaQuery<User> cq=cb.createQuery(User.class);
		Root<User> root=cq.from(User.class);
		cq.select(root);
		//使用like的时候可以不用判断是否有该参数传来，因为like %% 就等于没有这个限制条件
		Predicate condition1=cb.like(root.get("username").as(String.class),cb.parameter(String.class, "username"));
		Predicate condition2=cb.like(root.get("userAlias").as(String.class),cb.parameter(String.class, "userAlias"));
		//Predicate condition3=cb.equal(root.get("createTime").as(Date.class),cb.parameter(String.class, "createTime"));	
		cq.where(condition1,condition2);
		cb.and(condition1,condition2);
		TypedQuery<User> query=em.createQuery(cq);
		query.setParameter("username", "%"+user.getUsername()+"%");
		query.setParameter("userAlias","%"+ user.getUserAlias()+"%");
		query.setFirstResult(pageable.getOffset());
		query.setMaxResults(pageable.getPageSize());
		List<User> users=query.getResultList();
		Page<User> page=new PageImpl<User>(users, pageable,10 );
		return page;
	}
	public EntityManager getEm() {
		return em;
	}
	public void setEm(EntityManager em) {
		this.em = em;
	}
	
}
