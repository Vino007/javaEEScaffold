package com.vino.scaffold.shiro.controller;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.entity.Constants;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.RoleDuplicateException;
import com.vino.scaffold.shiro.exception.UserDuplicateException;
import com.vino.scaffold.shiro.service.ResourceService;
import com.vino.scaffold.shiro.service.RoleService;
import com.vino.scaffold.utils.Servlets;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController{
	
	@Autowired
	private RoleService roleService;
	@Autowired
	private ResourceService resourceService;
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String getAllRoles(Model model,@RequestParam(value="pageNumber",defaultValue="1")int pageNumber){	
		Page<Role> rolePage=roleService.findAll(buildPageRequest(pageNumber));
		model.addAttribute("roles", rolePage.getContent());
		model.addAttribute("page", rolePage);
		return "role/list";
	}
	
	
	@RequestMapping(value="/search",method=RequestMethod.GET)
	public String getUsersByCondition(Model model,Role role,@RequestParam(value="pageNumber",defaultValue="1")int pageNumber,ServletRequest request){
		Map<String,Object> searchParams=Servlets.getParametersStartingWith(request, "search_");
		log.info("搜索参数="+searchParams.toString());				
		Page<Role> rolePage=roleService.findRoleByCondition(searchParams, buildPageRequest(pageNumber));
		model.addAttribute("roles",rolePage.getContent());
		model.addAttribute("page", rolePage);	
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		System.out.println("返回到页面的搜索参数"+Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		model.addAttribute("searchParamsMap", searchParams);
		return "role/list";
	}
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String addUser(Model model ,Role role){
		try {
			roleService.saveWithCheckDuplicate(role);
			
		} catch (RoleDuplicateException e) {
			model.addAttribute("roleDuplicate", "true");
			e.printStackTrace();
		}
		Page<Role> rolePage=roleService.findAll(buildPageRequest(1));
		model.addAttribute("roles", rolePage.getContent());
		model.addAttribute("page", rolePage);
		return "role/list";	
	}
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public  String deleteUsers(Model model,@RequestParam("deleteIds[]")Long[] deleteIds){
		roleService.delete(deleteIds);
		Page<Role> rolePage=roleService.findAll(buildPageRequest(1));
		model.addAttribute("roles", rolePage.getContent());
		model.addAttribute("page", rolePage);
		return "role/list";
		
	}
	@RequestMapping(value="/update",method=RequestMethod.POST)	
	public String updateUser(Model model,Role role){
		roleService.update(role);
		Page<Role> rolePage=roleService.findAll(buildPageRequest(1));
		model.addAttribute("roles", rolePage.getContent());
		model.addAttribute("page", rolePage);
		return "role/list";
		
	}
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String prepareUpdateUser(Model model,@PathVariable("id") Long id){
		model.addAttribute("role", roleService.findOne(id));
		return "role/edit";
		
	}
	@RequestMapping(value="/detail/{id}",method=RequestMethod.GET)
	public String findUser(Model model,@PathVariable("id") Long id){
		model.addAttribute("role", roleService.findOne(id));
		return "role/detail";
		
	}
	/**
	 * 
	 * @param model return availableRoles and role
	 * @param id
	 * @return 
	 */
	@RequestMapping(value="/prepareBind/{id}",method=RequestMethod.GET)
	public String prepareBind(Model model,@PathVariable("id") Long id){
	
		Role role=roleService.findOne(id);
		model.addAttribute("role", role);
		List<Resource> resources=resourceService.findAll();
		for(Resource r:role.getResources())
			resources.remove(r);
		model.addAttribute("availableResources",resources);
		return "role/bind";
		
	}
	
	@RequestMapping(value="/bind",method=RequestMethod.POST)
	public String bind(Model model,@RequestParam("roleId")Long roleId,@RequestParam(value="roleIds[]",required=false)Long[] resourceIds){
		roleService.clearAllRoleAndResourceConnection(roleId);
		if(resourceIds!=null){
			roleService.connectRoleAndResource(roleId,resourceIds);
		}				
		Page<Role> rolePage=roleService.findAll(buildPageRequest(1));
		model.addAttribute("roles", rolePage.getContent());
		model.addAttribute("page", rolePage);
		return "role/list";
		
	}
	

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}


	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	
}
