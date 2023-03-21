package com.edu.zino.controller.teacher;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.zino.domain.Video;
import com.edu.zino.model.teacher.VideoService;

@RestController
@RequestMapping("/rest")
public class RestVideoController {
	
	@Autowired
	private VideoService videoService;
	
	@GetMapping("/videos/{teacher_idx}")
	public ResponseEntity<List<Video>> getVideoByTeacher(@PathVariable("teacher_idx") int teacher_idx){
		List<Video> videoList = videoService.selectAllByTeacher(teacher_idx);
		ResponseEntity<List<Video>> entity = new ResponseEntity<>(videoList,HttpStatus.OK);
		return entity;
	}
	
}
