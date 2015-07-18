<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="zh">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes"/>
		<meta name="apple-mobile-web-app-capable" content="yes"/>
		<meta name="format-detection" content="telephone=yes"/>
		<meta name="apple-mobile-web-app-status-bar-style" content="default"/>
		<meta name="keywords" content="活动分享—hi 初见"/>
		<meta name="description" content=""/>
		<link rel="shortcut icon" type="image/x-icon" href="/firstmeet_web/assets/share/res/logo.png" media="screen" />
		<title>活动分享—hi 初见</title>
		<link rel="stylesheet" type="text/css" href="/firstmeet_web/assets/share/share.css">
	</head>
	<body>
		<div class="main">
			<!--头部个人、活动信息-->
			<div class="head">
				<div class="shareheadportrait">
					<img src="${shareUser.head_portrait}!small">
				</div>
				<div class="share">
					<div class="shareprofile">
						<span class="username">${shareUser.nickName}</span>
						<span class="gender">
							<c:choose>
								<c:when test="${shareUser.sex=='男'}">
									<img src="/firstmeet_web/assets/share/res/male.png">
								</c:when>
								<c:otherwise>
									<img src="/firstmeet_web/assets/share/res/female.png">
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					<div class="shareinfo">
						<!-- <span class="activity_date">${activity }</span> -->
						<span class="activity_share">分享活动</span>
						<span class="activity_type">${activity.activityType }</span>
					</div>
				</div>
			</div>

			<!--活动-->
			<div class="activity">
				<div class="activity_info">
					<div class="activity_headportrait" id="activity_headportrait">
						<img src="${activityUser.head_portrait }!small">
					</div>
					<div class="activity_title" id="activity_title">
						${activity.activityContent }
					</div>
				</div>
				<div class="activity_media">
					<!-- <video  controls poster="/firstmeet_web/assets/share/res/bgfill.png" autoplay="autoplay">
						<source src="11.mp4" type="video/mp4" />
						<source src="demo.webm" type="video/webm"/>
						<source src="demo.ogv" type="video/ogg"/>     
						<object>
							<embed src="11.mp4" type= "application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" />
						</object>        
						HTML5 Video is required for this example
					</video>-->
					<img alt="活动图片" src="${activity.activityPicture }" onError="javascript:this.src='/firstmeet_web/assets/share/res/default.png';"/>
				</div>
				<div class="activity_time">
					<span class="icon_activity"><img src="/firstmeet_web/assets/share/res/time.png"></span>
					${activity_time}
				</div>
				<div class="activity_place">
					<span class="icon_activity"><img src="/firstmeet_web/assets/share/res/place.png"></span>
					${activity.activity_place}
				</div>
				<div class="activity_place">
					<span class="icon_activity"><img src="/firstmeet_web/assets/share/res/invitedobj.png"></span>
					邀请对象：${activity.invited_object_sex}
				</div>
				<div class="activity_place">
					<span class="icon_activity"><img src="/firstmeet_web/assets/share/res/invitednum.png"></span>
					邀请人数：
					<c:choose>
						<c:when test="${activity.expected_number==0}">
							不限
						</c:when>
						<c:otherwise>
							${activity.expected_number}人
						</c:otherwise>
					</c:choose>
				</div>
				<div class="activity_place">
					<span class="icon_activity"><img src="/firstmeet_web/assets/share/res/say.png"></span>
					${activity.activityExplain}
				</div>
				<!-- <div id="activity_invite" class="activity_invite">
					邀请对象：${activity.invited_object_sex}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邀请人数：
					<c:choose>
						<c:when test="${activity.expected_number==0}">
							不限
						</c:when>
						<c:otherwise>
							${activity.expected_number}
						</c:otherwise>
					</c:choose>
				</div>
				<div class="activity_content" id="activity_content">
					Ta 说：${activity.activityExplain }
				</div> -->
				<div class="todo">
					<div class="btn">
						<img onclick="checkIsInstalled('apply')" src="/firstmeet_web/assets/share/res/btnapply.png"/>
					</div>
					<div class="btn">
						<img onclick="checkIsInstalled('comment')" src="/firstmeet_web/assets/share/res/btncomment.png"/>
					</div>
				</div>
			</div>

			<!--评论-->
			<input id="activityId" type="hidden" value="${activity.activityId }"/>
			<div class="activity_comment">
				<div class="comment_head">
					<div id="person_num" class="person_num">已报名：${activity.sign_up_number}</div>
					<div class="comment_num">共${activity.comment_number }条评论</div>
				</div>
				<hr/>
				<div class="comments" id="comments">
					<!--  <div class="comment">
						<div class="comment_portrait">
							<img src="/firstmeet_web/assets/share/res/1.jpg">
						</div>
						<div class="comment_content">
							<div class="comment_name">优质西瓜</div>
							<div class="comment_msg">好好学习</div>
						</div>
					</div>
					<hr/>-->
				</div>
				<!-- 站长统计 -->
				<div class="cnzz">
					<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1253383357'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/z_stat.php%3Fid%3D1253383357%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
				</div>
			</div>

			<div class="footer" id="footer">
				<div class="logo">
					<img src="/firstmeet_web/assets/share/res/logo.png">
				</div>
				<div class="slogan">
					<div class="slogan_top">更多活动，更多精彩</div>
					<div class="slogan_bottom">尽在<span class="app_name">hi&nbsp;初见</span></div>
				</div>
				<div class="download">
					<img id="openOrdownImg" onclick="downloadClick()" src="/firstmeet_web/assets/share/res/btndown.png">
				</div>
			</div>
			<div style="display:none;" class="thirdpartLogin" id="thirdpartLogin" >
				<div onclick="mobile_login()" class="thirdpartLogin_item_mobile">
					<img src="/firstmeet_web/assets/share/res/phone.png">
					手机登录
				</div>
				<!-- <div><span>|</span></div>
				<div onclick="qq_login()" class="thirdpartLogin_item_qq">
					<img src="/firstmeet_web/assets/share/res/qq.png">
					QQ登录
				</div> -->
				<div><span>|</span></div> 
				<div onclick="weibo_login()" class="thirdpartLogin_item_sina">
					<img src="/firstmeet_web/assets/share/res/sina.png">
					微博登录
				</div>
			</div>
			<div style="display:none;" class="tips" id="tips"></div>
			<!--报名活动-->
			<div style="display:none;" class="activity_siginup" id="activity_siginup" >
				<div class="activity_siginup_enterMsg">
					<input id="applyMsg" placeholder="报名要对ta说一句话哦 ~"/>
				</div>
				<div class="activity_siginup_btn">
					<div class="activity_siginup_cancel" onclick="btnapplycancle()">
						取消
					</div>
					<div class="activity_siginup_confirm" onclick="btnapply()">
						确认报名
					</div>
				</div>
			</div>
			<!--评论活动-->
			<div style="display:none;" class="activity_comment_box" id="activity_comment_box" >
				<div class="activity_comment_enterMsg">
					<input id="commentMsg" placeholder="请输入评论内容！" />
				</div>
				<div class="activity_comment_btn">
					<div class="activity_comment_cancel" onclick="btncommentcancle()">
						取消
					</div>
					<div class="activity_comment_confirm" onclick="btncomment()">
						评论
					</div>
				</div>
			</div>

			<!--手机号验证码-->
			<div style="display:none;" class="mobile_num" id="mobile_num" >
				<div class="mobile_num_enter">
					<input id="mobile_num_input" placeholder="请输入手机号码！" />
					<input style="display:none;" id="checkauthcode_input" placeholder="请输入短信验证码！" />
				</div>
				<div class="mobile_num_enter_btn">
					<div class="mobile_num_cancel" onclick="btnmobilenumcancle()">
						取消
					</div>
					<div class="mobile_num_confirm" id="mobile_num_confirm" onclick="mobile_num_confirm('phone')">
						提交
					</div>
					<div style="display:none;" class="mobile_code_confirm" id="mobile_code_confirm" onclick="mobile_num_confirm('code')">
						提交
					</div>
				</div>
			</div>

			<!--注册时输入密码-->
			<div style="display:none;" class="pwd" id="pwd" >
				<div class="pwd_enter">
					<input id="pwd1" type="password" placeholder="请输入6位以上密码！" />
					<input id="pwd2" type="password" placeholder="请再次输入密码！" />
				</div>
				<div class="pwd_btn">
					<div class="pwd_cancel" onclick="pwd_cancel()">
						取消
					</div>
					<div class="pwd_confirm" onclick="pwd_confirm()">
						提交
					</div>
				</div>
			</div>


			<!--登陆时输入密码-->
			<div style="display:none;" class="login-pwd" id="login-pwd" >
				<div class="login_enter">
					<input id="login-pwd-value" type="password" placeholder="请输入密码" />
				</div>
				<div class="login_btn">
					<div class="login_cancel" onclick="login_cancel()">
						取消
					</div>
					<div class="login_confirm" onclick="login_confirm()">
						登陆
					</div>
				</div>
			</div>
			<div>
			</div>
			
			<!-- 在微信中点击下载提示进入浏览器 -->
			<!--
			<div style="display: none;" class="guid" id="guid">
				<div class="guid_arrow" id="guid_arrow">
					<img alt="点击右上角，在浏览器中打开" src="/firstmeet_web/assets/share/res/openanother.png">
				</div>
				<div class="guid_content">
					<ul>
						<li>1.请点击这里</li>
						<li>2.选择“在浏览器中打开”</li>
					</ul>
				</div>
			</div>
			-->
			<div style="display: none;" class="guid" id="guid">
				<img src="/firstmeet_web/assets/share/res/upsidebg.png" onclick="noguid()">
			</div>
		</div>
		<div class="hiden-msg">
			<input type="hidden" id="thirdpart_flag" />
			<input type="hidden" id="thirdpartyuserId" />
			<input type="hidden" id="openId" />
			<input type="hidden" id="uu" />
			<input type="hidden" id='csrfToken'/>
		</div>
