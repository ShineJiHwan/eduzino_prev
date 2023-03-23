/**
 * 
 */
const movie_item ={
	template:`
		<div class="zino-subject-movie-editor">
			<div v-if="flag.newMovieFlag" class="zino-subject-movie-flex zino-subject-movie-title">
		        <div class="zino-subject-movie-left-component">
		            <span class="zino-subject-movie-form-body-label">신규강의:</span>
		            <div class="flex zino-subject-movie-form-head-input">
		                <input class="form-control dp-inline zino-subject-input" :value="item.movie_name" @input="nameInputEvent($event)"/>
		            </div>
		        </div>
		        <div class="zino-subject-movie-title-btn-box">
		            <button class="btn btn-primary" @click="movieItemDelete(no)">취소</button>
		            <button class="btn btn-primary" @click="setMovieName()">저장</button>
		        </div>
			</div>
			<div v-else-if="!flag.titleFlag" class="zino-subject-movie-flex zino-subject-movie-title">
		        <div class="zino-subject-movie-left-component">
		            <span class="zino-subject-movie-form-body-label">강의{{no+1}}:</span>
		            <div class="zino-subject-movie-form-head-input">
		                <i class="bi bi-file-earmark"></i>
		                <span class="zino-subject-movie-form-head-value">{{item.movie_name}}</span>
		            </div>
		            <div class="zino-subject-movie-editor-icon-box">
		                <button class="zino-subject-movie-edit-icon" @click="movieNameEditEvent()">
		                    <i class="bi bi-pencil-fill"></i>
		                </button>
		                <button class="zino-subject-movie-delete-icon" @click="movieItemDelete(no)">
		                    <i class="bi bi-eraser-fill"></i>
		                </button>
		            </div>
		        </div>
		        <div class="zino-subject-movie-edit-btn-box">
					<span v-if="item.video != null && flag.selectedVideoFlag">
						{{item.video.video_name}}
						<button class="zino-subject-movie-add-btn" @click="selectedVideoEdit()">변경하기</button>
					</span>
		            <button v-else-if="!flag.videoShowFlag" class="zino-subject-movie-add-btn" @click="videoFlag">강의선택</button>
		            <button v-else class="zino-subject-movie-add-select-btn" @click="videoFlag">강의선택&nbsp<i class="bi bi-x-lg"></i></button>
		        </div>
		    </div>
			<div v-else class="zino-subject-movie-flex zino-subject-movie-title">
		        <div class="zino-subject-movie-left-component">
		            <span class="zino-subject-movie-form-body-label">강의{{no+1}}:</span>
		            <div class="flex zino-subject-movie-form-head-input">
		                <input class="form-control dp-inline zino-subject-input" :value="item.movie_name" @input="nameInputEvent($event)"/>
		            </div>
		        </div>
		        <div class="zino-subject-movie-title-btn-box">
		            <button class="btn btn-primary" @click="movieNameEditEvent()">취소</button>
		            <button class="btn btn-primary" @click="setMovieName()">저장</button>
		        </div>
			</div>
			<div v-show="flag.videoShowFlag" class="zino-subject-movie-select-form-group">
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
		                            <video_row :key="video.video_idx" :row_item="video" :movieFlag="flag" :movie_item="item"/>
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
	`,props:['videos', 'pm','item','no']
	,data(){
		return {
			flag:{
				titleFlag:false,
				newMovieFlag:true,
				videoShowFlag:false,
				selectedVideoFlag:false,
			},
			tempTitle:this.item.movie_name,
		};
	}
	,methods:{
		videoFlag:function(){
			this.flag.videoShowFlag = !this.flag.videoShowFlag;
			this.flag.selectedVideoFlag = true;
			console.log('item videoShowFlag : ',this.flag.videoShowFlag);
		},movieNameEditEvent:function(){
			this.flag.titleFlag = !this.flag.titleFlag;
			this.flag.videoShowFlag = false;
		},movieItemDelete(no){
			subjectApp.movieItemList.splice(no,1);
		},setMovieName(){
			this.item.movie_name = this.tempTitle;
			this.flag.newMovieFlag=false;
			this.flag.titleFlag = false;
			this.flag.videoShowFlag = false;
			this.tempTitle = "";
		},nameInputEvent(event){
			this.tempTitle = event.target.value;
		},selectedVideoEdit(){
			this.flag.videoShowFlag = !this.flag.videoShowFlag;
			this.flag.selectedVideoFlag = false;
		}
	},components:{
		video_row,
		pagination
	},created:function(){
		console.log('받아온 item : ',this.item);
	}
}