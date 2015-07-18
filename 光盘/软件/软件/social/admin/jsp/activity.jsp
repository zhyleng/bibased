<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="template/Headstart.jsp"></jsp:include>
<style type="text/css">
img, a img {
	border: 0;
	margin: 0;
	padding: 0;
	max-width: 600px;
	width: expression_r(this.width > 600 && this.width > this.height ? 600px : 
		'auto'; );
	max-height: 400px;
	height: expresion(this.height > 400 ? 400px : 'auto'; );
	margin-left: auto;
	margin-right: auto;
}
</style>
<jsp:include page="template/Headend.jsp"></jsp:include>
<jsp:include page="template/Body_Nav.jsp"></jsp:include>
<section id='content'>
	<div class='container-fluid'>
		<div class='row-fluid' id='content-wrapper'>
			<div class='span12'>
				<div class='row-fluid'>
					<div class='span12'>
						<div class='page-header'>
							<h1 class='pull-left'>
								<i class='icon-bullhorn'></i> <span>活动详情</span>
							</h1>
						</div>
					</div>
				</div>
				<div class='row-fluid'>
					<div class='span12 box'>
						<div class='box-content'>
							<div class='clearfix'></div>
							<table class='table table-bordered table-striped'
								id='inplaceediting-user' style='margin-top: 20px'>
								<tbody>
									<tr>
										<td style='width: 25%'>活动ID</td>
										<td id="activityId" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>活动类型</td>
										<td id="activityType" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>活动内容</td>
										<td id="activityContent" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>性别要求</td>
										<td id="invitedSex" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>描述</td>
										<td id="activityExplain" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>人数限制</td>
										<td id="expectedNumber" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>活动地点</td>
										<td id="activityPlace" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>发起人ID</td>
										<td id="userId" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>发起人昵称</td>
										<td id="nickName" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>活动进行时间</td>
										<td id="activityTime" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>活动创建时间</td>
										<td id="activityCreateTime" style='width: 75%'></td>
									</tr>
									<tr>
										<td style='width: 25%'>活动过期时间</td>
										<td id="activityPastTime" style='width: 75%'></td>
									</tr>
									<tr>
										<td>评论</td>
										<td>
											<input type="hidden" id='csrfToken'/>
											<div class='row-fluid'>
												<div class='span12 box'>
													<div class='chat row-fluid'>
														<div class='box box-nomargin span12'>
															<div class='box-content box-no-padding'>
																<div class='scrollable' data-scrollable-height='300'
																	data-scrollable-start='bottom'>
																	<ul id="comments"
																		class='unstyled list-hover list-striped'>

																	</ul>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td style='width: 25%'>活动照片</td>
										<td style='width: 75%'>
											<div class='span12 box' style='margin-bottom: 0'>
												<div class='box-content'>
													<div class='carousel slide carousel-without-caption'
														id='myCarousel' style='margin-bottom: 0;'>
														<ol class='carousel-indicators'>
															<li class='active' data-slide-to='0'
																data-target='#myCarousel'></li>
															<li data-slide-to='1' data-target='#myCarousel'></li>
															<li data-slide-to='2' data-target='#myCarousel'></li>
														</ol>
														<!-- Carousel items -->
														<div id="activityPicture" class='carousel-inner'></div>
														<!-- Carousel nav -->
														<a class='carousel-control left' data-slide='prev'
															href='#myCarousel'>‹</a> <a
															class='carousel-control right' data-slide='next'
															href='#myCarousel'>›</a>
													</div>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<hr class='hr-normal' />
						</div>
					</div>
				</div>
				<div class='pull-right'>
					<button class='btn btn-danger' onclick="unpass()" id='inplaceediting-enable'>屏蔽活动</button>
					<button class='btn btn-primary' onclick="pass()" id='inplaceediting-enable'>下一个</button>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="template/JsFile.jsp"></jsp:include>
