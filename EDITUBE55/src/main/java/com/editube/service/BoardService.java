package com.editube.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.editube.dao.CBoardDao;
import com.editube.dto.CReplyDto;
import com.editube.dto.ChatbotDto;
import com.editube.dao.BoardDao;
import com.editube.dao.MemberDao;
import com.editube.dto.BfileDto;
import com.editube.dto.EBoardDto;
import com.editube.dto.UBoardDto;
import com.editube.dto.UScriptDto;
import com.editube.dto.CBoardDto;
import com.editube.dto.MemberDto;
import com.editube.dto.QnaDto;
import com.editube.dto.RatingDto;
import com.editube.dto.ReplyDto;
import com.editube.dto.RequestDto;
import com.editube.util.Paging;

import lombok.extern.java.Log;

@Service
@Log
public class BoardService {
	//DAO 객체
	@Autowired
	private BoardDao bDao;
	@Autowired
	private MemberDao mDao;
	@Autowired
	private CBoardDao cbDao;

	//데이터 전달 객체 : ModelAndView
	ModelAndView mv;

	//세션
	@Autowired
	private HttpSession session;

	//페이지 당 글 개수 조정 변수
	private int listCount = 10;
	private int pageCount = 5;


	public ModelAndView doubleYoutubeTBoarda(String ubpositiontype,Integer pageNum) {
		System.out.println("ubpositiontype-"+ ubpositiontype);
		mv=new ModelAndView();

		if(ubpositiontype == null)
			ubpositiontype="게임 방송";

		EBoardDto eDto = new EBoardDto();

		int num = (pageNum == null) ? 1 : pageNum;

		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		Map<String, String> emap = 
				new HashMap<String, String>();
		emap.put("pageNum", String.valueOf(num));
		emap.put("cnt", String.valueOf(3));
		emap.put("pstatus", ubpositiontype);

		List<EBoardDto> pList = bDao.getPList(emap);   
		mv.addObject("pList", pList);


		Map<String, String> lmap = new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(5));
		lmap.put("ubpositiontype", ubpositiontype);
		List<UBoardDto> utList = bDao.getTDList(lmap);

		mv.addObject("utList", utList);

		String paging = getUDTPaging(num, ubpositiontype);
		mv.addObject("paging", paging);
		mv.addObject("sort", "작성일순");
		String ubname = null;
		mv.addObject("ubname", ubname);
		mv.addObject("ubpositiontype", ubpositiontype);
		session.setAttribute("pageNum", num);

