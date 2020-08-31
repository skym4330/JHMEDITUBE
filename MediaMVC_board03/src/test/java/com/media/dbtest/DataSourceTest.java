package com.media.dbtest;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.java.Log;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log
public class DataSourceTest {
	@Autowired
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		try (Connection conn = dataSource.getConnection()){
			log.info(conn.toString());
		}catch (Exception e) {
			// TODO: handle exception
			fail(e.getMessage());
		}
	}
}