<script type="text/javascript">
	loadData();
	function loadData() {
		cleanData();
		loadActivity();
		getcsrfToken();
	}
	
	function cleanData(){
		document.getElementById("comments").innerHTML="";
		
		document.getElementById("activityId").innerHTML = "";
		document.getElementById("activityPastTime").innerHTML = "";
		document.getElementById("activityContent").innerHTML = "";
		document.getElementById("activityCreateTime").innerHTML = "";
		document.getElementById("activityExplain").innerHTML = "";
		document.getElementById("nickName").innerHTML = "";
		document.getElementById("activityTime").innerHTML = "";
		document.getElementById("expectedNumber").innerHTML = "";
		document.getElementById("invitedSex").innerHTML = "";
		document.getElementById("activityType").innerHTML = "";
		document.getElementById("userId").innerHTML = "";
		document.getElementById("activityPlace").innerHTML = "";
		document.getElementById("activityPicture").innerHTML="";
	}
	function getcsrfToken() {
		$.ajax({
			type:"GET",
			url:"/firstmeet_web/getcsrfToken",
			dataType : "text",
			success : function(result) {
				$('#csrfToken').attr("value", result);
			}
		});
	}
	
	function loadComment(id) {
		$.ajax({
			type : "get",
			url : "/firstmeet_web/comment/" + id,
			dataType : "text",
			success : function(result) {
				comments = new Array;
				comments = result.split("|");

				for (i = 0; i < comments.length; i++) {
					var obj = eval("(" + comments[i] + ")");
					var createli = document.createElement("li");
					createli.className = "message";
					createli.innerHTML = "<div class='avatar'><img alt='Avatar' height='23' src='"+obj.userPortrait+"' width='23' />"
							+ "</div><div class='name-and-time'><div class='name pull-left'><small><a href='#' class='text-contrast'>"
							+ obj.reviewerNickName
							+ "</a></small></div><div class='time pull-right'><small class='date pull-right muted'>"
							+ "<span class='' data-placement='top' title='"+obj.commentTime+"'>"
							+ obj.commentTime
							+ "</span>"
							+ "<i class='icon-time'></i></small></div></div><div class='body'>"
							+ "<div id='"+obj.commentId+"'>"+obj.commentContent +"</div>"+ "<div class='pull-right'><small class='date pull-right muted'>"
                                  +"<a style='cursor:pointer;' onclick='shieldComment("+obj.commentId+")'>屏蔽该评论</a></small></div></div>";
					document.getElementById("comments").appendChild(
							createli);

				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				window.location.href = "/firstmeet_web";
			}
		});
	}
	function loadActivity() {
		$.ajax({
			type : "get",
			url : "/firstmeet_web/activity",
			dataType : "text",
			success : function(result) {
				var obj = eval("(" + result + ")");
				document.getElementById("activityId").innerHTML = obj.activityId;
				document.getElementById("activityPastTime").innerHTML = obj.activityPastTime;
				document.getElementById("activityContent").innerHTML = obj.activityContent;
				document.getElementById("activityCreateTime").innerHTML = obj.activityCreateTime;
				document.getElementById("activityExplain").innerHTML = obj.activityExplain;
				document.getElementById("nickName").innerHTML = obj.nickName;
				document.getElementById("activityTime").innerHTML = obj.activityTime;
				document.getElementById("expectedNumber").innerHTML = obj.expectedNumber;
				document.getElementById("invitedSex").innerHTML = obj.invitedSex;
				document.getElementById("activityType").innerHTML = obj.activityType;
				document.getElementById("userId").innerHTML = obj.userId;
				document.getElementById("activityPlace").innerHTML = obj.activityPlace;
				loadComment(obj.activityId);
				var photos = obj.activityPicture;
				photo = new Array;
				photo = photos.split(';');
				var createDiv = document.createElement("div");
				createDiv.className = "active item";
				createDiv.innerHTML = "<img alt='Fff&amp;text=2' src='"+photo[0]+"' />";
				document.getElementById("activityPicture").appendChild(
						createDiv);
				for (i = 1; i < photo.length; i++) {
					var createDiv = document.createElement("div");
					createDiv.className = "item";
					createDiv.innerHTML = "<img alt='Fff&amp;text=2' src='"+photo[i]+"' />";
					document.getElementById("activityPicture").appendChild(
							createDiv);
				}
				;
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				window.location.href = "/firstmeet_web";
			}
		});
	}
	
	//<!-- 屏蔽评论内容 -->
	function shieldComment(commentid){
		var msg = "确定要屏蔽该条评论吗？\n\n请确认！"; 
		if (confirm(msg)==true){ 
			$.ajax({
				type:"post",
				url:"/firstmeet_web/comment/"+commentid,
				data:{
					CSRFToken : $("#csrfToken").val()
				},
				dataType : "text",
				success : function(result) {
					document.getElementById(commentid).innerHTML="该条评论已被屏蔽";
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) { 
					alert("屏蔽评论失败！");
					}
			});
		} 
	}
	
	//屏蔽活动
	function unpass(){
		var msg = "确定要屏蔽该条活动吗？\n\n请确认！"; 
		var activityid=parseInt($("#activityId").text());
		if (confirm(msg)==true){ 
			$.ajax({
				type:"post",
				url:"/firstmeet_web/activity/"+activityid+"/unpass",
				data:{
					CSRFToken : $("#csrfToken").val()
				},
				dataType : "text",
				success : function(result) {
					loadData();
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) { 
					alert("屏蔽活动失败！请重试");
					}
			});
		}  
	}
	
	//不屏蔽活动
	function pass(){
		var msg = "确定要通过该条活动吗？\n\n请确认！"; 
		var activityid=parseInt($("#activityId").text());
		if (confirm(msg)==true){ 
			$.ajax({
				type:"post",
				url:"/firstmeet_web/activity/"+activityid+"/pass",
				data:{
					CSRFToken : $("#csrfToken").val()
				},
				dataType : "text",
				success : function(result) {
					loadData();
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) { 
					alert("通过活动失败！请重试");
					}
			});
		}  
	}
</script>
<!-- / slimscroll -->
<script src='/firstmeet_web/assets/javascripts/plugins/slimscroll/jquery.slimscroll.min.js' type='text/javascript'></script>
<!-- / timeago -->
<script src='/firstmeet_web/assets/javascripts/plugins/timeago/jquery.timeago.js' type='text/javascript'></script>
<jsp:include page="template/Bodyend.jsp"></jsp:include>


