package com.edu.zino.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WishListController {

	@GetMapping("/cart/wish")
	public ModelAndView getWish(HttpServletRequest request) {
		return new ModelAndView("/user/cart/wishList");
	}
}
