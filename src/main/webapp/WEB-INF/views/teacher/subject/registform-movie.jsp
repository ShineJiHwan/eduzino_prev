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
	      						<template v-for="">
									<video_item :videos="videoList" :pm="page"/>		      					
	      						</template>
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
		flag:{
			
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
const video_row = {
		template:`
			<tr>
				<td>{{video.video_name}}</td>
				<td>
					<button class="btn btn-primary zino-subject-movie-select-btn" @click="choose(video)">선택</button>
					<button class="btn btn-danger zino-subject-movie-delete-btn" @click="del(video)">삭제</button>
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
		                <button v-if="pm.prevFlag" type="button" class="btn btn-primary"><i class="mdi mdi-arrow-left-drop-circle-outline"></i></button>
		                <template v-for="i in parseInt(pm.pageSize)">
			                <button v-if="(i+pm.firstPage-1)<=pm.totalPage" type="button" class="btn btn-primary" @click="currentPageChange(i+pm.firstPage-1)">{{i+pm.firstPage-1}}</button>
		                </template>
		                <button v-if="pm.nextFlag" type="button" class="btn btn-primary"><i class="mdi mdi-arrow-right-drop-circle-outline"></i></button>
		            </div>
				</td>
			</tr>
		`,props:['pm']
		  ,methods:{
			currentPageChange(currentPage){
				videoState.setCurrentPage(currentPage);
			}
		},updated:function(){
			console.log("pagination updated");
		}
	}
//html태그에서는 대소문자를 구문못하기때문에 대문자로 사용할시 인식불가
const video_item ={
	template:`
		<div class="zino-subject-movie-editor">
		    <div v-if="!flag.titleFlag" class="zino-subject-movie-flex zino-subject-movie-title">
		        <div class="zino-subject-movie-left-component">
		            <span class="zino-subject-movie-form-body-label">강의1:</span>
		            <div class="zino-subject-movie-form-head-input">
		                <i class="bi bi-file-earmark"></i>
		                <span class="zino-subject-movie-form-head-value">{{title}}</span>
		            </div>
		            <div class="zino-subject-movie-editor-icon-box">
		                <button class="zino-subject-movie-edit-icon" @click="movieTitleEditEvent()">
		                    <i class="bi bi-pencil-fill"></i>
		                </button>
		                <button class="zino-subject-movie-delete-icon">
		                    <i class="bi bi-eraser-fill"></i>
		                </button>
		            </div>
		        </div>
		        <div class="zino-subject-movie-add-btn-box">
		            <button v-if="!flag.videoShowFlag" class="zino-subject-movie-add-btn" @click="videoFlag">강의선택</button>
		            <button v-else class="zino-subject-movie-add-select-btn" @click="videoFlag">강의선택&nbsp<i class="bi bi-x-lg"></i></button>
		        </div>
		    </div>
		    <div v-else class="zino-subject-movie-flex zino-subject-movie-title">
		        <div class="zino-subject-movie-left-component">
		            <span class="zino-subject-movie-form-body-label">강의1:</span>
		            <div class="flex zino-subject-movie-form-head-input">
		                <input class="form-control dp-inline zino-subject-input" :value="title" @input="nameInputEvent($event)"/>
		            </div>
		        </div>
		        <div class="zino-subject-movie-title-btn-box">
		            <button class="btn btn-primary" @click="movieNameEditEvent()">취소</button>
		            <button class="btn btn-primary" @click="setMovieName()">저장</button>
		        </div>
		    </div>
		    <div v-if="flag.videoShowFlag" class="zino-subject-movie-select-form-group">
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
		                        <template v-for="video in videos.showList">
		                            <video_row :key="video.video_idx" :item="video" />
		                        </template>
		                        <template>
		                            <pagination :pm="pm"/>
		                        </template>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		    </div>
		</div>
	`,props:['videos', 'pm','title']
	,data(){
		return {
			flag:{
				videoShowFlag:false,
				titleFlag:false
			},
			movie_name:this.title,
			tempTitle:""
		};
	}
	,methods:{
		videoFlag:function(){
			this.flag.videoShowFlag = !this.flag.videoShowFlag;
		},movieNameEditEvent:function(){
			this.flag.titleFlag = !this.flag.titleFlag;
			this.flag.videoShowFlag = false;
			this.tempTitle = "";
		},setMovieName(){
			console.log(this.title);
			this.title = this.tempTitle;
			this.movieNameEditEvent();
		},nameInputEvent(event){
			this.tempTitle = event.target.value;
		}
	},updated:function(){
		console.log('video_item updated');
	},components:{
		video_row,
		pagination
	}
}
videoApp= new Vue({
	el:"#videoApp",
	data:{
		videoList:videoState.list,//강사가 보유중인 전체 강의들
		page: videoState.page,
		videoItemList:[]
	},
	components:{
		video_item
	},methods:{
		setList:function(videoList){
			videoState.setVideoList(videoList);
			videoState.setTotalRecoard();
			videoState.setShowList();
		}
	},created:function(){
		let item = [];
		item['title']='소개';
		this.videoItemList.push(item);
	},updated:function(){
		videoState.setTotalRecoard();
		videoState.setShowList();
		console.log("videoApp updated")
	}
});

function init(){	
	$.ajax({
		url:"/teacher/rest/videos/1",
		type:"get",
		success:function(result){
			videoApp.setList(result);
		}
	});
}
$(function(){
	init();
});
</script>
</html>