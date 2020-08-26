package com.editube.dao;

import java.util.*;

import com.editube.dto.BfileDto;
import com.editube.dto.CBoardDto;
import com.editube.dto.ChatbotDto;
import com.editube.dto.EBoardDto;
import com.editube.dto.QnaDto;
import com.editube.dto.RatingDto;
import com.editube.dto.UBoardDto;
import com.editube.dto.UScriptDto;
import com.editube.dto.ReplyDto;
import com.editube.dto.RequestDto;
public interface BoardDao {

	public List<UBoardDto> getUList(Map<String, String> lmap);

	public List<UBoardDto> getTList(Map<String, String> lmap);
	
	public List<UBoardDto> getDList(Map<String, String> lmap);

	public List<UBoardDto> getTLista(Map<String, String> lmap);
	
	public List<UBoardDto> getTListb(Map<String, String> lmap);
	
	public int getUTBoardCount(Map<String, String> lmap);
	
	public int getUDBoardCount(Map<String, String> lmap);

	public UBoardDto getUTContent(Integer ubnum);
	
	public UBoardDto getUDContent(Integer ubnum);
	
//	public List<UBoardDto> getUTContentSc(Map<String, String> lmap);
	public UBoardDto getUTContentSc(Integer ubnum);
	
	public UBoardDto getUDContentSc(Integer ubnum);
	
	public UBoardDto getUContent(Integer ubnum);
	
	public void viewUpdate(Integer bnum);


	public void uboardInsert(UBoardDto uboard);

	public void boardUpdate(UBoardDto uboard);

	public void boardUDelete(int ubnum);

	public void uscript(UScriptDto uscript);

	public void uscriptdel(int ubnum);

	public UScriptDto uscriptlist(Integer ubnum);

	public List<UBoardDto> getTListSc(Map<String, String> lmap);

	public List<UBoardDto> getDListSc(Map<String, String> lmap);

	public int getUTBoardCountSc(String status);

	public int getUDBoardCountSc(String status);

	//혜명
	
	public List<ChatbotDto> getCList(Map<String, String> lmap);

	public void chatInsert(ChatbotDto cDto);

	public RequestDto chkReq(Integer ubnum);
	
	public RequestDto chkEReq(String nick);

	public int getLastNum();
	
	//성기
	
		//편집자 게시판 관련
		//편집자 게시판 목록
		public List<EBoardDto> getPList(Map<String, String> lmap);

		//조회수 증가
		public void viewPUpdate(Integer bnum);
		
		//편집자 게시글 
		public EBoardDto getPContents(Integer bnum);
		
		
		public int getPBoardCount(String pstatus);
		
		//Q&a 목록 불러오기
		public List<QnaDto> getQna(QnaDto qna);
		
		//평점 목록 불러오기
	    public List<RatingDto> getRate(Map<String, String> rmap);
		
		//조회순
		public List<EBoardDto> sortView(Map<String, String> lmap);
		
		//나의 포트폴리오
		public EBoardDto getPort(String nick);
		
		//나의 포트폴리오 수정
		public void portUpdate(EBoardDto pDto);

		//날짜 갱신
		public void dateUp(EBoardDto pDto);
		
		//포트폴리오 작성
		public void portInsert(EBoardDto pDto);

		//날짜 갱신
		public void reDate(EBoardDto pDto);

		public List<UBoardDto> getTListasc(Map<String, String> lmap);

		public List<UBoardDto> getTListbsc(Map<String, String> lmap);

		

		public void pscript(UScriptDto uscript);

		public EBoardDto getPTContentSc(int pnum);

		public void pscriptdel(int pnum);

		public List<EBoardDto> getPListasc(Map<String, String> lmap);

		public int getPScBoardCount(String nickname);

		public UScriptDto pscriptlist(Integer pnum);
		
		//Q&A 작성
		public void qInsert(QnaDto qDto);

		public int getUDTBoardCount(Map<String, String> lmap);

		public List<UBoardDto> getTDList(Map<String, String> lmap);
		
	
}
