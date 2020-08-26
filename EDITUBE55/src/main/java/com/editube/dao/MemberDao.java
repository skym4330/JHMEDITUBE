package com.editube.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.editube.dto.CashDto;
import com.editube.dto.ChatbotDto;
import com.editube.dto.EBoardDto;
import com.editube.dto.MemberDto;
import com.editube.dto.RatingDto;
import com.editube.dto.RequestDto;
import com.editube.dto.UBoardDto;

public interface MemberDao {

	//패스워드를 가져오는 메소드
	public String getPwd(String id);
	//로그인한 회원 정보를 가져오는 메소드
	public MemberDto getMemInfo(String id);
	//회원 가입 처리 메소드
	public void memberInsert(MemberDto member);
	//중복 ID 확인 메소드
	public int idCheck(String mid);
	//소셜 로그인 회원인증 관련 메소드
	public void authentication(MemberDto dto);
	
	public int nickCheck(String mnickname);
	
	public void typechange(String nick);
	
	public void typechangee(String nick);
	
	public MemberDto getMemInfoo(String nick);
	
	public void changepass(Map<String,Object> rmap);
	
	public void deleterp(String nk);
	
	public void fileInsert(Map<String, String> fmap);
	
	public void fileDelete(String nick);
	
	public MemberDto Idfind(Map<String,String> rmap);
	
	public MemberDto pwfind(String mid);
	
	public void pwch(HashMap<String, Object> rmap);
	
	public MemberDto getMemIn(String mr);
	
	public List<MemberDto> allmem(String nick);
	
	public void mdelete(String m_nickname);
	
	public List<MemberDto> searchmem(Map<String, String> lmap);
	
////////////////////////////////////////////////////////////////////////////////////


//////////////캐시 관련 메소드들 //////////
//캐시 충전 내역 추가 메소드ㅇ
public void chargingList(CashDto cash);

//캐시 전환 내역 추가 메소드ㅇ
public void changemoney(CashDto cash);

//전체 수입캐시 가져오는 메소드
public Integer getTotalInCash(CashDto cash);

//전체 지출캐시 가져오는 메소드
public Integer getTotalOutCash(CashDto cash);

//보유 캐시 업데이트 메소드
public void countMyCash(CashDto cash);

//캐시 내역 총 개수 구하는 메소드
public int getCashCount();

//캐시 내역 불러오는 메소드
public List<CashDto> getCashList(Map<String, String> lmap);

//캐시 내역 날짜 조회하는 메소드
public List<CashDto> cashSearch(Map<String, String> lmap);

//혜명메소드
//마이페이지 요청관리(전체메뉴)
public List<RequestDto> getAllReqList(String nickname);

//마이페이지 요청관리(서브메뉴)
public List<RequestDto> getReqList(Map<String, String> lmap);

//마이페이지 요청버튼관리
public void statusChange(RequestDto rDto);

//평점등록하기
public void InsertRatFrm(RatingDto raDto);

//마이 유튜브 페이지 요청관리 리스트 가져오기
public List<RequestDto> getUReqList(String m_nickname);

//마이 에디터 페이지 요청관리 리스트 가져오기
public List<RequestDto> getEReqList(String m_nickname);

//요청문
public void goReq(RequestDto request);

//관리자 관리 리스트 메소드
public List<RequestDto> getmDeal(Integer num);

//해당 거래의 status 가져오기
public RequestDto chkStatus(Integer rnum);

//해당 에디터 게시물의 가격가져오기
public EBoardDto getPortCash(String nick);

//해당 유튜버 게시물의 가격가져오기
public UBoardDto getUCash(Integer bnum);

//유튜버의 돈을 관리자에게
public void CashGoMaster(Map<String, String> lmap);

//관리자의 돈을 에디터에게
public void CashGoEdit(Map<String, String> lmap);

//1번(거래요청받음) 과 5번(완료요청받음)만 가져오는 메소드
public List<RequestDto> getAlertReq(String nick);

//후기여부 확인 메소드
public int getRatChk(int bnum);

//진행중인 채팅내역 불러오기
public List<ChatbotDto> getChatList(String nick);

//완료된거래 채팅내역 삭제
public void deleteChat(Map<String, String> cmap);

//1번 거래 개수 구하기
public int getOneReq(String nick);

//5번 거래 개수 구하기
public int getFiveReq(String nick);

//pnum구해오기
public EBoardDto getPNum(String nick);
/////////

//관리자 회원 탈퇴 페이지에서 닉네임 검색하는 메소드
public List<MemberDto> dealMemNickSearch(Map<String, String> lmap);


}
