package com.vino.scaffold.shiro.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.vino.scaffold.entity.base.BaseEntity;

@Entity
@Table(name="t_role")
public class Role extends BaseEntity<Long> {
	/*@Column(name="mark",length=100)
	private String mark;//角色标识，在dao层做唯一约束
*/	@Column(name="name",length=100)
	private String name;
	@Column(name="description",length=200)
	private String description;
	@Column(name="available")
	private Boolean available=Boolean.TRUE;
	@ManyToMany(targetEntity=Resource.class)
	@JoinTable(name="t_role_resource",joinColumns=@JoinColumn(name="role_id"),inverseJoinColumns=@JoinColumn(name="resource_id"))
	private Set<Resource> resources=new HashSet<Resource>();
	@ManyToMany(targetEntity=User.class,mappedBy="roles")//双向关系的接收端，mappedBy指的是关联对象中的某个属性
	private Set<User> users=new HashSet<User>();
	
	
	public Role() {
	}
	
	public Role(String mark, String name) {
		//this.mark = mark;
		this.name = name;
	}

/*	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}*/
	public Set<User> getUsers() {
		return users;
	}
	public void setUsers(Set<User> users) {
		this.users = users;
	}
	public Set<Resource> getResources() {
		return resources;
	}
	public void setResources(Set<Resource> resources) {
		this.resources = resources;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Boolean getAvailable() {
		return available;
	}
	public void setAvailable(Boolean available) {
		this.available = available;
	}
	
	
	
}
