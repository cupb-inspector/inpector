<%@page import="java.util.HashMap"%>
<%@page import="cn.hxy.inspect.admin.service.DataStatisticService"%>
<%@page import="cn.hxy.inspect.admin.service.OrderService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons.jsp" />
<%@page import="cn.hxy.inspect.entity.admin.AdminUser"%>
<%@page import="cn.hxy.inspect.entity.Orders"%>
<%@page import="cn.hxy.inspect.entity.admin.DataStatistic"%>
<%@page import="java.util.List"%>

<%
	AdminUser user = (AdminUser) request.getSession().getAttribute("user");
	int today = 0;//今天订单
	int total = 0;
	int unfinishedBill = 0;
	int unfinishedReport = 0;
	List<Orders> ls1=null;
	OrderService orderService = new OrderService();

	if (user == null) {
		//request.getRequestDispatcher("/lose").forward(request, response);
%>
<script type="text/javascript">
	window.top.location.href = 'login';
</script>
<%
	} else {
		DataStatisticService dataStatisticService = new DataStatisticService();
		DataStatistic dataStatistic = dataStatisticService.select();

		if (dataStatistic != null) {
			today = dataStatistic.getToday();
			total = dataStatistic.getTotal();
			unfinishedBill = dataStatistic.getUnfinishedBill();
			unfinishedReport = dataStatistic.getUnfinishedReport();
		}
		System.out.println("查询状态为4的订单");
		
		HashMap<String,Object> hashMap =new HashMap<>();
		hashMap.put("status", 4);//4以下都是未处理订单
		hashMap.put("start", 0);
		hashMap.put("size", 5);
		ls1= orderService.selectOrdersByStatusJudge(hashMap);
	}
%>
<!doctype html>
<html class="no-js" lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>首页内容</title>
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
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
<link href="assets/weather/css/weather-icons.css" rel="stylesheet" />
<link href="assets/calendar/fullcalendar.css" rel="stylesheet" />
<link href="assets/css/charts/chartist.min.css" rel="stylesheet">
<link href="assets/css/lib/vector-map/jqvmap.min.css" rel="stylesheet">
<style>
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
}

#weatherWidget .currentDesc {
	color: #ffffff !important;
}

.traffic-chart {
	min-height: 335px;
}

#flotPie1 {
	height: 150px;
}

#flotPie1 td {
	padding: 3px;
}

#flotPie1 table {
	top: 20px !important;
	right: -10px !important;
}

.chart-container {
	display: table;
	min-width: 270px;
	text-align: left;
	padding-top: 10px;
	padding-bottom: 10px;
}

#flotLine5 {
	height: 105px;
}

#flotBarChart {
	height: 150px;
}

#cellPaiChart {
	height: 160px;
}
</style>
</head>

