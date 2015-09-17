package com.vino.scaffold.shiro.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.vino.scaffold.entity.base.BaseEntity;

@Entity
@Table(name="t_organization")
public class Organization extends BaseEntity<Long>{
	@Column(name="name",length=100)
	private String name;
	@Column(name="priority")
	private Integer priority;
	@Column(name="parent_id")
	private Long parent_id;
	@Column(name="available")
	private Boolean available=Boolean.TRUE;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	public Long getParent_id() {
		return parent_id;
	}
	public void setParent_id(Long parent_id) {
		this.parent_id = parent_id;
	}
	public Boolean getAvailable() {
		return available;
	}
	public void setAvailable(Boolean available) {
		this.available = available;
	}
	
}
