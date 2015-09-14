package javaEEScaffold;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ResourceTest {
	private  ClassPathXmlApplicationContext ctx ;
	

	@Before
	public void setUp() throws Exception {
		 ctx =  new ClassPathXmlApplicationContext("applicationContext.xml"); 
	}

	@After
	public void tearDown() throws Exception {
		ctx.close();
	}

	@Test
	public void test() {
		fail("Not yet implemented");
	}

}
