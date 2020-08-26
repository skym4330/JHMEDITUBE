package com.editube.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.editube.controller.HomeController;
import com.editube.dao.MemberDao;
import com.editube.dto.CashDateDto;
import com.editube.dto.CashDto;
import com.editube.dto.ChatbotDto;
import com.editube.dto.EBoardDto;
import com.editube.dto.MemberDto;
import com.editube.dto.RatingDto;
import com.editube.dto.RequestDto;
import com.editube.dto.UBoardDto;
import com.editube.dto.memsearchDto;
import com.editube.util.Paging;

import lombok.extern.java.Log;

@Service
@Log
public class MemberService {
	//로그인 처리에 필요한 요소들
		//  DAO 객체, 세션 객체, ModelAndView 객체
		@Inject //서비스를 호출하기 위해서 의존성을 주입
		JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.
		MemberService memberservice; //서비스를 호출하기 위해 의존성을 주입
		@Autowired
		private MemberDao mDao;

		@Autowired
		private HttpSession session;

		private ModelAndView mv;

		private int listCount = 5;
		private int pageCount = 2;
		
		int MyCash = 0;
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
			if(pwdEncoder.matches(member.getM_password(), get_pw)) {
				//패스워드 맞음. 로그인 성공.
				//세션에 로그인 성공한 회원 정보 저장
				//로그인 한 회원의 정보를 가져오기.
				member = mDao.getMemInfo(member.getM_id());
				//받은요청만 알림에 추가 (미사용중 1,5번 거래리스트 가져오는 메소드)
				List<RequestDto> reqHList = mDao.getAlertReq(member.getM_nickname());
				//채팅리스트 가져오기
				List<ChatbotDto> chatList = mDao.getChatList(member.getM_nickname());
				
				//1번요청 개수 가져오기
				int one = mDao.getOneReq(member.getM_nickname());
				//2번요청 개수 가져오기
				int five = mDao.getFiveReq(member.getM_nickname());
				
				session.setAttribute("one", one);
				session.setAttribute("five", five);
				session.setAttribute("chatList", chatList);
				session.setAttribute("reqHList", reqHList);
				session.setAttribute("mb", member);
				//리다이렉트로 화면을 전환.
				view = "redirect:/";
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
		String encPwd = pwdEncoder.encode(member.getM_password());
		//암호화된 비밀번호를 member에 다시 저장
		member.setM_password(encPwd);
		
		try {
			//member의 데이터를 DB 저장(insert)
			mDao.memberInsert(member);
			//회원 등록 성공 -> 로그인 화면으로 전환
			view = "redirect:signWelFrm";
		} catch (Exception e) {
			// 회원 등록 실패 -> 같은 화면에 실패 메시지 전달
			//e.printStackTrace();
			view = "redirect:signPageFrm";
			rttr.addFlashAttribute("msg", "아이디 중복");
		}
		
		mv.setViewName(view);
		return mv;
	}	

