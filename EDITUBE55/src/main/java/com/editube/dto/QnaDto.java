package com.editube.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class QnaDto {
   private int q_num;
   private int q_pnum;
   private String q_nickname;
   @JsonFormat(pattern = "yyyy-MM-dd")
   private Date q_date;
   private String q_content;
   private int qnaNum;
}