package com.vino.scaffold.shiro.filter;

import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;

import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.service.UserService;

public class MyFormAuthenticationFilter extends FormAuthenticationFilter{
	@Autowired
	private UserService userService;
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token,
			Subject subject, ServletRequest request, ServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		
		User curUser=userService.findByUsername((String)subject.getPrincipal());
		curUser.setLastLoginTime(new Date());
		userService.update(curUser);
		System.out.println("Ö´ÐÐmyfilter");
		return super.onLoginSuccess(token, subject, request, response);
	}
	

}