<!-- / jquery -->
<script src='/firstmeet_web/assets/javascripts/jquery/jquery.min.js' type='text/javascript'></script>
<script type="text/javascript" src="/firstmeet_web/assets/share/md5.js"></script>
<script type="text/javascript" src="/firstmeet_web/assets/share/share.js"></script>	
<script type="text/javascript">
	var height_activity_title=document.getElementById("activity_headportrait").offsetHeight;
	document.getElementById("activity_title").style.height=height_activity_title+"px";
	document.getElementById("activity_title").style.lineHeight=height_activity_title+"px";
	/*用于state*/
	function state_guid() {
	    function S4() {
	       return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
	    }
	    return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
	}
	var qq_state=state_guid();
	var weibo_state=state_guid();
	var mobile_state=state_guid();
	var link = window.location.href;
	var content = $("#activity_content").text().trim();
	var title = "我在hi初见发现了这个活动，小伙伴们快来参加吧！ "+$("#activity_title").text().trim();
	window.shareData = {
        "imgUrl": "http://h5.m.hichujian.com/assets/share/res/logo.png",
        "timeLineLink": link,
        "tTitle": title,
        "tContent": content
    };
	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	    WeixinJSBridge.on('menu:share:appmessage', function (argv) {
	        WeixinJSBridge.invoke('sendAppMessage', {
	            "img_url": window.shareData.imgUrl,
	            "link": window.shareData.timeLineLink,
	            "desc": window.shareData.tContent,
	            "title": window.shareData.tTitle
	        }, onShareComplete);
	    });

	    WeixinJSBridge.on('menu:share:timeline', function (argv) {
	        WeixinJSBridge.invoke('shareTimeline', {
	            "img_url": window.shareData.imgUrl,
	            "img_width": "640",
	            "img_height": "640",
	            "link": window.shareData.timeLineLink,
	            "desc": window.shareData.tContent,
	            "title": window.shareData.tTitle
	        }, onShareComplete);
	    });
	}, false);

	function onShareComplete(res) {

        //document.location.href = mebtnopenurl;

    }

    function noguid(){
    	document.getElementById("guid").style.display="none";
    }
    isInstalled(link);
    setThirdpartyParam();
</script>		


	</body>
</html>