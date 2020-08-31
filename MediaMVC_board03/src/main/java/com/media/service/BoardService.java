package com.media.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.media.dao.BoardDao;
import com.media.dto.BfileDto;
import com.media.dto.BoardDto;
import com.media.dto.MemberDto;
import com.media.dto.ReplyDto;
import com.media.util.Paging;

import lombok.extern.java.Log;

@Service
@Log
public class BoardService {
	//DAO 객체
	@Autowired
	private BoardDao bDao;

	//데이터 전달 객체 : ModelAndView
	ModelAndView mv;

	//세션
	@Autowired
	private HttpSession session;

	//페이지 당 글 개수 조정 변수
	private int listCount = 5;
	private int pageCount = 2;

	//게시글 목록 가져오는 서비스 메소드
	public ModelAndView getBoardList(Integer pageNum) {
		log.info("getBoardList() - pageNum : " + pageNum);

		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		//맵을 만들어서 페이지번호와 글목록 개수를 저장
		Map<String, String> lmap = 
				new HashMap<String, String>();
		lmap.put("pageNum", String.valueOf(num));
		lmap.put("cnt", String.valueOf(listCount));

		List<BoardDto> bList = bDao.getList(lmap);

		
		mv.addObject("bList", bList);

		String paging = getPaging(num);
		mv.addObject("paging", paging);

		//세션에 페이지 번호 저장.
		session.setAttribute("pageNum", num);

		//view name을 지정!
		mv.setViewName("boardList");

		return mv;
	}

	private String getPaging(int num) {
		//전체 글 개수 구하기
		int maxNum = bDao.getBoardCount();
		String listName = "list";//게시판 uri

		Paging paging = new Paging(maxNum, num, 
				listCount, pageCount, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;
	}

	public ModelAndView getContents(Integer bnum) {
		mv = new ModelAndView();

		//조회수 증가.DB
		bDao.viewUpdate(bnum);

		//게시글 번호로 글 내용 검색 결과 받아오기.(DB) 
		BoardDto board = bDao.getContents(bnum);
		mv.addObject("board", board);

		//게시글 번호에 해당하는 댓글 목록/내용(DB)
		List<ReplyDto> replyList = bDao.getReplyList(bnum);
		mv.addObject("rList", replyList);

		//게시글 번호에 해당하는 파일 정보 목록(DB)
		List<BfileDto> bfList = bDao.getBfList(bnum);
		mv.addObject("bfList", bfList);

		mv.setViewName("boardContents");

		return mv;
	}

	//insert, update, delete 작업용 메소드는 
	//트랜잭션 처리가 필요
	@Transactional
	public String boardInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		String view = null;

		//Multipart request에서 데이터 추출
		String title = multi.getParameter("btitle");
		String contents = multi.getParameter("bcontents");
		int fcheck = Integer.parseInt
				(multi.getParameter("fileCheck"));
		String id = multi.getParameter("bid");
		/*//다음과 같이 세션에서 id값을 꺼내올 수도 있음.
		MemberDto mem = (MemberDto)session.getAttribute("mb");
		String id = mem.getM_id();
		 */

		//일반적으로 textarea에서 들어오는 데이터는
		//본 내용 앞 뒤에 쓸데없는 공백이 포함됨.
		//공백 제거 처리. trim()
		contents = contents.trim();

		BoardDto board = new BoardDto();
		board.setBid(id);
		board.setBtitle(title);
		board.setBcontents(contents);

		//insert, update, delete를 할 경우
		//웬만하면....... try/catch로 처리해 주세요...
		try {
			bDao.boardInsert(board);

			view = "redirect:list";
			rttr.addFlashAttribute("check", 2);

			//파일 저장 처리
			log.info("boardInsert - filecheck: " + fcheck);
			if(fcheck == 1) {
				//업로드할 파일이 있음.
				fileUp(multi, board.getBnum());
			}
		}catch (Exception e) {
			//DB 삽입 오류 시 글쓰기폼으로 돌아감.
			view = "redirect:writeFrm";
			rttr.addFlashAttribute("check", 1);
		}

		return view;
	}

