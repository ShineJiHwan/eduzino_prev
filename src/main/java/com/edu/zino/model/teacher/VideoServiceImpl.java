package com.edu.zino.model.teacher;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.zino.domain.Video;
import com.edu.zino.exception.VideoException;

@Service
public class VideoServiceImpl implements VideoService{

	@Autowired
	private MybatisVideoDAO mybatisVideoDAO;
	
	@Override
	public void insert(List<Video> videos) throws VideoException{
		mybatisVideoDAO.insert(videos);
	}

	@Override
	public List<Video> selectAllByTeacher(int teacher_idx) {
		return mybatisVideoDAO.selectAllByTeacher(teacher_idx);
	}

	@Override
	public void update(Video video) throws VideoException{
		mybatisVideoDAO.update(video);
	}

	@Override
	public void removeUpdate(int video_idx) throws VideoException{
		mybatisVideoDAO.removeUpdate(video_idx);
	}

	@Override
	public void delete(List<Video> videos) throws VideoException{
		mybatisVideoDAO.delete(videos);
	}

}
