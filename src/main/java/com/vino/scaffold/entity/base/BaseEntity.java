package com.vino.scaffold.entity.base;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
//@MappedSuperclass 用在父类上面。当这个类肯定是父类时，加此标注。如果改成@Entity，则继承后，多个类继承，只会生成一个表，而不是多个继承，生成多个表
@MappedSuperclass
public abstract class BaseEntity<PK extends Serializable> {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_time")
	private Date createTime;
	@Column(name="creator_id")
	private Long creatorId;
	@Column(name="creator_name")
	private String creatorName;
	
	
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Long getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(Long creatorId) {
		this.creatorId = creatorId;
	}
	 @Override
	    public boolean equals(Object obj) {

	        if (null == obj) {
	            return false;
	        }

	        if (this == obj) {
	            return true;
	        }

	        if (!getClass().equals(obj.getClass())) {
	            return false;
	        }

	        BaseEntity<?> that=(BaseEntity<?>) obj;
	        return null == this.getId() ? false : this.getId().equals(that.getId());
	    }

	   
	    @Override
	    public int hashCode() {

	        int hashCode = 17;

	        hashCode += null == getId() ? 0 : getId().hashCode() * 31;

	        return hashCode;
	    }
	    //通过反射实现toString apache common lang包里
		@Override
		public String toString() {
			return ReflectionToStringBuilder.toString(this);
		}

	   
}
