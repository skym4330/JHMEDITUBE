package com.media.service;

import static org.junit.Assert.assertNotNull;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.servlet.ModelAndView;

import com.media.dto.MemberDto;

import lombok.extern.java.Log;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log
public class MemServiceTest {
	@Autowired
	private MemberService mServ;//서비스 객체 얻어오기
	
	@Test	//bean 객체(인스턴스) 생성 정상 처리 여부 확인
	public void testExist() {
		log.info(mServ.toString());
		assertNotNull(mServ);//객체가 Null이 아닌지 여부 확인
	}
	
	@Test	//로그인 처리 메소드 테스트
	public void testLoginProc() {
		//임시 데이터 입력용 DTO 객체
		MemberDto member = new MemberDto();
		member.setM_id("PARK");
		member.setM_pwd("1111");
		
		ModelAndView mv = mServ.loginProc(member, null);
		log.info(mv.getViewName());		
	}
}







