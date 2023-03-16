package com.edu.zino.controller.teacher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.domain.Member;
import com.edu.zino.domain.OrderDetail;
import com.edu.zino.domain.OrderSummary;
import com.edu.zino.domain.Subject;
import com.edu.zino.domain.Teacher;
import com.edu.zino.model.teacher.OrderSummaryService;
import com.edu.zino.model.teacher.SubjectService;

//강사페이지 관련
@Controller
public class TeacherController {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrderSummaryService orderSummaryService;
	
	@Autowired
	private SubjectService subjectService;
	
	
	@GetMapping("/index")
	public ModelAndView getMain(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/teacher/index");
		return mav;
	}
	
	@GetMapping("/default")
	public ModelAndView getDefault(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/teacher/default");
		return mav;
	}

	@RequestMapping(value="/student/studentManagement", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getStudentManagement(HttpServletRequest request) {
		
		//로그인 하면 session에서 teacher_idx를 가져오므로 getMapping으로 가져올 필요는 없음
		int teacher_idx = 1;
		
		List<OrderSummary> orderSummaryList = null;

		List<Subject> subjectList = subjectService.selectAllByTeacher(teacher_idx); //과목명
		

		String subject_idx = request.getParameter("subject_idx");
		String member_nickname = request.getParameter("member_nickname");
		
		logger.info("subject_idx"+subject_idx);
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("teacher_idx", teacher_idx);
		searchMap.put("subject_idx", subject_idx);				
		searchMap.put("member_nickname", member_nickname);
		
		/*
		 *서비스에서 실행 
		 if(subject_idx == null && member_nickname == null || subject_idx.equals("0") && member_nickname == null) {
			orderSummaryList = orderSummaryService.selectAllByTeacher(teacher_idx);
		}else {
			Map<String, Object> searchMap = new HashMap<String, Object>();
			searchMap.put("teacher_idx", teacher_idx);
			searchMap.put("subject_idx", subject_idx);				
			searchMap.put("member_nickname", member_nickname);
			
			
			logger.info(searchMap.toString());
			orderSummaryList = orderSummaryService.selectAllBySubjectTitleMemberNickname(searchMap);
			
		}
		*/
		
		orderSummaryList = orderSummaryService.selectAllBySearch(searchMap);
		
		
		ModelAndView mav = new ModelAndView("/teacher/student/studentManagement");
		mav.addObject("subjectList", subjectList); //과목명
		mav.addObject("orderSummaryList", orderSummaryList);
		
		return mav;
	}
	


}
