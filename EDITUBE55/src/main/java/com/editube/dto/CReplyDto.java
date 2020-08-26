package com.editube.dto;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class CReplyDto {
	private int r_num;
	private int r_cbnum;
	private String r_content;
	@JsonFormat(pattern = "yyyy-mm-dd hh:mm:ss")
	private Timestamp r_date;
	private String r_nickname;
	private String m_sysName;
}
