<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/commons.jsp"/>
<%@page import="java.util.List"%>
<%@page import="hxy.inspec.admin.po.AdminUser"%>
<%
	AdminUser user = (AdminUser) request.getSession().getAttribute("user");
	if (user == null) {
		//request.getRequestDispatcher("/lose").forward(request, response);
		%>
		<script type="text/javascript">
		window.top.location.href = 'login';
		</script>
	<% 
	} else {
	
	}
%>
<!doctype html>
<html class="no-js" lang="">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>订单详情</title>
<meta name="description" content="Ela Admin - HTML5 Admin Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="assets/css/normalize.css">
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/themify-icons.css">
<link rel="stylesheet" href="assets/css/pe-icon-7-filled.css">
<link rel="stylesheet" href="assets/css/flag-icon.min.css">
<link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
<link rel="stylesheet"
	href="assets/css/lib/datatable/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800'
	rel='stylesheet' type='text/css'>

<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
<style>
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
}
</style>

  <script src="js/jquery.min.js"></script>
  <!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->
  <link rel="stylesheet" href="hxy/css/hxy-alert.css">
  <script src="hxy/js/hxy-alert.js"></script>
  
  <script type="text/javascript">
    $(document).ready(function () {
      $("#btn1").click(function () {
    	var inpectTel = $("#inpectTel").val();
		var fee = $("#fee").val();
		var id = $("#ordersId").val();
	//	var file = $("#file").val();
    	  console.log(fee+"\t"+inpectTel)
    	  
    	  if(inpectTel==""){
    		  
    			$('.alert').removeClass('alert-success')
				$('.alert').html('请选择验货员').addClass('alert-warning').show().delay(2000).fadeOut();
    		  return false;
    	  }
    	  if(fee==""){
  			$('.alert').removeClass('alert-success')
				$('.alert').html('请填写费用').addClass('alert-warning').show().delay(2000).fadeOut();
				
  		  return false;
  	  }
    	  
    		$.ajax({
    			//几个参数需要注意一下
    			url : "${pageContext.request.contextPath}/allotOrder",//url
    			type : "POST",//方法类型
    			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。
    			dataType : "json",//预期服务器返回的数据类型
    			cache : false,
    			data : {
    				"inpectTel" : inpectTel,
    				"fee":fee,
    				"id":id
    			},//这个是发送给服务器的数据

    			success : function(result) {
    				console.log(result);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					//跳转到首页	$('.alert').removeClass('alert-success')
    					$('.alert').html('提交成功').addClass('alert-success').show().delay(2000).fadeOut();
    				} else if (result.resultCode == 601) {
    					//	$(this).remove();
    					$('.alert').removeClass('alert-success')
    					$('.alert').html('密码错误').addClass('alert-warning').show().delay(2000).fadeOut();
    					document.getElementById("passwd").value=''
    				}else if (result.resultCode == 404) {
    					//	$(this).remove();
    					$('.alert').removeClass('alert-success')
    					$('.alert').html('手机号未注册').addClass('alert-warning').show().delay(2000).fadeOut();
    				}else if (result.resultCode == 604) {
    					//跳转到首页
    					window.location.href = 'login';
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
<body>
<div class="alert"></div>
	<div class="content" style="background: #f1f2f7; height: 100%">
		<div class="animated fadeIn">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-header">
							<strong>订单详情</strong><small>本页面提供详细订单信息</small>
						</div>
						<div class="card-body card-block">


							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">状态</label> <input
									disabled="" type="text" id="status" placeholder="${status}"
									class="form-control">
							</div>

							<div class="form-group col-lg-6" style="float: left">
								<label for="company" class=" form-control-label">订单号</label><input
									disabled="" type="text" id="ordersId" placeholder="${ordersId}"
									class="form-control" value=${ordersId}>
							</div>

							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">产品名称</label><input
									disabled="" type="text" id="goods" placeholder="${goods}"
									class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="street" class=" form-control-label">用户电话</label><input
									disabled="" type="text" id="street" placeholder="${custel}"
									class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">质检员</label><input
									type="text" id="inpectTel" placeholder="${inspect}"
									class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="street" class=" form-control-label">验货日期</label><input
									disabled="" type="text" id="exceData" placeholder="${exceData}"
									class="form-control">
							</div>

							<!-- 
							<div class="row form-group col-lg-6" style="float:left">
								<div class="col-8">
									<div class="form-group">
										<label for="city" class=" form-control-label">质检员</label><input
											type="text" id="city" placeholder="Enter your city"
											class="form-control">
									</div>
								</div>
								<div class="col-8">
									<div class="form-group">
										<label for="postal-code" class=" form-control-label">验货日期</label><input
											type="text" id="postal-code" placeholder="Postal Code"
											class="form-control">
									</div>
								</div>
							</div>
							
							
							-->
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">验货工厂</label><input
									disabled="" type="text" id="country"
									placeholder="${factoyName}" class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">工厂地址</label><input
									disabled="" type="text" id="country"
									placeholder="${facAddress}" class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">工厂联系人</label><input
									disabled="" type="text" id="country" placeholder="${facMan}"
									class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">工厂电话</label><input
									disabled="" type="text" id="country" placeholder="${facTel} "
									class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">验货要求</label><input
									disabled="" type="text" id="country" placeholder="Country name"
									class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">验货附件</label><a
									href="#" type="text" id="country" placeholder="关于质检的要求"
									class="form-control">关于质检的要求</a>
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">报告文件</label><input
									disabled="" type="text" id="country" placeholder="Country name"
									class="form-control">
							</div>
							<div class="form-group col-lg-6" style="float: left">
								<label for="country" class=" form-control-label">费用</label><input
									type="number" id="fee" placeholder="请填写费用"
									class="form-control">
							</div>

							<div>
								<button type="submit" id="btn1" class="btn btn-success btn-sm">
									<i class="fa fa-dot-circle-o"></i> 提交
								</button>
								<button type="reset" id="btn2" class="btn btn-danger btn-sm">
									<i class="fa fa-ban"></i> 重置
								</button>
							</div>

						</div>
					</div>
				</div>


			</div>
		</div>
		<!-- .animated -->
	</div>
	<!-- .content -->
	<div class="clearfix"></div>
	<!-- Right Panel -->
	<!-- Scripts -->
	<script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/lib/data-table/datatables.min.js"></script>
	<script src="assets/js/lib/data-table/dataTables.bootstrap.min.js"></script>
	<script src="assets/js/lib/data-table/dataTables.buttons.min.js"></script>
	<script src="assets/js/lib/data-table/buttons.bootstrap.min.js"></script>
	<script src="assets/js/lib/data-table/jszip.min.js"></script>
	<script src="assets/js/lib/data-table/vfs_fonts.js"></script>
	<script src="assets/js/lib/data-table/buttons.html5.min.js"></script>
	<script src="assets/js/lib/data-table/buttons.print.min.js"></script>
	<script src="assets/js/lib/data-table/buttons.colVis.min.js"></script>
	<script src="assets/js/init/datatables-init.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#bootstrap-data-table-export').DataTable();
		});
	</script>


</body>
</html>
