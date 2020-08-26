package com.editube.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.java.Log;

@Log
public class SessionInterceptor 
				extends HandlerInterceptorAdapter {
	@Autowired
	private HttpSession session;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("preHandle - 인터셉트");
		
		//세션에 mb 객체가 없으면 첫번째 페이지로 이동.
		if(session.getAttribute("mb") == null) {
			response.sendRedirect("./");
			return false;
		}
		
		return true;
	}
	
	//로그아웃 후 뒤로가기 막기
	//브라우저에 저장된 캐쉬(히스토리) 제거
	//http 버전에 따라 1.1과 1.0 두가지 경우를 처리
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 현재 사용중인 http 프로토콜의 버전은 두가지
		// 1.0 버전과 1.1 버전
		// 두 버전에서 캐쉬 삭제 형식이 다름
		if(request.getProtocol().equals("HTTP/1.1")) {
			response.setHeader("Cache-Control", 
					"no-cache, no-store, must-revalidate");
		}
		else {//"HTTP/1.0"
			response.setHeader("Pragma", "no-cache");
		}
		response.setDateHeader("Expires", 0);
	}
}






