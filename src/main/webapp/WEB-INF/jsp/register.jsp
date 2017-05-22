<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="uft-8">
<head>
  <meta charset="utf-8">
  <!-- Title and other stuffs -->
  <title>注册页面</title> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="">
  <!-- Stylesheets -->
  <link href="<c:url value="/style/bootstrap.css" />" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value="/style/font-awesome.css" />">
  <link href="<c:url value="/style/style.css" />" rel="stylesheet">
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->
  <!-- Favicon -->
  <link rel="shortcut icon" href="<c:url value="/img/favicon/favicon.png" />">
</head>
<body>
<div class="login-header">

</div>
<!-- Form area -->
<div class="login-page">
<div class="admin-form">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <!-- Widget starts -->
            <div class="widget worange">
              <!-- Widget head -->
              <div class="widget-head">
                <i class="icon-lock"></i> 注册 
              </div>
              <div class="widget-content">
                <div class="padd">
                  <!-- Login form -->
                  <form class="form-horizontal" id="_form" method="post">
                    <!-- Email -->
                    <div class="form-group">
                      <label class="control-label col-lg-3" for="userName">用戶名</label>
                      <div class="col-lg-9">
                        <input type="text" class="form-control" id="nickname" name="nickname" placeholder="用戶名">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-lg-3" for="mobile">手机号</label>
                      <div class="col-lg-9">
                        <input type="text" class="form-control" id="mobile" name="mobile" placeholder="手机号">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-lg-3" for="mobile">邮箱</label>
                      <div class="col-lg-9">
                        <input type="text" class="form-control" id="email" name="email" placeholder="邮箱">
                      </div>
                    </div>
                    <!-- Password -->
                    <div class="form-group">
                      <label class="control-label col-lg-3" for="inputPassword">密码</label>
                      <div class="col-lg-9">
                        <input type="password" class="form-control" id="password" name="password" placeholder="密码">
                      </div>
                    </div>
                    <!-- Password -->
                    <div class="form-group">
                      <label class="control-label col-lg-3" for="inputPassword">重复密码</label>
                      <div class="col-lg-9">
                        <input type="password" class="form-control" id="re_password" name="re_password" placeholder="重复密码">
                      </div>
                    </div>
                    <div class="form-group">
                    	<label class="control-label col-lg-3" for="inputPassword">验证码</label>
                    	
                    		<div class="col-lg-5">
		                        <input type="text" class="form-control" name="vcode" placeholder="验证码">
		                      </div>
		                <div style="text-align: left; margin-left: 10px;" id="vcode">
		                	<img src="<c:url value="/open/getGifCode.shtml" />" />
		                </div>
                    </div>
                    <div class="form-group">
					</div>
                        <div class="col-lg-9 col-lg-offset-2">
							<button type="button" id="register" class="btn btn-primary login-button">注册</button>
							<button type="button" id="login" class="btn btn-danger login-button">登录</button>
						</div>
                    <br />
                    <div class="error"><span></span></div>
                  </form>
				  
				</div>
                </div>
              
                <div class="widget-foot">为保证后台使用体验流畅，推荐在以下浏览器上运行：IE9、IE10、Firefox、chrome，其他浏览器不推荐使用。
                </div>
            </div>  
      </div>
    </div>
  </div> 
</div>
</div>
<div class="login-footer">
绿地集团© 版权所有
</div>
<!-- JS -->
<script src="<c:url value="/js/jquery.js" />"></script>
<script src="<c:url value="/js/bootstrap.js" />"></script>
<script src="<c:url value="/js/common/layer/layer.js" />"></script>

<script >
	jQuery(document).ready(function() {
		//验证码
		$("#vcode").on("click",'img',function(){
			/**动态验证码，改变地址，多次在火狐浏览器下，不会变化的BUG，故这样解决*/
			var i = new Image();
			i.src = "<c:url value='/open/getGifCode.shtml?'/>"  + Math.random();
			$(i).replaceAll(this);
			//$(this).clone(true).attr("src",'${basePath}/open/getGifCode.shtml?'  + Math.random()).replaceAll(this);
		});
	    $('#register').click(function(){
	    	var form = $('#_form');
	    	var error= form.find(".error");
	    	var tops = ['27px','96px','165px','235px','304px','372px'];
	    	var inputs = $("form :text,form :password");
	    	for(var i=0;i<inputs.length;i++){
	    		var self = $(inputs[i]);
	    		if(self.val() == ''){
	    			 error.fadeOut('fast', function(){
	               		 $(this).css('top', tops[i]);
		            });
		            error.fadeIn('fast', function(){
		               self.focus();
		            });
		            return !1;
	    		}
	    	}
	    	var re_password = $("#re_password").val();
	    	var password = $("#password").val();
	    	if(password != re_password){
	    		return layer.msg('2次密码输出不一样！',function(){}),!1;
	    	}
	    	
	    	if($('[name=vcode]').val().length !=4){
	    		return layer.msg('验证码的长度为4位！',function(){}),!1;
	    	}
	    	var load = layer.load();
	    	$.post("subRegister.shtml",$("#_form").serialize() ,function(result){
	    		layer.close(load);
	    		if(result && result.status!= 200){
	    			return layer.msg(result.message,function(){}),!1;
	    		}else{
	    			layer.msg('注册成功！' );
	    			window.location.href= result.back_url || "<c:url value='/'/>";
	    		}
	    	},"json");
	        
	    });
	    $("form :text,form :password").keyup(function(){
	        $(this).parent().find('.error').fadeOut('fast');
	    });
	    //跳转
	    $("#login").click(function(){
	    	window.location.href="login.shtml";
	    });
	    
	});
	
</script>
</body>
</html>