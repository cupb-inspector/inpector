<!doctype html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>验货员登录</title>
<meta name="description" content="Ela Admin - HTML5 Admin Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="assets/css/normalize.css">
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/themify-icons.css">
<link rel="stylesheet" href="assets/css/pe-icon-7-filled.css">
<link rel="stylesheet" href="assets/css/flag-icon.min.css">
<link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
<link rel="stylesheet" href="assets/css/style.css">
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800'
	rel='stylesheet' type='text/css'>
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
  
  <script src="js/jquery.min.js"></script>
  <!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->
  <link rel="stylesheet" href="hxy/css/hxy-alert.css">
  <script src="hxy/js/hxy-alert.js"></script>
  
  <script type="text/javascript">
    $(document).ready(function () {
      $("#btn1").click(function () {
    	  var username =$("#tel").val()
    	  var passwd=$("#passwd").val()
    	  
    	  console.log(username+"\t"+passwd)
    	  
    	  if(username==""){
    		  
    			$('.alert').removeClass('alert-success')
				$('.alert').html('请输入手机号码').addClass('alert-warning').show().delay(2000).fadeOut();
    		  return false;
    	  }
    	  if(passwd==""){
  			$('.alert').removeClass('alert-success')
				$('.alert').html('请输入密码').addClass('alert-warning').show().delay(2000).fadeOut();
				
  		  return false;
  	  }
    	  
    		$.ajax({
    			//几个参数需要注意一下
    			url : "${pageContext.request.contextPath}/loginVerify",//url
    			type : "POST",//方法类型
    			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

    			dataType : "json",//预期服务器返回的数据类型
    			cache : false,
    			data : {
    				"tel" : username,
    				"passwd":passwd,
    			},//这个是发送给服务器的数据

    			success : function(result) {
    				console.log(result);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					//跳转到首页
    					window.location.href = 'index';
    				} else if (result.resultCode == 601) {
    					//	$(this).remove();
    					$('.alert').removeClass('alert-success')
    					$('.alert').html('密码错误').addClass('alert-warning').show().delay(2000).fadeOut();
        				
    					document.getElementById("passwd").value=''
    					
    				}else if (result.resultCode == 404) {
    					//	$(this).remove();
    					$('.alert').removeClass('alert-success')
    					$('.alert').html('手机号未注册').addClass('alert-warning').show().delay(2000).fadeOut();
        				
    					
    				};
    			},
    			error : function() {
    				//console.log(data);
    				$('.alert').removeClass('alert-success')
					$('.alert').html('检查网络是否连接').addClass('alert-warning').show().delay(2000).fadeOut();
    				
    			}
    		});
        });
      
    });
    </script>

</head>
<body class="bg-dark">
<div class="alert"></div>
	<div class="sufee-login d-flex align-content-center flex-wrap">
		<div class="container">
			<div class="login-content">
				<div class="login-logo">
					<a href="index.html"> <img class="align-content"
						src="images/logo2.png" alt="">
					</a>
				</div>
				<div class="login-form">
					<div>
						<div class="form-group">
							<label>手机号码</label> <input type="phone" id="tel"
								class="form-control" placeholder="手机号码">
						</div>
						<div class="form-group">
							<label>密码</label> <input type="password" id="passwd"
								class="form-control" placeholder="密码">
						</div>
						<div class="checkbox">
							<label> <input type="checkbox"> 记住密码
							</label> <label class="pull-right"> <a href="#">忘记密码?</a>
							</label>

						</div>
						<button type="submit" id="btn1"
							class="btn btn-success btn-flat m-b-30 m-t-30">登录/Sign in</button>
						<!--  
                        <div class="social-login-content">
                            <div class="social-button">
                                <button type="button" class="btn social facebook btn-flat btn-addon mb-3"><i class="ti-facebook"></i>Sign in with facebook</button>
                                <button type="button" class="btn social twitter btn-flat btn-addon mt-2"><i class="ti-twitter"></i>Sign in with twitter</button>
                            </div>
                        </div>
                       -->
						<div class="register-link m-t-15 text-center">
							<p>
								还没有账号? <a href="register">这里注册</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>