<body>
	<!-- Content -->
	<div class="content" style="background: #f1f2f7; height: 100%;">
		<!-- Animated -->
		<div class="animated fadeIn">
			<!-- Widgets  -->
			<div class="row">
				<div class="col-lg-3 col-md-6">
					<a href="orders-checking" target="myiframe">
						<div class="card">
							<div class="card-body">
								<div class="stat-widget-five">
									<div class="stat-icon dib flat-color-1">
										<i class="pe-7s-cart"></i>
									</div>
									<div class="stat-content">
										<div class="text-left dib">
											<div class="stat-text">
												<%=today%>
											</div>
											<div class="stat-heading">今日验货订单</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-3 col-md-6">
					<a href="orders-unfinished" target="myiframe">
						<div class="card">
							<div class="card-body">
								<div class="stat-widget-five">
									<div class="stat-icon dib flat-color-2">
										<i class="pe-7s-cart"></i>
									</div>
									<div class="stat-content">
										<div class="text-left dib">
											<div class="stat-text">
												<%=unfinishedBill%>
											</div>
											<div class="stat-heading">未处理订单</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-3 col-md-6">
					<a href="report-unprocess" target="myiframe">
						<div class="card">

							<div class="card-body">
								<div class="stat-widget-five">
									<div class="stat-icon dib flat-color-3">
										<i class="pe-7s-browser"></i>
									</div>
									<div class="stat-content">
										<div class="text-left dib">
											<div class="stat-text">
												<%=unfinishedReport%>
											</div>
											<div class="stat-heading">未处理报告</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="card">
						<a href="orders-all" target="myiframe">
							<div class="card-body">
								<div class="stat-widget-five">
									<div class="stat-icon dib flat-color-4">
										<i class="pe-7s-cash"></i>
									</div>
									<div class="stat-content">
										<div class="text-left dib">
											<div class="stat-text">
												<%=total %>
											</div>
											<div class="stat-heading">总订单数</div>
										</div>
									</div>
								</div>
							</div>
						</a>
					</div>
				</div>
			</div>
			<!-- /Widgets -->
			<!--table-->
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">最近验货订单</strong> <a
								href='orders-checking' target="myiframe"> <small><span
									class="badge badge-success float-right mt-1">查看更多 ></span></small>
							</a>
						</div>
						<div class="card-body">
							<table id="bootstrap-data-table2"
								class="table table-striped table-bordered">
								<thead>
									<tr>
										<th class="serial">#</th>
										<th>订单号</th>
										<th>委托方</th>
										<th>验货方</th>
										<th>验货日期</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 从数据库读取最近两天的5条数据 ,依据时间和状态-->
									<%
									
										List<Orders> ls = orderService.selectTodayTomorrowOrders();
										if (ls != null && ls.size() != 0) {
											for (int i = 0; i < ls.size(); i++) {
												Orders order = ls.get(i);
									%>
									<tr>
									<td><%=i + 1%></td>
									<td><%=order.getOrderid()%></td>
									<td><%=order.getCusId()%></td>
									<td><%=order.getQualId()%></td>
									<td><%=order.getExcedate()%></td>
									   <td><a href="details-orders2?id=<%=order.getOrderid() %>" target="myiframe"
                                                style="color: blue">详情</a></td>
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
			<!--/table-->
			<!--table-->
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">未处理订单</strong> <a
								href='orders-unfinished' target="myiframe"> <small><span
									class="badge badge-success float-right mt-1">查看更多 ></span></small>
							</a>
						</div>
						<div class="card-body">
							<table id="bootstrap-data-table3"
								class="table table-striped table-bordered">
								<thead>
									<tr>
										<th>客户</th>
										<th>报告语言</th>
										<th>下单日期</th>
										<th>验货日期</th>
										<th>验货地址</th>
										<th>产品种类</th>
										<th>服务类型</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
	<%
								if(ls1!=null&&ls1.size()!=0){
									for(int i =0;i<ls1.size();i++){
										Orders orders= ls1.get(i);
										%>
										<tr>
										<td><%=orders.getCusId() %></td>
										<td>中文</td>
										<td><%=orders.getDate() %></td>
										<td><%=orders.getExcedate() %></td>
										<td><%=orders.getFactoryaddress() %></td>
										<td><%=orders.getGoods() %></td>
										<td><%=orders.getType() %></td>
										<td>详情</td>
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
			<!--/table-->
			<!--table-->
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">未处理报告</strong> <a
								href='report-unprocess' target="myiframe"> <small><span
									class="badge badge-success float-right mt-1">查看更多 ></span></small>
							</a>
						</div>
						<div class="card-body">
							<table id="bootstrap-data-table4"
								class="table table-striped table-bordered">
								<thead>
									<tr>
										<th>订单号</th>
										<th>委托方</th>
										<th>验货方</th>
										<th>验货日期</th>
										<th>完成日期</th>
										<th>报告</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
			<!--/table-->
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">日财务统计</strong> <a href='finance'
								target="myiframe"> <small><span
									class="badge badge-success float-right mt-1">查看更多 ></span></small>
							</a>
						</div>
						<div class="card-body">
							<table id="bootstrap-data-table5"
								class="table table-striped table-bordered">
								<thead>
									<tr>
										<th>订单号</th>
										<th>委托方</th>
										<th>验货方</th>
										<th>城市</th>
										<th>付款</th>
										<th>差旅费</th>
										<th>收益</th>
										<th>操作</th>

									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
			<!--/table-->


			<!-- Modal - Calendar - Add New Event -->
			<div class="modal fade none-border" id="event-modal">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title">
								<strong>Add New Event</strong>
							</h4>
						</div>
						<div class="modal-body"></div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default waves-effect"
								data-dismiss="modal">Close</button>
							<button type="button"
								class="btn btn-success save-event waves-effect waves-light">Create
								event</button>
							<button type="button"
								class="btn btn-danger delete-event waves-effect waves-light"
								data-dismiss="modal">Delete</button>
						</div>
					</div>
				</div>
			</div>
			<!-- /#event-modal -->
			<!-- Modal - Calendar - Add Category -->
			<div class="modal fade none-border" id="add-category">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title">
								<strong>Add a category </strong>
							</h4>
						</div>
						<div class="modal-body">
							<form>
								<div class="row">
									<div class="col-md-6">
										<label class="control-label">Category Name</label> <input
											class="form-control form-white" placeholder="Enter name"
											type="text" name="category-name" />
									</div>
									<div class="col-md-6">
										<label class="control-label">Choose Category Color</label> <select
											class="form-control form-white"
											data-placeholder="Choose a color..." name="category-color">
											<option value="success">Success</option>
											<option value="danger">Danger</option>
											<option value="info">Info</option>
											<option value="pink">Pink</option>
											<option value="primary">Primary</option>
											<option value="warning">Warning</option>
										</select>
									</div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default waves-effect"
								data-dismiss="modal">Close</button>
							<button type="button"
								class="btn btn-danger waves-effect waves-light save-category"
								data-dismiss="modal">Save</button>
						</div>
					</div>
				</div>

			</div>
			<!-- /#add-category -->
		</div>
		<!-- .animated -->
	</div>
	<!-- /.content -->
	<div class="clearfix"></div>
	<!-- Footer -->

	<!-- /.site-footer -->

	<!-- /#right-panel -->

	<script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/plugins.js"></script>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/lib/chart-js/Chart.bundle.js"></script>

	<script src="assets/js/lib/chartist/chartist.min.js"></script>
	<script src="assets/js/lib/chartist/chartist-plugin-legend.js"></script>
	<script src="assets/js/lib/flot-chart/jquery.flot.js"></script>
	<script src="assets/js/lib/flot-chart/jquery.flot.pie.js"></script>
	<script src="assets/js/lib/flot-chart/jquery.flot.spline.js"></script>
	<script src="assets/weather/js/jquery.simpleWeather.min.js"></script>
	<script src="assets/weather/js/weather-init.js"></script>
	<script src="assets/js/lib/moment/moment.js"></script>
	<script src="assets/calendar/fullcalendar.min.js"></script>
	<script src="assets/calendar/fullcalendar-init.js"></script>
	<script src="assets/js/init/weather-init.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
	<script src="assets/js/init/fullcalendar-init.js"></script>

	<!--Local Stuff-->
	<script>
		jQuery(document)
				.ready(
						function($) {
							"use strict";

							// Pie chart flotPie1
							var piedata = [ {
								label : "Desktop visits",
								data : [ [ 1, 32 ] ],
								color : '#5c6bc0'
							}, {
								label : "Tab visits",
								data : [ [ 1, 33 ] ],
								color : '#ef5350'
							}, {
								label : "Mobile visits",
								data : [ [ 1, 35 ] ],
								color : '#66bb6a'
							} ];

							$.plot('#flotPie1', piedata, {
								series : {
									pie : {
										show : true,
										radius : 1,
										innerRadius : 0.65,
										label : {
											show : true,
											radius : 2 / 3,
											threshold : 1
										},
										stroke : {
											width : 0
										}
									}
								},
								grid : {
									hoverable : true,
									clickable : true
								}
							});
							// Pie chart flotPie1  End
							// cellPaiChart
							var cellPaiChart = [ {
								label : "Direct Sell",
								data : [ [ 1, 65 ] ],
								color : '#5b83de'
							}, {
								label : "Channel Sell",
								data : [ [ 1, 35 ] ],
								color : '#00bfa5'
							} ];
							$.plot('#cellPaiChart', cellPaiChart, {
								series : {
									pie : {
										show : true,
										stroke : {
											width : 0
										}
									}
								},
								legend : {
									show : false
								},
								grid : {
									hoverable : true,
									clickable : true
								}

							});
							// cellPaiChart End
							// Line Chart  #flotLine5
							var newCust = [ [ 0, 3 ], [ 1, 5 ], [ 2, 4 ],
									[ 3, 7 ], [ 4, 9 ], [ 5, 3 ], [ 6, 6 ],
									[ 7, 4 ], [ 8, 10 ] ];

							var plot = $.plot($('#flotLine5'), [ {
								data : newCust,
								label : 'New Data Flow',
								color : '#fff'
							} ], {
								series : {
									lines : {
										show : true,
										lineColor : '#fff',
										lineWidth : 2
									},
									points : {
										show : true,
										fill : true,
										fillColor : "#ffffff",
										symbol : "circle",
										radius : 3
									},
									shadowSize : 0
								},
								points : {
									show : true,
								},
								legend : {
									show : false
								},
								grid : {
									show : false
								}
							});
							// Line Chart  #flotLine5 End
							// Traffic Chart using chartist
							if ($('#traffic-chart').length) {
								var chart = new Chartist.Line('#traffic-chart',
										{
											labels : [ 'Jan', 'Feb', 'Mar',
													'Apr', 'May', 'Jun' ],
											series : [
													[ 0, 18000, 35000, 25000,
															22000, 0 ],
													[ 0, 33000, 15000, 20000,
															15000, 300 ],
													[ 0, 15000, 28000, 15000,
															30000, 5000 ] ]
										}, {
											low : 0,
											showArea : true,
											showLine : false,
											showPoint : false,
											fullWidth : true,
											axisX : {
												showGrid : true
											}
										});

								chart
										.on(
												'draw',
												function(data) {
													if (data.type === 'line'
															|| data.type === 'area') {
														data.element
																.animate({
																	d : {
																		begin : 2000 * data.index,
																		dur : 2000,
																		from : data.path
																				.clone()
																				.scale(
																						1,
																						0)
																				.translate(
																						0,
																						data.chartRect
																								.height())
																				.stringify(),
																		to : data.path
																				.clone()
																				.stringify(),
																		easing : Chartist.Svg.Easing.easeOutQuint
																	}
																});
													}
												});
							}
							// Traffic Chart using chartist End
							//Traffic chart chart-js
							if ($('#TrafficChart').length) {
								var ctx = document
										.getElementById("TrafficChart");
								ctx.height = 150;
								var myChart = new Chart(
										ctx,
										{
											type : 'line',
											data : {
												labels : [ "Jan", "Feb", "Mar",
														"Apr", "May", "Jun",
														"Jul" ],
												datasets : [
														{
															label : "Visit",
															borderColor : "rgba(4, 73, 203,.09)",
															borderWidth : "1",
															backgroundColor : "rgba(4, 73, 203,.5)",
															data : [ 0, 2900,
																	5000, 3300,
																	6000, 3250,
																	0 ]
														},
														{
															label : "Bounce",
															borderColor : "rgba(245, 23, 66, 0.9)",
															borderWidth : "1",
															backgroundColor : "rgba(245, 23, 66,.5)",
															pointHighlightStroke : "rgba(245, 23, 66,.5)",
															data : [ 0, 4200,
																	4500, 1600,
																	4200, 1500,
																	4000 ]
														},
														{
															label : "Targeted",
															borderColor : "rgba(40, 169, 46, 0.9)",
															borderWidth : "1",
															backgroundColor : "rgba(40, 169, 46, .5)",
															pointHighlightStroke : "rgba(40, 169, 46,.5)",
															data : [ 1000,
																	5200, 3600,
																	2600, 4200,
																	5300, 0 ]
														} ]
											},
											options : {
												responsive : true,
												tooltips : {
													mode : 'index',
													intersect : false
												},
												hover : {
													mode : 'nearest',
													intersect : true
												}

											}
										});
							}
							//Traffic chart chart-js  End
							// Bar Chart #flotBarChart
							$.plot("#flotBarChart", [ {
								data : [ [ 0, 18 ], [ 2, 8 ], [ 4, 5 ],
										[ 6, 13 ], [ 8, 5 ], [ 10, 7 ],
										[ 12, 4 ], [ 14, 6 ], [ 16, 15 ],
										[ 18, 9 ], [ 20, 17 ], [ 22, 7 ],
										[ 24, 4 ], [ 26, 9 ], [ 28, 11 ] ],
								bars : {
									show : true,
									lineWidth : 0,
									fillColor : '#ffffff8a'
								}
							} ], {
								grid : {
									show : false
								}
							});
							// Bar Chart #flotBarChart End
						});
	</script>
</body>

</html>