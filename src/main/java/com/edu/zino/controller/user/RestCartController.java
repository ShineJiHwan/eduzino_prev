package com.edu.zino.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.zino.domain.Cart;
import com.edu.zino.domain.Member;
import com.edu.zino.domain.Subject;
import com.edu.zino.domain.Wish;
import com.edu.zino.model.user.CartService;
import com.edu.zino.model.user.WishService;

@RestController
@RequestMapping("/rest")
public class RestCartController {
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private WishService wishService;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//카트목록 비동기로 가져오기
	@GetMapping("/cart/list")
	public List<Cart> getCartList(){
		Member member=new Member();
		member.setMember_idx(2);
		return cartService.selectAll(member);
	}
 
		
	//장바구니 삭제
	@PostMapping("/cart/list/{cart_idx}")
	public ResponseEntity<String> delCart(HttpServletRequest request, int cart_idx){
		//3단계
		logger.info("삭제할 cart_idx"+cart_idx);
		cartService.delCart(cart_idx);
		
		//4단계
		ResponseEntity<String> entity = new ResponseEntity<String>("성공",HttpStatus.OK);
		return entity;
	}
	
	
	/*---------------찜--------------------*/
	//찜목록 비동기로 가져오기
	@GetMapping("/cart/wishlist")
	public List<Cart> getWishList(){
		Member member=new Member();
		member.setMember_idx(2);
		return wishService.selectAll(member);
	}
	
	//찜목록 장바구니에 등록
	@PostMapping("/cart/wishtocart")
	public ResponseEntity<String> toCart(HttpServletRequest request,@PathVariable int[] subject_idx){
		Cart[] cartList=new Cart[subject_idx.length];
		
		//임시데이터
		Member member1=new Member();
		member1.setMember_idx(2);
		
		//임시데이터?
		for(int i=0; i<subject_idx.length; i++) {			
			Subject subject = new Subject();
			subject.setSubject_idx(subject_idx[i]);
			
			Cart cart = new Cart();
			cart.setSubject(subject);
			cart.setMember(member1);
			
			cartList[i]=cart;
		}
		//3단계
		cartService.regist(cartList);
		logger.info("cartList는 "+cartList);
		
		//4단계
		ResponseEntity<String> entity = new ResponseEntity<String>("성공",HttpStatus.OK);
		
		return entity;
	}
	
	//찜목록 삭제하기
	@PostMapping("/cart/wish_list")
	public ResponseEntity<String> delWish(HttpServletRequest request, @RequestBody Wish wish){
		logger.info("wish 는 "+wish);
		
		//3단계
		//wishService.delWish(wishList);
		
		
		//4단계
		ResponseEntity<String> entity = new ResponseEntity<String>("삭제 성공", HttpStatus.OK);
		return entity;
	}
	
}
