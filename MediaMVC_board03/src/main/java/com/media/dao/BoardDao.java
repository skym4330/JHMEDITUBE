package com.media.dao;

import java.util.*;//List, Map 클래스 사용.

import com.media.dto.BfileDto;
import com.media.dto.BoardDto;
import com.media.dto.ReplyDto;

public interface BoardDao {
	//게시글 목록 가져오는 메소드 getList
	public List<BoardDto> getList(Map<String, String> lmap);
	
	//페이징을 위한 게시글 목록 개수 가져오는 메소드
	public int getBoardCount();
	
	//조회수 수정 메소드
	public void viewUpdate(Integer bnum);
	
	//게시글 내용 가져오는 메소드
	public BoardDto getContents(Integer bnum);
	
	//해당 게시글의 댓글목록과 내용을 가져오는 메소드
	public List<ReplyDto> getReplyList(Integer bnum);

	//게시글 등록 메소드
	public void boardInsert(BoardDto board);
	
	//파일 정보 등록 메소드
	public void fileInsert(Map<String, String> fmap);
	
	//파일 목록 가져오는 메소드
	public List<BfileDto> getBfList(Integer bnum);

	//파일 실제 이름 가져오는 메소드
	public String getOriName(String sysFileName);
	
	//댓글 저장 메소드
	public void replyInsert(ReplyDto reply);

	//게시글 수정 메소드
	public void boardUpdate(BoardDto board);

	public void fileDelete(int bnum);

	public void replyDelete(int bnum);

	public void boardDelete(int bnum);

	public String getFileName(int bnum);

	public void fDelByName(String fname);

	public void fileUpdate(Map<String, String> fmap);
}







