package javaEEScaffold;

import static org.junit.Assert.*;

import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;







import com.vino.scaffold.shiro.entity.Resource;
import com.vino.scaffold.shiro.entity.Role;
import com.vino.scaffold.shiro.service.ResourceService;
import com.vino.scaffold.shiro.service.RoleService;

public class RoleTest {
	
	private EntityManager em;
	private  ClassPathXmlApplicationContext ctx ;
	private RoleService roleService;
	private ResourceService resourceService;
	@Before
	public void setUp() throws Exception {
		 ctx =  new ClassPathXmlApplicationContext("applicationContext.xml"); 
		 roleService=ctx.getBean("roleService",RoleService.class);
		 resourceService=ctx.getBean("resourceService",ResourceService.class);
	}

	@After
	public void tearDown() throws Exception {
		ctx.close();
	}

	@Test
	public void testSave() {
		roleService.save(new Role("guest", "访客"));
		roleService.save(new Role("admin", "超级管理员"));
	}
	@Test
	public void testConnectRoleAndResource(){
		roleService.connectRoleAndResource(1L, 5L);
	}
	@Test public void testDisconnectRoleAndResource(){
		roleService.disconnnectRoleAndResource(1l, 5l);
	}
}
