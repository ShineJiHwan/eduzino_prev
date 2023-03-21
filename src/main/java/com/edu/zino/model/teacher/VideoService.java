package com.edu.zino.model.teacher;

import java.util.List;

import com.edu.zino.domain.Video;

public interface VideoService {
	public void insert(List<Video> videos);
	public List<Video> selectAllByTeacher(int teacher_idx);
	public void update(Video video);
	public void removeUpdate(int video_idx);
	public void delete(List<Video> videos);
}
