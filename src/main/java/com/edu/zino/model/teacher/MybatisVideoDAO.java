package com.edu.zino.model.teacher;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.edu.zino.domain.Video;
import com.edu.zino.exception.VideoException;

@Repository
public class MybatisVideoDAO implements VideoDAO{
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	@Override
	public void insert(List<Video> videos) throws VideoException{
		int result = sessionTemplate.insert("Video.insert", videos);
		if(result < 1) {
			throw new VideoException("영상등록실패");
		}
	}

	@Override
	public List<Video> selectAllByTeacher(int teacher_idx) {
		return sessionTemplate.selectList("Video.selectAllByTeacher",teacher_idx);
	}

	@Override
	public void update(Video video) throws VideoException{
		int result = sessionTemplate.update("Video.update", video);
		if(result < 1) {
			throw new VideoException("영상수정실패");
		}
	}

	@Override
	public void removeUpdate(int video_idx) throws VideoException{
		int result = sessionTemplate.update("Video.removeUpdate", video_idx);
		if(result < 1) {
			throw new VideoException("영상삭제요청실패");
		}
	}

	@Override
	public void delete(List<Video> videos) throws VideoException{
		int result = sessionTemplate.update("Video.delete", videos);
		if(result < 1) {
			throw new VideoException("영상삭제실패");
		}
	}
	
	
	
	
}
