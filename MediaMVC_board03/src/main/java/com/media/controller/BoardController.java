package com.media.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.media.dto.MemberDto;
import com.media.dto.ReplyDto;
import com.media.service.BoardService;
import com.media.service.MemberService;

import lombok.extern.java.Log;

@Controller
@Log
public class BoardController {

	//서비스 객체
	@Autowired
	private BoardService bServ;
	
	@Autowired
	private MemberService mServ;

	//데이터 전달 객체
	ModelAndView mv;

	//이 메소드는 나중에 BoardController로 이전할 예정임.
	@GetMapping("list")//list?pageNum=3
	public ModelAndView boardList(Integer pageNum) {
		log.info("boardList()");

		mv = bServ.getBoardList(pageNum);		

		return mv;
	}
	
	@GetMapping("contents")
	public ModelAndView boardContents(Integer bnum) {
		log.info("boardContents - bnum:" + bnum);

		//DB에서 bnum(게시글 번호)에 해당하는 게시글
		//정보를 가져와서 model에 추가.
		mv = bServ.getContents(bnum);

		return mv;
	}

	@GetMapping("writeFrm")
	public String writeFrm() {
		log.info("writeFrm()");

		return "writeFrm";
	}

	//writeFrm에서 들어온 데이터 처리 메소드
	//action uri는 "boardWrite"
	@PostMapping("boardWrite")
	public String boardWrite
	(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr) {
		log.info("boardWrite()");

		String view = bServ.boardInsert(multi, rttr);
		
		//글 작성 시 회원 포인트 증가
		mServ.pointUp(multi.getParameter("bid"));
		
		return view;
	}

	//첨부파일 다운로드 처리 메소드
	@GetMapping("download")
	public void fileDownload(String sysFileName,
			HttpServletRequest req,
			HttpServletResponse resp) {
		log.info("download() - sysFileName : " 
				+ sysFileName);

		bServ.fileDown(sysFileName, req, resp);
	}

	//댓글 추가 및 댓글 목록 처리 메소드
	@PostMapping(value = "replyInsert",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<ReplyDto>> 
	replyInsert(ReplyDto reply){
		log.info("replyInsert - bnum : " 
				+ reply.getR_bnum());	

		Map<String, List<ReplyDto>> rMap = 
				bServ.rInsert(reply);

		return rMap;
	}

	//게시글 수정
	@GetMapping("updateFrm")
	public ModelAndView updateFrm(int bnum, 
			RedirectAttributes rttr) {
		log.warning("글번호 : " + bnum);
		mv = bServ.updateFrm(bnum, rttr);

		return mv;
	}
	
	@PostMapping("boardUpdate")
	public String boardUpdate
		(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = bServ.boardUpdate(multi, rttr);
		
		return view;
	}
	
	@GetMapping("delete")
	public String deleteBoard(int bnum, RedirectAttributes rttr) {
		log.info("delete() - bnum : " + bnum);
		String view = bServ.deleteBoard(bnum, rttr); 
		return view;
	}
	
	@GetMapping(value = "fdelete", 
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String fileDelete(String fname, HttpServletRequest req) {
		log.info("fileDelete() - fname : " + fname);
		
		String result = bServ.fileDelete(fname);
		
		return result;
	}
}//class end








