<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="template/Headstart.jsp"></jsp:include>
<style type="text/css">
img,a img{
border:0;
margin:0;
padding:0;
max-width:600px;
width: expression_r(this.width > 600 && this.width > this.height ? 600px : 'auto';);
max-height:400px;
height: expresion(this.height > 400 ? 400px : 'auto';);
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
			<input type="hidden" id="csrfToken" value="${CSRFToken}" />
				<div class='page-header'>
				    <h1 class='pull-left'>
				        <i class='icon-group'></i>
				        <span>用户信息</span>
				    </h1>
				</div>
				<div class='row-fluid'>
				<div class='span12 box bordered-box orange-border' style='margin-bottom:0;'>
				<div class='box-header orange-background'>
				    <div class='title'>当前注册用户&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>总人数:${count}人</span></div>
				</div>
				<div class='box-content box-no-padding'>
				<div class='responsive-table'>
				<div class='scrollable-area'>
				<table class='data-table table table-bordered table-striped' style='margin-bottom:0;'>
				    <thead>
				    <tr>
				    	<th>
				    		ID
				    	</th>
				        <th>
				            昵称
				        </th>
				        <th>
				            大学
				        </th>
				        <th>
				            性别
				        </th>
				        <th></th>
				    </tr>
				    </thead>
				    <tbody>
					    <c:forEach items="${userList}" var="item">
						    <tr>
						    	<td><c:out value="${item.userId}" /></td>
					            <td><c:out value="${item.nickName}" /></td>
					            <td><c:out value="${item.units}" /></td>
					            <td><c:out value="${item.sex}" /></td>
					            <td>
					                <div class='text-right'>
					                	<a class='btn btn-success btn-mini' data-toggle='modal' onclick="getUserById(${item.userId})" href='#modal-example2'>
					                        <i class='icon-eye-open'></i>
					                    </a>
					                    <a class='btn btn-danger btn-mini' onclick="delUser(${item.userId})">
					                        <i class='icon-remove'></i>
					                    </a>
					                </div>
					            </td>
					        </tr>
						</c:forEach> 
				    </tbody>
				</table>
				<div class="row-fluid">
				    <div class="span6">
				        <div class="dataTables_info" id="DataTables_Table_0_info"></div>
				    </div>
				    <div class="span6 text-right">
				        <div class="dataTables_paginate paging_bootstrap pagination pagination-small">
				            <ul>
				            	<c:set var="pageNo" value="${pageNo}"/>
				            	<c:set var="pageSum" value="${pageSum}"/>
				            	<c:choose>
				            		<c:when test="${pageNo==1}">
				            			<li class="prev disabled"><a href="#">← 上一页</a></li>
				            		</c:when>
				            		<c:otherwise>
				            			<li ><a href="../../user/${pre}/list">← 上一页</a></li>
				            		</c:otherwise>
				            	</c:choose>
				                <c:forEach var="i" begin="1" end="${pageSum}">
				                	<c:choose>
									   <c:when test="${i==pageNo}">
											<li class="active"><a href="#"><c:out value="${i}"/></a></li>
									   </c:when>
									   <c:otherwise>
											<li ><a href="../../user/${i}/list"><c:out value="${i}"/></a></li>
									   </c:otherwise>
									</c:choose>
								</c:forEach>
								<c:choose>
									<c:when test="${pageNo==pageSum}">
										<li class="next disabled"><a href="#">下一页 → </a></li>
									</c:when>
									<c:otherwise>
										<li class="next"><a href="../../user/${next}/list">下一页 → </a></li>
									</c:otherwise>
								</c:choose>
				            </ul>
				        </div>
				    </div>
				</div>
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			<div class='modal hide fade' id='modal-example2' role='dialog' tabindex='-1'>
	        <div class='modal-header'>
	            <button class='close' data-dismiss='modal' onclick="$('#photo').empty()" type='button'>&times;</button>
	            <h3>用户详情</h3>
	        </div>
	        <div class='modal-body'>
	            <form class='form' style='margin-bottom: 0;' />
	                <div class='control-group'>
	                    <label class='control'><b>用户ID：&nbsp;</b><span id="userid">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control'><b>性别：&nbsp;</b><span id="sex">正在加载...</span></label>
	                </div>
	                <div class='control-group'>
	                    <label class='control-label'><b>昵称：&nbsp;</b><span id="nickname">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>身高：&nbsp;</b><span id="height">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>体重：&nbsp;</b><span id="weight">正在加载...</span></label>
	                </div>
	                <div class='control-group'>
	                    <label class='control-label'><b>手机号：&nbsp;</b><span id="phone_number">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>QQ号：&nbsp;</b><span id="qq_number">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>weibo 帐号：&nbsp;</b><span id="weibo_number">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>被拉黑次数：&nbsp;</b><span id="pulled_black_number">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>注册时间：&nbsp;</b><span id="user_register_time">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>生日：&nbsp;</b><span id="birthday">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>地点：&nbsp;</b><span id="location">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>职业：&nbsp;</b><span id="job">正在加载...</span></label>
	                </div>
			<div class='control-group'>
	                    <label class='control-label'><b>照片：&nbsp;</b></label>
			    <div class='box-content'>
			    <div class='carousel slide carousel-without-caption' id='myCarousel' style='margin-bottom:0;'>
				<ol class='carousel-indicators'>
				    <li class='active' data-slide-to='0' data-target='#myCarousel'></li>
				    <li data-slide-to='1' data-target='#myCarousel'></li>
				    <li data-slide-to='2' data-target='#myCarousel'></li>
				</ol>
				<!-- Carousel items -->
				<div id="photo" class='carousel-inner'>
				    
				</div>
				<!-- Carousel nav -->
				<a class='carousel-control left' data-slide='prev' href='#myCarousel'>‹</a>
				<a class='carousel-control right' data-slide='next' href='#myCarousel'>›</a>
			    </div>
			    </div>
	                </div>
	            </form>
	        </div>
	        <div class='modal-footer'>
	            <button class='btn' data-dismiss='modal' onclick="$('#photo').empty()">Close</button>
	        </div>
	    </div>
		</div>
	</div>
</section>
<jsp:include page="template/JsFile.jsp"></jsp:include>
<script type="text/javascript">
	function delUser(id){
		var msg = "确定要删除吗？\n\n请确认！"; 
		if (confirm(msg)==true){ 
			$.ajax({
				type:"post",
				url:"../../user/"+id,
				data:{
					CSRFToken : $("#csrfToken").val()
				},
				dataType : "text",
				success : function(result) {
					if(result=="ok"){
						window.location.href="../../user/${pageNo}/list";
					}else{
						alert(result);
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) { 
					window.location.href="/firstmeet_web";
					}
			});
		} 
	}
	
	function getUserById(id){
		$.ajax({
			type:"get",
			url:"../../user/"+id,
			dataType : "text",
			success : function(result) {
				var obj=eval ("(" + result + ")");
				document.getElementById("userid").innerHTML = obj.userId;
				document.getElementById("sex").innerHTML = obj.sex;
				document.getElementById("nickname").innerHTML = obj.nickName;
				document.getElementById("birthday").innerHTML = obj.birthday;
				document.getElementById("user_register_time").innerHTML = obj.user_register_time;
				document.getElementById("weight").innerHTML = obj.weight+" kg";
				document.getElementById("height").innerHTML = obj.height+" cm";
				document.getElementById("qq_number").innerHTML = obj.qq_number;
				document.getElementById("weibo_number").innerHTML = obj.weibo_number;
				document.getElementById("phone_number").innerHTML = obj.phone_number;
				document.getElementById("location").innerHTML = obj.location;
				document.getElementById("job").innerHTML = obj.job;
				document.getElementById("pulled_black_number").innerHTML = obj.pulled_black_number;
				var photos=obj.photo;
				photo = new Array;
				photo=photos.split(';');
				var createDiv=document.createElement("div");
				createDiv.className="active item"; 
				createDiv.innerHTML="<img alt='Fff&amp;text=2' src='"+photo[0]+"' />";  
				document.getElementById("photo").appendChild(createDiv); 
				for(i=1;i<photo.length;i++){
					var createDiv=document.createElement("div"); 
					createDiv.className="item"; 
					createDiv.innerHTML="<img alt='Fff&amp;text=2' src='"+photo[i]+"' />";  
					document.getElementById("photo").appendChild(createDiv); 
					}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { 
				window.location.href="/firstmeet_web";
				}
		});
	}
</script>
<jsp:include page="template/Bodyend.jsp"></jsp:include>