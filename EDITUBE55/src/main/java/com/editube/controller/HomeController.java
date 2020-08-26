package com.editube.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.editube.dto.CashDateDto;
import com.editube.dto.CashDto;
import com.editube.dto.MemberDto;
import com.editube.dto.RatingDto;
import com.editube.dto.memsearchDto;
import com.editube.service.MemberService;

@Controller
public class HomeController {
	
	@Inject //서비스를 호출하기 위해서 의존성을 주입
	JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.
    MemberService memberservice; //서비스를 호출하기 위해 의존성을 주입

	@Autowired
	private MemberService mServ;

	private ModelAndView mv;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@GetMapping("/")
	public String main() {
		logger.info("main()");
		
		return "main";
	}

	//로그인 화면 전환 메소드
	@GetMapping("loginFrm")
	public String loginFrm() {
		logger.info("loginFrm()");

		return "loginFrm";
	}

	@PostMapping("access")
	public ModelAndView accessProc(MemberDto member, 
			RedirectAttributes rttr) {
		logger.info("accessProc()");

		mv = mServ.loginProc(member, rttr);

		return mv;
	}

	@GetMapping("signPageFrm")
	public String signPageFrm() {
		return "signPageFrm";
	}

	@PostMapping("memInsert")
	public ModelAndView memInsert(MemberDto member,	RedirectAttributes rttr) {
		logger.info("memInsert()");

		//서비스에서 처리
		mv = mServ.memberInsert(member, rttr);

		return mv;
	}
	
	
	@GetMapping("comIdFrm")
	public String comIdFrm() {
		return "comIdFrm";
	}
	
	@GetMapping("findIdFrm")
	public String findIdFrm() {
		return "findIdFrm";
	}	
	
//	@PostMapping("findIdMatch")
//	public String findIdMatch(String name, String phonenum) {
//		String result = mServ.idFind(mname, mphonenum);
//		
//		return result;
//	}
	
	@GetMapping("findPwFrm")
	public String findPwFrm() {
		return "findPwFrm";
	}
	
	@GetMapping("rePwFrm")
	public String rePwFrm() {
		return "rePwFrm";
	}
	
	@GetMapping("comPwFrm")
	public String comPwFrm() {
		return "comPwFrm";
	}
	@GetMapping("signWelFrm")
	public String signWelFrm() {
		return "signWelFrm";
	}
	
	@GetMapping("myInfo")
	public String myInfo() {

		return "myInfo";
	}
	@GetMapping("myInfoUp")
	public String myInfoUp() {
		
		return "myInfoUp";
	}

	@GetMapping("youtuberBoard")
	public String youtuberBoard() {
		
		return "youtuberBoard";
	}
	@GetMapping("editBoard")
	public String editBoard() {
		
		return "editBoard";
	}
	@GetMapping("editContent")
	public String editContent() {
		
		return "editContent";
	}
	
	
	@GetMapping("myEPage")
	public String myEPage() {
		
		return "myEPage";
	}
	@GetMapping("myEPageCash")
	public String myEPageCash() {
		
		return "myEPageCash";
	}
	@GetMapping("myEPageSc")
	public String myEPageSc() {
		
		return "myEPageSc";
	}

	@GetMapping("mWarning")
	public String mWarning() {
		
		return "mWarning";
	}
	@GetMapping("mWarningFrm")
	public String mWarningFrm() {
		
		return "mWarningFrm";
	}
	
	//관리자 회원관리
			@GetMapping("Member")
			public ModelAndView mMember() {
				ModelAndView mv=new ModelAndView();
				mv=mServ.mMember();
				return mv;
			}
	
	//id 중복 체크 처리 메소드
		@GetMapping(value = "idCheck",
				produces = "application/text; charset=utf-8")
		@ResponseBody
		public String idCheck(String mid) {
			logger.info("idCheck() - mid : " + mid);

			String result = mServ.idCheck(mid);

			return result;
		}

