package com.editube.dao;

import java.util.List;
import java.util.Map;

import com.editube.dto.CBoardDto;
import com.editube.dto.CReplyDto;

public interface CBoardDao {

	public List<CBoardDto> getCList(Map<String, String> lmap);

	public int getCBoardCount(Integer cbstatus);

	public CBoardDto getCContent(Integer cbnum);
	
	public List<CReplyDto> getReplyList(Integer cbnum);
	
	public void cBoardInsert(CBoardDto board);

	public void ReplyInsert(CReplyDto reply);

	public void ReplyDelete(CReplyDto reply);

	public void cReplyDelete(int cbnum);

	public void cBoardDelete(int cbnum);

	public void cBoardUpdate(CBoardDto cboard);

}
