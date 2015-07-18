//检测浏览器语言
currentLang = navigator.language;   //判断除IE外其他浏览器使用语言
if(!currentLang){//判断IE浏览器使用语言
    currentLang = navigator.browserLanguage;
}
//alert(currentLang);


//判断访问终端
var browser={
    versions:function(){
        var u = navigator.userAgent, app = navigator.appVersion;
        return {
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1, //opera内核
            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
            ios: !!u.match(/(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
            iPhone: u.indexOf('iPhone') > -1 , //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1, //是否iPad
            webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
        };
    }(),
    language:(navigator.browserLanguage || navigator.language).toLowerCase()
}

//browser.versions.trident返回真假，真则是IE内核，以此类推browser.versions.webKit是否为谷歌内核
//判断是否IE内核
// if(browser.versions.trident){
// //    alert("is IE");
// }

// //判断是否webKit内核
// if(browser.versions.webKit){
// //    alert("is webKit");
// }

// //判断是否移动端
// if(browser.versions.mobile||browser.versions.android||browser.versions.ios){
// //    alert("移动端");
// }
