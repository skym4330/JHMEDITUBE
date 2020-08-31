package com.media.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.java.Log;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log
public class DaoTest {
	@Autowired
	private MemberDao mDao;
	
	@Test
	public void testGetPwd() {
		log.info(mDao.getPwd("TEST"));
		//System.out.println(mDao.getPwd("TEST"));
	}
}







