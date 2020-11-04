package com.pino.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

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

import com.pino.controller.HomeController;
import com.pino.dto.InsaDto;
import com.pino.dto.Insa_ComDto;
import com.pino.service.MemberService;

@Controller
public class HomeController {

	@Inject 
	//서비스를 호출하기 위해서 의존성을 주입
	MemberService memberservice;

	@Autowired
	private MemberService mServ;

	private ModelAndView mv;

	private static final Logger logger =  LoggerFactory.getLogger(HomeController.class);

	/////////////페이지 이동관련 매핑//////////////

	//메인페이지
	@GetMapping("/")
	public String main() {
		logger.info("main()");

		return "main";
	}

	//조회페이지
	@GetMapping("/insaListForm")
	public ModelAndView insaListForm(InsaDto iDto, RedirectAttributes rttr) {
		mv = new ModelAndView();
		List<Insa_ComDto> iList = null;
		logger.info("getInsaList()");
		String view = "insaListForm";
		iList=mServ.InputComList();

		mv.addObject("iList", iList);
		mv.setViewName(view);
		return mv;
	}

	//입력페이지
	@GetMapping("/insaInputForm")
	public ModelAndView insaInputForm() {
		mv = new ModelAndView();
		List<Insa_ComDto> iList = null;
		logger.info("insaInputForm()");
		iList=mServ.InputComList();

		String view = "insaInputForm";
		mv.addObject("iList", iList);
		mv.setViewName(view);
		return mv;
	}


	//수정페이지
	@GetMapping("/insaUpdateForm")
	public ModelAndView insaUpdateForm(Integer sabun) {
		logger.info("insaUpdateForm()");
		mv=mServ.updateGetList(sabun);
		return mv;
	}


	////////////페이지 기능관련 매핑////////////////////////

	//인사등록메소드
	@PostMapping("/MemberInsert")
	public ModelAndView MemberInsert(InsaDto iDto, MultipartHttpServletRequest multi,
			RedirectAttributes rttr) throws IllegalStateException, IOException {
		System.out.println("ㅋㅋㅋ");
		logger.info("MemberInsert()");
		mv=mServ.MemberInsert(iDto, multi, rttr);

		return mv;
	}
	//인사업데이트메소드
	@PostMapping("/MemberUpdate")
	public ModelAndView MemberUpdate(String sabun, InsaDto iDto, MultipartHttpServletRequest multi,
			RedirectAttributes rttr) throws IllegalStateException, IOException {
		logger.info("MemberUpdate()");
		System.out.println("컨트롤러에서 넘겨받은 사번"+iDto.getSABUN()+sabun);
		mv=mServ.MemberUpdate(sabun, iDto, multi, rttr);

		return mv;
	}

	//인사삭제메소드
	@GetMapping("/MemberDelete")
	public ModelAndView MemberDelete(Integer sabun, RedirectAttributes rttr) {
		logger.info("MemberDelete()");


		mv=mServ.MemberDelete(sabun, rttr);

		return mv;
	}

	//아이디중복확인메소드
	@GetMapping(value = "idChk",
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String idChk(String id) {
		logger.info("idChk() - id : " + id);
		String result = mServ.idChk(id);

		return result;
	}

	//조회리스트가져오는메소트
	@GetMapping("/getInsaList")
	public ModelAndView getInsaList(InsaDto iDto, RedirectAttributes rttr) {
		logger.info("getInsaList()");
		mv = new ModelAndView();
		List<Insa_ComDto> iList = null;
		iList=mServ.InputComList();
		mv = mServ.getPage(iDto, iList);

		return mv;
	}
}
