<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Point</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- header_link -->
<jsp:include page="../inc/header_link.jsp"></jsp:include>
<!-- header_link end -->

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
			<div class="col-md-9">
			<div class="card mt-5">
                  <div class="card-body">
                    <h4 class="card-title">포인트 적립내역</h4>
                    
                    <div class="table-responsive">
                      <table class="table table-hover">
                        <thead>
                           <tr>
                            <th>결제일</th>
                            <th>강좌명</th>
                            <th>수강료</th>
                            <th>적립액</th>
                          </tr>
                        </thead>
                        <tbody class="point_form_box" id="app_point">
							<template v-for="i in count">
								<point_table />
							</template>
                        </tbody>
                      </table>
               			 <ul>
               				<label style="float:right">1,000</label>
                            <label style="float:right">보유 포인트</label>
                        </ul>
                    </div>
                  </div>
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
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
<script type="text/javascript">
/*----뷰 영역-------*/
let pointApp;
	
	const point_table={
		template:`
			<tr>
	               <td>결제일</td>
	               <td>강좌명</td>
	                <td>결제액</td>
	               <td>적립액</td>
           </tr>
		`		
	}


	orderApp=new Vue({
		el:"#app_point",
		components:{
			point_table
		},
		data:{
			count:3
		}
		
	});

/*----------------------*/


</script>
</html>