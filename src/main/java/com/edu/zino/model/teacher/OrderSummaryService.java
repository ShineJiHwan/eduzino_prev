package com.edu.zino.model.teacher;


import java.util.List;
import java.util.Map;

import com.edu.zino.domain.OrderSummary;

public interface OrderSummaryService {
	//과목검색
	public List selectAllByTeacher(int teacher_idx);
	
	//과목, 닉네임으로 검색
	public List selectAllBySearch(Map<String, Object> searchMap);
	
	
}
