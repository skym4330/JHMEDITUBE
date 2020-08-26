package com.editube.dto;

import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CBoardDto {
	private int ronum;
	private int cbnum;
	private String cbtitle;
	private String cbcontent;
	private String cbnickname;
	private int cbstatus;
	@DateTimeFormat(pattern="yyyy-MM-dd hh:mm:ss")
	private Timestamp cbdate; 	
	private String msysName;
}
