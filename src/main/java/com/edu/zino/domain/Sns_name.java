package com.edu.zino.domain;

import lombok.Data;

@Data
public class Sns_name {
	private int sns_name_idx;
	//0:구글	1:네이버 2:카카오
	private String sns_type;
}
