package com.pino.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pino.dao.MemberDao;
import com.pino.dto.InsaDto;
import com.pino.dto.Insa_ComDto;
import com.pino.dto.PagingUtil;

import lombok.extern.java.Log;

@Service
@Log
public class MemberService {

	@Autowired
	private MemberDao mDao; 

	private ModelAndView mv;

	//세션
	@Autowired
	private HttpSession session;

	//직원등록메소드
	@Transactional
	public ModelAndView MemberInsert(InsaDto iDto, MultipartHttpServletRequest multi,
			RedirectAttributes rttr) throws IllegalStateException, IOException{
		mv = new ModelAndView();
		System.out.println("iDto" + iDto);
		String view = null;

		/*
		//3자가 입력하는 프로그램은 암호화 하지 않음
		//비밀번호 암호화 처리
		//스프링 시큐리티는 암호화만 해줌.
		//복호화는 안해줌.
		System.out.println("1차구간");
		BCryptPasswordEncoder pwdEncoder =
				new BCryptPasswordEncoder();
		//비밀번호 암호화
		System.out.println("2차구간 PW : " + iDto.getPWD() +"ID : "+ iDto.getID());
		String encPwd = pwdEncoder.encode(iDto.getPWD());
		System.out.println("3차구간 암호화된 PW : "+encPwd);
		//저장
		iDto.setPWD(encPwd);
		System.out.println("3차구간");
		 */

		if(iDto.getCARRIER_IMAGE() != null||iDto.getCARRIER_IMAGE() != null || iDto.getPROFILE_IMAGE() != null) {

			//파일은 실제 물리 경로를 사용하여 저장해야 함.
			// upload 폴더에 저장하도록 지정.
			// 상대 경로 : resources/upload/
			String filePath = multi.getSession()
					.getServletContext()
					.getRealPath("/") + "resources/upload/";
			log.info(filePath);

			//upload 폴더 만들기
			File folder = new File(filePath);
			if(folder.isDirectory() == false) {
				//경로를 설정한 폴더가 없다면
				folder.mkdir();//upload 폴더 생성
			}

			MultipartFile profile_image_file = iDto.getPROFILE_IMAGE_FILE();
			MultipartFile carrier_image_file = iDto.getCARRIER_IMAGE_FILE();
			MultipartFile cmp_reg_image_file = iDto.getCMP_REG_IMAGE_FILE();

			UUID uuid = UUID.randomUUID();

			iDto.setSYS_PROFILE_IMAGE(uuid.toString());
			//				+ "."+ iDto.getPROFILE_IMAGE().substring(iDto.getPROFILE_IMAGE().lastIndexOf(".") + 1));
			iDto.setPROFILE_IMAGE(profile_image_file.getOriginalFilename());
			iDto.setSYS_CARRIER_IMAGE(uuid.toString());
			//				+ "."+ iDto.getCARRIER_IMAGE().substring(iDto.getCARRIER_IMAGE().lastIndexOf(".") + 1));
			iDto.setCARRIER_IMAGE(carrier_image_file.getOriginalFilename());
			iDto.setSYS_CMP_REG_IMAGE(uuid.toString());
			//			+ "."+ iDto.getCMP_REG_IMAGE().substring(iDto.getCMP_REG_IMAGE().lastIndexOf(".") + 1));
			iDto.setCMP_REG_IMAGE(cmp_reg_image_file.getOriginalFilename());
			try {
				profile_image_file.transferTo(new File(filePath+iDto.getPROFILE_IMAGE()));	
				carrier_image_file.transferTo(new File(filePath+iDto.getCARRIER_IMAGE()));	
				cmp_reg_image_file.transferTo(new File(filePath+iDto.getCMP_REG_IMAGE()));	
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}

		try {
			mDao.MemberInsert(iDto);
			view = "redirect:insaInputForm";
			rttr.addFlashAttribute("msg", 1);
			System.out.println("등록성공");
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:insaInputForm";
			rttr.addFlashAttribute("msg", 2);
			System.out.println("등록실패");
		}


		mv.setViewName(view);
		return mv;
	}

	//직원 수정 메소드
	@Transactional
	public ModelAndView MemberUpdate(String sabun, InsaDto iDto, MultipartHttpServletRequest multi,
			RedirectAttributes rttr) throws IllegalStateException, IOException {
		mv = new ModelAndView();
		String view = null;
		iDto.setSABUN(sabun);
		System.out.println("넘겨받은 사번" + iDto.getSABUN());

		/*
		//비밀번호 암호화 처리
		//스프링 시큐리티는 암호화만 해줌.
		//복호화는 안해줌.
		System.out.println("1차구간");
		BCryptPasswordEncoder pwdEncoder =

				new BCryptPasswordEncoder();
		//비밀번호 암호화
		System.out.println("2차구간 PW : " + iDto.getPWD() +"ID : "+ iDto.getID());
		String encPwd = pwdEncoder.encode(iDto.getPWD());
		System.out.println("3차구간 암호화된 PW : "+encPwd);
		//저장
		iDto.setPWD(encPwd);
		System.out.println("3차구간");
		 */


		if(iDto.getCARRIER_IMAGE() != null||iDto.getCARRIER_IMAGE() != null || iDto.getPROFILE_IMAGE() != null) {

			//파일은 실제 물리 경로를 사용하여 저장해야 함.
			// upload 폴더에 저장하도록 지정.
			// 상대 경로 : resources/upload/
			String filePath = multi.getSession()
					.getServletContext()
					.getRealPath("/") + "resources/upload/";
			log.info(filePath);

			//upload 폴더 만들기
			File folder = new File(filePath);
			if(folder.isDirectory() == false) {
				//경로를 설정한 폴더가 없다면
				folder.mkdir();//upload 폴더 생성
			}

			MultipartFile profile_image_file = iDto.getPROFILE_IMAGE_FILE();
			MultipartFile carrier_image_file = iDto.getCARRIER_IMAGE_FILE();
			MultipartFile cmp_reg_image_file = iDto.getCMP_REG_IMAGE_FILE();

			UUID uuid = UUID.randomUUID();

			iDto.setSYS_PROFILE_IMAGE(uuid.toString());
			//				+ "."+ iDto.getPROFILE_IMAGE().substring(iDto.getPROFILE_IMAGE().lastIndexOf(".") + 1));
			iDto.setPROFILE_IMAGE(profile_image_file.getOriginalFilename());
			iDto.setSYS_CARRIER_IMAGE(uuid.toString());
			//				+ "."+ iDto.getCARRIER_IMAGE().substring(iDto.getCARRIER_IMAGE().lastIndexOf(".") + 1));
			iDto.setCARRIER_IMAGE(carrier_image_file.getOriginalFilename());
			iDto.setSYS_CMP_REG_IMAGE(uuid.toString());
			//			+ "."+ iDto.getCMP_REG_IMAGE().substring(iDto.getCMP_REG_IMAGE().lastIndexOf(".") + 1));
			iDto.setCMP_REG_IMAGE(cmp_reg_image_file.getOriginalFilename());
			try {
				profile_image_file.transferTo(new File(filePath+iDto.getPROFILE_IMAGE()));	
				carrier_image_file.transferTo(new File(filePath+iDto.getCARRIER_IMAGE()));	
				cmp_reg_image_file.transferTo(new File(filePath+iDto.getCMP_REG_IMAGE()));	
			} catch (Exception e) {
				// TODO: handle exception
			}	
		}

		try {
			mDao.MemberUpdate(iDto);
			view = "redirect:insaUpdateForm?sabun="+iDto.getSABUN();
			rttr.addFlashAttribute("msg", 3);
			System.out.println("수정완료");
		} catch (Exception e) {
			view = "redirect:insaUpdateForm?sabun="+iDto.getSABUN();
			rttr.addFlashAttribute("msg", 4);
			System.out.println("수정실패");
		}


		mv.setViewName(view);
		return mv;
	}

	//직원삭제 메소드
	@Transactional
	public ModelAndView MemberDelete(Integer sabun, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;

		try {
			mDao.MemberDelete(sabun);
			view = "redirect:insaListForm";
			rttr.addFlashAttribute("msg", 5);
		} catch (Exception e) {
			rttr.addFlashAttribute("msg", 6);
		}

		mv.setViewName(view);
		return mv;
	}
	//공통테이블 가져오는 메소드
	public List<Insa_ComDto> InputComList(){
		List<Insa_ComDto> iList = null;

		try {
			iList = mDao.getComList();			
		} catch (Exception e) {

		}

		return iList;
	}

	//사번체크메소드
	public int SabunChk() {
		int sabun = 0;

		try {
			sabun = mDao.SabunChk();
			sabun++;
			System.out.println("사번 및 공통테이블 가져오기 성공");
		} catch (Exception e) {
			System.out.println("사번체크오류");
		}

		return sabun;
	}

	public String idChk(String id) {
		String result = null;

		try {
			int chk = mDao.idChk(id);
			if(chk != 0) {
				result = "fail";
			}else {
				result = "success";
			}
		} catch (Exception e) {
			System.out.println("id체크 오류");
			e.printStackTrace();
		}

		return result;
	}

	public ModelAndView updateGetList(Integer sabun) {
		mv = new ModelAndView();
		InsaDto iDto = new InsaDto();
		List<Insa_ComDto> iList = null;

		try {			
			iDto=mDao.updateGetList(sabun);
			iList = mDao.getComList();
		} catch (Exception e) {

		}

		mv.addObject("iList", iList);
		mv.addObject("iDto", iDto);
		mv.setViewName("insaUpdateForm");
		return mv;
	}

	public ModelAndView getPage(InsaDto iDto, List<Insa_ComDto> iList) {
		mv = new ModelAndView();
		String view = "insaListForm";
		int totalRecordCount = 0;

		try {
			totalRecordCount = mDao.getListCount(iDto);	
			System.out.println("갯수계산성공!");
		} catch (Exception e) {
			// TODO: handle exception
		}

		PagingUtil PagingUtil = new PagingUtil();

		//페이지 처리를 위한 설정값
		int pageSize = 5;
		int blockPage = 2;

		//전체페이지 수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rowNum 구하기
		int PageNum = iDto.getPageNum() == 0 ? 1 : iDto.getPageNum();
		int start = (PageNum-1) * pageSize +1;
		int end = PageNum * pageSize;
		//위에서 계산한 start, end을 DTO에 저장
		iDto.setStartCnt(start);
		iDto.setEndCnt(end);


		List<InsaDto> mList = null;

		try {
			mList=mDao.getInsaList(iDto);
			System.out.println("성공");
		} catch (Exception e) {
			System.out.println("실패");
		}

		//페이지 번호에 대한 처리
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, PageNum, 
				"/controller/getInsaList?SABUN="+iDto.getSABUN()
				+"&POS_GBN_CODE="+iDto.getPOS_GBN_CODE()+"&NAME="+iDto.getNAME()+"&JOIN_DAY="+iDto.getJOIN_DAY()
				+"&JOIN_YN="+iDto.getJOIN_YN()+"&RETIRE_DAY="+iDto.getRETIRE_DAY()+"&PUT_YN="+iDto.getPUT_YN()
				+"&JOIN_GBN_CODE="+iDto.getJOIN_GBN_CODE()+"&");

		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		try {
			Date jdate = sf.parse(iDto.getJOIN_DAY());
			Date rdate = sf.parse(iDto.getRETIRE_DAY());				
			iDto.setRday(rdate);
			iDto.setJday(jdate);
			System.out.println("날짜뽀ㅃ기"+rdate+jdate);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}


		mv.addObject("iList", iList);
		mv.addObject("pagingImg", pagingImg);
		mv.addObject("mList", mList);
		mv.addObject("iDto", iDto);


		mv.setViewName(view);


		//		System.out.println("토탈카운트는 "+totalCount+" 입니다.");
		//		page.setPage(page.getNowPage(), totalCount, 3, 3);


		return mv;
	}


}
