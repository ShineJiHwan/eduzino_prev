<%@page import="com.edu.zino.domain.OrderSummary"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<OrderSummary> orderSummaryList = (List)request.getAttribute("orderSummaryList");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Teacher Chat-Message</title>
    <!-- plugins:css -->
    <jsp:include page="../inc/header_link.jsp"></jsp:include>
  </head>
  <body>

<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">EduZino</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="bt_messageOk">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>



    <div class="container-scroller">
      <!-- partial:partials/_sidebar.html -->
      <jsp:include page="../inc/sidebar.jsp"></jsp:include>
      <!-- sidebar.html end  -->
      
      <!-- partial  -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_settings-panel.html -->
        <!-- partial -->
        <!-- partial:partials/_navbar.html -->
        <jsp:include page="../inc/navbar.jsp"></jsp:include>
        <!-- partial -->
        <div class="main-panel">
    <div class="chat-container p-0">
		<div class="card-chat">
			<div class="row-chat g-0">
			
				<!-- 채팅방 -->
				<div class="col-12 col-lg-5 col-xl-3 border-right">

					<div class="px-4 d-none d-md-block">
						<div class="d-flex align-items-center">
						
							<div class="flex-grow-1" id="selectChat">
								<input type="text" class="form-control my-3" placeholder="대화상대이름..">
							</div>
							<select class="form-control form-control-sm my-3" id="chatMember">
		                        <option value="0">수강생을 선택하세요</option>
		                        <% for(int i=0;i<orderSummaryList.size();i++){ %>
	                        	<%
	                        		OrderSummary orderSummary = orderSummaryList.get(i);
	                        	%>
		                        <option value="<%= orderSummary.getMember().getMember_idx() %>"><%= orderSummary.getMember().getMember_nickname() %></option>
		                        <% } %>
	                    	</select>
							
							<div class="chat-icon mdi mdi-comment-plus-outline" id="addChat"></div>
						</div>
					</div>
					
					<section id="app_chatRooms">
						<template v-for="chat in chatList">
							<row :key="chat.member_teacher_idx" :obj="chat" />
						</template>
					</section>

					<hr class="d-block d-lg-none mt-1 mb-0">
				</div>
				
				<!-- 채팅내용 -->
				<div class="col-12 col-lg-7 col-xl-9">
					<div class="py-2 px-4 border-bottom d-none d-lg-block chat-item-float-overflow">
						<div class="d-flex align-items-center py-1 chat-item-align-left">
							<div class="position-relative">
								<img src="https://bootdey.com/img/Content/avatar/avatar3.png" class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
							</div>
							<div class="flex-grow-0 pl-3">
								<strong>신지환</strong>
							</div>
						</div>
						<div class="close-item-box-bg">
							<div class="chat-icon mdi mdi-close btn-close-item"></div>
						</div>
					</div>

					<div class="position-relative" style="height:70%">
						<div class="chat-messages p-4" id="chatArea">

						</div>
					</div>

					<div class="flex-grow-0 py-3 px-4 border-top">
						<div class="chat-textarea">
							<textarea class="form-control" rows="6"; cols="30" placeholder="메세지를 입력하세요..." id="t_content"></textarea>
							<button class="btn btn-primary" style="float:right;" id="bt_send">전송</button>											
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

        </div>
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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.18/vue.min.js"></script>
  <script type="text/javascript">
  //비동기방식관련
  let app_chatRooms;
  
  
  //websocket관련
	let ws;
	let socket = null;
	let flag = true; //수강생조회하는 폼 보이거나 숨길 때 사용


  //웹소켓을 이용한 서버에 접속
  function connect(){
  	ws=new WebSocket("ws://localhost:8888/chat");
  	
  	ws.onopen=function(){
  		console.log("서버에 접속됨 onopen");
  		ws.send("1" + "," + "me" + "," + "ENTER");
  	}
  	
  	ws.onmessage=function(e){
  		console.log("서버가 보낸 데이터", e.data);
  		
  		//서버가 보낸 메시지를 area에 누적 
  		//$("#t_receive").append(e.data+"\n");
  		
  		let sm = e.data;
  		let sl = sm.split(',');
  		let sendId = sl[0]; //추후 member_idx가 넘어올 예정
		let content = sl[1];
  		if(sendId != "me"){
			showMessageLeftCard();  		
  		}
  	}
  	
  	ws.onclose=function(e){
  		console.log("서버와 접속이 끊김");
  		//끊기는 시점을 발견할때, 1초의 시간 뒤에 다시 재접속하여 프로그램의 
  		//안정성을 높이자
  		setTimeout("connect()", 1000);
  	}
  	ws.onerror=function(e){
  		console.log("에러발생 ",e);
  	}
  }
  
  
  	function getList(){
  		//비동기로 서버에서 불러왔다는 전제하에...
  		let messageList=[];
  		
  		for(let i=0;i<10;i++){
	  		let json={
	  			title:"해영씨"+i	
	  		};
	  		messageList.push(json);
  		}
  		console.log(messageList);
  		
  	}
  	
  	//내가보낸메세지_이미지
  	function showMessageRightCard(msg){
  		//현재 시간구하기
  		let time = new Date().getHours() + ":" + new Date().getMinutes();
  		
  		//profile, name, time, content
  		let messageRightCard = new MessageRightCard("https://bootdey.com/img/Content/avatar/avatar3.png","신지환",time, msg);
  		$("#chatArea").append(messageRightCard.getBox());	
  	}
  	
  	//내가받은메세지_이미지
  	function showMessageLeftCard(msg){
  		//현재 시간구하기
  		let time = new Date().getHours() + ":" + new Date().getMinutes();
  		
  		//profile, name, time, content
  		let messageLeftCard = new MessageLeftCard("https://bootdey.com/img/Content/avatar/avatar5.png", "김나연", time, msg);
  		
  	}
  	
  	
  	function sendMsg(){
  		let msg = $("#t_content").val();
		
		//protocol: RoomNum, 보내는id, 내용 
		ws.send("1," + "me" + "," + msg);
  		
		showMessageRightCard(msg);
  		$("#t_content").val("");
  	}
  	
  	/*------------------------------------------------------------------------------------------*/
  	
  	/*
  	<a href="#" class="list-group-item list-group-item-action border-0">
	<div class="badge bg-success float-right">5</div>
		<div class="d-flex align-items-start">
				<img src="https://bootdey.com/img/Content/avatar/avatar5.png" class="rounded-circle mr-1" alt="Vanessa Tucker" width="40" height="40">
			<div class="chatname flex-grow-1 ml-3">
								신지환
				<div class="chatmessage">안녕하세요</div>
			</div>
		</div>
	</a>
  	*/
  	
  	const row={
  			template:`
  				<a href="#" class="list-group-item list-group-item-action border-0">
  				<div class="badge bg-success float-right">5</div>
  					<div class="d-flex align-items-start">
  							<img src="https://bootdey.com/img/Content/avatar/avatar5.png" class="rounded-circle mr-1" alt="Vanessa Tucker" width="40" height="40">
  						<div class="chatname flex-grow-1 ml-3">
  											{{chat.member.member_nickname}}
  							<div class="chatmessage">안녕하세요</div>
  						</div>
  					</div>
  				</a>
  			`,
  			props:["obj"],
  			data(){
  				return{
  					chat:this.obj
  				};
  			}
  	};
  	
  	app_chatRooms = new Vue({
  		el:"#app_chatRooms",
  		components:{
  			row
  		},
  		data:{
  			chatList:[]
  		},
  		methods:{
  			getChat:function(chat){
  				//채팅방 클릭시 채팅내용 출력

  			}
  		}
  	});
  	
  	//채팅목록 불러오기
  	function getChatRooms(){
		$.ajax({
			url:"/rest/teacher/chat/message",
			type:"post",
			success:function(result, status, xhr){
				 app_chatRooms.chatList = result;
				 console.log(result);
			}
		});
  	}
  	
  	//수강생에게 보낼 채팅방 생성 또는 이동하기
  	function chatRoom(){
  		/*
  		{
  			"member"{
  				member_idx:5
  			}
  			
  		}
  		
  		*/
		let obj={};
  		let json={};
		
  		json['member_idx']=parseInt($("#chatMember option:checked").val()); //수강생 member_idx);
  		obj['member']=json;
			
		
		
		console.log(JSON.stringify(obj));
		
		$.ajax({
			url:"/rest/teacher/chat/message",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(obj),
			processData:false, /*query string화 여부*/
			success:function(result, status, xhr){
				 alert(result.msg);
			}
		});
		

  	}

  	//수강생selectbox와 검색창
  	function selectShowHide (flag){
  		if(flag == true){
	  		$("#selectChat").show(); //보이기
	  		$("#chatMember").hide(); //숨기기  			
  		}else {
	  		$("#selectChat").hide(); //보이기
	  		$("#chatMember").show(); //숨기기
  		}
  	}
  	
  	/*------------------------------------------------------------------------------------------*/
  	
	$(function(){
		selectShowHide(flag); //기본 : 채팅방검색
		//connect();
		getChatRooms();
		
		//메세지전송
		$("#bt_send").click(function(){
			sendMsg();	
		});
		
		//수강생selectbox와 검색창
		$("#addChat").click(function(){
			flag = !flag;
			selectShowHide(flag);
		});
		
		$("#chatMember").change(function(e){
			let chatMemberChecked = $("#chatMember option:checked").text();
			$('#myModal').modal('show');
			
			$(".modal-body").html(chatMemberChecked+"님께 메세지를 보내시겠습니까?");
			

	  		$("#bt_messageOk").click(function(){
	  			$('#myModal').modal('hide');
				chatRoom();
	  		});
	
			
		});
		
	});  	
  </script>

</html>