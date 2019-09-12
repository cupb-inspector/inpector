<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>我的报告</title>
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
</head>
<style>
        html,
        body {
            margin: 0px;
            width: 100%;
            height: 100%;
        }
</style>

<body>
	<div class="content" style="background: #f1f2f7;height:100%">
		<div class="animated fadeIn">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">全部订单</strong>
						</div>
						<div class="card-body"  id="div-table-container">
							<table id="table-cusUser" class="table table-striped table-bordered table-hover table-condensed">
								<thead>
									<tr>
									<th>订单号</th>
									<th>产品</th>
									<th>工厂名称</th>
									<th>下单时间</th>
									<th>报告</th>
									<th>执行日期</th>
									</tr>
								</thead>
								<tbody>
								<!--  
									<tr>
										<td>123</td>
										<td>2018/12/09</td>
										<td>一</td>
										<td>1</td>
										<td>12</td>
										<td>罐头</td>
										<td>已完成</td>
										<td>1</td>
									</tr>
									-->
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
	<!-- Scripts -->
	<script src="report/js/json2.js"></script>
	<script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>
	<script src="report/js/jquery.dataTables.js"></script>
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
	<!-- SpinJS 遮罩层-->
	<script src="js/jquery.spin.merge.js"></script>
	<!-- DataTables JS end-->

<!--  
	<script src="report/js/constant.js"></script>
	<script src="report/js/cusUser-manage.js"></script>
-->

	<!-- 数据加载 -->
	<script src="report/js/constant.js"></script>
	<script src="report/js/cusUser-manage2.js"></script>
<!-- 
	<script type="text/javascript">
		$(document).ready(function() {
			var data = [
			    [
			        "Tiger Nixon",
			        "System Architect",
			        "Edinburgh",
			        "5421",
			        "2011/04/25",
			        "$3,120",
			        "1",
			        "好的",
			        "编辑"
			    ],
			    [
			        "Garrett Winters",
			        "Director",
			        "Edinburgh",
			        "8422",
			        "2011/07/25",
			        "$5,300",
			        "2",
			        "好的",
			        "编辑"
			    ]
			]
			for(var i=0;i<50;i++){
				//push添加元素到数组
				data.push(
						 [
						        "Garrett Winters",
						        "Director",
						        "Edinburgh",
						        "8422",
						        "2011/07/25",
						        "$5,300",
						        "9",
						        "好的",
						        "编辑"
						    ]
				);
			}
			//添加数据到表格
			$('#table-cusUser').DataTable(
					 {
						 destroy:true,//防止多次初始化
						 data: data
						});
		});
		
	</script>
 -->

</body>
</html>