package com.editube.dto;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class memsearchDto {
	   @DateTimeFormat(pattern = "yyyy-MM-dd")
	   private Date reqDatestart;
	   @DateTimeFormat(pattern = "yyyy-MM-dd")
	   private Date reqDateend;
}
