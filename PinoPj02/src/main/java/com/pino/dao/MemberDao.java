package com.pino.dao;

import java.util.List;
import java.util.Map;

import com.pino.dto.InsaDto;
import com.pino.dto.Insa_ComDto;

public interface MemberDao {

	public void MemberInsert(InsaDto iDto);

	public int SabunChk();

	public int idChk(String id);

	public List<Insa_ComDto> getComList();

	public List<InsaDto> getInsaList(InsaDto iDto);

	public InsaDto updateGetList(int sabun);

	public void MemberUpdate(InsaDto iDto);

	public void MemberDelete(int sabun);

	public void fileInsert(Map<String, String> fmap);

	public int getListCount(InsaDto iDto);
	
}
