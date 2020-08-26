package com.editube.dto;

import java.sql.Timestamp;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;



import lombok.Data;

@Data
public class CashDateDto {

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date eDate;

}