//var baseURL="http://cj.pobing.net"
var baseURL="http://localhost/ichujian";
var ajax_flag=0;  //用于记录ajax执行完毕状态
var id = document.getElementById("activityId").value;
loadComment(id);

function loadComment(id) {
	document.getElementById("comments").innerHTML="";
	$.ajax({
		type: "get",
		url: "/firstmeet_web/comment/" + id,
		dataType: "text",
		success: function(result) {
			comments = new Array;
			comments = result.split("|");
			for (i = 0; i < comments.length; i++) {
				var obj = eval("(" + comments[i] + ")");
				var creatediv = document.createElement("div");
				creatediv.className = "comment";
				creatediv.innerHTML = "<div class='comment_portrait'>" +
					"<img src='" + obj.userPortrait + "!small'></div><div class='comment_content'>" +
					"<div class='comment_name'>" + obj.reviewerNickName + "</div>" +
					"<div class='comment_msg'>" + obj.commentContent + "</div></div><hr/>";
				document.getElementById("comments").appendChild(creatediv);

			}
		}
	});
}


/*判断是否在微信浏览器中打开*/
function is_weixin() {
	var ua = navigator.userAgent.toLowerCase();
	if (ua.match(/MicroMessenger/i) == "micromessenger") {
		return true;
	} else {
		return false;
	}
}

function downloadClick() {
	var isappinstalled=getQueryString("isappinstalled");
	if (isappinstalled == "1") {
			if (is_weixin()) {
				document.getElementById("guid").style.display = "";
			}else{
				link=link.replace("http","chujian");
				window.location.href = link;
			}
	}else if (isappinstalled == "2") {
			window.location.href = link;
	}else{
		if (is_weixin()) {
		document.getElementById("guid").style.display = "";
		} else {
			window.location.href = 'http://www.hichujian.com/index_wap.html';
		}
	}
}

/*判断url中参数，本地是否安装此应用*/
/*http://h5.m.hichujian.com/actdetail/index.htm?actId=11&userId=100004&from=singlemessage&isappinstalled=0*/
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
    }
function isInstalled(link) {
	var isappinstalled=getQueryString("isappinstalled");
	if (isappinstalled == "1"||isappinstalled == "2") {
			document.getElementById("openOrdownImg").src="/firstmeet_web/assets/share/res/btnopen.png";
		}
}



/*用户点击报名或评论，先判断是否安装初见，否则第三方注册*/
function checkIsInstalled(item){
	var isappinstalled=getQueryString("isappinstalled");
	if (isappinstalled == "1") {
		if (is_weixin()) {
			document.getElementById("guid").style.display = "";
		}else{
			link=link.replace("http","chujian");
			window.location.href = link;
		}
	}else {
		document.cookie="todo="+item;
		var userId = document.getElementById("thirdpartyuserId").value;
		if(userId.length==0){
			document.getElementById("footer").style.display="none";
			document.getElementById("thirdpartLogin").style.display="";
		}else{
			logined();
		}
		
	}
}


/*qq登陆、注册*/
function qq_login(){
	//回调里的参数不能多，所以参数存放在cookies中
	document.cookie="qq_state="+qq_state;
	document.cookie="shareuserId="+getQueryString("userId");
	document.cookie="actId="+getQueryString("actId");
	//link=link+"&qq_code=1&qq_state="+qq_state;
	link=encodeURI(link);
	//var redirect_uri=encodeURI("http://h5.m.hichujian.com/actdetail/qq_login/share");
	//var redirect_uri=encodeURI("http://test.h5.m.hichujian.com/actdetail/qq_login/share");
	var redirect_uri=encodeURI("http://local.h5.m.hichujian.com/firstmeet_web/actdetail/qq_login/share");
	window.location.href="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101165629&redirect_uri="+redirect_uri+"&state="+qq_state+"&display=mobile";
	// $.get("https://graph.z.qq.com/moc2/authorize", { response_type: "code", client_id: "1103374766",redirect_uri:link,state:qq_state,display="mobile" } );
	// var request = $.ajax({
	// 			  url: "https://graph.qq.com/oauth2.0/authorize",
	// 			  type: "GET",
	// 			  data: {
	// 			  	response_type: "code", 
	// 			  	client_id: "1103374766",
	// 			  	redirect_uri:link,
	// 			  	state:qq_state,
	// 			  	display:"mobile"
	// 			  },
	// 			  dataType: "html"
	// 			});
				 
	// 			request.done(function(msg) {
	// 			  //$("#log").html( msg );
	// 			  alert(msg);
	// 			});
				 
	// 			request.fail(function(jqXHR, textStatus) {
	// 			  alert( "Request failed: " + textStatus );
	// 			});
}


