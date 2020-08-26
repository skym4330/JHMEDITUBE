package com.editube.dto;

import java.sql.Timestamp;

import com.editube.dto.EBoardDto;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class EBoardDto {
	private int pnum;
	private String pnickname;
	private String ptitle;
	private String pcontent;
	private int pcost;
	private String plink;
	private String pstatus;
	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Timestamp ptimepart;
	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Timestamp predate;
	private int pview;
	private String msysname;
	private String moriname;
	private int chk;
}
