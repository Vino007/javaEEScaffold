package com.vino.scaffold.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
	public static Tree formatResourceToTree(Resource resource,boolean checked){
		Tree tree=new Tree();
		tree.setId(resource.getId());
		tree.setName(resource.getName());
		tree.setpId(resource.getParentId());
		if(checked){
			tree.setChecked(true);
		}else
			tree.setChecked(false);
		return tree;
	}
	
	public static Tree formatUserToTree(User user){
		Tree tree=new Tree();
		tree.setId(user.getId());
		tree.setName(user.getUsername());
		tree.setpId(0L);
		return tree;
	}
	/**
	 * 将resource转换成相应的tree,并且返回是否checked
	 * @param uncheckedResources
	 * @param checkedResources
	 * @return
	 */
	public static List<Tree> fomatResourceToTree(List<Resource> uncheckedResources,Set<Resource> checkedResources){
		List<Tree> trees=new ArrayList<Tree>();
		for(Resource res:uncheckedResources){
			Tree tree=TreeUtils.formatResourceToTree(res,false);
			trees.add(tree);
		}
		for(Resource res:checkedResources){
			Tree tree=TreeUtils.formatResourceToTree(res,true);
			trees.add(tree);
		}
		return trees;
	}
	
	public static List<Tree> fomatResourceToTree(List<Resource> resources){
		List<Tree> trees=new ArrayList<Tree>();
		Tree root=new Tree();
		root.setId((long) 0);//根节点的id为0
		root.setpId(0l);
		root.setName("Root节点");
		root.setChecked(false);
		
		trees.add(root);
		for(Resource res:resources){
			Tree tree=TreeUtils.formatResourceToTree(res,false);//checkbox无选中
			trees.add(tree);
		}
		return trees;
	}
}
