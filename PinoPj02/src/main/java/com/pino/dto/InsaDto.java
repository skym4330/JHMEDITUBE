package com.pino.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class InsaDto {
	private int pageNum;
	private int startCnt, endCnt;
	private int max;
	private Date jday;
	private Date rday;
	private String SABUN;
	private String JOIN_DAY;
	private String RETIRE_DAY;
	private String PUT_YN;
	private String NAME;
	private String REG_NO;
	private String ENG_NAME;
	private String PHONE;
	private String HP;
	private String CARRIER;
	private String POS_GBN_CODE;
	private String CMP_REG_NO;
	private MultipartFile CMP_REG_IMAGE_FILE;
	private String CMP_REG_IMAGE;
	private String SEX;
	private int YEARS;
	private String EMAIL;
	private String ZIP;
	private String ADDR1;
	private String ADDR2;
	private String DEPT_CODE;
	private String JOIN_GBN_CODE;
	private String ID;
	private String PWD;
	private int SALARY;
	private String KOSA_REG_YN;
	private String KOSA_CLASS_CODE;
	private String MIL_YN;
	private String MIL_TYPE;
	private String MIL_LEVEL;
	private String MIL_STARTDATE;
	private String MIL_ENDDATE;
	private String JOB_TYPE;
	private String GART_LEVEL;
	private String SELF_INTRO;
	private String CRM_NAME;
	private MultipartFile PROFILE_IMAGE_FILE;
	private String PROFILE_IMAGE;
	private MultipartFile CARRIER_IMAGE_FILE;
	private String CARRIER_IMAGE;
	private String JOIN_YN;
	private String DOMAIN;
	private String PWDCHK;
	private String ORI_CMP_REG_IMAGE;
	private String SYS_CMP_REG_IMAGE;
	private String SYS_PROFILE_IMAGE;
	private String SYS_CARRIER_IMAGE;
}