	public String logout() {
		//세션 정보 지우기
		session.invalidate();
		
		return "main";
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
	
	public String nickCheck(String mnickname) {
		String result = null;
		
		try {
			//cnt : 중복 id가 있을 경우 1, 없을 경우 0
			int cnt = mDao.nickCheck(mnickname);
			
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

	public ModelAndView typechange(String nick, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;
		
		try {
			//member의 데이터를 DB 저장(insert)
			mDao.typechange(nick);
			
			//MemberDto member = new MemberDto();
			MemberDto member = (MemberDto)session.getAttribute("mb");
			member.setM_usertype(2);
			
			//member = mDao.getMemInfoo(nick);
			session.setAttribute("mb", member);
			
			//회원 등록 성공 -> 로그인 화면으로 전환
			view = "redirect:timearrySc";
		} catch (Exception e) {
			// 회원 등록 실패 -> 같은 화면에 실패 메시지 전달
			//e.printStackTrace();
			view = "redirect:myUPageSc";
		}
		
		mv.setViewName(view);
		return mv;
	}
	public ModelAndView typechangee(String nick, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;
		
		try {
			//member의 데이터를 DB 저장(insert)
			mDao.typechangee(nick);
			
			MemberDto member = mDao.getMemInfoo(nick);
			session.setAttribute("mb", member);
			
			//회원 등록 성공 -> 로그인 화면으로 전환
			view = "redirect:myUPageSc";
		} catch (Exception e) {
			// 회원 등록 실패 -> 같은 화면에 실패 메시지 전달
			//e.printStackTrace();
			view = "redirect:timearrySc";
		}
		
		mv.setViewName(view);
		return mv;
	}
	
	public ModelAndView InfoCh(MemberDto member,RedirectAttributes rttr) {

		mv = new ModelAndView();//화면으로 데이터 전송.
		String msg = null;//화면에 출력할 메시지
		String view = null;//이동할 jsp 이름 저장 변수.
		//세션 정보 가져오기
		MemberDto m = (MemberDto)session.getAttribute("mb");

		String get_pw = mDao.getPwd(m.getM_id());
		BCryptPasswordEncoder pwdEncoder = 
				new BCryptPasswordEncoder();
		if(pwdEncoder.matches(member.getM_password(), get_pw)){

			//리다이렉트로 화면을 전환.
			view = "redirect:myInfoUp";
			rttr.addFlashAttribute("msg", "비밀번호가 일치합니다.");
		}else {
			//패스워드 틀림.
			view = "redirect:myInfo";
			rttr.addFlashAttribute("msg", "패스워드 틀림.");
		}
		mv.setViewName(view);
		return mv;
	}

	public ModelAndView passChange(String cpassword,RedirectAttributes rttr) {
		mv = new ModelAndView();//화면으로 데이터 전송.
		String msg=null;
		String view=null;
		System.out.println("비밀번호"+cpassword);
		if(cpassword==""){
			System.out.println("비밀번호 없음");
			view="redirect:/";
			rttr.addFlashAttribute("msg", "성공적으로 저장하였습니다.");
		}
		else {
			System.out.println("비밀번호 있음");
		BCryptPasswordEncoder pwdEncoder =
				new BCryptPasswordEncoder();

		//위의 인코더를 사용하여 평문 비밀번호를 
		//암호 비밀번호로 변경

		MemberDto m = (MemberDto)session.getAttribute("mb");

		String encPwd = pwdEncoder.encode(cpassword);

		HashMap<String,Object> rmap=new HashMap<>();
		rmap.put("cpassword", encPwd);
		System.out.println(cpassword);
		rmap.put("m", m.getM_id());
		System.out.println(m.getM_id());
		try {
			mDao.changepass(rmap);
			//리다이렉트로 화면을 전환.
			view = "redirect:/";
			rttr.addFlashAttribute("msg", "비밀번호를 성공적으로 변경하였습니다.");
		}catch(Exception e){
			e.printStackTrace();
			view = "redirect:/myInfoUp";
			rttr.addFlashAttribute("msg", "비밀번호 변경을 실패하였습니다.");
		}
		}
		mv.setViewName(view);
		return mv;

	}

	public String delete(String nk, RedirectAttributes rttr) {
		String msg=null;
		String view=null;

		try {
			mDao.deleterp(nk);
			session.invalidate();
			view="redirect:/";
			rttr.addFlashAttribute("msg","탈퇴를 성공적으로 하였습니다.");


		}catch (Exception e) {
			// DB삽입
			e.printStackTrace();
			view="redirect:myInfoUp";
			rttr.addFlashAttribute("msg","탈퇴를 실패하였습니다.");
		}

		return view;

	}

	public String fileup(MultipartHttpServletRequest multi) throws IllegalStateException, IOException {
		MemberDto member=new MemberDto();
		Map<String,String> fmap=new HashMap<String,String>();
		MemberDto m = (MemberDto)session.getAttribute("mb");
		String mr = m.getM_id();
		//파일 정보 저장(DB)에 필요한 정보
		//1. 게시글 번호, 2.실제파일명, 3. 저장파일명
		fmap.put("m",m.getM_id());
		List<MultipartFile> fList = multi.getFiles("file");
		String view=null;
		String filePath=multi.getSession()
				.getServletContext()
				.getRealPath("/")+"resources/images/";
		String sysName=null;
		
		for(int i=0;i<fList.size();i++) {
			MultipartFile mf=fList.get(i);
			//파일의 실제 이름 가져오기
			String oriName = mf.getOriginalFilename();
			fmap.put("oriFileName",oriName);
			//실제 파일명을 맵에 저장
			//로그에 찍어서 확인
			sysName = System.currentTimeMillis()+"."+oriName.substring(oriName.lastIndexOf(".")+1);
			fmap.put("sysFileName",sysName);
			mf.transferTo(new File(filePath+sysName));
			mDao.fileInsert(fmap);
			member=mDao.getMemIn(mr);
		}
		System.out.println(member);
		session.setAttribute("mb",member);
		view="resources/images/"+sysName;
		return view;
	}

	public String filedel() {
		String view=null;
		MemberDto member=new MemberDto();
		Map<String,String> fmap=new HashMap<String,String>();
		MemberDto m = (MemberDto)session.getAttribute("mb");
		String mr = m.getM_id();
		String nick = m.getM_nickname();
		System.out.println(nick);
		mDao.fileDelete(nick);
		member=mDao.getMemIn(mr);
		session.setAttribute("mb",member);
		
		view="resources/images/기본이미지.png";
		return view;
	}

	public ModelAndView findId(String name,String phonenum, RedirectAttributes rttr) {
		mv = new ModelAndView();//화면으로 데이터 전송.
		String msg = null;//화면에 출력할 메시지
		String view = null;//이동할 jsp 이름 저장 변수.
		Map<String,String> rmap=new HashMap<String,String>();
		rmap.put("name", name);
		rmap.put("phonenum", phonenum);
		try {
			//이름과 전화번호를 가지고 select
			MemberDto member=mDao.Idfind(rmap);
			session.setAttribute("mb", member);
			//아이디찾기 성공 -> 아이디 찾는 화면 전환
			view = "redirect:comIdFrm";
			rttr.addFlashAttribute("msg","아이디찾기 성공.");
		} catch (Exception e) {
			// 아이디 찾기 실패 -> 아이디찾기 창으로 감
			//e.printStackTrace();
			view = "redirect:findIdFrm";
			rttr.addFlashAttribute("msg","일치하는 정보가 없습니다.");
		}
		
		mv.setViewName(view);
		return mv;
	}

	public ModelAndView pwfind(String name, String mid, RedirectAttributes rttr) {
		mv = new ModelAndView();//화면으로 데이터 전송.
		String msg = null;//화면에 출력할 메시지
		String view = null;//이동할 jsp 이름 저장 변수.
		try {
			MemberDto member=mDao.pwfind(mid);
			session.setAttribute("mb", member);
			System.out.println(member.getM_name());
			if(member.getM_name().equals(name)){
				view = "redirect:rePwFrm";
				rttr.addFlashAttribute("msg","비밀번호 변경 화면으로 전환 됩니다.");
			}
			else {
				view = "redirect:findPwFrm";
				rttr.addFlashAttribute("msg","일치하는 정보가 없습니다.");
			}
		}catch(Exception e) {
			view = "redirect:findPwFrm";
			rttr.addFlashAttribute("msg","일치하는 정보가 없습니다.");
		}
		mv.setViewName(view);
		return mv;
	}

	public String pwch(String pw, String pwcheck, RedirectAttributes rttr) {
		String msg = null;//화면에 출력할 메시지
		String view = null;//이동할 jsp 이름 저장 변수.
		BCryptPasswordEncoder pwdEncoder =
				new BCryptPasswordEncoder();

		//위의 인코더를 사용하여 평문 비밀번호를 
		//암호 비밀번호로 변경

		MemberDto m = (MemberDto)session.getAttribute("mb");

		String encPwd = pwdEncoder.encode(pwcheck);

		HashMap<String,Object> rmap=new HashMap<>();
		rmap.put("pwcheck", encPwd);
		System.out.println(pwcheck);
		rmap.put("m", m.getM_id());
		System.out.println(m.getM_id());
		if(pw.equals(pwcheck)) {
			try {
				mDao.pwch(rmap);
				session.invalidate();
				view = "redirect:comPwFrm";
				rttr.addFlashAttribute("msg","비밀번호를 성공적으로 변경하였습니다.");
			}catch(Exception e) {
				view = "redirect:rePwFrm";
				rttr.addFlashAttribute("msg","비밀번호 변경을 실패했습니다.");
			}
		}else {
			view = "redirect:rePwFrm";
			rttr.addFlashAttribute("msg","비밀번호가 일치하지 않습니다.");
		}
		return view;
	}

	public String fpw() {
		//세션 정보 지우기
		session.invalidate();

		return "findPwFrm";
	}

	public String jo() {
		//세션 정보 지우기
		session.invalidate();

		return "loginFrm";
	}

	public Map<String, String> sendmail(String email) throws IOException{
		  Random r = new Random();
		  int dice = r.nextInt(4589362) + 49311; //이메일로 받는 인증코드 부분 (난수)
        
          String setfrom = "1223seho@gmail.com";
          String tomail = email; // 받는 사람 이메일
          System.out.println(email);
          String title = "에디튜브 인증 이메일 입니다."; // 제목
          String content =
          
          System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성
          
          System.getProperty("line.separator")+
                  
          "안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"
          
          +System.getProperty("line.separator")+
          
          System.getProperty("line.separator")+
  
          " 인증번호는 " +dice+ " 입니다. "
          
          +System.getProperty("line.separator")+
          
          System.getProperty("line.separator")+
          
          "받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
          
          
          try {
              MimeMessage message = mailSender.createMimeMessage();
              MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                      true, "UTF-8");
  
              messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
              System.out.println("보낸사람: "+setfrom);
              messageHelper.setTo(tomail); // 받는사람 이메일
              System.out.println("받는사람: "+tomail);
              messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
              System.out.println("제목: "+title);
              messageHelper.setText(content); // 메일 내용
              System.out.println(content);
              
              mailSender.send(message);
              System.out.println("메시지: "+message);
          } catch (Exception e) {
              System.out.println(e);
          }
  
          Map<String, String> rmap = new HashMap<String, String>();
          rmap.put("result", "이메일이 발송되었습니다. 인증번호를 입력해주세요.");
          rmap.put("dice", String.valueOf(dice));
          return rmap;
        
    }

	public ModelAndView mMember() {
		ModelAndView mv=new ModelAndView();
		String msg = null;//화면에 출력할 메시지
		String view = null;//이동할 jsp 이름 저장 변수.
		MemberDto m = (MemberDto)session.getAttribute("mb");
		String nick=m.getM_nickname();
		try {
			List<MemberDto> mList =mDao.allmem(nick);
			System.out.println(mList);
			mv.addObject("mList", mList);
			
			view = "./mMember";
		}catch(Exception e) {
			view = "redirect:mDeal";
		}
		mv.setViewName(view);
		
		return mv;
	}
	
	@Transactional
	public String mdelete(String m_nickname, RedirectAttributes rttr) {
		String msg = null;//화면에 출력할 메시지
		String view = null;//이동할 jsp 이름 저장 변수.
		try {
			mDao.mdelete(m_nickname);
			view="redirect:Member";
			rttr.addFlashAttribute("msg","성공적으로 회원을 제명했습니다.");
		}catch(Exception e){
			view="redirect:Member";
			rttr.addFlashAttribute("msg","회원 제명을 실패하였습니다.");
		}
		return view;
	}

	public ModelAndView dateSearch(MemberDto member,memsearchDto memsea) {
		mv = new ModelAndView();
		String view = null;//이동할 jsp 이름 저장 변수.
		
		if(memsea.getReqDateend()==null) {
			Date date = new Date();
			Date date2 = new Date();
			memsea.setReqDateend(date2);

			date.setYear(-1000);
			memsea.setReqDatestart(date);
		}
		else if(memsea.getReqDatestart()==null) {
			Date date = new Date();
			Date date2 = new Date();
			memsea.setReqDateend(date2);

			date.setYear(-1000);
			memsea.setReqDatestart(date);
		}
		
		Map<String, String> lmap = new HashMap<String, String>();
		MemberDto m = (MemberDto)session.getAttribute("mb");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	      int d = memsea.getReqDateend().getDate() + 1;
	      memsea.getReqDateend().setDate(d);
	      lmap.put("sDate", sdf.format(memsea.getReqDatestart()));
	      lmap.put("eDate", sdf.format(memsea.getReqDateend()));
	    List<MemberDto> mList = mDao.searchmem(lmap);
	    mv.addObject("mList", mList);
	    view = "./mMember";
	    mv.setViewName(view);
	      
		return mv;
	}
	
	//관리자 페이지 회원 관리에서 닉네임 검색하는 매소드
	public ModelAndView dealMemNickSearch(String searchNick) {

		ModelAndView mv=new ModelAndView();
		String msg = null;//화면에 출력할 메시지
		String view = null;//이동할 jsp 이름 저장 변수.

		MemberDto m = (MemberDto)session.getAttribute("mb");
		String nick=m.getM_nickname();

		Map<String, String> lmap = new HashMap<String, String>();
		 lmap.put("nick", m.getM_nickname());
		 lmap.put("searchNick", searchNick);
		
		try {
				
			List<MemberDto> mList =mDao.dealMemNickSearch(lmap);
			System.out.println(mList);
			mv.addObject("mList", mList);

			view = "./mMember";
		}catch(Exception e) {
			view = "redirect:mDeal";
		}
		mv.setViewName(view);

		return mv;
	}
	
	
	
	//혜명메소드
	@Transactional
	public ModelAndView goReq(Integer bnum, String nick) {
		mv = new ModelAndView();
		RequestDto request = new RequestDto();
		EBoardDto eDto = new EBoardDto();
		MemberDto member = (MemberDto)session.getAttribute("mb");
		String view = null;
		
		request.setRq_mnickname(member.getM_nickname());
		request.setRq_status(2);
		request.setRq_targetnickname(nick);
		//포트폴리오에는 bnum이 없으므로 반드시 파라미터값에 0을 넣어줘야한다.
		request.setRq_bnum(bnum);
		
		if(member.getM_usertype()==1) {
			request.setRq_targetstatus(1);
			request.setRq_type(1);
		}
		else {
			request.setRq_targetstatus(1);
			request.setRq_type(2);
		}
		if(bnum==0) {
	         try {
	            //포트폴리오 정보를 받아오는 메소드
	            eDto = mDao.getPNum(request.getRq_targetnickname());

		} catch (Exception e) {
			
		}
	    }
		
		try {
			mDao.goReq(request);
			if(bnum==0) {
				view= "redirect:pcontents?pnum="+eDto.getPnum();
			}else {
				view= "redirect:utcontent?ubnum="+request.getRq_bnum();				
			}
		}catch (Exception e) {
			if(bnum==0) {
				view= "redirect:pcontents?pnum="+eDto.getPnum();
			}else {
				view= "redirect:utcontent?ubnum="+request.getRq_bnum();				
			}
		}
		
		mv.setViewName(view);
		return mv;
	}
	
	public ModelAndView getReqList(Integer status,Integer PageNum) {
		mv = new ModelAndView();
		RequestDto request = new RequestDto();
		List<RequestDto> reqList = null;
		MemberDto member = (MemberDto)session.getAttribute("mb");
		String nickname = member.getM_nickname();
		
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("nickname", String.valueOf(nickname));
		lmap.put("status", String.valueOf(status));
		
		if(status==null) {
			//전체보기를 클릭했을때 거래상태에 상관없이 모든 리스트를 가져옴
			reqList = mDao.getAllReqList(nickname);
			//리스트를 한개씩 불러와서 메시지 출력문을 List에 저장해주는 메소드
			for(int i=0; i<reqList.size();i++) {
				request=reqList.get(i);
				//게시글의 주인이 나일때
				if(request.getRq_mnickname().equals(member.getM_nickname())) {
					//메시지 저장 메소드에서 해당 거래상태에 따른 메시지 불러오기
					InsertMsg(request.getRq_status());
					//Dto에 불러온 메시지 저장
					request.setRq_msg(request.getRq_targetnickname()+InsertMsg(request.getRq_status()));					
				}
				//게시글의 주인이 상대방일때
				else {
					//메시지 저장 메소드에서 해당 거래상태에 따른 메시지 불러오기
					InsertMsg(request.getRq_targetstatus());
					//Dto에 불러온 메시지 저장
					request.setRq_msg(request.getRq_mnickname()+InsertMsg(request.getRq_targetstatus()));		
				}
				//해당 게시글에 후기를 남겼나 확인하는 메소드
				request.setRq_chk(mDao.getRatChk(request.getRq_num()));
			}
			mv.addObject("reqList", reqList);
		}
		else {		
			reqList = mDao.getReqList(lmap);
			for(int i=0; i<reqList.size();i++) {
				request=reqList.get(i); 
				if(request.getRq_mnickname().equals(member.getM_nickname())) {
					InsertMsg(request.getRq_status());
					request.setRq_msg(request.getRq_targetnickname()+InsertMsg(request.getRq_status()));					
				}
				else {
					InsertMsg(request.getRq_targetstatus());
					request.setRq_msg(request.getRq_mnickname()+InsertMsg(request.getRq_targetstatus()));		
				}
				//해당 게시글에 후기를 남겼나 확인하는 메소드
				request.setRq_chk(mDao.getRatChk(request.getRq_num()));
			}
			mv.addObject("reqList", reqList);
		}
		System.out.println("zzzzzzzzzzzzzzzzzzzzz"+PageNum);
		if(PageNum==1) {
			mv.setViewName("myUPageReqM");
		}else {
			mv.setViewName("myEPageReqM");
		}
		
		return mv;   
	}
	
	public String InsertMsg(Integer num) {
		String msg =null;
		
		if(num==1) {
			msg="님이 거래를 요청했습니다.";
		}
		else if(num==2){
			msg="님에게 거래요청을 보냈습니다.";
		}				
		else if(num==3){
			msg="님과 거래중입니다.";
		}
		else if(num==4){
			msg="님의 완료요청을 대기중입니다.";
		}
		else if(num==5){
			msg="님의 완료요청이 도착했습니다.";
		}
		else if(num==6){
			msg="님과의 거래가 취소요청중 입니다.";
		}
		else if(num==7){
			msg="님과의 거래가 완료됬습니다.";
		}
		else if(num==8){
			msg="님과의 거래가 취소되었습니다.";	
		}
		return msg;
	}
	
	@Transactional
	public ModelAndView statusChange(Integer rnum, Integer myNum, String rtnick, Integer targetNum) {
		mv = new ModelAndView();
		RequestDto rDto = new RequestDto();
		EBoardDto eDto = new EBoardDto();
		UBoardDto uDto = new UBoardDto();
		
		MemberDto member = (MemberDto)session.getAttribute("mb");
		String view = null;
		
		rDto.setRq_num(rnum);
		rDto.setRq_status(myNum);
		rDto.setRq_targetstatus(targetNum);
		System.out.println("체인지 되는 번호 넘버" + myNum + targetNum);
		
		//스테이터스를 바꾸는 메소드
		try {
			mDao.statusChange(rDto);
			view= "redirect:myEPageReqM";
			System.out.println("스테이터스 바꾸기 성공");
		} catch (Exception e) {
			view= "redirect:myEPageReqM";
			System.out.println("스테이터스 바꾸기 실패");
		}
		
		//거래진행중으로 넘어가는 상황일때 유튜버의 돈을 빼서 관리자에게 넘어오게 하는 분기처리
		if(myNum==3) {
			//현재 거래중인 타입 불러오기 1.유튜버가 에디터에게 거래요청 2.에디터가 유튜버에게 거래요청
			rDto=mDao.chkStatus(rnum);
			
			System.out.println("게시글의 거래값 : " + rDto.getRq_bnum());
			
			try {
				System.out.println("try입장");
				if(rDto.getRq_type()==1) {
					//1번타입일 경우 포트폴리오에서 가격을 가져옴
					eDto = mDao.getPortCash(rDto.getRq_targetnickname());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					lmap.put("nick", String.valueOf(rDto.getRq_mnickname()));
					lmap.put("cost", String.valueOf( eDto.getPcost()));
					lmap.put("cancel",String.valueOf(1));
					
					//1번타입일 경우 유튜버(mnickname)의 돈을 관리자에게 넘김
					mDao.CashGoMaster(lmap);
					
					member = mDao.getMemInfo(member.getM_id());
					session.setAttribute("mb", member);
				
				}else {
					//2번타입일 경우 유튜버컨텐츠에서 가격을 가져옴
					System.out.println("22222번입잡");
					uDto = mDao.getUCash(rDto.getRq_bnum());
					System.out.println("돈가져오기 성공"+uDto.getUbcost());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					lmap.put("nick", String.valueOf(rDto.getRq_targetnickname()));
					lmap.put("cost", String.valueOf(uDto.getUbcost()));
					lmap.put("cancel",String.valueOf(1));
					
					//2번타입일 경우 유튜버(targetnickname)의 돈을 관리자에게 넘김
					mDao.CashGoMaster(lmap);
					
					member = mDao.getMemInfo(member.getM_id());
					session.setAttribute("mb", member);
					
				}
				System.out.println("돈보내기 성공");
			} catch (Exception e) {
				System.out.println("관리자에게 돈넘기기 실패");
			}
		
		}
		
		if(myNum == 7) {
			//현재 거래중인 타입 불러오기 1.유튜버가 에디터에게 거래요청 2.에디터가 유튜버에게 거래요청
			rDto=mDao.chkStatus(rnum);
			
			System.out.println("게시글의 거래값 : " + rDto.getRq_bnum());
			
			try {
				System.out.println("try입장");
				if(rDto.getRq_type()==1) {
					//1번타입(유튜버 => 에디터(타겟))일 경우 포트폴리오에서 가격을 가져옴
					//포트폴리오는 인당 1게시물이기 때문에 닉네임 만으로도 충분
					eDto = mDao.getPortCash(rDto.getRq_targetnickname());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					//에디터닉네임
					lmap.put("nick", String.valueOf(rDto.getRq_targetnickname()));
					//현재상품의 가격
					lmap.put("cost", String.valueOf(eDto.getPcost()));
					lmap.put("cancel",String.valueOf(1));
					//1번타입일 경우 관리자의 돈을 에디터에게 넘김
					mDao.CashGoEdit(lmap);
				}else {
					//2번타입일 경우 유튜버컨텐츠에서 가격을 가져옴
					System.out.println("22222번입잡");
					uDto = mDao.getUCash(rDto.getRq_bnum());
					System.out.println("돈가져오기 성공"+uDto.getUbcost());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					//에디터닉네임
					lmap.put("nick", String.valueOf(rDto.getRq_mnickname()));
					//현재상품의 가격
					lmap.put("cost", String.valueOf(uDto.getUbcost()));
					lmap.put("cancel",String.valueOf(1));
					//2번타입일 경우 관리자의 돈을 에디터에게 넘김
					mDao.CashGoEdit(lmap);
				}
				System.out.println("돈보내기 성공");
				System.out.println("메시지삭제중");
				
				Map<String, String> cmap = new HashMap<String, String>();
				cmap.put("nick", String.valueOf(rDto.getRq_mnickname()));
				cmap.put("tnick", String.valueOf(rDto.getRq_targetnickname()));
				
				mDao.deleteChat(cmap);
				System.out.println("메시지삭제성공");
			} catch (Exception e) {
				System.out.println("관리자에게 돈넘기기 실패");
			}
		}
		
		if(myNum == 8) {
			//현재 거래중인 타입 불러오기 1.유튜버가 에디터에게 거래요청 2.에디터가 유튜버에게 거래요청
			rDto=mDao.chkStatus(rnum);
			
			System.out.println("게시글의 거래값 : " + rDto.getRq_bnum());
			
			try {
				System.out.println("try입장");
				if(rDto.getRq_type()==1) {
					//1번타입일 경우 포트폴리오에서 가격을 가져옴
					eDto = mDao.getPortCash(rDto.getRq_targetnickname());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					//에디터닉네임
					lmap.put("nick", String.valueOf(rDto.getRq_mnickname()));
					//현재상품의 가격
					lmap.put("cost", String.valueOf( eDto.getPcost()));
					lmap.put("cancel",String.valueOf(2));
					//1번타입일 경우 관리자의 돈을 유튜버에게 넘김
					mDao.CashGoEdit(lmap);
					
					member = mDao.getMemInfo(member.getM_id());
					session.setAttribute("mb", member);
				}else {
					//2번타입일 경우 유튜버컨텐츠에서 가격을 가져옴
					System.out.println("22222번입잡");
					uDto = mDao.getUCash(rDto.getRq_bnum());
					System.out.println("돈가져오기 성공"+uDto.getUbcost());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					//에디터닉네임
					lmap.put("nick", String.valueOf(rDto.getRq_targetnickname()));
					//현재상품의 가격
					lmap.put("cost", String.valueOf(uDto.getUbcost()));
					lmap.put("cancel",String.valueOf(2));
					//2번타입일 경우 관리자의 돈을 유튜버에게 넘김
					mDao.CashGoEdit(lmap);
					
					member = mDao.getMemInfo(member.getM_id());
					session.setAttribute("mb", member);
					
				}
				System.out.println("돈보내기 성공");
				
				System.out.println("돈보내기 성공");
				System.out.println("메시지삭제중");
				
				Map<String, String> cmap = new HashMap<String, String>();
				cmap.put("nick", String.valueOf(rDto.getRq_mnickname()));
				cmap.put("tnick", String.valueOf(rDto.getRq_targetnickname()));
				
				mDao.deleteChat(cmap);
				
				member = mDao.getMemInfo(member.getM_id());
				session.setAttribute("mb", member);
			} catch (Exception e) {
				System.out.println("관리자에게 돈넘기기 실패");
			}
		}
		

		mv.setViewName(view);
		return mv;
	}

	@Transactional
	public ModelAndView InsertRatFrm(RatingDto rating, RedirectAttributes rttr) {
		mv = new ModelAndView();
		RatingDto raDto = new RatingDto();
		String view = null;
		log.info("boardInsert - filecheck: " + 
			rating.getM_nickname()+
			rating.getRa_content()+
			rating.getRa_nickname()+
			rating.getRa_score()
		);
		
		try {
			mDao.InsertRatFrm(rating);
			view= "redirect:myEPageReqM";
		}catch (Exception e) {
			view="redirect:myEPageReqM";
		}
		
		mv.setViewName(view);
		return mv;
	}

	public ModelAndView getmDeal() {
		mv= new ModelAndView();
		List<RequestDto> rDto = null;
		
		try {
			rDto = mDao.getmDeal(6);
			mv.addObject("rMList",rDto);
		} catch (Exception e) {
			
		}
		
		mv.setViewName("mDeal");
		return mv;
	}
	
	
	@Transactional
	public void cancelOk(Integer rnum, Integer conNum) {
		//관리자 취소요청 메소드
		RequestDto rDto = new RequestDto();
		EBoardDto eDto = new EBoardDto();
		UBoardDto uDto = new UBoardDto();
		
		if(conNum==1) {
			//수락요청처리
			rDto.setRq_num(rnum);
			rDto.setRq_status(8);
			rDto.setRq_targetstatus(8);
		}else {
			//거절요청처리
			rDto.setRq_num(rnum);
			rDto.setRq_status(3);
			rDto.setRq_targetstatus(3);
		}
		
		try {
			mDao.statusChange(rDto);
		} catch (Exception e) {
			System.out.println("업데이트에 실패하였습니다.");
		}
		
		//현재 거래중인 타입 불러오기 1.유튜버가 에디터에게 거래요청 2.에디터가 유튜버에게 거래요청
			rDto=mDao.chkStatus(rnum);

			
			System.out.println("게시글의 거래값 : " + rDto.getRq_bnum());
		if(rDto.getRq_status()==8) {
			
			try {
				System.out.println("try입장");
				if(rDto.getRq_type()==1) {
					//1번타입일 경우 포트폴리오에서 가격을 가져옴
					eDto = mDao.getPortCash(rDto.getRq_targetnickname());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					//에디터닉네임
					lmap.put("nick", String.valueOf(rDto.getRq_targetnickname()));
					//현재상품의 가격
					lmap.put("cost", String.valueOf( eDto.getPcost()));
					lmap.put("cancel",String.valueOf(2));
					//1번타입일 경우 관리자의 돈을 에디터에게 넘김
					mDao.CashGoEdit(lmap);
				}else {
					//2번타입일 경우 유튜버컨텐츠에서 가격을 가져옴
					System.out.println("22222번입잡");
					uDto = mDao.getUCash(rDto.getRq_bnum());
					System.out.println("돈가져오기 성공"+uDto.getUbcost());
					
					Map<String, String> lmap = 
							new HashMap<String, String>();
					//에디터닉네임
					lmap.put("nick", String.valueOf(rDto.getRq_mnickname()));
					//현재상품의 가격
					lmap.put("cost", String.valueOf(uDto.getUbcost()));
					lmap.put("cancel",String.valueOf(2));
					//2번타입일 경우 관리자의 돈을 에디터에게 넘김
					mDao.CashGoEdit(lmap);
				}
				System.out.println("돈보내기 성공");
			} catch (Exception e) {
				System.out.println("관리자에게 돈넘기기 실패");
			}
		}
		
		
	} //메소드끝


	
	
	
	//지혜부분
	//캐시 충전
	@Transactional
	public ModelAndView chargingList(CashDto cash, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;
		MemberDto member = (MemberDto)session.getAttribute("mb");
		try {
			mDao.chargingList(cash);
			
			cash.setM_mycash(getMyCash(cash));	
				
			mDao.countMyCash(cash);
			
			CashDto cDto = new CashDto();
			member = mDao.getMemInfo(member.getM_id());
			session.setAttribute("mb", member);
									
			//맵을 만들어서 페이지번호와 글목록 개수를 저장
			Map<String, String> lmap = 
					new HashMap<String, String>();
			lmap.put("nick", String.valueOf(member.getM_nickname()));		
			
			List<CashDto> cashList = mDao.getCashList(lmap);
			
			for(int i = 0 ; i<cashList.size(); i++) {
				cDto = cashList.get(i);
				
				if(cDto.getCa_incash()==0) {
					if(cDto.getCa_targetnickname()==null) {
						cDto.setCa_type(2);
					}
					else {
						cDto.setCa_type(3);
					}
				}else {
					if(cDto.getCa_targetnickname()==null) {
						
						if(cDto.getCa_cancel()==2) {
							cDto.setCa_type(5);
						}
						else {
						cDto.setCa_type(1);
						}
					}
					
					else {
						if(cDto.getCa_cancel()==2) {
							cDto.setCa_type(5);
						}
						else {
							cDto.setCa_type(4);
						}
					}
				}
			}
			
			mv.addObject("cashList", cashList);
			rttr.addFlashAttribute("msg", "충전 됐으요");

		} catch (Exception e) {
			
			view = "redirect:myEPageCash";
			rttr.addFlashAttribute("msg", "충전 실패");
		}
		
		//view name을 지정!
		mv.setViewName("myEPageCash");
		return mv;
	}
	
	//캐시환전
	public ModelAndView changemoney(CashDto cash, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;
		MemberDto member = (MemberDto)session.getAttribute("mb");
		try {
			mDao.changemoney(cash);
			
			
			cash.setM_mycash(getMyCash(cash));	
			System.out.println(cash);
			mDao.countMyCash(cash);
						
			member = mDao.getMemInfo(member.getM_id());
			session.setAttribute("mb", member);
			
			CashDto cDto = new CashDto();
			
							
			//맵을 만들어서 페이지번호와 글목록 개수를 저장
			Map<String, String> lmap = 
					new HashMap<String, String>();
			lmap.put("nick", String.valueOf(member.getM_nickname()));		
			
			List<CashDto> cashList = mDao.getCashList(lmap);
			
			for(int i = 0 ; i<cashList.size(); i++) {
				cDto = cashList.get(i);
				
				if(cDto.getCa_incash()==0) {
					if(cDto.getCa_targetnickname()==null) {
						cDto.setCa_type(2);
					}
					else {
						cDto.setCa_type(3);
					}
				}else {
					if(cDto.getCa_targetnickname()==null) {
						
						if(cDto.getCa_cancel()==2) {
							cDto.setCa_type(5);
						}
						else {
						cDto.setCa_type(1);
						}
					}
					
					else {
						if(cDto.getCa_cancel()==2) {
							cDto.setCa_type(5);
						}
						else {
							cDto.setCa_type(4);
						}
					}
				}
			}
			mv.addObject("cashList", cashList);
			rttr.addFlashAttribute("msg", "환전 성공");

		} catch (Exception e) {
			
			view = "redirect:myEPageCash";
			rttr.addFlashAttribute("msg", "환전 실패");
		}
		
		//view name을 지정!
		mv.setViewName("myEPageCash");
		return mv;
	}
	
	public int getMyCash(CashDto cash) {
		
		int totalInCash = 0;
		int totalOutCash = 0;
		
		Integer tic = mDao.getTotalInCash(cash);
		Integer toc = mDao.getTotalOutCash(cash);
		
		totalInCash = (tic==null)? 0: tic;
		totalOutCash = (toc==null)? 0: toc;

		System.out.println("전체지출 : " + totalOutCash);
		System.out.println("전체수입 : " + totalInCash);
		
		MyCash = totalInCash - totalOutCash;
		System.out.println("보유캐쉬 : " + MyCash);
						
		return MyCash;
	}
	
	public ModelAndView getCashList(String nick) {
		log.info("getCashList()");
		
			
		CashDto cDto = new CashDto();
		mv = new ModelAndView();
		MemberDto member = (MemberDto)session.getAttribute("mb");
		
		
		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("nick", String.valueOf(member.getM_nickname()));		
		
		List<CashDto> cashList = mDao.getCashList(lmap);
		for(int i = 0 ; i<cashList.size(); i++) {
			cDto = cashList.get(i);
			
			if(cDto.getCa_incash()==0) {
				if(cDto.getCa_targetnickname()==null) {
					cDto.setCa_type(2);
				}
				else {
					cDto.setCa_type(3);
				}
			}else {
				if(cDto.getCa_targetnickname()==null) {
					
					if(cDto.getCa_cancel()==2) {
						cDto.setCa_type(5);
					}
					else {
					cDto.setCa_type(1);
					}
				}
				
				else {
					if(cDto.getCa_cancel()==2) {
						cDto.setCa_type(5);
					}
					else {
						cDto.setCa_type(4);
					}
				}
			}
		}
		mv.addObject("cashList", cashList);

		//view name을 지정!
		mv.setViewName("myEPageCash");

		return mv;
	}
	
	public ModelAndView cashSearch(CashDateDto cd) {
	      log.info("cashSearch()");
	      CashDto cDto = new CashDto();
	      mv = new ModelAndView();
	      
	      if(cd.getEDate()==null) {
				Date date = new Date();
				Date date2 = new Date();
				cd.setEDate(date2);

				date.setYear(-1000);
				cd.setSDate(date);
			}
			else if(cd.getSDate()==null) {
				Date date = new Date();
				Date date2 = new Date();
				cd.setEDate(date2);

				date.setYear(-1000);
				cd.setSDate(date);
			}
	      
	      MemberDto member = (MemberDto)session.getAttribute("mb");
	               
	      //맵을 만들어서 페이지번호와 글목록 개수를 저장
	      Map<String, String> lmap = new HashMap<String, String>();
	      lmap.put("nick", String.valueOf(member.getM_nickname()));
	      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	      int d = cd.getEDate().getDate() + 1;
	      cd.getEDate().setDate(d);
	      lmap.put("sDate", sdf.format(cd.getSDate()));
	      lmap.put("eDate", sdf.format(cd.getEDate()));
	            
	      List<CashDto> cashList = mDao.cashSearch(lmap);
	      
	  	for(int i = 0 ; i<cashList.size(); i++) {
			cDto = cashList.get(i);
			
			if(cDto.getCa_incash()==0) {
				if(cDto.getCa_targetnickname()==null) {
					cDto.setCa_type(2);
				}
				else {
					cDto.setCa_type(3);
				}
			}else {
				if(cDto.getCa_targetnickname()==null) {
					
					if(cDto.getCa_cancel()==2) {
						cDto.setCa_type(5);
					}
					else {
					cDto.setCa_type(1);
					}
				}
				
				else {
					if(cDto.getCa_cancel()==2) {
						cDto.setCa_type(5);
					}
					else {
						cDto.setCa_type(4);
					}
				}
			}
		}
	      mv.addObject("cashList", cashList);

	      //view name을 지정!
	      mv.setViewName("myEPageCash");

	      return mv;
	   }

}