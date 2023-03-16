<%@page import="com.edu.zino.domain.Subject"%>
<%@page import="java.util.List"%>
<%@page import="com.edu.zino.domain.Cart"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List cartList = (List)request.getAttribute("cartList");

	int totalPrice=0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Cart List</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- header_link -->
<jsp:include page="../inc/header_link.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/shop/css/style_cart.css">
</head>
<body>
	<!-- hero-content -->
    <div class="page-header">
    	<!-- header-->
		<jsp:include page="../inc/page/header.jsp"></jsp:include>
		<!-- header end -->
    	<jsp:include page="../inc/page/header_main.jsp"></jsp:include>
    </div>
    <!-- hero-content end-->
 
		
	<section class="shop-cart spad">
	
        <div class="container">
        <div class="row">
         	<div class="col-lg-4">
            	<div class="breadcrumb__links">
					<a href="#"><i class="fa fa-home"></i> Home</a>
					<span>수강 신청</span>
				</div>
			</div>
		</div>
			<span>&nbsp;</span>
            <div class="row">
                <div class="col-lg-12">
                    <div class="shop__cart__table">
                        <table>
                            <thead>
                                <tr>
                                	<th>
	                                 	<div class="check_wrap">
										  <input type="checkbox" id="checkAll" name="checkAll"/>
										 <span>select all</span>
										</div>
                                 	</td>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th></th>
                                </tr>
                            </thead>
                          	<tbody class="cart_form_box" id="app_cart">
                     	        <template v-for="cart in cartList">
                     	        	<cart_table :key="cart.cart_idx"  :cart="cart"/>
                     	        </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
           
            <div class="row" style="justify-content: flex-end;">
	             <div class="col-lg-6 offset-lg-2">
                    <div class="cart__total__procced">
                          <h4>포인트 사용</h4>                       
                            <ul>
                            <li>보유 포인트 <span>1,000</span></li>
                              </ul>
                            <div class="discount__content">
                        <form action="#">
                            <input type="text" placeholder="Enter your point">
                            <button type="submit" class="site-btn" style="right: -126px; ">전액 사용</button>
                        </form>
                    </div>
                    </div>
                </div>
                   <div class="col-lg-6 offset-lg-2">
                    <div class="cart__total__procced">
                        <h4>총 결제 금액</h4>
                        <ul>
                            <li>할인 금액 <span>1,000</span></li>
                            <li>결제 금액 <span><%= totalPrice %></span></li>
                        </ul>
                          <a href="#" class="primary-btn" style="color: white" id="bt_pay">결제하기</a>
                    </div>
				</div>
            </div>
        </div>
    </section>
	
	<!-- clients_logo -->
    <jsp:include page="../inc/clients_logo.jsp"></jsp:include>
    <!-- clients_logo end -->
    
	<!-- footer -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	<!-- footer -->
	<!-- footer_link -->
	<jsp:include page="../inc/footer_link.jsp"></jsp:include>
	<!-- footer_link end-->
</body>
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
<script type="text/javascript">
	let cartApp;
	
	const cart_table={
			template:`
			 <tr>
            	<td>
            	<div class="check_wrap">
            			<input type="hidden" :value="item.cart_idx">
					  <input type="checkbox" name="cart_idx" :value="item.cart_idx" class="col-2" />
						<span>select</span>
					</div>
            	</td>
                <td class="cart__product__item">
                    <img src="/resources/shop/img/shop-cart/cp-1.jpg" alt="">
                    <div class="cart__product__item__title">
                        <h6>{{item.subject.subject_title}}</h6>
                        <span>{{item.subject.subject_subTitle}}</span>
                    </div>
                </td>
                <td class="cart__price">{{item.subject.subject_price}}</td>
                <td class="cart__close" ><span class="icon_close" @click="del(item.cart_idx)"></span></td>
            </tr>
			`, props:['cart']
			,data(){
				return{
					item:this.cart
				};
			},methods:{
				del:function(key){
					if(!confirm("삭제하시겠습니까?")){
						return;
					}						
					let idx =  getIndex(key);
					cartApp.cartList.splice(idx,1);
					
					delAsyncCart(key);
					
				}
			}
		
		}
	

	cartApp=new Vue({
		el:"#app_cart",
		components:{
			cart_table
		},
		data:{
			cartList:[],
			count:4
		}
		
	});
	
	//vue 배열에서 삭제하기 위해 인덱스를 가져오는 메서드
	function getIndex(key){
		let cartList = cartApp.cartList;
		for(let i=0; i<cartList.length; i++){
			if(cartList[i].key == key) return i;
		}
		return -1;
	}
	
	
	//시작하자마자 목록을 가져온다
	function getCartList(){
		$.ajax({
			url:"/rest/cart/list",
			type:"get",
			success:function(result,status,xhr){
				console.log("result",result);
				cartApp.cartList = result;
			}
		});
	}
	
/*------------------------------------------------------------------------*/


	//선택 장바구니 비동기로 삭제
	function delAsyncCart(cart_idx){
		if(!confirm("선택하신 항목을 삭제하시겠습니까?")){
			return;
		}else{
			$.ajax({
				url:"/rest/cart/list/"+$("input[name='cart_idx']").val(),
				type:"DELETE",
				success:function(result,status,xhr){
					console.log(result);
					getCartList();
				},error:function(xhr, status, err){
					
				}
			});
		}
	}


	//체크박스 전체 선택
	function allCheckBox(){
		if($("#checkAll").is(':checked')){
			$("input[name=cart_idx]").prop("checked", true);
		}else{
			$("input[name=cart_idx]").prop("checked", false);	
		}
	};
	
	//체크박스 개별 선택
	function CheckBox(){
		if($("input[name=cart_idx]:checked").length==$("input[name=cart_idx]").length){
			$("#checkAll").prop("checked", true);
		}	else{
			$("#checkAll").prop("checked", false);
		}
	}

	$(function(){
		getCartList();


		//전체선택 클릭
		$("#checkAll").click(function(){			
			allCheckBox();
		});
		
		//개별 선택 클릭
		$("input[name=cart_idx]").click(function(){
			CheckBox();
		});
	
	});

</script>
</html>