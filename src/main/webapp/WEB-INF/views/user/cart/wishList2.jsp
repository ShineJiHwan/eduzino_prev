<%@page import="java.util.List"%>
<%@page import="com.edu.zino.domain.Wish"%>
<%@page import="com.edu.zino.domain.Subject"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List wishList = (List)request.getAttribute("wishList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>WishList</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- header_link -->
<jsp:include page="../inc/header_link.jsp"></jsp:include>
<!-- header_link end -->
<style type="text/css">
.eduzino-box-line{
	display: inline;
	margin: 0px 5px;
}
.subejct-item-checkbox input[type='checkbox'], .check_wrap input[type='checkbox']{
	zoom:1.5;
    width: 15px;
    height: 15px;
}
</style>
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


	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<!-- partial:partials/_sidebar.html -->
				<jsp:include page="../inc/mypage/sidebar.jsp"></jsp:include>
				<!-- sidebar.html end  -->
			</div>
			<div class="col-md-9" style="overflow: hidden;">
				<div class="card mt-5">
					<div class="card-body">
						<h4 class="card-title" style="margin-left:12px">Wish List</h4>
						<div class="table-responsive">
							<div class="col">
								<div class="check_wrap">
									<input type="checkbox" id="checkAll" name="checkAll" /> <span style="font-size:20px">전체 선택</span>
								</div>
									<form id="form1">
			
									<% for(int i=0; i<wishList.size(); i++){ %>	
	                          		<% Wish wish = (Wish)wishList.get(i); %>
	                          		<% Subject subject = wish.getSubject(); %>
								<div class="row">
				
									<input type="hidden" id="wish_idx" value=<%=wish.getWish_idx()%>>
									<div class="course-content flex flex-wrap justify-content-between align-content-lg-stretch">
										<div class="eduzino-box-line subejct-item-checkbox">
										  <input type="checkbox" name="subject_idx" value="<%=wish.getSubject().getSubject_idx() %>" />
										</div>
										<div class="eduzino-box-line">
											<figure class="course-thumbnail" style="width: 200px; height: 220px;">
												<a href="#"><img src="/resources/shop/img/shop-cart/cp-1.jpg" alt=""></a>
											</figure>
										</div>
										<!-- .course-thumbnail -->
										<div class="course-content-wrap eduzino-box-line" style="width:500px; height: 220px;">
											<header class="entry-header">
												<h2 class="entry-title"><a href="#"><%=subject.getSubject_title() %></a></h2>
												<span><%=subject.getSubject_subTitle() %></span>
												<div class="entry-meta flex flex-wrap align-items-center">
													<div class="course-author">
														<a href="#">강사명</a>
													</div>
												</div>
												<!-- .course-date -->
											</header>
											<!-- .entry-header -->
											<footer class="entry-footer flex justify-content-between align-items-center">
													<%=subject.getSubject_price() %>
												<!-- .course-cost -->
											</footer>
											<!-- .entry-footer -->
										</div>
										<!-- .course-content-wrap -->
									</div>
									<!-- .course-content -->
								</div>
  								<%} %>
								</form>
							</div>
						</div>
					</div>
					
				</div>
				<div class="row" style="float: right; margin: 10px 0px 5px 10px">
					<button type="button" class="btn btn-success btn-md" style="margin-right:10px" id="bt_del">선택항목 삭제</button>
	                 <button type="button" class="btn btn-success btn-md" id="bt_cart"> 장바구니로 이동</button>
	        	</div>
	 
			</div>
		</div>
	</div>


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
<script type="text/javascript">
	let checkArray = new Array();
	let data=$("#wish_idx").val();
	
	//선택 찜 비동기로 삭제
	function delWish(){
		if($("input[name=subject_idx]").is(':checked')){
			if(!confirm("찜에서 삭제하시겠습니까?")){
				return;
			}else{
				//console.log("선택한 wish_idx",$("#wish_idx").val());
				$.ajax({
					url:"/rest/cart/wishlist/"+$("#wish_idx").val(),
					type:"DELETE",
					success:function(result,status,xhr){
						console.log(result);
					}		
				});
			}
		}
	}


	//찜내역 카트에 추가하기
	function insertCart(){
		let formData =  $("#form1").serialize();
	
		if($("input[name=subject_idx]").is(':checked')){
			if(confirm("장바구니에 추가하시겠습니까?")){
				//네 클릭 시 > form을 보낸다
				//alert(formData);
				console.log(formData);
				
				$.ajax({
					url:"/rest/cart/wishlist",
					type:"post",
					data:formData,
					success:function(result,status,xhr){
						if(confirm("장바구니로 이동하시겠습니까?")){
							location.href="/cart/list";
						}
					}
				});	
			}
		}
	}

	//체크박스 전체 선택
	function allCheckBox(){
		if($("#checkAll").is(':checked')){
			$("input[name=subject_idx]").prop("checked", true);
		}else{
			$("input[name=subject_idx]").prop("checked", false);	
		}
	};
	
	//체크박스 개별 선택
	function CheckBox(){
		if($("input[name=subject_idx]:checked").length==$("input[name=subject_idx]").length){
			$("#checkAll").prop("checked", true);
		}	else{
			$("#checkAll").prop("checked", false);
		}
	}

	$(function(){
		$("#bt_del").click(function(){
			delWish();
		});
		$("#bt_cart").click(function(){
			insertCart();
		});
		
		$("#checkAll").click(function(){			
			allCheckBox();
		});
		$("input[name=subject_idx]").click(function(){
			CheckBox();
		});
	
	});

</script>
</html>