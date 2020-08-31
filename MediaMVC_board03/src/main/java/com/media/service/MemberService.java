package com.media.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.media.dao.MemberDao;
import com.media.dto.MemberDto;

@Service
public class MemberService {
	//로그인 처리에 필요한 요소들
	//  DAO 객체, 세션 객체, ModelAndView 객체
	@Autowired
	private MemberDao mDao;
	
	@Autowired
	private HttpSession session;
	
	private ModelAndView mv;
	
	//로그인 처리용 메소드
	public ModelAndView loginProc(MemberDto member, 
			RedirectAttributes rttr) {
		mv = new ModelAndView();//화면으로 데이터 전송.
		
		String view = null;//이동할 jsp 이름 저장 변수.
		String msg = null;//화면에 출력할 메시지
		
		//DB에서 해당 id의 password 가져오기.
		String get_pw = mDao.getPwd(member.getM_id());
		
		BCryptPasswordEncoder pwdEncoder = 
				new BCryptPasswordEncoder();
		
		//로그인 처리
		if(get_pw != null) {
			//아이디 있음.
			if(pwdEncoder.matches(member.getM_pwd(), get_pw)) {
				//패스워드 맞음. 로그인 성공.
				//세션에 로그인 성공한 회원 정보 저장
				//로그인 한 회원의 정보를 가져오기.
				member = mDao.getMemInfo(member.getM_id());
				session.setAttribute("mb", member);
				
				//리다이렉트로 화면을 전환.
				view = "redirect:list";//list는 uri.
			}
			else {
				//패스워드 틀림.
				view = "redirect:loginFrm";
				msg = "패스워드 틀림.";
			}
		}
		else {
			//아이디 없음.
			view = "redirect:loginFrm";
			msg = "아이디 없음.";
		}
		
		mv.setViewName(view);
		rttr.addFlashAttribute("msg", msg);
		return mv;
	}

	public ModelAndView memberInsert(MemberDto member, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;
		
		//비밀번호 암호화 처리
		//스프링 시큐리티는 암호화만 해줌.
		//복호화는 안해줌.
		BCryptPasswordEncoder pwdEncoder =
				new BCryptPasswordEncoder();
		
		//위의 인코더를 사용하여 평문 비밀번호를 
		//암호 비밀번호로 변경
		String encPwd = pwdEncoder.encode(member.getM_pwd());
		//암호화된 비밀번호를 member에 다시 저장
		member.setM_pwd(encPwd);
		
		try {
			//member의 데이터를 DB 저장(insert)
			mDao.memberInsert(member);
			//회원 등록 성공 -> 로그인 화면으로 전환
			view = "redirect:/";
			rttr.addFlashAttribute("msg", "가입 성공");
		} catch (Exception e) {
			// 회원 등록 실패 -> 같은 화면에 실패 메시지 전달
			//e.printStackTrace();
			view = "redirect:joinFrm";
			rttr.addFlashAttribute("msg", "아이디 중복");
		}
		
		mv.setViewName(view);
		return mv;
	}

	public String logout() {
		//세션 정보 지우기
		session.invalidate();
		
		return "home";
	}

	public String idCheck(String mid) {
		String result = null;
		
		try {
			//cnt : 중복 id가 있을 경우 1, 없을 경우 0
			int cnt = mDao.idCheck(mid);
			
			if(cnt == 1) {
				result = "fail";
			}
			else {
				result = "success";
			}
		}catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Transactional
	public void pointUp(String mid) {
		try {
			mDao.pointUp(mid);
			//포인트를 증가하고 증가된 새 정보를 세션에 저장
			MemberDto member = 
					(MemberDto)session.getAttribute("mb");
			member = mDao.getMemInfo(member.getM_id());
			session.setAttribute("mb", member);
		}catch (Exception e) {
			// TODO: handle exception
		}		
	}
}








