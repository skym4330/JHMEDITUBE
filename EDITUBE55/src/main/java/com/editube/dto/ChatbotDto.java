package com.editube.dto;

import lombok.Data;
import oracle.sql.TIMESTAMP;

@Data
public class ChatbotDto {
	private int ch_num;
	private String ch_mnickname;
	private String ch_content;
	private String ch_targetnickname;
	private TIMESTAMP ch_date;
}
