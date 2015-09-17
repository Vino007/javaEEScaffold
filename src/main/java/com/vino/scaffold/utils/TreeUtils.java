package com.vino.scaffold.utils;

import java.util.ArrayList;
import java.util.List;

import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.entity.User;
/**
 * 将实体类转换成ztree显示需要的信息
 * @author Joker
 *
 */
public class TreeUtils {
	public static Tree formatRoleToTree(Role role){
		Tree tree=new Tree();
		tree.setId(role.getId());
		tree.setName(role.getName());
		tree.setpId(0L);
		return tree;
	}
	public static Tree formatResourceToTree(Resource resource){
		Tree tree=new Tree();
		tree.setId(resource.getId());
		tree.setName(resource.getName());
		tree.setpId(resource.getParentId());
		return tree;
	}
	
	public static Tree formatUserToTree(User user){
		Tree tree=new Tree();
		tree.setId(user.getId());
		tree.setName(user.getUsername());
		tree.setpId(0L);
		return tree;
	}
	
	public static List<Tree> fomatResourceToTree(List<Resource> resources){
		List<Tree> trees=new ArrayList<Tree>();
		for(Resource res:resources){
			Tree tree=TreeUtils.formatResourceToTree(res);
			trees.add(tree);
		}
		return trees;
	}
}
