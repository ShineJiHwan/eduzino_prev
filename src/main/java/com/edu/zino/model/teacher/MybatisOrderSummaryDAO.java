package com.edu.zino.model.teacher;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.edu.zino.domain.OrderSummary;

@Repository
public class MybatisOrderSummaryDAO implements OrderSummaryDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAllByTeacher(int teacher_idx) {
		return sqlSessionTemplate.selectList("OrderSummary.selectAllByTeacher", teacher_idx);
	}

	@Override
	public List selectAllBySubjectTitleMemberNickname(Map<String, Object> searchMap) {
		return sqlSessionTemplate.selectList("OrderSummary.selectAllBySubjectTitleMemberNickname", searchMap);
	}
	


}
