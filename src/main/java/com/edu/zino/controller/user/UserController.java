package com.edu.zino.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {
	
	
	@GetMapping("/")
	public ModelAndView getIndex(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("index");
		return mav;
	}
	
	@GetMapping("/default")
	public ModelAndView getDefault(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("default");
		return mav;
	}
	
	@GetMapping("/mypage")
	public ModelAndView getMypage() {
		ModelAndView mav = new ModelAndView("/user/mypage");
		return mav;
	}
	
	@GetMapping("/user/message")
	public ModelAndView getMessage() {
		ModelAndView mav = new ModelAndView("/user/message");
		return mav;
	}
	
}
