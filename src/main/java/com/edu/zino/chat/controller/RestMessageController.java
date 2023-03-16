package com.edu.zino.chat.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.zino.chat.model.MessageService;
import com.edu.zino.domain.Chat;
import com.edu.zino.domain.Member;
import com.edu.zino.util.MessageUtil;


@RestController
@RequestMapping("/rest")
public class RestMessageController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MessageService messageService;
	
	//채팅방생성할 때
	@PostMapping("/{teacher_user}/chat/message")
	public ResponseEntity<MessageUtil> insert(HttpServletRequest request, @PathVariable String teacher_user, @RequestBody Chat chat){
		
		Member member = new Member();
		
		
		logger.info("chat is "+chat);
		
		//로그인 하면 session에서 로그인 정보를 가져오므로 get으로 가져올 필요는 없음
		if(chat.getMember_teacher() == null) {
			int member_teacher_idx = 1;
			member.setMember_idx(member_teacher_idx);
			chat.setMember_teacher(member);
		}else {
			int member_idx = 1;
		}
		
		//3단계
		messageService.insert(chat); //채팅방 생성하기
		messageService.select(chat); //채팅방 검색하기
		MessageUtil messageUtil = new MessageUtil();
		messageUtil.setMsg("채팅방 생성");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(messageUtil, HttpStatus.OK);
		
		return entity;
	}
	

}
