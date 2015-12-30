package com.vino.scaffold.shiro.filter;

import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.vino.scaffold.shiro.service.UserService;
/**
 * isAccessAllowed：即是否允许访问，返回true表示允许；
 * onAccessDenied：表示访问拒绝时是否自己处理，如果返回true表示自己不处理且继续拦截器链执行，返回false表示自己已经处理了（比如重定向到另一个页面）。
 * @author vino007
 *
 */
public class MonitorAccessControlFilter extends AccessControlFilter {
	@Autowired
	private UserService userService;
	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object arg2) throws Exception {
		
		Subject subject=getSubject(request, response);
		String username=(String) subject.getPrincipal();
		if(username == null)//未登录
			return false;
		Set<String> permissions=userService.findAllPermissionsByUsername(username);	
		for(String permission:permissions){
			if("monitor:view".equals(permission)){
				return true;
			}
		}	
		return false;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response)
			throws Exception {
		 WebUtils.issueRedirect(request, response, "/static/404.html");//导向404 not found,导向login由于用户已登录，会导致login无效
		return false;
	}
	  
	
		
}
