package com.editube.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;

import com.editube.dto.UBoardDto;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class UBoardDto {
	private int ubnum;
	private String nickname;
	private String ubnickname;
	private String ubcontent;
	private String ubtitle;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Timestamp ubtimepart;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public Date ubdeadline;
	private String ubstatus;
	private String ubpositiontype;
	private int ubcost;
	private int ubview;
	private String msysname;
	private String moriname;
	private int chk;
}
