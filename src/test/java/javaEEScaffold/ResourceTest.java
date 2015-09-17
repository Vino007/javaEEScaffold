package javaEEScaffold;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.service.ResourceService;

public class ResourceTest {
	private  ClassPathXmlApplicationContext ctx ;
	private ResourceService resourceService;

	@Before
	public void setUp() throws Exception {
		 ctx =  new ClassPathXmlApplicationContext("applicationContext.xml"); 
		 resourceService=ctx.getBean("resourceService",ResourceService.class);
	}

	@After
	public void tearDown() throws Exception {
		ctx.close();
	}

	@Test
	public void testSave() {
		resourceService.save(new Resource("角色管理", "menu", "role:menu"));
		resourceService.save(new Resource("创建角色", "button", "role:create"));
		resourceService.save(new Resource("删除角色", "button", "role:delete"));
		resourceService.save(new Resource("编辑角色", "button", "role:update"));
		resourceService.save(new Resource("查询角色", "button", "role:view"));
	}

}