//weibo登陆
//https://api.weibo.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
function weibo_login(){
	document.cookie="weibo_state="+weibo_state;
	document.cookie="shareuserId="+getQueryString("userId");
	document.cookie="actId="+getQueryString("actId");
	//link=link+"&qq_code=1&qq_state="+qq_state;
	//link=encodeURI(link);
	var redirect_uri="http://h5.m.hichujian.com/actdetail/weibo_login/share";
	//var redirect_uri="http://test.h5.m.hichujian.com/actdetail/weibo_login/share";
	//var redirect_uri="http://local.h5.m.hichujian.com/firstmeet_web/actdetail/weibo_login/share";
	window.location.href="https://api.weibo.com/oauth2/authorize?client_id=2545316838&response_type=code&redirect_uri="+redirect_uri;
	
}


function mobile_login(){
	document.getElementById("thirdpartLogin").style.display="none";
	document.getElementById("mobile_num").style.display="";
}

function btnmobilenumcancle(){
	document.getElementById("footer").style.display="";
	document.getElementById("mobile_num").style.display="none";
}

//短信注册，提交手机号
function mobile_num_confirm(item){
	//var ischeckauthcode=getCookie("ischeckauthcode");
	if (item=="code") {
		var authcode=document.getElementById("checkauthcode_input").value;
		if (authcode.length!=6) {
			showTips("验证码错误。");
			return;
		}else{
			checkAuthCode(authcode);
			document.getElementById("mobile_num").style.display="none";
			document.getElementById("pwd").style.display="";
		}
		document.getElementById("mobile_num").style.display="none";
	}else{
		var phone = document.getElementById("mobile_num_input").value;
		getcsrfToken();
		if (isPhone(phone)) {
			checkRegister(phone);
			document.cookie="phone="+phone;
		}else{
			showTips("手机号格式不对哦~~");
		}
	}
}

//手机号码注册
function phone_register(phone){
	getAuthCode(phone);
	document.getElementById("mobile_num_input").style.display="none";
	document.getElementById("checkauthcode_input").style.display="";
	document.getElementById("mobile_num_confirm").style.display="none";
	document.getElementById("mobile_code_confirm").style.display="";
}

function setThirdpartyParam(){
	var user_id=getQueryString("thirdpartyuserId");
	//var openId=getQueryString("openId");
	var thirdpart_flag=getQueryString("thirdpart_flag");
	var uu=getQueryString("uu");
	document.getElementById("thirdpartyuserId").value=user_id;
	document.getElementById("thirdpart_flag").value=thirdpart_flag;
	document.getElementById("uu").value=uu;
	//document.getElementById("openId").value=openId;
	if(thirdpart_flag!=""||thirdpart_flag!=null){
		logined();
	}
	if (thirdpart_flag=="qq"||thirdpart_flag=="weibo") {
		getcsrfToken();
	};
}

function logined(){
	var todo=getCookie("todo");
	document.cookie="thirdpart_flag="+getQueryString("thirdpart_flag");
	var thirdpart_flag=getCookie("thirdpart_flag");
	if (thirdpart_flag=="null") {
		thirdpart_flag=document.getElementById("thirdpart_flag").value;
	};
	if (thirdpart_flag!="null"&&thirdpart_flag.length>0) {
		if(todo=="apply"){
			document.getElementById("footer").style.display="none";
			document.getElementById("activity_siginup").style.display="";
		}else if(todo=="comment"){
			document.getElementById("footer").style.display="none";
			document.getElementById("activity_comment_box").style.display="";
		}
	};
}

function getCookie(name) 
{ 
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
 
    if(arr=document.cookie.match(reg))
 
        return unescape(arr[2]); 
    else 
        return null; 
}


function btnapplycancle(){
	document.getElementById("footer").style.display="";
	document.getElementById("activity_siginup").style.display="none";
}

function btnapply(){
	var msg=document.getElementById("applyMsg").value;
	if(msg==""||msg==null){
		showTips("对Ta 说句话咯~！");
	}
	var actId=getQueryString("actId");
	var user_id=document.getElementById("thirdpartyuserId").value;
	var CSRFToken=document.getElementById("uu").value;
	btnapplycancle();
	$.ajax({
		type: "post",
		url: "/firstmeet_web/apply",
		dataType: "text",
		data:{
			activityId:actId,
			userId:user_id,
			msg:msg,
			CSRFToken:CSRFToken
		},
		success: function(result) {
			showTips(result);
			}
		});
}

