<%@page import="hxy.inspec.admin.services.InspectorService"%>
<%@page import="hxy.inspec.admin.po.Inspector"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="hxy.inspec.admin.po.AdminUser"%>
<%@page import="hxy.inspec.admin.po.Inspector"%>
<%@page import="hxy.inspec.admin.po.CusUser"%>
<%@page import="hxy.inspec.admin.po.Orders"%>
<%@page import="hxy.inspec.admin.services.CusUserService"%>
<%@page import="hxy.inspec.admin.services.InspectorService"%>
<%@page import="hxy.inspec.admin.services.OrderService"%>

<%@page import="java.io.IOException"%>

<%
	AdminUser user = (AdminUser) request.getSession().getAttribute("user");
	Orders orders = null;
	String ordersId=null;
	Inspector inspector =null;
	CusUser cusUser = null;
	if (user == null) {
		%>
<script type="text/javascript">
	window.top.location.href = 'login';
</script>
<% 
	} else {
		 ordersId=request.getParameter("id");  
		// 依据id查询数据库得知数据库的订单详细信息
		OrderService orderService = new OrderService();
		try {
			orders = orderService.selectOrderById(ordersId);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (orders != null) {
			//依据订单查找质检员和用户的信息
			String inspectTel = orders.getQualId();
			// 通过订单的验货员信息与用户信息找到两个人资料
			CusUserService cusUserService = new CusUserService();
			 cusUser = cusUserService.selectUserById(orders.getCusId());
			InspectorService inspectorService = new InspectorService();
			 inspector = inspectorService.findInspectorById(orders.getQualId());
		}else{
			//订单异常
		}
	}
%>
<!doctype html>
<html class="no-js" lang="">

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
	<link rel="stylesheet" href="assets/css/lib/datatable/dataTables.bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/style.css">
	<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
	<style>
		html,
		body {
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
			filter: alpha(opacity=80);
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
				url: "${pageContext.request.contextPath}/assign",//url
				type: "POST",//方法类型
				async: false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

				dataType: "json",//预期服务器返回的数据类型
				cache: false,
				data: {
					"tel": tel,
					"id": ordersId
				},//这个是发送给服务器的数据

				success: function (result) {
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
				error: function () {
					//console.log(data);
					$('.alert').removeClass('alert-success')
					$('.alert').html('检查网络是否连接').addClass('alert-warning').show()
						.delay(2000).fadeOut();

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
				<div class="col-xl-4">
					<div class="row">
						<!-- 客户资料显示 start -->

						<div class="col-lg-6 col-xl-12">
							<div class="card br-0">
								<div class="card">
									<div class="card-header">
										<i class="fa fa-user"></i><strong class="card-title pl-2">客户资料</strong>
									</div>
									<div class="card-body">
										<div class="mx-auto d-block">
											<img class="rounded-circle mx-auto d-block" src="images/admin.jpg"
												alt="Card image cap">
											<h5 class="text-sm-center mt-2 mb-1"><%=cusUser.getCusname() %></h5>
											<div class="location text-sm-center">
												<i class="fa fa-map-marker"></i> <%=cusUser.getCusaddress() %>
											</div>
										</div>
										<br />
										<ul class="list-group list-group-flush">
											<li class="list-group-item"><a href="#"> <i class="fa fa-envelope-o"></i> 邮箱
													<span class="pull-right"><%=cusUser.getEmail() %></span></a>
											</li>
											<li class="list-group-item"><a href="#"> <i class="fa fa-tasks"></i> 总订单数
													<span class="pull-right"><%=cusUser.getCusOrders() %></span></a>
											</li>
											<li class="list-group-item"><a href="#"> <i class="fa fa-money"></i> 钱包
													<span class="pull-right"><%=cusUser.getCusMoney() %></span></a>
											</li>
											<li class="list-group-item"><a href="#"> <i class="fa fa-star-o"></i>
													积分<span
														class="pull-right r-activity"><%=cusUser.getCustrade() %></span></a>
											</li>
										</ul>

									</div>
								</div>
							</div>
							<!-- /.card -->
						</div>
						<!-- 客户资料显示  end-->

						<!-- 验货员资料显示，一需要判断验货员是否存在，不存在就不显示了 -->
						<% if(inspector!=null){
	%>

						<div class="col-lg-6 col-xl-12">
							<div class="card br-0  ">
								<div class="card">
									<div class="card-header">
										<i class="fa fa-user"></i><strong class="card-title pl-2">验货员资料</strong>
									</div>
									<div class="card-body">
										<div class="mx-auto d-block">
											<img class="rounded-circle mx-auto d-block" src="images/admin.jpg"
												alt="Card image cap">
											<h5 class="text-sm-center mt-2 mb-1"><%=inspector.getUserName() %></h5>
											<div class="location text-sm-center">
												<i class="fa fa-map-marker"></i> <%=inspector.getAddress() %>
											</div>
										</div>
										<br />
										<ul class="list-group list-group-flush">
											<li class="list-group-item"><a href="#"> <i class="fa fa-phone"></i> 电话
													<span class="pull-right"><%=inspector.getUserTel() %></span></a>
											</li>
											<li class="list-group-item"><a href="#"> <i class="fa fa-tasks"></i> 总接单数
													<span class="pull-right"><%=inspector.getOrders() %></span></a>
											</li>
											<li class="list-group-item"><a href="#"> <i class="fa fa-money"></i> 钱包
													<span class="pull-right"><%=inspector.getMoney() %></span></a>
											</li>
											<li class="list-group-item"><a href="#"> <i class="fa fa-star-o"></i>
													积分<span
														class="pull-right r-activity"><%=inspector.getIntegral() %></span></a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>


						<%
				}
				%>
					</div>
				</div>
				<!-- /.col-md-4 -->


				<!-- 质检员显示 end -->
				<div class="col-xl-8">
					<div class="card">
						<div class="card-header">
							<h4>详情</h4>
						</div>
						<div class="card-body">
							<div class="card border"
								style="background-color: #e2e3e5; border-color: #d6d8db; color: #383d41">
								<div class="card-body">
									<p style="color: #383d41"">
									<h4>订单信息</h4>
									<!--
									<small>订单可以在验货日期的24小时前取消。24小时内取消会扣分。 </small><code>重要</code>
									-->
									</p>
									<form action=" #" method="post" class="form-horizontal">
										<div class="row form-group">
											<div class="col col-md-6">
												<p>
													订单号：<span id='ordersId' value='<%=ordersId%>'><%=ordersId %></span>
												</p>
											</div>
											<div class="col col-md-6">
												<p>
													订单状态：<span><%=orders.getStatusString() %></span>
												</p>
											</div>
										</div>
										<div class="row form-group">
											<div class="col col-md-4">
												<p>
													验货时间：<span><%=orders.getExcedate() %></span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													报告语言：<span>中文</span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													检验类型：<span>初次检验</span>
												</p>
											</div>
										</div>
										<div class="row form-group">
											<div class="col col-md-4">
												<p>
													服务类型：<span>初期验货</span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													产品信息：<span><%=orders.getGoods() %></span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													工厂名称：<span><%=orders.getFactoryname() %></span>
												</p>
											</div>
										</div>
										<div class="row form-group">
											<div class="col col-md-4">
												<p>
													工厂地址：<span><%=orders.getFactoryaddress() %></span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													联系人姓名：<span><%=orders.getFactoryman() %></span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													手机号：<span><%=orders.getFactorytel() %></span>
												</p>
											</div>
										</div>
										<hr />
										<div class="row form-group">
											<div class="col col-md-4">
												<p>
													下单日期：<span><%=orders.getDate() %></span>
												</p>
											</div>

										</div>

										</form>
								</div>
							</div>
							<!-- /# card -->

							<div class="card border"
								style="background-color: #d1ecf1; border-color: #bee5eb; color: #0c5460">
								<div class="card-body">
									<p style="color: #0c5460"">
									<h4>报告</h4>
									<!-- 
									<small>订单可以在验货日期的24小时前取消。24小时内取消会扣分。</small>
									<code>重要</code>
									 -->
									</p>
									<p>
										<i class=" fa fa-envelope-o"></i> 报告 <a href=""> <span class="pull-right">下载</span></a>
										<p>
								</div>
							</div>

						</div>
					</div>
					<!-- /.card -->
				</div>
				<!-- /.col-lg-8 -->

			</div>
			<!-- .row -->


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
									<table id="bootstrap-data-table" class="table table-striped table-bordered">
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
			$(document).ready(function () {
				$('#bootstrap-data-table-export').DataTable();
			});
		</script>


</body>

</html>