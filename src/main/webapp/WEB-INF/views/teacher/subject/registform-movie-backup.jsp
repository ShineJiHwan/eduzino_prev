<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Plus Admin</title>
<!-- plugins:css -->
<jsp:include page="../inc/header_link.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/teacher/subject/regist_style.css" />
</head>
  <body>
    <div class="container-scroller container" style="max-width: 1403px; overflow: initial;">
		<!-- partial:partials/_sidebar.html -->
		<jsp:include page="../inc/subject/sidebar.jsp"></jsp:include>
      <!-- sidebar.html end  -->
      
      <!-- partial  -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.html -->
        <jsp:include page="../inc/subject/navbar.jsp"></jsp:include>
        <!-- partial -->
        <div class="main-panel app--content--3vcMt" style="padding: 0px;">
           	<div class="sub-header--flex-align-center--1_RER sub-header--container--1pQeg">
           		<div class="sub-header--flex-align-center--1_RER sub-header--content--1H7YJ">
           			<h2 data-purpose="page-title" class="ud-heading-serif-xl">${studyPlanVO.getName()}</h2>
           		</div>
           	</div>
           	<div class="main-content--content--1Myl4" id="subjectApp">
           		<div class="goals--formgroup-box" id="app_goal">
           			<p class="goals-form--subtitle--3R5d-">
	       				<span>다음 설명은 강의 미리보기에서 공개되며 강의 성과에 직접적으로 영향을 미칩니다. 이러한 설명은 수강생이 강의가 자신에게 맞는지 여부를 판단할 수 있도록 돕습니다.</span>
	      			</p>
	      			<div>
	      				<session_item />
	      			</div>
           		</div>
           		<div>
           			<div class="zino-subject-movie-plus-btn-box" style="background: #fff">
      					<button>세션 추가</button>
      				</div>
           		</div>
				<div class="ud-form-btn-group">
					<button class="btn btn--form-grop-save float-right">저장하기</button>
				</div>
           	</div>
          <!-- content-wrapper ends -->
          <!-- partial -->
        </div>
        <div> 푸터올곳</div>
        <!-- main-panel ends -->
      </div>
      <!-- partial end  -->
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <!-- plugins:js -->
	<jsp:include page="../inc/footer_link.jsp"></jsp:include>
    <!-- plugins:js end -->
    <!-- End custom js for this page -->
  </body>
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
<script src="/resources/teacher/subject/js/video_row.js"></script>
<script src="/resources/teacher/subject/js/pagination.js"></script>
<script src="/resources/teacher/subject/js/movie_item.js"></script>
<script type="text/javascript">
let subjectApp;
let videoState = {
	page: {
		totalRecord: 0,
		blockSize: 10,
		pageSize: 10,
		totalPage: 0,
		firstPage: 0,
		lastPage: 0,
		currentPage: 1,
		no: 0,
		curPos: 0,
		prevFlag:true,
		nextFlag:true,
	},
	list:{
		videoList:[],
		showList:[],
	},
	setTotalRecoard() {
		this.page.totalRecord = this.list.videoList.length;
		this.init();
	},
	setVideoList(videoList){
		this.list.videoList = videoList;
	},
	setShowList(){
		this.list.showList = this.list.videoList.slice(this.page.curPos,this.page.curPos+this.page.pageSize);
	},
	setCurrentPage(currentPage){
		this.page.currentPage = currentPage;
		this.init();
		this.setShowList();
	},
	init(){
		this.page.totalPage = Math.ceil(this.page.totalRecord/this.page.pageSize);
		this.page.firstPage = this.page.currentPage-(this.page.currentPage%this.page.blockSize-1);
		this.page.lastPage = parseInt(this.page.firstPage)+parseInt(this.page.blockSize);
		this.page.curPos = (this.page.currentPage-1)*this.page.pageSize;
		this.page.no = this.page.totalRecord-this.page.curPos;
		if(this.page.currentPage<11){
			this.page.prevFlag = false;
		}
		if(this.page.lastPage>this.page.totalPage){
			this.page.nextFlag=false;
		}
	}
}

const session_item={
	template:`
		<div class="zino-subject-section-form-group">
			<div class="zino-subject-movie-form-head">
				<span class="zino-subject-movie-form-head-label">      						
					세션1:
				</span>
				<div class="zino-subject-movie-form-head-input">
					<i class="bi bi-file-earmark"></i>
					<span class="zino-subject-movie-form-head-value">소개</span>
					<div class="zino-subject-movie-head-icon-box">
						<button class="zino-subject-movie-edit-icon">
     						<i class="bi bi-pencil-fill"></i>
						</button>
						<button class="zino-subject-movie-delete-icon">
     						<i class="bi bi-eraser-fill"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="zino-subject-movie-form-body">
				<template v-for="(item,i) in movieItemList">
				<movie_item :videos="videoList" :pm="page" :item="item" :no="i"/>		      					
				</template>
				<div class="zino-subject-movie-plus-btn-box">
 					<button @click="videoItemPlus()">커리큘럼 추가</button>
 				</div>
			</div>
		</div>
	`,props:[]
	,data(){
		return{
			movieItemList:[]
		};
	},components:{
		movie_item
	},methods:{
		
	}
}


//html태그에서는 대소문자를 구문못하기때문에 대문자로 사용할시 인식불가
subjectApp= new Vue({
	el:"#subjectApp",
	data:{
		videoList:videoState.list,//강사가 보유중인 전체 강의들
		page: videoState.page
	},
	components:{
		session_item
	},methods:{
		setList:function(videoList){
			videoState.setVideoList(videoList);
			videoState.setTotalRecoard();
			videoState.setShowList();
		},videoItemPlus:function(){
			let item = [];
			item['movie_name']='';
			this.movieItemList.push(item);
		}
	},created:function(){
		let item = [];
		item['movie_name']='소개';
		this.movieItemList.push(item);
	},updated:function(){
		videoState.setTotalRecoard();
		videoState.setShowList();
		console.log("subjectApp updated")
	}
});

function init(){	
	$.ajax({
		url:"/teacher/rest/videos/1",
		type:"get",
		success:function(result){
			subjectApp.setList(result);
		}
	});
}
$(function(){
	init();
});
</script>
</html>