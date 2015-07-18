<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="template/Headstart.jsp"></jsp:include>
<!-- 日历选择 -->
<link rel="stylesheet"
	href="/firstmeet_web/assets/stylesheets/jquery_ui/jquery.cxcalendar.css">

<jsp:include page="template/Headend.jsp"></jsp:include>
<jsp:include page="template/Body_Nav.jsp"></jsp:include>
<section id='content'>
	<div class='container-fluid'>
		<div class='row-fluid' id='content-wrapper'>
			<div class='span12'>
				<div class='page-header'>
					<h1 class='pull-left'>
						<i class='icon-picture'></i> <span>图片审核</span>
					</h1>
				</div>
				<div class='row-fluid'>
					<div class='span12 box'>
						<div class='box-content'>
							<div class='row-fluid'>
								<div class='span12'>
									<div class="control-group">
										<form class="form form-horizontal" action="asd">
											<label class="control-label">选择图片上传日期：</label>
											<div class="controls">
												<input id="calendar" type="text" value="" readonly />
												<button type="button" onclick="pullImg()">确定</button>
											</div>
										</form>
									</div>
									<div class='gallery'>
										<input type="hidden" id='csrfToken' value="${CSRFToken}" />
										<ul id="imgs" class='unstyled inline'>
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
</section>
<jsp:include page="template/JsFile.jsp"></jsp:include>
<!-- 日历选择 -->
<script
	src="/firstmeet_web/assets/javascripts/jquery/jquery.cxcalendar.min.js"></script>
<script type="text/javascript">
	Initialization();
	var urlarray = new Array();
	function Initialization() {
		var currentDate = new Date();
		var year = currentDate.getFullYear(); //获取完整的年份(4位,1970-????)
		var month = currentDate.getMonth() + 1; //获取当前月份(0-11,0代表1月)
		var date = currentDate.getDate(); //获取当前日(1-31)
		$("#calendar").cxCalendar();
		if (month < 10) {
			month = "0" + month;
		}
		if (date < 10) {
			date = "0" + date;
		}
		var time = "" + year + "-" + month + "-" + date + "";
		$("#calendar").val(time);
		getImg(time);
	}

	//确定按钮点击事件
	function pullImg() {
		var date = $("#calendar").val();
		$("#imgs").html("");
		getImg(date);
	}

	/*拉取图片*/
	function getImg(date) {
		$
				.ajax({
					type : "get",
					url : "/firstmeet_web/getImg/" + date,
					dataType : "text",
					cache:false,
					success : function(result) {
						if ("null" == result) {
							$("#imgs").html("<h4>当前日期没有图片，请选择其他日期！</h4>")
						} else {
							urlarray = result.split('|');
							for (i = 0; i < urlarray.length - 1; i++) {
								var createli = document.createElement("li");
								createli.innerHTML = "<div class='picture'><div class='actions'>"
										+ "<div class='pull-right'><a class='btn btn-link' onclick='unpass("
										+ i
										+ ")'>"
										+ "<i class='icon-share'></i> 不合格</a></div></div>"
										+ "<img style='width:250px;height:250px;' alt='加载失败' src="+urlarray[i]+" /></div>";
								$("#imgs").append(createli);
							}
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$("#imgs").html("<h4>加载失败，请重新选择日期！</h4>");
					}
				});
	}

	//确认图片不符合要求
	function unpass(i) {
		question = confirm("你确认该图片不符合要求吗？")
		if (question != "0") {
			var date = $("#calendar").val();
			$.ajax({
				type : "post",
				url : "/firstmeet_web/unpassImg",
				dataType : "text",
				data : {
					date : date,
					url : urlarray[i],
					CSRFToken : $("#csrfToken").val()
				},
				success : function(result) {
					pullImg();
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert("操作失败！");
					windows.location.href="/firstmeet_web";
				}
			});
		}
	}
</script>
<jsp:include page="template/Bodyend.jsp"></jsp:include>