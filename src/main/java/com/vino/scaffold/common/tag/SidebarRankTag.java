package com.vino.scaffold.common.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.vino.scaffold.entity.Constants;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;

public class SidebarRankTag extends SimpleTagSupport{
	private User currentUser;
	@Override
	public void doTag() throws JspException, IOException {
		List<Resource> menuResources=new ArrayList<Resource>();	
		for(Role role:currentUser.getRoles()){
			Set<Resource> resources=role.getResources();			
			for(Resource res : resources){
				if(res!=null&&res.getType().equals("menu")){
					menuResources.add(res);
				}
			}			
		}		
		Collections.sort(menuResources, new Comparator<Resource>() {
			@Override
			public int compare(Resource o1, Resource o2) {
				//o1>o2则返回正数O1=O2返回0，小于返回负数
				return o1.getPriority().compareTo(o2.getPriority());
			}
		});
		
		JspWriter out=getJspContext().getOut();
		for(Resource res : menuResources){
			if(res.getUrl().equals("druid"))
				out.println("<li><a  href='"+res.getUrl()+"' target='_blank'><i class='fa fa-laptop'></i><span>"+res.getName()+"</span></a></li>");//直接跳转到监控页面
			else
				out.println("<li><a class='sidebarMenuHref' href='"+res.getUrl()+"'><i class='fa  fa-circle-o'></i><span>"+res.getName()+"</span></a></li>");	
		
		}
	}
	public User getCurrentUser() {
		return currentUser;
	}
	public void setCurrentUser(User currentUser) {
		this.currentUser = currentUser;
	}
	

}
