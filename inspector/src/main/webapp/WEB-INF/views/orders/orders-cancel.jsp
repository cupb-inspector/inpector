<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="hxy.inspec.inspector.po.Orders"%>
<%@page import="hxy.inspec.inspector.po.User"%>
<%@page import="hxy.inspec.inspector.services.OrderService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%
	//这里面应该是个人所有的取消的订单 需要检查员ID 以及 未完成状态字集合、枚举
	User user = (User) request.getSession().getAttribute("user");
	List<Orders> ls = null;
	if (user != null) {
		//枚举模板，只要是迭代类型变量都可以
		List<Integer> odUD=new Vector<Integer>();int[]temp = new int[]{1,2,3,4,5};for(int i:temp)odUD.add(i);
		OrderService orderService = new OrderService();
		ls = orderService.findOrdersByStatusAndInspector(odUD,user.getUserId());
	} else {
		request.getRequestDispatcher("/lose").forward(request, response);
	}
%>
<html class="no-js" lang="">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>已取消订单 </title>
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

</head>
<body>
<div class="alert"></div>
	<div class="content" style="background: #f1f2f7; height: 100%;">
		<div class="animated fadeIn">
			<div class="row">

				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">已取消订单</strong>
						</div>
						<div class="card-body">
							<table id="bootstrap-data-table"
								class="table table-striped table-bordered">
								<thead>
									<tr>
										<th>#</th>
										<th>验货日期</th>
										<th>验货地址</th>
										<th>产品名称</th>
										<th>工厂名称</th>
										<th>操作</th>

									</tr>
								</thead>
								<tbody>

									<%
										if (ls != null && ls.size() != 0) {
											for (int i = 0; i < ls.size(); i++) {
												Orders o = ls.get(i);
									%>
									<tr>
										<td><%=i + 1%></td>
										<td><%=o.getExcedate()%></td>
										<td><%=o.getFactoryaddress()%></td>

										<td><%=o.getGoods()%></td>
										<td><%=o.getFactoryname()%></td>

										<td> <button onclick="rob(this,'<%=o.getOrderid()%>')" type="button" class="btn btn-success btn-sm" value="<%=o.getOrderid()%>"><i class="fa fa-magic"></i>&nbsp; 抢单</button></td>
									</tr>
									<%
										}

										}
									%>
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
