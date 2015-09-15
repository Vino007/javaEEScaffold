package javaEEScaffold;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.vino.shirospring.entity.Resource;
import com.vino.shirospring.service.ResourceService;

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
		resourceService.save(new Resource("用户管理", "menu", "user:menu"));
		resourceService.save(new Resource("创建用户", "button", "user:create"));
		resourceService.save(new Resource("删除用户", "button", "user:delete"));
		resourceService.save(new Resource("编辑用户", "button", "user:update"));
		resourceService.save(new Resource("查询用户", "button", "user:view"));
	}

}
