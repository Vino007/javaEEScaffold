package com.vino.scaffold.shiro.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.entity.Constants;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.UserDuplicateException;
import com.vino.scaffold.shiro.service.RoleService;
import com.vino.scaffold.shiro.service.UserService;
import com.vino.scaffold.utils.Servlets;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@RequiresPermissions("user:menu")
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String getALLUsers(Model model,@RequestParam(value="pageNumber",defaultValue="1")int pageNumber,
			@RequestParam(value = "page.size", defaultValue = Constants.PAGE_SIZE+"") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType){
		Page<User> userPage=userService.findAll(buildPageRequest(pageNumber));
		model.addAttribute("users", userPage.getContent());
		model.addAttribute("page", userPage);
		//model.addAttribute("searchParams", "");
		return "user/list";
	}
	@RequiresPermissions("user:view")
	@RequestMapping(value="/search",method=RequestMethod.GET)
	public String getUsersByCondition(Model model,User user,@RequestParam(value="pageNumber",defaultValue="1")int pageNumber,ServletRequest request){
		Map<String,Object> searchParams=Servlets.getParametersStartingWith(request, "search_");
		log.info("搜索参数="+searchParams.toString());				
		Page<User> userPage=userService.findUserByCondition(searchParams, buildPageRequest(pageNumber));
		model.addAttribute("users",userPage.getContent());
		model.addAttribute("page", userPage);	
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		System.out.println("返回到页面的搜索参数"+Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		model.addAttribute("searchParamsMap", searchParams);
		return "user/list";
	}
	@RequiresPermissions("user:create")
	@RequestMapping(value="/prepareAdd",method=RequestMethod.GET)
	public String prepareAddUser(Model model ){
		return "user/add";
	}
	@RequiresPermissions("user:create")
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String addUser(Model model ,User user,HttpSession session){
		User curUser=(User) session.getAttribute(Constants.CURRENT_USER);
		try {
			userService.saveWithCheckDuplicate(user,curUser);
			
		} catch (UserDuplicateException e) {
			model.addAttribute("userDuplicate", "true");
			e.printStackTrace();
		}
		Page<User> userPage=userService.findAll(buildPageRequest(1));
		model.addAttribute("users", userPage.getContent());
		model.addAttribute("page", userPage);
		return "user/list";	
	}
	@RequiresPermissions("user:delete")
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public  String deleteUsers(Model model,@RequestParam("deleteIds[]")Long[] deleteIds){
		userService.delete(deleteIds);
		Page<User> userPage=userService.findAll(buildPageRequest(1));
		model.addAttribute("users", userPage.getContent());
		model.addAttribute("page", userPage);
		return "user/list";
		
	}
	@RequiresPermissions("user:update")
	@RequestMapping(value="/update",method=RequestMethod.POST)	
	public String updateUser(Model model,User user){
		userService.update(user);
		Page<User> userPage=userService.findAll(buildPageRequest(1));
		model.addAttribute("users", userPage.getContent());
		model.addAttribute("page", userPage);
		return "user/list";
		
	}
	@RequiresPermissions("user:update")
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String prepareUpdateUser(Model model,@PathVariable("id") Long id){
		model.addAttribute("user", userService.findOne(id));
		return "user/edit";
		
	}
	@RequiresPermissions("user:view")
	@RequestMapping(value="/detail/{id}",method=RequestMethod.GET)
	public String findUser(Model model,@PathVariable("id") Long id){
		model.addAttribute("user", userService.findOne(id));
		return "user/detail";
		
	}
	/**
	 * 
	 * @param model return availableRoles and user
	 * @param id
	 * @return 
	 */
	@RequiresPermissions("user:bind")
	@RequestMapping(value="/prepareBind/{id}",method=RequestMethod.GET)
	public String prepareBind(Model model,@PathVariable("id") Long id){
	
		User user=userService.findOne(id);
		model.addAttribute("user", user);
		List<Role> roles=roleService.findAll();
		for(Role r:user.getRoles())
			roles.remove(r);
		model.addAttribute("availableRoles",roles);
		return "user/bind";
		
	}
	@RequiresPermissions("user:bind")
	@RequestMapping(value="/bind",method=RequestMethod.POST)
	public String bind(Model model,@RequestParam("userId")Long userId,@RequestParam(value="roleIds[]",required=false)Long[] roleIds){
		userService.clearAllUserAndRoleConnection(userId);
		if(roleIds!=null){
			userService.connectUserAndRole(userId,roleIds);
		}				
		Page<User> userPage=userService.findAll(buildPageRequest(1));
		model.addAttribute("users", userPage.getContent());
		model.addAttribute("page", userPage);
		return "user/list";
		
	}
	
	
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	
}