function btncommentcancle(){
	document.getElementById("footer").style.display="";
	document.getElementById("activity_comment_box").style.display="none";
}
function btncomment(){
	var msg=document.getElementById("commentMsg").value;
	if(msg==""||msg==null){
		showTips("评论内容不能空！");
	}
	var actId=getQueryString("actId");
	var user_id=document.getElementById("thirdpartyuserId").value;
	var act_userId=getQueryString("userId");
	var CSRFToken=document.getElementById("uu").value;
	btncommentcancle();
	$.ajax({
		type: "post",
		url: "/firstmeet_web/comment",
		dataType: "text",
		data:{
			//act_userId:act_userId，
			activityId:actId,
			userId:user_id,
			msg:msg,
			CSRFToken:CSRFToken
		},
		success: function(result) {
			showTips(result);
			if (result=="评论成功!") {
				loadComment(actId);
			};
			}
		});
}


function pwd_cancel(){
	document.getElementById("pwd").style.display="none";
}

function pwd_confirm(){
	var phone=getCookie("phone");
	var pwd1=calcMD5(document.getElementById("pwd1").value);
	var pwd2=calcMD5(document.getElementById("pwd2").value);
	if (pwd1.length>=6&&pwd1==pwd2) {
		$.ajax({
		type: "get",
		url: "/firstmeet_web/actdetail/mobbileSign",
		data:{
				phone_number:phone,
				password:pwd1
			},
		dataType: "html",
		success: function(result) {
			document.getElementById("pwd").style.display="none";
			var temp = result.split(";");
			document.getElementById("thirdpartyuserId").value=temp[0];
			document.getElementById("uu").value=temp[1];
			document.getElementById("footer").style.display="";
			logined();
			}
	});
	}else{
		showTips("请重新输入密码！");
		document.getElementById("pwd1").value="";
		document.getElementById("pwd2").value="";
	}
}
function hiddenTips(){
	document.getElementById("tips").style.display="none";
}

function showTips(msg){
	document.getElementById("tips").style.display="";
	document.getElementById("tips").innerHTML=msg;
	setTimeout("hiddenTips()",2000);
}

/**
* 检查字符串是否为合法手机号码
* @param {String} 字符串
* @return {bool} 是否为合法手机号码
*/
function isPhone(aPhone) {
    var bValidate = RegExp(/1[3-8]+\d{9}/).test(aPhone);
    if (bValidate) {
        return true;
    }
    else
        return false;
}

//获取短信验证码
function getAuthCode(phone){
	$.ajax({
		type: "get",
		url: "/firstmeet_web/actdetail/getAuthCode",
		data:{
				phone_number:phone
			},
		dataType: "html",
		success: function(result) {
			showTips(result);
			}
	});
}

//检测验证码
function checkAuthCode(code){
	var phone=getCookie("phone");
	$.ajax({
		type: "get",
		url: "/firstmeet_web/actdetail/checkAuthCode",
		data:{
				phone_number:phone,
				auth_code:code
			},
		dataType: "html",
		success: function(result) {
			//showTips(result);
			}
	});
}


//验证手机号是否已经注册
function checkRegister(phone){
	$.ajax({
		type: "get",
		url: "/firstmeet_web/actdetail/checkRegister",
		data:{
				phone_number:phone,
			},
		dataType: "text",
		success: function(result) {
			if (result=="0") {
				showTips("手机号码格式不正确！");
			}else{
				if (result=="131") {//已经被注册
					document.getElementById("login-pwd").style.display="";
					document.getElementById("mobile_num").style.display="none";
				}else if(result=="132"){//未被注册
					phone_register(phone);
				}
			}
		}
	});
}


function login_cancel(){
	document.getElementById("login-pwd").style.display="none";
	document.getElementById("footer").style.display="none";
}


//手机号登陆
function login_confirm(){
	document.getElementById("login-pwd").style.display="none";
	var phone = getCookie("phone");
	var pwd=calcMD5(document.getElementById("login-pwd-value").value);
	var CSRFToken=document.getElementById("uu").value;
	$.ajax({
		type: "post",
		url: "/firstmeet_web/actdetail/mobileSign",
		data:{
				phone_number:phone,
				password:pwd,
				CSRFToken : CSRFToken
			},
		dataType: "html",
		success: function(result) {
			if(result==1){
				document.getElementById("pwd").style.display="";   //登录时未注册用户注册
			}else if (result=="0"){
				showTips("登录失败，请重试。");
				document.getElementById("login-pwd").style.display="";
			}          //登录出错
			else{
				document.getElementById("thirdpartyuserId").value=result;
				getcsrfToken();
				document.getElementById("thirdpart_flag").value="mobile";
				document.cookie="thirdpart_flag="+document.getElementById("thirdpart_flag").value;
				logined();
			}
		}
	});
}


//获取token
function getcsrfToken() {
	$.ajax({
		type:"GET",
		url:"/firstmeet_web/getcsrfToken",
		dataType : "text",
		success : function(result) {
			document.getElementById("uu").value=result;
			ajax_flag=1;
		}
	});
}
//https://api.weibo.com/oauth2/default.html
//http://local.h5.m.hichujian.com/firstmeet_web/actdetail/weibo_login