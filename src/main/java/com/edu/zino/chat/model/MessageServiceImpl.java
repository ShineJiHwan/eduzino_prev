package com.edu.zino.chat.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.zino.domain.Chat;
import com.edu.zino.exception.ChatException;

@Service
public class MessageServiceImpl implements MessageService {
	
	@Autowired
	private MessageDAO messageDAO;

	//수강생 조회
	@Override
	public List selectAllByTeacher(int teacher_idx) {
		return messageDAO.selectAllByTeacher(teacher_idx);
	}
	
	//채팅방생성
	@Override
	public void insert(Chat chat) throws ChatException {
		messageDAO.insert(chat);
	}
	
	
	//채팅방조회
	@Override
	public List select(Chat chat) {
		List<Chat> chatList = null;
		if(chat.getMember_teacher() != null) {
			int member_teacher_idx = chat.getMember_teacher().getMember_idx();
			chatList = messageDAO.selectByTeacher(member_teacher_idx);
		}else {
			int member_idx = chat.getMember().getMember_idx();
			chatList = messageDAO.selectByStudent(member_idx);
		}
		
		return chatList;
	}

}
