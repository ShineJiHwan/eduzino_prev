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
           	<div class="main-content--content--1Myl4" id="videoApp">
           		<div class="goals--formgroup-box" id="app_goal">
           			<p class="goals-form--subtitle--3R5d-">
	       				<span>다음 설명은 강의 미리보기에서 공개되며 강의 성과에 직접적으로 영향을 미칩니다. 이러한 설명은 수강생이 강의가 자신에게 맞는지 여부를 판단할 수 있도록 돕습니다.</span>
	      			</p>
	      			<div>
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
								<video_item :videos="videoList" />		      					
		      					<div class="zino-subject-movie-plus-btn-box">
		      						<button>커리큘럼 추가</button>
		      					</div>
	      					</div>
	      				</div>
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
<script type="text/javascript">
let videoApp;
let temp;
const video_row = {
		template:`
			<tr>
				<td>{{video.video_name}}</td>
				<td>
					<button class="btn btn-primary zino-subject-movie-select-btn" @click="choose(video)">선택</button>
					<button class="btn btn-primary zino-subject-movie-delete-btn" @click="del(video)">삭제</button>
				</td>
			</tr>
		`,props:['item']
		,data(){
			return{
				video:this.item
			};
		},methods:{
			choose:function(video){
				console.log('선택메서드',video);
			},
			del:function(movie){
				console.log('삭제메서드',video);
			}
		}
	}
	const pagination ={
		template:`
			<tr class="zino-subject-pagination" :style="{border:0}">
				<td colspan="2" >
					<div class="btn-group" role="group" aria-label="Basic example">
		                <button v-if="pageManager.prevFlag" type="button" class="btn btn-primary"><i class="mdi mdi-arrow-left-drop-circle-outline"></i></button>
						{{pageManager.firstPage-1}} , {{pageManager.totalPage}}
		                <template v-for="i in parseInt(pageManager.pageSize)">
			                <button v-if="(i+pageManager.firstPage-1)<=pageManager.totalPage" type="button" class="btn btn-primary">{{i+pageManager.firstPage-1}}</button>
		                </template>
		                <button v-if="pageManager.nextFlag" type="button" class="btn btn-primary"><i class="mdi mdi-arrow-right-drop-circle-outline"></i></button>
		            </div>
				</td>
			</tr>
		`,props:['pm']
		,data(){
			return{
				pageManager:this.pm
			};
		},methods:{
			reset:function(){
				this.$set(this.pageManager,'currentPage',1);
				this.$set(this.pageManager,'totalPage',Math.ceil(this.pageManager.totalRecord/this.pageManager.pageSize));
				console.log("totalRecord",this.pageManager.totalRecord);
				console.log("pageSize",this.pageManager.pageSize);
				console.log("totalPage",this.pageManager.totalRecord/this.pageManager.pageSize);
				this.$set(this.pageManager,'firstPage',this.pageManager.currentPage-(this.pageManager.currentPage%this.pageManager.blockSize-1));
				this.$set(this.pageManager,'lastPage',parseInt(this.pageManager.firstPage)+parseInt(this.pageManager.blockSize));
				this.$set(this.pageManager,'curPos',(this.pageManager.currentPage-1)*this.pageManager.pageSize);
				this.$set(this.pageManager,'no',this.pageManager.totalRecord-this.pageManager.curPos);
				this.$set(this.pageManager,'prevFlag',true);
				this.$set(this.pageManager,'nextFlag',true);
				
				if(this.pageManager.currentPage<11){
					this.pageManager.prevFlag = false;
				}
				if(this.pageManager.lastPage>this.pageManager.totalPage){
					this.pageManager.nextFlag=false;
				}
				console.log("pageManager",this.pageManager);
			}
		},created:function(){
			this.reset();
			console.log("created pagination pagemanager : ",this.pageManager);
			this.$set(this.pageManager,'totalPage',Math.ceil(this.pageManager.totalRecord/this.pageManager.pageSize));
			console.log("created pagination pagemanager2 : ",this.pageManager);
			console.log("pageManager.totalRecord",this.pageManager.totalRecord);
			console.log("created pagination pagemanager3 : ",this.pageManager);
		},updated:function(){
			this.reset();
			console.log("updated pagination pagemanager : ",this.pageManager);
		}
	}
//html태그에서는 대소문자를 구문못하기때문에 대문자로 사용할시 인식불가
const video_item ={
	template:`
		<div class="zino-subject-movie-editor">
			<div class="zino-subject-movie-flex zino-subject-movie-title">
				<div class="zino-subject-movie-left-component">
					<span class="zino-subject-movie-form-body-label">강의1:</span>
					<div class="zino-subject-movie-form-head-input">
						<i class="bi bi-file-earmark"></i>
						<span class="zino-subject-movie-form-head-value">제목</span>
					</div>
					<div class="zino-subject-movie-editor-icon-box">
						<button class="zino-subject-movie-edit-icon">
  						<i class="bi bi-pencil-fill"></i>
						</button>
						<button class="zino-subject-movie-delete-icon">
  						<i class="bi bi-eraser-fill"></i>
						</button>
					</div>
				</div>
				<div class="zino-subject-movie-add-btn-box">
					<button class="zino-subject-movie-add-btn">강의선택</button>
				</div>
			</div>
			<div class="zino-subject-movie-select-form-group">
				<div class="zino-subject-movie-select-labal">
					<span class="zino-subject-movie-select-lable-text">영상목록</span>
				</div>
				<div class="zino-subject-movie-select-list-form-group">
					<div class="zino-subject-movie-select-search-box">
						<input type="text"  placeholder="이름별로 파일 검색">
						<button>
							<i class="bi bi-search"></i>
						</button>
					</div>			      							
					<div class="zino-subject-movie-select-table">
						<table class="zino-subject-regist-table">
							<thead>
								<tr>
									<th class="zino-subject-movie-select-table-name">파일이름</th>
									<th class="zino-subject-movie-select-table-btn-box"></th>
								</tr>
							</thead>
							<tbody>
								<template v-for="movie in videoList.videos">
									<video_row :item="movie" />
								</template>
								<template>
									<pagination :pm="pageManager"/>
								</template>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	`,props:['videos']
	,data(){
		return{
			videoList:this.videos,
			pageManager:[]
		};
	},methods:{
		init:function(){
			this.$set(this.pageManager,'totalRecord',0);
			this.$set(this.pageManager,'pageSize',10);
			this.$set(this.pageManager,'blockSize',10);
		}
	},created:function(){
		this.init();
	},updated:function(){
		if(this.videoList.videos != undefined){
			this.$set(this.pageManager,'totalRecord',this.videoList.videos.length);
		}
		console.log('updated pageManager',this.pageManager);
	},components:{
		video_row,
		pagination
	}
}

videoApp= new Vue({
	el:"#videoApp",
	data:{
		videoList:[],//강사가 보유중인 전체 강의들
		pageSize:10,//페이지 사이즈
		blockSize:10//블럭사이즈
	},
	components:{
		video_item
	},methods:{
		setList:function(videoList){
			this.$set(this.videoList,'videos',videoList);
			console.log("set성공",this.videoList.videos);
		}
	},updated:function(){
		console.log('업데이트  : ',this.videoList);
	}
});

function init(){
	
	/*for(let i=0;i<100;i++){
		let json = [];
		json['title']='임시제목'+i;
		json['access']=i;
		videoApp.videoList.push(json);
	}*/
	
	$.ajax({
		url:"/teacher/rest/videos/1",
		type:"get",
		success:function(result){
			console.log('값가져옴',result);
			videoApp.setList(result);
		}
	});
}
$(function(){
	init();
});
</script>
</html>