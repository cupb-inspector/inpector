<%@page import="cn.hxy.inspect.entity.Orders"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="cn.hxy.inspect.customer.service.OrderService"%>
	<%@page import="cn.hxy.inspect.entity.customer.User"%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>全部订单</title>
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


<%

request.setCharacterEncoding("utf-8");
User user = (User) request.getSession().getAttribute("user");
List<Orders> ls=null;
if (user == null) {
	//登录过期！直接跳转到登录页
	%>
	<script type="text/javascript">
		console.log('跳转');
		window.top.location.href= 'login'
	</script>
	<% 
} else {
	OrderService o = new OrderService();
	System.out.println("查看当前用户"+user.toString());
	 ls=o.selectAllByCusId(user.getCusid());
}
%>
<style>
        html,
        body {
            margin: 0px;
            width: 100%;
            height: 100%;
        }
</style>

</head>
<body>
	<!-- Right Panel -->

	<div class="content" style="background: #f1f2f7;height:100%;width:100%">
			<div class="animated fadeIn">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<strong class="card-title">全部订单</strong>
							</div>
							<div class="card-body">
								<table id="bootstrap-data-table"
									class="table table-striped table-bordered">
									<thead>
										<tr>
											<th>订单号</th>
											<th>验货日期</th>
											<th>工厂名称</th>
											<th>产品名称</th>
											<th>状态</th>
											<th>下单日期</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									<%
									if(ls!=null&&ls.size()!=0){
										for(int i=0;i<ls.size();i++){
										Orders orders = ls.get(i);
										%>
									<tr>
										<td><%=orders.getOrderid() %></td>
										<td><%=orders.getExcedate() %></td>
										<td><%=orders.getFactoryname() %></td>
										<td><%=orders.getGoods() %></td>
										<td><%=orders.getStatusString() %></td>
										<td><%=orders.getDate()%></td>
											<td><a href="details2?id=<%=orders.getOrderid() %>" target="_blank">详情</a></td>
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
