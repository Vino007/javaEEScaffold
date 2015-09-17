package com.vino.scaffold.shiro.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;





import com.vino.scaffold.controller.base.BaseController;
import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.service.ResourceService;
import com.vino.scaffold.utils.Tree;
import com.vino.scaffold.utils.TreeUtils;

@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController{
	@Autowired
	private ResourceService resourceService;
	@ResponseBody
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public List<Tree> getAllResources(){
		List<Resource> resources=resourceService.findAll();
		
		return TreeUtils.fomatResourceToTree(resources);
	
		
	}
}
