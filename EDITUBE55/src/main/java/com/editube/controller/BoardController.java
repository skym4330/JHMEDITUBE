package com.editube.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.editube.dto.CReplyDto;
import com.editube.dto.ChatbotDto;
import com.editube.dto.MemberDto;
import com.editube.dto.QnaDto;
import com.editube.dto.RatingDto;
import com.editube.dto.ReplyDto;
import com.editube.service.BoardService;
import com.editube.service.MemberService;

import lombok.extern.java.Log;

@Controller
@Log
public class BoardController {

	//서비스 객체
	@Autowired
	private BoardService bServ;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);


	//데이터 전달 객체
	ModelAndView mv;

	@GetMapping("commuBoard")
	public ModelAndView boardList(Integer cbstatus,Integer pageNum) {
		mv= bServ.getCommuBoard(cbstatus ,pageNum);

		return mv;
	}
	@GetMapping("commuContent")
	public ModelAndView commuContent(Integer cbstatus,Integer cbnum) {
		mv=bServ.getCContent(cbstatus,cbnum);
		return mv;
	}
	@GetMapping("writeCommuFrm")
	public ModelAndView writeCommuFrm(Integer cbstatus) {
		log.info("status="+ cbstatus);
		mv= new ModelAndView();
		mv.addObject("cbstatus",cbstatus);
		mv.setViewName("writeCommuFrm");
		return mv;
	}
	@PostMapping("writeCom")
	public String writeCom(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		String view = bServ.cBoardInsert(multi, rttr);
		return view;
	}
	@GetMapping("upConmmuFrm")
	public ModelAndView upConmmuFrm(int cbstatus,int cbnum, RedirectAttributes rttr){
		log.info("글번호: "+ cbnum);
		mv= bServ.upCommuFrm(cbstatus,cbnum,rttr);
		return mv;
	}
	@PostMapping("cBoardUpdate")
	public String cBoardUpdate(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = bServ.cBoardUpdate(multi, rttr);
		return view;
	}
	@GetMapping("delCBoard")
	public ModelAndView deleteCBoard(int cbstatus, int cbnum, RedirectAttributes rttr) {
		log.info("delete() - bnum : " +cbnum);

		mv= bServ.deleteCBoard(cbstatus,cbnum,rttr);
		return mv;
	}
	@PostMapping(value="replyInsert", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String,List<CReplyDto>> replyInsert(CReplyDto reply){
		Map<String,List<CReplyDto>> rMap=bServ.rInsert(reply);
		return rMap;
	}
	@PostMapping(value="replyDelete", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String,List<CReplyDto>> replyDelete(CReplyDto reply){
		int num = reply.getR_num();
		log.info("r_num : " + num);
		Map<String,List<CReplyDto>> rMap=bServ.rDelete(reply);
		return rMap;
	}

	@GetMapping("timearry")
	public ModelAndView timearry(String ubpositiontype, Integer pageNum, String status) {
		logger.info("timearry()");
		mv= bServ.getYoutubeTBoard(ubpositiontype ,pageNum, status);

		return mv;
	}
	@GetMapping("deadarry")
	public ModelAndView deadarry(String ubpositiontype, Integer pageNum, String status) {
		logger.info("deadarry()");
		mv= bServ.getYoutubeDBoard(ubpositiontype ,pageNum, status);

		return mv;
	}
	@GetMapping("timearrySc")
	public ModelAndView timearrySc(Integer pageNum, String nickname, String status) {
		logger.info("timearrySc()");

		//서비스에서 처리
		mv = bServ.timearrySc(pageNum, nickname, status);

		return mv;
	}
	@GetMapping("deadarrySc")
	public ModelAndView deadarrySc(Integer pageNum, String nickname, String status) {
		logger.info("deadarrySc()");

		//서비스에서 처리
		mv = bServ.deadarrySc(pageNum, nickname, status);

		return mv;
	}

	@GetMapping("timearrya")
	public ModelAndView timearrya(String ubpositiontype, Integer pageNum, String status) {
		logger.info("timearrya()");

		//서비스에서 처리
		mv = bServ.getYoutubeTBoarda(ubpositiontype, pageNum, status);

		return mv;
	}
	@GetMapping("timearryb")
	public ModelAndView timearryb(String ubpositiontype, Integer pageNum, String status) {
		logger.info("timearryb()");

		//서비스에서 처리
		mv = bServ.getYoutubeTBoardb(ubpositiontype, pageNum, status);

		return mv;
	}
	@GetMapping("timearryasc")
	public ModelAndView timearryasc(Integer pageNum, String status, String nickname) {
		logger.info("timearryasc()");

		//서비스에서 처리
		mv = bServ.getYoutubeTBoardasc(pageNum, status, nickname);

		return mv;
	}
	@GetMapping("timearrybsc")
	public ModelAndView timearrybsc(Integer pageNum, String status, String nickname) {
		logger.info("timearrybsc()");

		//서비스에서 처리
		mv = bServ.getYoutubeTBoardbsc(pageNum, status, nickname);

		return mv;
	}

	@GetMapping("utcontent")
	public ModelAndView boardtContent(Integer ubnum, String nickname) {
		log.info("UboardtContent - ubnum:" + ubnum);

		//DB에서 bnum(게시글 번호)에 해당하는 게시글
		//정보를 가져와서 model에 추가.
		mv = bServ.getUTContent(ubnum, nickname);

		return mv;
	}
	@GetMapping("udcontent")
	public ModelAndView boarddContent(Integer ubnum) {
		log.info("UboarddContent - ubnum:" + ubnum);

		//DB에서 bnum(게시글 번호)에 해당하는 게시글
		//정보를 가져와서 model에 추가.
		mv = bServ.getUDContent(ubnum);

		return mv;
	}
	@GetMapping("ucontent")
	public ModelAndView boardContent(Integer ubnum) {
		log.info("UboardContent - ubnum:" + ubnum);

		//DB에서 bnum(게시글 번호)에 해당하는 게시글
		//정보를 가져와서 model에 추가.
		mv = bServ.getUContent(ubnum);

		return mv;
	}

	@GetMapping("writeUFrm")
	public String writeFrm() {
		log.info("writeUFrm()");

		return "writeUFrm";
	}

	//writeFrm에서 들어온 데이터 처리 메소드
	//action uri는 "boardWrite"
	@PostMapping("uboardWrite")
	public String uboardWrite
	(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr) {
		log.info("uboardWrite()");

		String view = bServ.uboardInsert(multi, rttr);

		return view;
	}

	//	//댓글 추가 및 댓글 목록 처리 메소드
	//	@PostMapping(value = "replyInsert",
	//			produces = "application/json; charset=utf-8")
	//	@ResponseBody
	//	public Map<String, List<ReplyDto>> 
	//	replyInsert(ReplyDto reply){
	//		log.info("replyInsert - bnum : " 
	//				+ reply.getR_cbnum());	
	//
	//		Map<String, List<ReplyDto>> rMap = 
	//				bServ.rInsert(reply);
	//
	//		return rMap;
	//	}

	//게시글 수정
	@GetMapping("updateUFrm")
	public ModelAndView updateUFrm(int ubnum, 
			RedirectAttributes rttr) {
		log.warning("글번호 : " + ubnum);
		mv = bServ.updateUFrm(ubnum, rttr);

		return mv;
	}

	@PostMapping("UboardUpdate")
	public String UboardUpdate
	(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = bServ.UboardUpdate(multi, rttr);

		return view;
	}

	@GetMapping("uscript")
	public ModelAndView uscript(int ubnum, String nickname, int usertype) {
		log.info("uscript()");
		mv = bServ.uscript(ubnum, nickname, usertype); 
		return mv;
	}
	@GetMapping("uscriptdel")
	public String uscriptdel(int ubnum) {
		log.info("uscript()");
		String view = bServ.uscriptdel(ubnum); 
		return view;
	}

	@GetMapping("pscript")
	public ModelAndView pscript(int pnum, String nickname, int usertype) {
		log.info("pscript()");
		mv = bServ.pscript(pnum, nickname, usertype); 
		return mv;
	}
	@GetMapping("pscriptdel")
	public String pscriptdel(int pnum, String nickname) {
		log.info("pscriptdel()");
		String view = bServ.pscriptdel(pnum,nickname); 
		return view;
	}


	@GetMapping("udelete")
	public String deleteUBoard(int ubnum, RedirectAttributes rttr) {
		log.info("delete() - ubnum : " + ubnum);
		String view = bServ.deleteUBoard(ubnum, rttr); 
		return view;
	}






	//혜명메소드
	@PostMapping("chating")
	public ModelAndView chating(ChatbotDto cDto,RedirectAttributes rttr) {
		mv = bServ.chatInsert(cDto,rttr);

		return mv;
	}

	@GetMapping("chating")
	public ModelAndView chating(String nick) {
		mv=bServ.getChat(nick);

		return mv;
	}

	@PostMapping(value = "chatingSel",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<ChatbotDto>> chatingSel(String nick){
		log.info("chatingSel - nick : " 
				+ nick);	

		Map<String, List<ChatbotDto>> cMap = 
				bServ.chatingSel(nick);

		return cMap;
	}
	///////성기오빠꺼//////////////////////
	@GetMapping("plist")//list?pageNum=3
	public ModelAndView PortfolioList(String pstatus, Integer pageNum) {
		log.info("PortfolioList()");

		mv = bServ.getPortfolioList(pstatus, pageNum);		

		return mv;
	}
	@GetMapping("sortView")//list?pageNum=3
	public ModelAndView sortView(String pstatus, Integer pageNum) {
		log.info("sortView()");

		mv = bServ.sortView(pstatus, pageNum);		

		return mv;
	}


	@GetMapping("pcontents")
	public ModelAndView boardPContents(Integer pnum, String pnickname) {
		log.info("boardPContents - pnum:" + pnum);

		//DB에서 bnum(게시글 번호)에 해당하는 게시글
		//정보를 가져와서 model에 추가.
		mv = bServ.getPContents(pnum, pnickname);

		return mv;
	}


	@GetMapping("pcontentsc")
	public ModelAndView boardPContentsc(Integer pnum, String nick) {
		log.info("boardPContentsc - pnum:" + pnum);

		//DB에서 bnum(게시글 번호)에 해당하는 게시글
		//정보를 가져와서 model에 추가.
		mv = bServ.getPContentsc(pnum, nick);

		return mv;
	}

	//더보기(Q&a)
	@PostMapping(value = "qna",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<QnaDto>> moreQna(QnaDto qna){
		log.info("moreQna - q_num : " + qna.getQnaNum());	
		log.info("moreQna - p_num : " + qna.getQ_pnum());	

		Map<String, List<QnaDto>> qMap = bServ.qMore(qna);

		return qMap;
	}

	//더보기(평점)
	@PostMapping(value = "rate",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<RatingDto>> moreRate(RatingDto rate){
		log.info("moreRate - ra_num : " + rate.getRateNum());	
		log.info("moreRate - ra_pnum : " + rate.getRa_pnum());	

		Map<String, List<RatingDto>> rMap = bServ.rMore(rate);

		return rMap;
	}

	@GetMapping("myEPagePf")
	public ModelAndView viewPort(String nick) {
		log.info("viewPort - nickname:" + nick);
		mv = bServ.getPort(nick);

		return mv;
	}


	@GetMapping("dateUp")
	public String dateUp(String pnickname) {
		log.info("dateUp()");
		String view = bServ.dateUp(pnickname);
		return view;
	}
	@GetMapping("upPortfolio")
	public ModelAndView upPortfolio(String nick) {
		log.info("upPortfolio - nickname:" + nick);
		mv = bServ.upPortfolio(nick);

		return mv;
	}

	@PostMapping("portUpdate")
	public String portUpdate(MultipartHttpServletRequest multi) {
		log.info("portUpdate");
		String view = bServ.portUpdate(multi);
		return view;
	}

	@GetMapping("inPortfolio")
	public ModelAndView inPortfolio(String nick) {
		log.info("inPortfolio - nickname:" + nick);
		mv = bServ.inPortfolio(nick);

		return mv;
	}
	@PostMapping("portInsert")
	public String portInsert(MultipartHttpServletRequest multi) {
		log.info("portInsert");
		String view = bServ.portInsert(multi);
		return view;
	}

	@GetMapping("reDate")
	public String reDate(int pnum) {
		log.info("reDate()");
		String view = bServ.reDate(pnum);
		return view;
	}

	@GetMapping("doubleBoard")
	public ModelAndView doubleBoard(String ubpositiontype, Integer pageNum) {
		logger.info("doubleBoard()");
		mv= bServ.doubleYoutubeTBoarda(ubpositiontype ,pageNum);

		return mv;
	}

	@GetMapping("myUPageSc")
	public ModelAndView myUPageSc(Integer pageNum, String nickname) {
		logger.info("myUPageSc()");
		mv = bServ.getPortfolioListSc(pageNum, nickname);

		return mv;
	}
	@PostMapping("qInsert")
	public String qInsert(QnaDto qDto, RedirectAttributes rttr) {
		log.info("qInsert");
		String view = bServ.qInsert(qDto, rttr);
		return view;
	}	

}//class end