		//닉네임 중복 체크 처리 메소드
		@GetMapping(value = "nickCheck",
				produces = "application/text; charset=utf-8")
		@ResponseBody
		public String nickCheck(String mnickname) {
			logger.info("nickCheck() - mnickname : " + mnickname);

			String result = mServ.nickCheck(mnickname);

			return result;
		}

		@GetMapping("typechangee")
		public ModelAndView typechangee(String nick,	RedirectAttributes rttr) {
			logger.info("typechangee()");

			//서비스에서 처리
			mv = mServ.typechangee(nick, rttr);

			return mv;
		}

		@GetMapping("typechange")
		public ModelAndView typechange(String nick,	RedirectAttributes rttr) {
			logger.info("typechange()");

			//서비스에서 처리
			mv = mServ.typechange(nick, rttr);

			return mv;
		}

		//mailSending 코드
		@PostMapping(value = "email" ,produces="application/json;charset=utf-8")
		@ResponseBody
		public Map<String, String> mailSending(String email) throws IOException {
			Map<String, String> rmap = new HashMap<String, String>();
			rmap=mServ.sendmail(email);
			return rmap;
		}
		
		
		//계정 설정 비밀번호 인증
		@PostMapping(value = "Infopwcheck")
		public ModelAndView InfoCheck(MemberDto member,RedirectAttributes rttr) {
			ModelAndView mv = new ModelAndView();
			mv=mServ.InfoCh(member, rttr);
			return mv;
		}

		//계정 설정에서 비밀번호 변경
		@PostMapping("passcheck")
		public ModelAndView passcheck(String cpassword,RedirectAttributes rttr) {
			mv = new ModelAndView();//화면으로 데이터 전송.;
			System.out.println(cpassword);
			mv=mServ.passChange(cpassword,rttr);
			return mv;
		}

		//회원탈퇴
		@GetMapping("delete")
		public String delete(String nk,RedirectAttributes rttr) {
			String view=mServ.delete(nk,rttr);
			System.out.println(nk);

			return view;
		}
		//사진 수정
		@PostMapping(value = "fileup", produces="application/text; charset=utf-8")
		@ResponseBody
		public String fileup(MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
			String view=mServ.fileup(multi);
			return view;
		}
		//사진 삭제
		@PostMapping(value = "filedel", produces="application/text; charset=utf-8")
		@ResponseBody
		public String filedel() {
			String view=mServ.filedel();
			return view;
		}

		//ID찾기
		@PostMapping("findId")
		public ModelAndView findId(String name, String phonenum,RedirectAttributes rttr) {
			mv=new ModelAndView();
			System.out.println(name);
			System.out.println(phonenum);
			mv = mServ.findId(name, phonenum,rttr);
			return mv;
		}

		//PW찾기
		@PostMapping("pwfind")
		public ModelAndView pwfind(String name, String mid,RedirectAttributes rttr) {
			mv=new ModelAndView();
			System.out.println(name);
			System.out.println(mid);
			mv = mServ.pwfind(name, mid,rttr);
			return mv;
		}

		//PW변경
		@PostMapping("pwch")
		public String pwch(String pw, String pwcheck,RedirectAttributes rttr) {
			String view=null;
			System.out.println(pw);
			System.out.println(pwcheck);
			view = mServ.pwch(pw, pwcheck,rttr);
			return view;
		}

		//아이디 찾기 후 비밀번호 찾기
		@GetMapping("fpw")
		public String fpw() {
			String view = mServ.fpw();
			return view;
		}

		//아이디 찾기 후 로그인
		@GetMapping("jo")
		public String jo() {
			//세션에 저장된 로그인 정보(회원 정보) 삭제
			//첫번째 페이지로 이동.
			String view = mServ.jo();
			return view;
		}
		
