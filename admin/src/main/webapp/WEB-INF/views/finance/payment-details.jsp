<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="hxy.inspec.admin.services.InspectorService"%>
<%@page import="hxy.inspec.admin.po.Inspector"%>
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

<html class="no-js" lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>充值详情</title>
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
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
<style>
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
}

.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 1001;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 80);
}

.white_content {
	display: none;
	position: absolute;
	top: 10%;
	left: 10%;
	width: 80%;
	height: 80%;
	border: 16px solid lightblue;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}

.white_content_small {
	display: none;
	position: absolute;
	top: 20%;
	left: 30%;
	width: 40%;
	height: 50%;
	border: 16px solid lightblue;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
</style>
<script type="text/javascript">
	//弹出隐藏层
	function ShowDiv(show_div, bg_div) {
		document.getElementById(show_div).style.display = 'block';
		document.getElementById(bg_div).style.display = 'block';
		var bgdiv = document.getElementById(bg_div);
		bgdiv.style.width = document.body.scrollWidth; // bgdiv.style.height = $(document).height();

		$("#" + bg_div).height($(document).height());
	};
	//关闭弹出层
	function CloseDiv(show_div, bg_div) {
		document.getElementById(show_div).style.display = 'none';
		document.getElementById(bg_div).style.display = 'none';
	};
	function selectInspector(e, tel) {

		var ordersId = $
		{
			ordersId
		}
		;
		console.log(tel + "\t" + ordersId);
		$.ajax({
			//几个参数需要注意一下
			url : "${pageContext.request.contextPath}/assign",//url
			type : "POST",//方法类型
			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

			dataType : "json",//预期服务器返回的数据类型
			cache : false,
			data : {
				"tel" : tel,
				"id" : ordersId
			},//这个是发送给服务器的数据

			success : function(result) {
				console.log(result);//打印服务端返回的数据(调试用)
				if (result.resultCode == 200) {
					CloseDiv('MyDiv', 'fade');
					//跳转到首页		
					$('.hxy-alert').removeClass('hxy-alert-warning')
					$('.hxy-alert').html('分配成功').addClass('hxy-alert-success')
							.show().delay(2000).fadeOut();
				} else if (result.resultCode == 601) {
					//	$(this).remove();
					$('.alert').removeClass('alert-success')
					$('.alert').html('密码错误').addClass('alert-warning').show()
							.delay(2000).fadeOut();

					document.getElementById("passwd").value = ''

				} else if (result.resultCode == 404) {
					//	$(this).remove();
					$('.alert').removeClass('alert-success')
					$('.alert').html('手机号未注册').addClass('alert-warning').show()
							.delay(2000).fadeOut();
				};
			},
			error : function() {
				//console.log(data);
				$('.alert').removeClass('alert-success')
				$('.alert').html('检查网络是否连接').addClass('alert-warning').show()
						.delay(2000).fadeOut();

			}
		});
	}
	
	
	  function verifyReport2(e,id,flag) {
		  document.getElementById("btn").setAttribute("disabled", true);
		  document.getElementById("btn1").setAttribute("disabled", true);
    		$.ajax({
    			//几个参数需要注意一下
    			url : "${pageContext.request.contextPath}/account-verify",//url
    			type : "POST",//方法类型
    			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

    			dataType : "json",//预期服务器返回的数据类型
    			cache : false,
    			data : {
    				"id" : id,
    				"flag":flag
    			},//这个是发送给服务器的数据

    			success : function(result) {
    				console.log(result);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					//跳转到首页		$('.alert').removeClass('alert-success')
    					$('.alert').html('报告审核通过').addClass('alert-success').show().delay(2000).fadeOut();
        				
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
    }
	
	
	
</script>

</head>
<body>
	<div class="hxy-alert"></div>
	<div class="content" style="background: #f1f2f7; height: 100%">
		<div class="animated fadeIn">
			<div class="row">
				<div class="col-md-5">
					<div class="row">
						<div class="col-lg-6 col-xl-12">
							<div class="card br-0">
								<div class="card">
									<div class="card-header">
										<i class="fa fa-user"></i><strong class="card-title pl-2">凭证</strong>
									</div>
									<div class="card-body">
										<div class="mx-auto d-block">
											<img class="rounded-circle mx-auto d-block" style=""
												src="${photo}" alt="Card image cap">

										</div>

									</div>
								</div>
							</div>
							<!-- /.card -->
						</div>

					</div>
				</div>
				<!-- /.col-md-4 -->
				<div class="col-md-5">
					<div class="card">
						<div class="card-header">
							<h4>详情</h4>
						</div>
						<div class="card-body">
							<div class="card border"
								style="background-color: #e2e3e5; border-color: #d6d8db; color: #383d41">
								<div class="card-body">
									<p style="color: #383d41"">
									<h4>详细信息</h4>
									<!--
									<small>订单可以在验货日期的24小时前取消。24小时内取消会扣分。 </small><code>重要</code>
									-->
									</p>
									<form action="#" method="post" class="form-horizontal">
										<div class="row form-group">
											<div class="col col-md-12">
												<p>
													流水号：<span id='ordersId' value='${ordersId}'>${ordersId}</span>
												</p>
											</div>
											<div class="col col-md-12">
												<p>
													类型：<span>${status}</span>
												</p>
											</div>
											<div class="col col-md-12">
												<p>
													金额：<span>${value}</span>
												</p>
											</div>
											<div class="col col-md-12">
												<p>
													申请时间：<span>${date}</span>
												</p>
											</div>
										</div>
										<hr />
										<div class="row form-group">
											<div class="col col-md-12">
												<button type="button" id="btn"
													onclick="verifyReport2(this,${ordersId},'conform')"
													class="btn btn-success btn-lg">通过</button>
												<button type="button" id="btn1"
													onclick="verifyReport2(this,${ordersId},'cancel')"
													class="btn btn-danger btn-lg">拒绝</button>
											</div>

										</div>

									</form>
								</div>
							</div>
							<!-- /# card -->
						</div>
					</div>
					<!-- /.card -->
				</div>
				<!-- /.col-lg-8 -->


			</div>
			<!-- .row -->
		</div>
		<!-- .animated -->
	</div>
	<!-- .content -->


	<!-- 下面的内容是那个质检员选择的界面 -->
	<%
		InspectorService inspectorService = new InspectorService();
		List<Inspector> ls = inspectorService.selectAll();
	%>
	<!--弹出层时背景层DIV-->
	<div id="fade" class="black_overlay"></div>
	<div id="MyDiv" class="white_content">

		<div style="text-align: right; cursor: default; height: 40px;">
			<span style="font-size: 16px;" onclick="CloseDiv('MyDiv','fade')">关闭</span>
		</div>
		<div class="content" style="background: #f1f2f7; height: 100%">
			<div class="animated fadeIn">
				<div class="row">

					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<strong class="card-title"> 验货员 </strong>
							</div>
							<div class="card-body">
								<table id="bootstrap-data-table"
									class="table table-striped table-bordered">
									<thead>
										<tr>
											<th>#</th>
											<th>姓名</th>
											<th>电话</th>
											<th>城市</th>
											<th>历史订单数</th>
											<th>积分</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>


										<%
											if (ls.size() != 0) {
												for (int i = 0; i < ls.size(); i++) {
													Inspector in = ls.get(i);
													if (in != null) {
										%>

										<tr>
											<td><%=i + 1%></td>
											<td><%=in.getUserName()%></td>
											<td><%=in.getUserTel()%></td>
											<td><%=in.getCity()%></td>
											<td><%=in.getOrders()%></td>
											<td><%=in.getIntegral()%></td>
											<td><%=in.getStatus()%></td>
											<td>

												<button type="button"
													onclick="selectInspector(this,'<%=in.getUserTel()%>')"
													class="btn btn-outline-success btn-sm">
													<i class="fa fa-magic"></i>&nbsp; 选择
												</button>

											</td>
										</tr>
										<%
											}
												}
											}
										%>
										<tr>
											<td>12</td>
											<td>xiaoxiao</td>
											<td>1234</td>
											<td>shanghai</td>
											<td>0</td>
											<td>0</td>
											<td>正常</td>
											<td><a href='' style="color: blue">选择</a></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- .animated -->
		</div>
		<!-- .content -->
	</div>
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