		mv.setViewName("doubleBoard");
		return mv;
	}

	public ModelAndView getYoutubeTBoardasc(Integer pageNum, String status, String nickname) {
		mv=new ModelAndView();

		MemberDto member = (MemberDto)session.getAttribute("mb");
		
		if(status == null)
			status="건별편집";

		int num = (pageNum == null) ? 1 : pageNum;

		Map<String, String> lmap = new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));
		lmap.put("status", status);
		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		List<UBoardDto> utList = bDao.getTListasc(lmap);

		mv.addObject("utList", utList);

		String paging = getUTPagingSc(num, status);
		mv.addObject("paging", paging);
		mv.addObject("sort", "작성일순");
		mv.addObject("status", status);
		session.setAttribute("pageNum", num);

		mv.setViewName("myEPageSc");
		return mv;
	}
	public ModelAndView getYoutubeTBoardbsc(Integer pageNum, String status, String nickname) {
		mv=new ModelAndView();
		
		MemberDto member = (MemberDto)session.getAttribute("mb");

		if(status == null)
			status="정기편집";

		int num = (pageNum == null) ? 1 : pageNum;

		Map<String, String> lmap = new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));
		lmap.put("status", status);
		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		List<UBoardDto> utList = bDao.getTListbsc(lmap);

		mv.addObject("utList", utList);

		String paging = getUTPagingSc(num, status);
		mv.addObject("paging", paging);
		mv.addObject("sort", "작성일순");
		mv.addObject("status", status);
		session.setAttribute("pageNum", num);

		mv.setViewName("myEPageSc");
		return mv;
	}
	
	   public ModelAndView getYoutubeTBoarda(String ubpositiontype,Integer pageNum, String status) {
		      System.out.println("ubpositiontype-"+ ubpositiontype);
		      mv=new ModelAndView();
		            
		      int num = (pageNum == null) ? 1 : pageNum;
		      
		      Map<String, String> lmap = new HashMap<String, String>();
		      lmap.put("pageNum", String.valueOf(num));
		      lmap.put("cnt", String.valueOf(listCount));
		      lmap.put("ubpositiontype", ubpositiontype);
		      lmap.put("status", status);
		      List<UBoardDto> utList = bDao.getTLista(lmap);
		      
		      mv.addObject("utList", utList);
		      
		      String paging = getUTPaging(num, ubpositiontype, status);
		      mv.addObject("paging", paging);
		      mv.addObject("sort", "작성일순");
		      String ubname = null;
		      mv.addObject("ubname", ubname);
		      mv.addObject("status", status);
		      mv.addObject("ubpositiontype", ubpositiontype);
		      session.setAttribute("pageNum", num);
		      
		      mv.setViewName("youtuberBoard");
		      return mv;
		   }
		   public ModelAndView getYoutubeTBoardb(String ubpositiontype,Integer pageNum, String status) {
		      System.out.println("ubpositiontype-"+ ubpositiontype);
		      mv=new ModelAndView();
		            
		      int num = (pageNum == null) ? 1 : pageNum;
		      
		      Map<String, String> lmap = new HashMap<String, String>();
		      lmap.put("pageNum", String.valueOf(num));
		      lmap.put("cnt", String.valueOf(listCount));
		      lmap.put("ubpositiontype", ubpositiontype);
		      lmap.put("status", status);
		      List<UBoardDto> utList = bDao.getTListb(lmap);
		      
		      mv.addObject("utList", utList);
		      
		      String paging = getUTPaging(num, ubpositiontype, status);
		      mv.addObject("paging", paging);
		      mv.addObject("sort", "작성일순");
		      String ubname = null;
		      mv.addObject("ubname", ubname);
		      mv.addObject("status", status);
		      mv.addObject("ubpositiontype", ubpositiontype);
		      session.setAttribute("pageNum", num);
		      
		      mv.setViewName("youtuberBoard");
		      return mv;
		   }
		   
		   public ModelAndView getYoutubeTBoard(String ubpositiontype,Integer pageNum,String status) {
		      System.out.println("ubpositiontype-"+ ubpositiontype);
		      mv=new ModelAndView();
		      
		      if(ubpositiontype == null)
		         ubpositiontype="게임 방송";
		      
		    	  status="건별편집";
		      
		      int num = (pageNum == null) ? 1 : pageNum;
		      
		      Map<String, String> lmap = new HashMap<String, String>();
		      lmap.put("pageNum", String.valueOf(num));
		      lmap.put("cnt", String.valueOf(listCount));
		      lmap.put("ubpositiontype", ubpositiontype);
		      lmap.put("status", status);
		      List<UBoardDto> utList = bDao.getTList(lmap);
		      
		      mv.addObject("utList", utList);
		      
		      String paging = getUTPaging(num, ubpositiontype, status);
		      mv.addObject("paging", paging);
		      mv.addObject("sort", "작성일순");
		      String ubname = null;
		      mv.addObject("ubname", ubname);
		      mv.addObject("ubpositiontype", ubpositiontype);
		      mv.addObject("status", status);
		      session.setAttribute("pageNum", num);
		      
		      mv.setViewName("youtuberBoard");
		      return mv;
		   }
	
	public ModelAndView getYoutubeDBoard(String ubpositiontype,Integer pageNum, String status) {
		System.out.println("ubpositiontype-"+ ubpositiontype);
		mv=new ModelAndView();

		if(ubpositiontype == null)
			ubpositiontype="게임 방송";
		
		if(status == null)
	    	  status="건별편집";

		int num = (pageNum == null) ? 1 : pageNum;

		Map<String, String> lmap = new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));
		lmap.put("ubpositiontype", ubpositiontype);
		lmap.put("status", status);
		List<UBoardDto> udList = bDao.getDList(lmap);

		mv.addObject("udList", udList);

		String paging = getUDPaging(num, ubpositiontype, status);
		mv.addObject("paging", paging);
		mv.addObject("sort", "마감일순");
		String ubname = null;
		mv.addObject("ubname", ubname);
		mv.addObject("ubpositiontype", ubpositiontype);
		mv.addObject("status", status);
		session.setAttribute("pageNum", num);

		mv.setViewName("youtuberBoard");
		return mv;
	}

	public ModelAndView getCommuBoard(Integer cbstatus,Integer pageNum) {
		System.out.println("status-"+ cbstatus);
		mv=new ModelAndView();

		if(cbstatus == null)
			cbstatus=1;

		int num=(pageNum==null) ?1: pageNum;
		Map<String, String> lmap=new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));
		lmap.put("cbstatus", String.valueOf(cbstatus));
		List<CBoardDto> cbList=cbDao.getCList(lmap);

		mv.addObject("cbList", cbList);

		String paging = getPaging(cbstatus,num);
		mv.addObject("paging", paging);
		String cbname = null;

		switch(cbstatus) {
		case 1:cbname="공지사항";
		break;
		case 2:cbname="자유게시판"; 
		break;
		case 3:cbname="합방하실분";
		break;
		case 4:cbname="섭외게시판";
		break;
		}
		mv.addObject("cbname", cbname);
		mv.addObject("cbstatus", cbstatus);
		session.setAttribute("pageNum", num);

		mv.setViewName("commuBoard");
		return mv;
	}

	private String getPaging(int cbstatus,int num) {
		int maxNum =cbDao.getCBoardCount(cbstatus);
		System.out.println("maxNum="+maxNum);
		String listName="commuBoard?cbstatus="+cbstatus;
		Paging paging = new Paging(maxNum, num, listCount, pageCount, listName);
		String pagingHtml = paging.makePaging();

		return pagingHtml;
	}
	public ModelAndView getCContent(Integer cbstatus,Integer cbnum) {
		mv= new ModelAndView();

		CBoardDto cboard = cbDao.getCContent(cbnum);
		mv.addObject("cboard", cboard);
		mv.addObject("cbstatus", cbstatus);
		List<CReplyDto> replyList = cbDao.getReplyList(cbnum);
		mv.addObject("rList",replyList);

		mv.setViewName("commuContent");
		return mv;
	}
	@Transactional
	public String cBoardInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		String view =null;
		String title =multi.getParameter("cbtitle");
		String content = multi.getParameter("cbcontent");
		String nickname= multi.getParameter("cbnickname");
		int status=Integer.parseInt(multi.getParameter("cbstatus"));
		content=content.trim();
		CBoardDto cboard =new CBoardDto();
		cboard.setCbnickname(nickname);
		cboard.setCbtitle(title);
		cboard.setCbcontent(content);
		cboard.setCbstatus(status);

		try {
			cbDao.cBoardInsert(cboard);
			view="redirect:commuContent?cbstatus="+ cboard.getCbstatus()+"&cbnum="+ cboard.getCbnum();
		}catch(Exception e){
			view="redirect:writeCommuFrm?cbstatus="+status;
		}
		return view;
	}

	public Map<String, List<CReplyDto>> rInsert(CReplyDto reply){
		Map<String, List<CReplyDto>> rMap= null;
		try {
			cbDao.ReplyInsert(reply);
			List<CReplyDto> rList=cbDao.getReplyList(reply.getR_cbnum());
			rMap=new HashMap<String,List<CReplyDto>>();
			rMap.put("rList",rList);
		}catch (Exception e) {
			e.printStackTrace();
			rMap=null;
		}
		return rMap;
	}

	public ModelAndView getCon(Integer cbnum) {
		mv= new ModelAndView();
		CBoardDto cboard =cbDao.getCContent(cbnum);
		mv.addObject("cbaord", cboard);
		mv.setViewName("upCommuFrm");
		return mv;
	}

	public Map<String, List<CReplyDto>> rDelete(CReplyDto reply) {
		Map<String, List<CReplyDto>> rMap= null;
		try {
			cbDao.ReplyDelete(reply);
			List<CReplyDto> rList=cbDao.getReplyList(reply.getR_cbnum());
			rMap=new HashMap<String,List<CReplyDto>>();
			rMap.put("rList",rList);
		}catch (Exception e) {
			e.printStackTrace();
			rMap=null;
		}
		return rMap;
	}
	@Transactional
	public ModelAndView deleteCBoard(int cbstatus,int cbnum, RedirectAttributes rttr) {
		mv= new ModelAndView();
		mv.addObject("cbstatus",cbstatus);
		log.info("deleteCBoard() - cbnum : " +cbnum);
		try {

			cbDao.cReplyDelete(cbnum);
			cbDao.cBoardDelete(cbnum);
			mv.setViewName("redirect:commuBoard?cbstatus="+cbstatus);
			rttr.addFlashAttribute("check", 3);
		}catch (Exception e) {
			mv.addObject("cbnum", cbnum);
			mv.setViewName("redirect:commuContent?cbstatus="+cbstatus);
			rttr.addFlashAttribute("check", 4);
		}
		return mv;
	}

	public ModelAndView upCommuFrm(int cbstatus, int cbnum, RedirectAttributes rttr) {
		mv=new ModelAndView();
		String view =null;

		CBoardDto cboard = cbDao.getCContent(cbnum);
		MemberDto member = (MemberDto)session.getAttribute("mb");
		String cNick= member.getM_nickname();
		mv.addObject("cbstatus", cbstatus);
		if(cboard.getCbnickname().equals(cNick)) {
			mv.addObject("cboard",cboard);
			view = "upCommuFrm";
		}else {
			view = "redirect:content?cbstatus="+cbstatus+"&cbnum=" + cbnum;
			rttr.addFlashAttribute("check",1); 
		}
		mv.setViewName(view);
		return mv;
	}
	@Transactional
	public String cBoardUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		int num=Integer.parseInt(multi.getParameter("cbnum"));
		int status=Integer.parseInt(multi.getParameter("cbstatus"));
		String title =multi.getParameter("cbtitle");
		String content = multi.getParameter("cbcontent");
		String nickname= multi.getParameter("cbnickname");
		content=content.trim();

		log.info("cbnum=" +num);
		CBoardDto cboard =new CBoardDto();

		cboard.setCbnum(num);
		cboard.setCbnickname(nickname);
		cboard.setCbtitle(title);
		cboard.setCbcontent(content);

		String view = null;
		try {
			cbDao.cBoardUpdate(cboard);
			rttr.addFlashAttribute("check",2);
		}catch(Exception e){
			rttr.addFlashAttribute("check",3);
		}
		view="redirect:commuContent?cbstatus="+status+"&cbnum=" + num;
		return view;
	}

	//게시글 목록 가져오는 서비스 메소드
	public ModelAndView timearrySc(Integer pageNum, String nickname, String status) {
		log.info("timearry() - pageNum : " + pageNum);
		mv = new ModelAndView();
		int num = (pageNum == null) ? 1 : pageNum;
		MemberDto member = (MemberDto)session.getAttribute("mb");
		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		if(status == null)
			status="건별편집";

		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));
		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		lmap.put("status", status);
		List<UBoardDto> utList = bDao.getTListSc(lmap);
		System.out.println("zzzzzzzzzzzzzzzzzzzzzzzz" + utList);
		mv.addObject("utList", utList);

		String paging = getUTPagingSc(num, status);
		mv.addObject("paging", paging);
		mv.addObject("sort", "작성일순");
		mv.addObject("status", status);
		//세션에 페이지 번호 저장.
		session.setAttribute("pageNum", num);

		//view name을 지정!
		mv.setViewName("myEPageSc");

		return mv;
	}
	public ModelAndView deadarrySc(Integer pageNum, String nickname,  String status) {
		log.info("deadarry() - pageNum : " + pageNum);
		mv = new ModelAndView();
		int num = (pageNum == null) ? 1 : pageNum;
		MemberDto member = (MemberDto)session.getAttribute("mb");
		if(status == null)
			status="건별편집";		

		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));
		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		lmap.put("status", status);
		List<UBoardDto> udList = bDao.getDListSc(lmap);

		mv.addObject("udList", udList);

		String paging = getUDPagingSc(num, status);
		mv.addObject("paging", paging);
		mv.addObject("sort", "마감일순");
		mv.addObject("status", status);
		//세션에 페이지 번호 저장.
		session.setAttribute("pageNum", num);

		//view name을 지정!
		mv.setViewName("myEPageSc");

		return mv;
	}

	private String getUDTPaging(int num, String ubpositiontype) {
		//전체 글 개수 구하기     
		
		Map<String, String> lmap = new HashMap<String, String>();
		lmap.put("ubpositiontype", ubpositiontype);
		
		int maxNum = bDao.getUDTBoardCount(lmap);
		String listName = "timearry?ubpositiontype="+ubpositiontype;//게시판 uri
		
		Paging paging = new Paging(maxNum, num, 
				listCount, pageCount, listName);
		
		String pagingHtml = paging.makePaging();
		
		return pagingHtml;
	}
	private String getUTPaging(int num, String ubpositiontype, String status) {
	      //전체 글 개수 구하기     
		
		Map<String, String> lmap = new HashMap<String, String>();
	      lmap.put("ubpositiontype", ubpositiontype);
	      lmap.put("status", status);		
		
		int maxNum = bDao.getUTBoardCount(lmap);
		String listName = "timearry?ubpositiontype="+ubpositiontype+"&status="+status;//게시판 uri
	      
	    Paging paging = new Paging(maxNum, num, 
	          listCount, pageCount, listName);
	      
	    String pagingHtml = paging.makePaging();
	      
	    return pagingHtml;
	   }
	
	
	private String getUDPaging(int num, String ubpositiontype, String status) {
		//전체 글 개수 구하기
		
		Map<String, String> lmap = new HashMap<String, String>();
	      lmap.put("ubpositiontype", ubpositiontype);
	      lmap.put("status", status);	
	      
		int maxNum = bDao.getUDBoardCount(lmap);
		String listName = "deadarry?ubpositiontype="+ubpositiontype+"&status="+status;//게시판 uri

		Paging paging = new Paging(maxNum, num, 
				listCount, pageCount, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;
	}
	private String getUTPagingSc(int num, String status) {
		//전체 글 개수 구하기
		int maxNum = bDao.getUTBoardCountSc(status);
		String listName = "timearrySc?status="+status;//게시판 uri

		Paging paging = new Paging(maxNum, num, 
				listCount, pageCount, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;
	}
	private String getUDPagingSc(int num, String status) {
		//전체 글 개수 구하기
		int maxNum = bDao.getUDBoardCountSc(status);
		String listName = "deadarrySc?status="+status;//게시판 uri

		Paging paging = new Paging(maxNum, num, 
				listCount, pageCount, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;
	}

	public ModelAndView getUTContent(Integer ubnum, String nickname) {
		mv = new ModelAndView();

		bDao.viewUpdate(ubnum);

		UScriptDto uscriptlist = bDao.uscriptlist(ubnum);
		mv.addObject("uscriptlist", uscriptlist);

		//		MemberDto member = (MemberDto)session.getAttribute("mb");
		//		
		//		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		//		Map<String, String> lmap = 	new HashMap<String, String>();
		//		lmap.put("ubnum", String.valueOf(uscriptlist.getSc_ubnum()));
		//		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		//		
		//		List<UBoardDto> utcboard = bDao.getUTContentSc(lmap);		
		//		mv.addObject("utcboard", utcboard);

		//게시글 번호로 글 내용 검색 결과 받아오기.(DB) 
		UBoardDto uboard = bDao.getUTContent(ubnum);
		mv.addObject("uboard", uboard);
		RequestDto rDto = new RequestDto();
		rDto=bDao.chkReq(ubnum);

		if(rDto==null) {
			uboard.setChk(0);
		}else {
			uboard.setChk(1);
		}

		System.out.println("zzzzzzzzzzzzzz"+ubnum+uboard.getChk());

		mv.setViewName("uContent");

		return mv;
	}
	public ModelAndView getUDContent(Integer ubnum) {
		mv = new ModelAndView();

		//조회수 증가.DB
		bDao.viewUpdate(ubnum);

		UScriptDto uscriptlist = bDao.uscriptlist(ubnum);
		mv.addObject("uscriptlist", uscriptlist);

		//게시글 번호로 글 내용 검색 결과 받아오기.(DB) 
		UBoardDto uboard = bDao.getUDContentSc(ubnum);
		mv.addObject("uboard", uboard);

		mv.setViewName("uContent");

		return mv;
	}

	public ModelAndView getUContent(Integer ubnum) {
		mv = new ModelAndView();
		//조회수 증가.DB
		bDao.viewUpdate(ubnum);

		//게시글 번호로 글 내용 검색 결과 받아오기.(DB) 
		UBoardDto uboard = bDao.getUContent(ubnum);
		RequestDto rDto = new RequestDto();
		rDto=bDao.chkReq(ubnum);

		if(rDto==null) {
			uboard.setChk(0);
		}else {
			uboard.setChk(1);
		}

		System.out.println("zzzzzzzzzzzzzz"+ubnum+uboard.getChk());

		mv.addObject("uboard", uboard);
		mv.setViewName("uContent");

		return mv;
	}
	//insert, update, delete 작업용 메소드는 
	//트랜잭션 처리가 필요
	@Transactional
	public String uboardInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		String view = null;

		//Multipart request에서 데이터 추출
		String title = multi.getParameter("ubtitle");
		String content = multi.getParameter("ubcontent");
		String nickname = multi.getParameter("ubnickname");
		String dateformat = multi.getParameter("ubdeadline");
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		Date deadline = null;
		try {
			deadline = fm.parse(dateformat);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String status = multi.getParameter("ubstatus");
		String positiontype = multi.getParameter("ubpositiontype");
		int cost = Integer.parseInt(multi.getParameter("ubcost"));
		String sysname = multi.getParameter("msysname");
		String oriname = multi.getParameter("moriname");

		/*//다음과 같이 세션에서 id값을 꺼내올 수도 있음.
		MemberDto mem = (MemberDto)session.getAttribute("mb");
		String id = mem.getM_id();
		 */

		//일반적으로 textarea에서 들어오는 데이터는
		//본 내용 앞 뒤에 쓸데없는 공백이 포함됨.
		//공백 제거 처리. trim()
		content = content.trim();

		UBoardDto uboard = new UBoardDto();
		uboard.setUbnickname(nickname);
		uboard.setUbcontent(content);
		uboard.setUbtitle(title);
		uboard.setUbdeadline(deadline);
		uboard.setUbstatus(status);
		uboard.setUbpositiontype(positiontype);
		uboard.setUbcost(cost);
		uboard.setMsysname(sysname);
		uboard.setMoriname(oriname);

		//insert, update, delete를 할 경우
		//웬만하면....... try/catch로 처리해 주세요...
		try {
			bDao.uboardInsert(uboard);

			view = "redirect:utcontent?ubnum=" + uboard.getUbnum();
			rttr.addFlashAttribute("check", 2);

		}catch (Exception e) {
			//DB 삽입 오류 시 글쓰기폼으로 돌아감.
			view = "redirect:writeUFrm";
			rttr.addFlashAttribute("check", 1);
		}

		return view;
	}	

	public ModelAndView updateUFrm(int bnum, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;

		UBoardDto board = bDao.getUContent(bnum);
		MemberDto member = (MemberDto)session.getAttribute("mb");
		String sNickname = member.getM_nickname();

		if(board.getUbnickname().equals(sNickname)) {
			mv.addObject("board", board);
			view = "updateUFrm";
		}
		else {
			view = "redirect:utcontent?bnum=" + bnum;
			rttr.addFlashAttribute("check", 1);
		}

		mv.setViewName(view);

		return mv;
	}

	@Transactional
	public String UboardUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		int num = Integer.parseInt(multi.getParameter("ubnum"));
		String title = multi.getParameter("ubtitle");
		String content = multi.getParameter("ubcontent");
		String dateformat = multi.getParameter("ubdeadline");
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		Date deadline = null;
		try {
			deadline = fm.parse(dateformat);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String status = multi.getParameter("ubstatus");
		String positiontype = multi.getParameter("ubpositiontype");
		int cost = Integer.parseInt(multi.getParameter("ubcost"));
		String sysname = multi.getParameter("msysname");
		String oriname = multi.getParameter("moriname");

		content = content.trim();
		//int check = Integer.parseInt(
		//		multi.getParameter("fileCheck"));

		UBoardDto uboard = new UBoardDto();
		uboard.setUbnum(num);
		uboard.setUbcontent(content);
		uboard.setUbtitle(title);
		uboard.setUbdeadline(deadline);
		uboard.setUbstatus(status);
		uboard.setUbpositiontype(positiontype);
		uboard.setUbcost(cost);
		uboard.setMsysname(sysname);
		uboard.setMoriname(oriname);

		String view = null;

		try {
			bDao.boardUpdate(uboard);
			rttr.addFlashAttribute("check", 2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			rttr.addFlashAttribute("check", 3);
		}

		view = "redirect:utcontent?ubnum=" + num;

		return view;
	}

	@Transactional
	public ModelAndView uscript(int ubnum, String nickname, int usertype) {
		mv = new ModelAndView();
		String view = null;

		UScriptDto uscript = new UScriptDto();

		uscript.setSc_ubnum(ubnum);
		uscript.setSc_mnickname(nickname);
		uscript.setSc_usertype(usertype);	

		bDao.uscript(uscript);
		mv.addObject("uscript", uscript);
	
		UBoardDto uboard = bDao.getUTContentSc(ubnum);		

		String encNIck;
		try {
			encNIck = URLEncoder.encode(uboard.getUbnickname(), "UTF-8");
			view="redirect:utcontent?ubnum=" + uscript.getSc_ubnum() + "&nickname=" + encNIck;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mv.setViewName(view);
		
		return mv;
	}

	@Transactional
	public ModelAndView pscript(int pnum, String nickname, int usertype) {
		mv = new ModelAndView();
		String view = null;
		UScriptDto uscript = new UScriptDto();
      	uscript.setSc_pnum(pnum);
		uscript.setSc_mnickname(nickname);
		uscript.setSc_usertype(usertype); 
		bDao.pscript(uscript);
		mv.addObject("pscriptlistsc", uscript);     
		EBoardDto eboard = bDao.getPTContentSc(pnum);   
		
		String encNIck;
		try {
			encNIck = URLEncoder.encode(eboard.getPnickname(), "UTF-8");
			view="redirect:pcontents?pnum=" + uscript.getSc_pnum() + "&pnickname=" + encNIck;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mv.setViewName(view);

		return mv;
	}

	@Transactional
	public String deleteUBoard(int ubnum, RedirectAttributes rttr) {
		String view = null;

		try {
			// 원글 삭제
			bDao.boardUDelete(ubnum);

			view = "redirect:timearry";
			rttr.addFlashAttribute("check", 3);
		}catch(Exception e) {
			view = "redirect:utcontent?ubnum=" + ubnum;
			rttr.addFlashAttribute("check", 4);
		}

		return view;
	}

/*
	public String uscriptdel(int ubnum, RedirectAttributes rttr) {
		String view = null;

		try {
			// 원글 삭제
			bDao.uscriptdel(ubnum);

			view = "redirect:utcontent?ubnum=" + ubnum;
		}catch(Exception e) {
		}      
		return view;
	}
*/	
	
	public String pscriptdel(int pnum,String nickname) {
		String view = null;
		String encNIck;
		try {
			// 원글 삭제
			EBoardDto eboard = bDao.getPTContentSc(pnum); 
			encNIck = URLEncoder.encode(eboard.getPnickname(), "UTF-8");
			view="redirect:pcontents?pnum=" + pnum + "&pnickname=" + encNIck;
			bDao.pscriptdel(pnum);
		}catch(Exception e) {
			
		}      
		return view;
	}


	public String uscriptdel(int ubnum) {
		String view = null;
		String encNIck;

		try {
			UBoardDto uboard = bDao.getUTContentSc(ubnum);
			encNIck = URLEncoder.encode(uboard.getUbnickname(), "UTF-8");
			view="redirect:utcontent?ubnum=" + ubnum + "&nickname=" + encNIck;
			// 원글 삭제
			bDao.uscriptdel(ubnum);

		}catch(Exception e) {
		}		
		return view;
		
	}


	//혜명메소드

	public ModelAndView getChat(String nick) {
		mv = new ModelAndView();
		session.setAttribute("nick",nick);
		MemberDto member = (MemberDto)session.getAttribute("mb");
		List<ChatbotDto> cList = null;

		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		lmap.put("targetnickname", String.valueOf(nick));

		try {
			cList=bDao.getCList(lmap);
			mv.addObject("cList", cList);
		} catch (Exception e) {

		}
		mv.setViewName("chating");

		return mv;
	}

	@Transactional
	public ModelAndView chatInsert(ChatbotDto cDto, RedirectAttributes rttr) {
		mv = new ModelAndView();
		MemberDto member = (MemberDto)session.getAttribute("mb");
		List<ChatbotDto> cList = null;
		cDto.setCh_mnickname(member.getM_nickname());
		System.out.println(cDto);

		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		lmap.put("targetnickname", String.valueOf(cDto.getCh_targetnickname()));

		try {
			bDao.chatInsert(cDto);
			cList=bDao.getCList(lmap);
			mv.addObject("cList", cList);
		} catch (Exception e) {

		}
		mv.setViewName("chating");

		return mv;
	}


	
	public Map<String, List<ChatbotDto>> chatingSel(String nick) {
		Map<String, List<ChatbotDto>> cMap = null;
//		session.setAttribute("nick",nick);
		MemberDto member = (MemberDto)session.getAttribute("mb");
		
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("nickname", String.valueOf(member.getM_nickname()));
		lmap.put("targetnickname", String.valueOf(nick));
		
		try {
			//int lastNum = bDao.getLastNum();
			
			List<ChatbotDto> cList = bDao.getCList(lmap);
			
			cMap = new HashMap<String, List<ChatbotDto>>();
			
			cMap.put("cList", cList);
			System.out.println("불러오기 씹성공" + cList);
		} catch (Exception e) {
			cMap = null;
			System.out.println("망해쓰요");
		}
		
		return cMap;
	}


	//편집자 관련

	//편집자 게시판 목록 불러오기
	public ModelAndView getPortfolioList(String pstatus, Integer pageNum) {
		log.info("getPortfolioList() - pageNum : " + pageNum);
		mv = new ModelAndView();

		if(pstatus == null)
			pstatus="게임 방송";

		EBoardDto eDto = new EBoardDto();

		int num = (pageNum == null) ? 1 : pageNum;

		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount-4));
		lmap.put("pstatus", pstatus);

		List<EBoardDto> pList = bDao.getPList(lmap);	
		mv.addObject("pList", pList);

		mv.addObject("sort2", "최신순");
		String paging = getPPaging(num, pstatus);
		mv.addObject("paging", paging);

		String pname= null;


		mv.addObject("pstatus", pstatus);


		//세션에 페이지 번호 저장.
		session.setAttribute("pageNum", num);

		//view name을 지정!
		mv.setViewName("editBoard");

		return mv;
	}

	public ModelAndView getPortfolioListSc(Integer pageNum, String nickname) {
		log.info("getPortfolioList() - pageNum : " + pageNum);
		mv = new ModelAndView();

		MemberDto member = (MemberDto)session.getAttribute("mb");
		nickname = member.getM_nickname();
		EBoardDto eDto = new EBoardDto();

		int num = (pageNum == null) ? 1 : pageNum;

		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount-4));
		lmap.put("nickname", nickname);

		List<EBoardDto> pList = bDao.getPListasc(lmap);   
		mv.addObject("pList", pList);

		String paging = getPPagingSc(num, nickname);
		mv.addObject("paging", paging);

		String pname= null;


		//세션에 페이지 번호 저장.
		session.setAttribute("pageNum", num);

		//view name을 지정!
		mv.setViewName("myUPageSc");

		return mv;
	}


	private String getPPagingSc(int num, String nickname) {
	      //전체 글 개수 구하기
	      int maxNum = bDao.getPScBoardCount(nickname);
	      String listName = "myUPageSc?nickname="+nickname;//게시판 uri
	      
	      Paging paging = new Paging(maxNum, num, 
	            listCount-4, pageCount, listName);
	      
	      String pagingHtml = paging.makePaging();
	      
	      return pagingHtml;
	   }

	//포트폴리오 내용 가져오기
    public ModelAndView getPContents(Integer pnum, String pnickname) {
       mv = new ModelAndView();

       //조회수 증가.DB
       bDao.viewPUpdate(pnum);
       
       UScriptDto uscriptlist = bDao.pscriptlist(pnum);
        mv.addObject("pscriptlist", uscriptlist);

       //게시글 번호로 글 내용 검색 결과 받아오기.(DB) 
       EBoardDto port = bDao.getPContents(pnum);
       RequestDto rDto = bDao.chkEReq(port.getPnickname());

       if(rDto==null || rDto.getRq_status()==8 || rDto.getRq_status()==7) {
          port.setChk(0);
       }else{
          port.setChk(1);
       }

       mv.addObject("port", port);

       //Q&a
       QnaDto qna = new QnaDto();
       qna.setQ_pnum(pnum);
       qna.setQnaNum(1);
       List<QnaDto> qnaList = bDao.getQna(qna);
       mv.addObject("qnaList", qnaList);

       //평점
       int sum = 0;
       mv.addObject("sum",sum);
       RatingDto rate = new RatingDto();
       Map<String, String> rmap = 
             new HashMap<String, String>();
       rmap.put("rateNum", String.valueOf(1));
       rmap.put("nick", String.valueOf(pnickname));
       try {
          List<RatingDto> rateList = bDao.getRate(rmap);
          mv.addObject("rateList", rateList);
          sum = 0;
          System.out.println("sdfsdf" + rateList);
          if(rateList != null) {
             System.out.println("이프문 들어왔어요");
             for(int i =0; i<rateList.size();i++) {
                System.out.println("반복문 들어왔어요");
                rate = rateList.get(i);
                System.out.println("평점을 불러왓어요"+rate.getRa_score());
                sum += rate.getRa_score();
                System.out.println("더했어요"+sum);
                rate.setRateNum(1);
             }
             System.out.println("총합"+sum);
             sum = sum/rateList.size();
             System.out.println("몇점인가요???"+sum);
             mv.addObject("sum",sum);
          }
          else {
             rate.setRateNum(1);
             sum = 0;
             mv.addObject("sum",sum);
          }
          
       } catch (Exception e) {

          System.out.println("ㅋㅋㅋㅋㅈ망");
          // TODO: handle exception
       }
       
       
       mv.setViewName("editContent");

       return mv;
    }


    public ModelAndView getPContentsc(Integer pnum, String nick) {
        mv = new ModelAndView();

        //조회수 증가.DB
        bDao.viewPUpdate(pnum);

        UScriptDto pscriptlist = bDao.pscriptlist(pnum);
        mv.addObject("pscriptlist", pscriptlist);

        //게시글 번호로 글 내용 검색 결과 받아오기.(DB) 
        EBoardDto port = bDao.getPTContentSc(pnum);
		RequestDto rDto = bDao.chkEReq(port.getPnickname());

		if(rDto==null) {
			port.setChk(0);
		}else {
			port.setChk(1);
		}
		
        mv.addObject("port", port);

        //Q&a
        QnaDto qna = new QnaDto();
        qna.setQ_pnum(pnum);
        qna.setQnaNum(1);
        List<QnaDto> qnaList = bDao.getQna(qna);
        mv.addObject("qnaList", qnaList);

		//평점
		int sum = 0;
		mv.addObject("sum",sum);
		RatingDto rate = new RatingDto();
		Map<String, String> rmap = 
				new HashMap<String, String>();
		rmap.put("rateNum", String.valueOf(1));
		rmap.put("nick", String.valueOf(nick));
		try {
			List<RatingDto> rateList = bDao.getRate(rmap);
			mv.addObject("rateList", rateList);
			sum = 0;
			System.out.println("sdfsdf" + rateList);
			if(rateList != null) {
				System.out.println("이프문 들어왔어요");
				for(int i =0; i<rateList.size();i++) {
					System.out.println("반복문 들어왔어요");
					rate = rateList.get(i);
					System.out.println("평점을 불러왓어요"+rate.getRa_score());
					sum += rate.getRa_score();
					System.out.println("더했어요"+sum);
					rate.setRateNum(1);
				}
				System.out.println("총합"+sum);
				sum = sum/rateList.size();
				System.out.println("몇점인가요???"+sum);
				mv.addObject("sum",sum);
			}
			else {
				rate.setRateNum(1);
				sum = 0;
				mv.addObject("sum",sum);
			}
			
		} catch (Exception e) {

			System.out.println("ㅋㅋㅋㅋㅈ망");
			// TODO: handle exception
		}
        
        mv.setViewName("editContent");

        
        return mv;
     }

	//포트폴리오 페이징
	private String getPPaging(int num, String pstatus) {
		//전체 글 개수 구하기
		int maxNum = bDao.getPBoardCount(pstatus);
		String listName = "plist?pstatus="+pstatus;//게시판 uri

		Paging paging = new Paging(maxNum, num, 
				listCount-4, pageCount, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;
	}
	//인기순 정렬
	public ModelAndView sortView(String pstatus, Integer pageNum) {
		log.info("sortView() - pageNum : " + pageNum);
		mv = new ModelAndView();

		if(pstatus == null)
			pstatus="게임 방송";

		int num = (pageNum == null) ? 1 : pageNum;
		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));
		lmap.put("pstatus", String.valueOf(pstatus));

		List<EBoardDto> pList = bDao.sortView(lmap);	
		mv.addObject("pList", pList);

		String paging = getPPaging(num, pstatus);
		mv.addObject("paging", paging);

		String pname = null;

		switch(pstatus) {
		case "게임 방송":pname="게임 방송";
		break;
		case "먹방":pname="먹방"; 
		break;
		case "뷰티":pname="뷰티";
		break;
		case "브이로그":pname="브이로그";
		break;
		case "음악방송":pname="음악방송";
		break;
		case "기타":pname="기타";
		break;
		}
		mv.addObject("pname", pname);
		mv.addObject("pstatus", pstatus);
		mv.addObject("sort2", "인기순");
		//세션에 페이지 번호 저장.
		session.setAttribute("pageNum", num);

		//view name을 지정!
		mv.setViewName("editBoard");

		return mv;
	}

	//더보기 처리(Q&A)
	public Map<String, List<QnaDto>> qMore(QnaDto qna) {

		Map<String, List<QnaDto>> qMap = null;

		try {
			//qna 검색
			List<QnaDto> qList = bDao.getQna(qna);
			//qna 목록 추가
			qMap = new HashMap<String, List<QnaDto>>();
			qMap.put("qList", qList);
		}catch (Exception e) {
			e.printStackTrace();
			qMap = null;
		}
		return qMap;
	}

	//마이페이지 나의 포트폴리오	
	public ModelAndView getPort(String nick) {
		mv = new ModelAndView();
		EBoardDto pDto = new EBoardDto();

		pDto = bDao.getPort(nick);
		mv.addObject("port", pDto);

		mv.setViewName("myEPagePf");
		return mv;
	}

	//나의 포트폴리오 수정 게시판 이동
	public ModelAndView upPortfolio(String nick) {
		mv = new ModelAndView();

		EBoardDto pDto = new EBoardDto();

		pDto = bDao.getPort(nick);
		mv.addObject("port", pDto);
		mv.setViewName("upPortfolio");

		return mv;
	}

	//나의 포트폴리오 수정
	@Transactional
	public String portUpdate(MultipartHttpServletRequest multi) {
		int num = Integer.parseInt(multi.getParameter("pnum"));
		String nickname = multi.getParameter("pnickname");
		String title = multi.getParameter("ptitle");
		int cost = Integer.parseInt(multi.getParameter("pcost"));
		String content = multi.getParameter("pcontent");
		String link = multi.getParameter("plink");
		String status = multi.getParameter("pstatus");
		content = content.trim();

		EBoardDto pDto = new EBoardDto();

		pDto.setPnum(num);
		pDto.setPnickname(nickname);
		pDto.setPtitle(title);
		pDto.setPcontent(content);
		pDto.setPlink(link);
		pDto.setPcost(cost);
		//		pDto.setPredate(redate);
		pDto.setPstatus(status);

		String view = null;

		
	    try {
		       bDao.portUpdate(pDto);
		       String encNick = URLEncoder.encode(nickname, "UTF-8");
		       view = "redirect:myEPagePf?nick=" + encNick;

		    } catch (Exception e) {

		    }
		
		
		return view;
	}

	//나의 포트폴리오 작성 게시판 이동
	public ModelAndView inPortfolio(String nick) {
		mv = new ModelAndView();

		EBoardDto pDto = new EBoardDto();

		pDto = bDao.getPort(nick);
		mv.addObject("port", pDto);
		mv.setViewName("inPortfolio");

		return mv;
	}

	public Map<String, List<RatingDto>> rMore(RatingDto rate) {
	      Map<String, List<RatingDto>> rMap = null;

	      try {
	         rate = new RatingDto();
	         Map<String, String> rmap = 
	               new HashMap<String, String>();
	         rmap.put("rateNum", String.valueOf(1));
	         rmap.put("nick", String.valueOf(rate.getRa_nickname()));
	         //rate 검색
	         List<RatingDto> rList = bDao.getRate(rmap);
	         //rate 목록 추가
	         rMap = new HashMap<String, List<RatingDto>>();
	         rMap.put("rList", rList);
	      }catch (Exception e) {
	         e.printStackTrace();
	         rMap = null;
	      }
	      return rMap;
	   }

	//날짜 갱신
	@Transactional
	public String dateUp(String pnickname) {		
		EBoardDto pDto = new EBoardDto();
		pDto.setPnickname(pnickname);
		String view = null;

		try {
			bDao.dateUp(pDto);
		} catch (Exception e) {
			// TODO: handle exception
		}


		view = "redirect:myEPagePf?nick=" + pnickname;

		return view;
	}

	//포트폴리오 작성
	   @Transactional
	   public String portInsert(MultipartHttpServletRequest multi) {
	      
	      String status = multi.getParameter("pstatus");
	      String nickname = multi.getParameter("pnickname");
	      String title = multi.getParameter("ptitle");
	      int cost = Integer.parseInt(multi.getParameter("pcost"));
	      String content = multi.getParameter("pcontent");
	      String link = multi.getParameter("plink");
	      content = content.trim();

	      System.out.println("portInsert - nickname: " + nickname);
	      
	      EBoardDto pDto = new EBoardDto();

	      pDto.setPnickname(nickname);
	      pDto.setPtitle(title);
	      pDto.setPcontent(content);
	      pDto.setPlink(link);
	      pDto.setPcost(cost);
	      pDto.setPstatus(status);

	      String view = null;

	      try {
	         bDao.portInsert(pDto);
	         String encNick = URLEncoder.encode(nickname, "UTF-8");
	         view = "redirect:myEPagePf?nick=" + encNick;

	      } catch (Exception e) {

	      }

	      return view;
	   }
	   public String reDate(int pnum) {
		      EBoardDto pDto = new EBoardDto();
		      pDto.setPnum(pnum);
		      String view = null;

		      try {
		         bDao.reDate(pDto);
		      } catch (Exception e) {
		         // TODO: handle exception
		      }

		      view = "redirect:pcontents?pnum=" + pnum;

		      return view;
		   }
	@Transactional
	public String qInsert(QnaDto qDto, RedirectAttributes rttr) {	
		String view = null;
	
		try {
			System.out.println("2222들어왔어요");
			bDao.qInsert(qDto);
			
		} catch (Exception e) {
			
		}
		view = "redirect:pcontents?pnum=" + qDto.getQ_pnum();
		
		return view;
	}


}