		@GetMapping("mdelete")
		public String mdelete(String m_nickname,RedirectAttributes rttr) {
			System.out.println("들어왔음"+m_nickname);
			String view=mServ.mdelete(m_nickname,rttr);
			
			return view;
		}
		
		@GetMapping("dateSearch")
		   public ModelAndView dateSearch(memsearchDto memsea, MemberDto member) {
		      logger.info("dateSearch()");
		      //서비스에서 처리
		      mv = mServ.dateSearch(member,memsea);
		      
		      return mv;
		   }
		
		//혜명메소드
		
		//관리자 거래요청 관리 메소드
		@GetMapping("mDeal")
		public ModelAndView mDeal() {
			mv=mServ.getmDeal();
			
			return mv;
		}
		
		//관리자 취소 요청 관리 메소드
		@GetMapping("cancelOk")
		public String cancelOk(Integer rnum, Integer conNum) {
			mServ.cancelOk(rnum,conNum);
			
			return "mDeal";
		}
		
		//후기 남기기 메소드
		@GetMapping("InsertRatFrm")
		public ModelAndView InsertRatFrm(RatingDto rating, RedirectAttributes rttr) {
			
			mv = mServ.InsertRatFrm(rating, rttr);
			
			return mv;
		}
		
		//거래 요청 status관리 메소드
		@GetMapping("statusChange")
		public ModelAndView statusChange(Integer rnum, Integer myNum, String rtnick, Integer targetNum) {
			mv=mServ.statusChange(rnum, myNum, rtnick, targetNum);
			
			return mv;
		}
		
		//마이페이지 요청관리 페이지 메소드
		@GetMapping("myUPageReqM")
		public ModelAndView myUPageReqM(Integer status) {
			mv=mServ.getReqList(status, 1);
			return mv;
		}
		
		//마이페이지 요청관리 페이지 메소드
		@GetMapping("myEPageReqM")
		public ModelAndView myEPageReqM(Integer status) {
			mv=mServ.getReqList(status, 2);
			
			return mv;
		}
		
		//거래요청 메소드
		@GetMapping("goReq")
		public ModelAndView goReq(Integer bnum, String nick) {
			mv=mServ.goReq(bnum,nick);
			
			return mv;
		}
		
		//지혜메소드
		//캐시 충전 메소드
		@PostMapping("cashCharging")
		public ModelAndView cashCharging(CashDto cash,
				RedirectAttributes rttr) {
			logger.info("cashCharging()");
			
			//서비스에서 처리
			mv = mServ.chargingList(cash, rttr);
			
			return mv;
		}
		
		@PostMapping("changemoney")
		public ModelAndView changemoney(CashDto cash,
				RedirectAttributes rttr) {
			logger.info("changemoney()");
			
			//서비스에서 처리
			mv = mServ.changemoney(cash, rttr);
			
			return mv;
		}
		
	      @GetMapping("logout")
	      public String logout() {
	         //세션에 저장된 로그인 정보(회원 정보) 삭제
	         //첫번째 페이지로 이동.
	         String view = mServ.logout();
	         return view;
	      }
		
		@GetMapping("cashList")
		public ModelAndView cashList(String nick) {
			logger.info("cashList()");
			
			//서비스에서 처리
			mv = mServ.getCashList(nick);
			
			return mv;
		}
		
		@GetMapping("cashSearch")
		public ModelAndView cashSearch(CashDateDto cd) {
			logger.info("cashSearch()");
			Integer pageNum = null; 
			//서비스에서 처리
			mv = mServ.cashSearch(cd);
			
			return mv;
		}
		
		@GetMapping("chargeCash")
		public String chargeCash() {
			
			return "chargeCash";
		}
		
		@GetMapping("cashTransform")
		public String cashTransform() {
			
			return "cashTransform";
		}
		
		@GetMapping("dealMemNickSearch")
		public ModelAndView dealMemNickSearch(String searchNick) {
			mv=mServ.dealMemNickSearch(searchNick);
			
			return mv;
		}
		
		
		
		
}
