package com.vino.scaffold.shiro.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.vino.scaffold.entity.base.BaseEntity;

@Entity
@Table(name="t_resource")
public class Resource extends BaseEntity<Long> {
	
	@Column(name="name",length=100)
	private String name;
	@Column(name="type",length=30)
	private String type="button";
	@Column(name="priority")
	private Integer priority=1;
	@Column(name="parent_id")
	private Long parentId=0L;
	@Column(name="permission",length=100)
	private String permission;
	@Column(name="available")
	private Boolean available=Boolean.TRUE;
	@Column(name="url",length=200)
	private String url;
	@ManyToMany(mappedBy="resources",targetEntity=Role.class)
	private Set<Role> roles=new HashSet<Role>();
		
	public Resource() {
		
	}
	public Resource(String name, String type, String permission) {
		
		this.name = name;
		this.type = type;
		this.permission = permission;
	}
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	public Long getParentId() {
		return parentId;
	}
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	public Boolean getAvailable() {
		return available;
	}
	public void setAvailable(Boolean available) {
		this.available = available;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
