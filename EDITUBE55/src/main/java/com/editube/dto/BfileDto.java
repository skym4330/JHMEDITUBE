package com.editube.dto;

import java.sql.Timestamp;

import com.editube.dto.BfileDto;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BfileDto {
	private String bf_oriName;
	private String bf_sysName;
}
