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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.entity.Constants;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.User;
import com.vino.scaffold.shiro.exception.ResourceDuplicateException;
import com.vino.scaffold.shiro.service.ResourceService;
import com.vino.scaffold.shiro.service.RoleService;
import com.vino.scaffold.utils.Servlets;
import com.vino.scaffold.utils.Tree;
import com.vino.scaffold.utils.TreeUtils;

@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController{
	@Autowired
	private ResourceService resourceService;
	@Autowired
	private RoleService roleService;
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	@RequiresPermissions("resource:menu")
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String getAllResources(Model model,@RequestParam(value="pageNumber",defaultValue="1")int pageNumber){	
		Page<Resource> resourcePage=resourceService.findAll(buildPageRequest(pageNumber));
		model.addAttribute("resources", resourcePage.getContent());
		model.addAttribute("page", resourcePage);
		return "resource/list";
	}
	@RequiresPermissions("resource:menu")
	@ResponseBody
	@RequestMapping(value="/json/all",method=RequestMethod.GET)
	public List<Tree> getAllResources(){	
		List<Resource> resources=resourceService.findAll();
		
		return TreeUtils.fomatResourceToTree(resources);
	}
	@RequiresPermissions("resource:view")
	@RequestMapping(value="/search",method=RequestMethod.GET)
	public String getRolesByCondition(Model model,Resource resource,@RequestParam(value="pageNumber",defaultValue="1")int pageNumber,ServletRequest request){
		Map<String,Object> searchParams=Servlets.getParametersStartingWith(request, "search_");
		log.info("搜索参数="+searchParams.toString());				
		Page<Resource> resourcePage=resourceService.findResourceByCondition(searchParams, buildPageRequest(pageNumber));
		model.addAttribute("resources",resourcePage.getContent());
		model.addAttribute("page", resourcePage);	
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		model.addAttribute("searchParamsMap", searchParams);
		return "resource/list";
	}

	@RequiresPermissions("resource:create")
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String addRole(Model model ,Resource resource,HttpSession session){
		User curUser=(User) session.getAttribute(Constants.CURRENT_USER);
		try {
			resourceService.saveWithCheckDuplicate(resource,curUser);
			roleService.connectRoleAndResource(1l,resourceService.findByName(resource.getName()).getId() );//新建一个资源就绑定给超级角色admin，使得admin拥有所有权限
		} catch (ResourceDuplicateException e) {
			model.addAttribute("resourceDuplicate", "true");
			e.printStackTrace();
		}
		Page<Resource> resourcePage=resourceService.findAll(buildPageRequest(1));
		model.addAttribute("resources", resourcePage.getContent());
		model.addAttribute("page", resourcePage);
		return "resource/list";	
	}
	@RequiresPermissions("resource:delete")
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public  String deleteRoles(Model model,@RequestParam("deleteIds[]")Long[] deleteIds){
		
		resourceService.delete(deleteIds);
		
		Page<Resource> resourcePage=resourceService.findAll(buildPageRequest(1));
		model.addAttribute("resources", resourcePage.getContent());
		model.addAttribute("page", resourcePage);
		return "resource/list";
		
	}
	@RequiresPermissions("resource:update")
	@RequestMapping(value="/update",method=RequestMethod.POST)	
	public String updateRole(Model model,Resource resource){
		resourceService.update(resource);
		Page<Resource> resourcePage=resourceService.findAll(buildPageRequest(1));
		model.addAttribute("resources", resourcePage.getContent());
		model.addAttribute("page", resourcePage);
		return "resource/list";
		
	}
	@RequiresPermissions("resource:update")
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String prepareUpdateRole(Model model,@PathVariable("id") Long id){
		model.addAttribute("resource", resourceService.findOne(id));
		return "resource/edit";
		
	}
	@RequiresPermissions("resource:view")
	@RequestMapping(value="/detail/{id}",method=RequestMethod.GET)
	public String findResource(Model model,@PathVariable("id") Long id){
		model.addAttribute("resource", resourceService.findOne(id));
		return "resource/detail";
		
	}
}
