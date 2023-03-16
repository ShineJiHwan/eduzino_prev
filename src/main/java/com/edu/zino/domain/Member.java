package com.edu.zino.domain;

import java.util.List;

import lombok.Data;

@Data
public class Member {
	private int member_idx;//고유키
	private String member_email;//이메일
	private String member_nickname;//이름
	private String member_regdate;//가입일
	private String member_birth;//생년월일
	private String member_photo;//프로필사진
	private Sns_name social_login;//로그인 방식
	
}