	private void fileUp
	(MultipartHttpServletRequest multi, int bnum) 
			throws IllegalStateException, IOException {
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

		//실제 파일명과 저장 파일명을 함께 관리
		Map<String, String> fmap = 
				new HashMap<String, String>();
		//파일 정보 저장(DB)에 필요한 정보
		//1.게시글 번호, 2.실제파일명, 3.저장파일명
		fmap.put("bnum", String.valueOf(bnum));

		//multipart에서 파일 꺼내오기
		//멀티파트는 파일을 배열형태로 저장.
		List<MultipartFile> fList =
				multi.getFiles("files");

		for(int i = 0; i < fList.size(); i++) {
			MultipartFile mf = fList.get(i);
			//파일의 실제 이름 가져오기
			String oriName = mf.getOriginalFilename();
			//실제 파일명을 맵에 저장
			fmap.put("oriFileName", oriName);
			//저장 파일명 작성(밀리초 값을 사용)
			String sysName = System.currentTimeMillis()
					+ "."
					+ oriName.substring
					(oriName.lastIndexOf(".") + 1);
			fmap.put("sysFileName", sysName);
			//로그에 찍어서 확인
			log.info("fileUP() - oriName:" + oriName);
			log.info("fileUP() - sysName:" + sysName);

			//저장 위치로 파일 전송
			//새로 만든 파일이름으로 지정된 경로에 전송
			mf.transferTo(new File(filePath+sysName));
			//DB에 파일 정보 저장(dDao)
			bDao.fileInsert(fmap);
		}
	}

