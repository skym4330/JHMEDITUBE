package com.media.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardDto {
	private int bnum;
	private String btitle;
	private String bcontents;
	private String bid;//작성자 ID
	private String mname;
	private Timestamp bdate;
	private int bviews;
}




