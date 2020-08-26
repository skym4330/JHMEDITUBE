package com.editube.dto;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyDto {
	private int r_num;//PK
	private int r_cbnum;//FK. board의 PK.
	private	String r_contents;
	//date 처리시 json 객체로 변환할 때 
	//문자열(jsp에서의 날짜) -> json으로 변환
	//jackson 라이브러리에서 처리할 수 있도록
	//패턴을 지정
	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Timestamp r_date;
	private String r_nickname;//댓글 작성자 id(로그인 id)
}






