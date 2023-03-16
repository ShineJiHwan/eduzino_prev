package com.edu.zino.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OrderController {
	//주문체크 보여주기
	@GetMapping("/order/ordercheck")
	public ModelAndView getOrderCheck() {
		return new ModelAndView("/user/order/orderCheck");
	}
	
	//주문내역 보여주기
	@GetMapping("/order/orderlist")
	public ModelAndView getOrderList() {
		return new ModelAndView("/user/order/orderList");
	}
	
	//포인트 내역 보여주기
	@GetMapping("/order/point")
	public ModelAndView getPointList() {
		return new ModelAndView("/user/order/point");
	}
}
