startgps();
//获取地理位置
function startgps()
{
	var gps = navigator.geolocation;
	if (gps){
		gps.getCurrentPosition(showgps,function(error){},{maximumAge: 10000}
		); // 这里设置超时为10000毫秒，即10秒
	}
}
            
function showgps(position){
    if (position){
        latitude = position.coords.latitude;
        longitude = position.coords.longitude;
        getActivity();
    }
}


//滑动页面加载数据
$(function(){ 
    var winH = $(window).height(); //页面可视区域高度 
    var i = 1; //设置当前页数 
    $(window).scroll(function () { 
        var pageH = $(document.body).height(); 
        var scrollT = $(window).scrollTop(); //滚动条top 
        var aa = (pageH-winH-scrollT)/winH; 
        if(aa<0.02){ 
            $("#hidden").show();
            // $.getJSON("result.php",{page:i},function(json){ 
            //     if(json){ 
            //         var str = ""; 
            //         $.each(json,function(index,array){ 
            //             var str = "<div class=\"single_item\"><div class=\"element_head\">"; 
            //             var str += "<div class=\"date\">"+array['date']+"</div>"; 
            //             var str += "<div class=\"author\">"+array['author']+"</div>"; 
            //             var str += "</div><div class=\"content\">"+array['content']+"</div></div>"; 
            //             $("#container").append(str); 
            //         }); 
            //         i++; 
            //     }else{ 
            //         $(".nodata").show().html("别滚动了，已经到底了。。。"); 
            //         return false; 
            //     } 
            // }); 
        } 
    }); 
}); 



function getActivity(){
	$.getJSON("getActivityList",{pageNo:pageNo,longitude:longitude,latidute:latidute},function(json){ 
        if(json){ 
        	alert(json);
            // var str = ""; 
            // $.each(json,function(index,array){ 
            //     var str = "<div class=\"single_item\"><div class=\"element_head\">"; 
            //     var str += "<div class=\"date\">"+array['date']+"</div>"; 
            //     var str += "<div class=\"author\">"+array['author']+"</div>"; 
            //     var str += "</div><div class=\"content\">"+array['content']+"</div></div>"; 
            //     $("#container").append(str); 
            // }); 
            pageNo++; 
        }else{ 
            // $(".nodata").show().html("别滚动了，已经到底了。。。"); 
            return false; 
        } 
    }); 
}