/**
 * 
 */

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
	}
}