	public void fileDown(String sysFileName, 
			HttpServletRequest req, 
			HttpServletResponse resp) {
		//파일 경로 찾기
		String filePath = req.getSession()
				.getServletContext()
				.getRealPath("/") + "resources/upload/";

		//DB에서 sysFileName으로 oriFileName 검색
		String oriName = bDao.getOriName(sysFileName);

		//실제 파일 저장 폴더 경로와 파일 지정
		filePath += sysFileName;

		//서버의 디스크(폴더)에 저장된 파일을 읽어오는 객체
		InputStream is = null;
		//사용자의 컴퓨터에 파일을 보내는 객체
		OutputStream os = null;

		try {
			//파일명의 한글 깨짐 방지(encoding)
			String dFileName = URLEncoder.encode
					(oriName, "UTF-8");

			//파일 객체 생성
			File file = new File(filePath);
			//저장된 파일과 메모리 상의 파일 객체의 연결
			is = new FileInputStream(filePath);

			//응답(response) 객체의 헤더 설정.
			resp.setContentType("application/octet-stream");
			resp.setHeader("content-Disposition",
					"attachment; filename=\"" 
							+ dFileName + "\"");
			//attachment; filename="p2.jpg"

			//사용자 컴퓨터로 통로 연결
			os = resp.getOutputStream();

			//파일 전송
			byte[] buffer = new byte[1024];
			int length;
			while((length = is.read(buffer)) != -1) {
				os.write(buffer, 0, length);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				os.flush();//남아있는 출력 스트림의 데이터를
				//모두 전송해라~~~
				//출력 스트림(os)를 close하기 전에 flush 할것.
				os.close();
				is.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public Map<String, List<ReplyDto>> rInsert(ReplyDto reply) {
		Map<String, List<ReplyDto>> rMap = null;

		try {
			//1. 넘어온 댓글 -> DB에 insert 처리
			bDao.replyInsert(reply);
			//2. 새로 추가된 댓글 포함 전체 댓글 목록 가져오기
			List<ReplyDto> rList = bDao.getReplyList
					(reply.getR_bnum());
			//3. 전체 댓글 목록을 rMap에 추가하여 반환
			rMap = new HashMap<String, List<ReplyDto>>();
			rMap.put("rList", rList);
		}catch (Exception e) {
			e.printStackTrace();
			rMap = null;
		}
		return rMap;
	}

	public ModelAndView updateFrm(int bnum, RedirectAttributes rttr) {
		mv = new ModelAndView();
		String view = null;

		BoardDto board = bDao.getContents(bnum);
		MemberDto member = 
				(MemberDto)session.
				getAttribute("mb");
		String sId = member.getM_id();

		if(board.getBid().equals(sId)) {
			mv.addObject("board", board);
			List<BfileDto> bfList = bDao.getBfList(bnum);
			mv.addObject("bfList", bfList);
			view = "updateFrm";
		}
		else {
			view = "redirect:contents?bnum=" + bnum;
			rttr.addFlashAttribute("check", 1);
		}

		mv.setViewName(view);

		return mv;
	}

	@Transactional
	public String boardUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {

		int num = Integer.parseInt(multi.getParameter("bnum"));
		String title = 
				multi.getParameter("btitle");
		String contents = 
				multi.getParameter("bcontents");
		int fcheck = Integer.parseInt
				(multi.getParameter("fileCheck"));

		contents = contents.trim();
		//int check = Integer.parseInt(
		//		multi.getParameter("fileCheck"));

		String id = multi.getParameter("bid");
		log.info(title + "," + contents + ","
				+ id);

		BoardDto board = new BoardDto();
		board.setBnum(num);
		board.setBtitle(title);
		board.setBid(id);
		board.setBcontents(contents);

		String view = null;

		try {
			bDao.boardUpdate(board);

			if(fcheck == 1) {
				String fname = bDao.getFileName(num);
				sysFileDel(fname);
				
				fileChange(multi, num);
			}

			rttr.addFlashAttribute("check", 2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			rttr.addFlashAttribute("check", 3);
		}

		view = "redirect:contents?bnum=" 
				+ num;

		return view;
	}

	private void fileChange(MultipartHttpServletRequest multi, int num)
			throws IllegalStateException, IOException {
		//저장공간의 물리적 경로 구하기
		String path = multi.getSession()
				.getServletContext()
				.getRealPath("/");

		path += "resources/upload/";
		log.info(path);

		File dir = new File(path);
		if(dir.isDirectory() == false) {
			//위에 설정한 경로의 폴더가 없다면
			dir.mkdir();//upload 폴더 생성.
		}

		//실제 파일명과 저장 파일명을 함께 관리
		Map<String, String> fmap = 
				new HashMap<String, String>();
		//map이 문자만 저장하도록 만들었기 때문에
		//게시글 번호를 문자열로 변환하여 저장.
		fmap.put("bnum", String.valueOf(num));

		boolean fResult = false;

		List<MultipartFile> fList = 
				multi.getFiles("files");

		for(int i = 0; i < fList.size(); i++) {
			//파일 메모리에 저장
			MultipartFile mf = fList.get(i);
			String oriName = mf.getOriginalFilename();
			fmap.put("oriFileName", oriName);
			String sysName = System.currentTimeMillis()
					+ "."
					+ oriName.substring
					(oriName.lastIndexOf(".")+1);
			fmap.put("sysFileName", sysName);

			mf.transferTo(new File(path+sysName));

			bDao.fileUpdate(fmap);
		}
	}

	@Transactional
	public String deleteBoard(int bnum, RedirectAttributes rttr) {
		String view = null;

		try {
			// 파일 삭제
			String fname = bDao.getFileName(bnum);
			sysFileDel(fname);
			bDao.fileDelete(bnum);
			// 댓글리스트 삭제
			bDao.replyDelete(bnum);
			// 원글 삭제
			bDao.boardDelete(bnum);

			view = "redirect:list";
			rttr.addFlashAttribute("check", 3);
		}catch(Exception e) {
			view = "redirect:contents?bnum=" + bnum;
			rttr.addFlashAttribute("check", 4);
		}

		return view;
	}

	private void sysFileDel(String fname) throws Exception {
		log.info("sysFileDel() - fname: " + fname);

		if(fname == null) {
			return;
		}

		String path = session.getServletContext().getRealPath("resources/upload/");
		log.info("sysFileDel() - filePath: " + path);

		File file = new File(path + fname);

		if(file.exists()){
			if(file.delete()){
				log.info("파일 삭제 성공");
			}else{
				throw new Exception("파일삭제 실패");
			}
		}else{
			throw new Exception("파일이 존재하지 않습니다.");
		}
	}

	public String fileDelete(String fname) {
		String result = null;

		try {
			sysFileDel(fname);
			bDao.fDelByName(fname);
			result = "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result = "fail";
		}
		return result;
	}
}








