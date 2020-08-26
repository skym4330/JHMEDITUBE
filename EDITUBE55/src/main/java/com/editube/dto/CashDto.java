package com.editube.dto;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class CashDto {
	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Timestamp ca_date;
	private String ca_mnickname;
	private String ca_targetnickname;
	private int ca_incash;
	private int ca_outcash;
	private int m_mycash;
	private int ca_type;
	private int ca_cancel;
	//1번 충전 2번 환전 3번 돈지금 4번 돈받음
}
