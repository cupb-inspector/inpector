<!doctype html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="cn.hxy.inspect.entity.admin.AdminUser"%>
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
<title>管理员后台</title>
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
	<!-- Left Panel -->
	<aside id="left-panel" class="left-panel">
		<nav class="navbar navbar-expand-sm navbar-default">
			<div id="main-menu" class="main-menu collapse navbar-collapse">
				<ul class="nav navbar-nav" id='nky'>

					<li class="nav-item menu-item"><a class="nav-link"
						href="index-content" target="myiframe"><i
							class="menu-icon fa fa-laptop"></i>我的主页</a></li>

					<li class="nav-item menu-item-has-children"><a
						class="nav-link" data-toggle="collapse" href="#bill"
						aria-haspopup="true" aria-expanded="false" aria-controls="bill">
							<i class="menu-icon fa fa-file-text"></i> 订单管理
					</a>
						<div class="collapse" id="bill">
							<ul class="nav flex-column sub-menu">
								<li><a href="orders-new" target="myiframe">新订单</a></li>
								<li><a href="orders-checking" target="myiframe">最近验货订单</a></li>
								<li><a href="orders-unfinished" target="myiframe">未完成订单</a></li>
								<li><a href="orders-finished" target="myiframe">已完成订单</a></li>
								<li><a href="orders-all" target="myiframe">所有订单</a></li>
							</ul>
						</div></li>

					<li class="nav-item menu-item-has-children"><a
						class="nav-link" data-toggle="collapse" href="#report"
						aria-haspopup="true" aria-expanded="false" aria-controls="bill">
							<i class="menu-icon fa fa-file-text"></i> 报告管理
					</a>
						<div class="collapse" id="report">
							<ul class="nav flex-column sub-menu">
								<li><a href="report-unprocess" target="myiframe">未处理报告</a></li>
								<li><a href="report-process" target="myiframe">已处理报告</a></li>
								<li><a href="report-finished" target="myiframe">已完成报告</a></li>
							</ul>
						</div></li>

					<!-- 
                        <li class="nav-item menu-item-has-children">
                            <a class="nav-link" data-toggle="collapse" href="#evalution" aria-haspopup="true"
                                aria-expanded="false" aria-controls="bill">
                                <i class="menu-icon fa fa-file-text-o"></i>
                                评价管理
                            </a>
                            <div class="collapse" id="evalution">
                                <ul class="nav flex-column sub-menu">
                                    <li><a href="unevaluation" target="myiframe">未评价订单</a></li>
                                    <li><a href="evaluation" target="myiframe">已评价订单</a></li>
                                    <li><a href="complain" target="myiframe">已投诉订单</a></li>
                               </ul>
                            </div>
                        </li>
 -->

					<li class="nav-item menu-item-has-children"><a
						class="nav-link" data-toggle="collapse" href="#finance"
						aria-haspopup="true" aria-expanded="false" aria-controls="bill">
							<i class="menu-icon fa fa-money"></i> 财务管理
					</a>
						<div class="collapse" id="finance">
							<ul class="nav flex-column sub-menu">
								<li><a href="payment" target="myiframe">充值统计</a></li>
									<li><a href="withdraw" target="myiframe">提现统计</a></li>
								<!--  
								<li><a href="finance" target="myiframe">财务统计</a></li>
							
								<li><a href="refund" target="myiframe">退款处理</a></li>
								<li><a href="chart" target="myiframe">财务报表</a></li>
								-->
							</ul>
						</div></li>
					<li class="nav-item menu-item-has-children"><a
						class="nav-link" data-toggle="collapse" href="#managers"
						aria-haspopup="true" aria-expanded="false" aria-controls="bill">
							<i class="menu-icon fa fa-group"></i> 管理员管理
					</a>
						<div class="collapse" id="managers">
							<ul class="nav flex-column sub-menu">
								<li><a href="managers" target="myiframe">管理员管理</a></li>
								<li><a href="clients" target="myiframe">客户管理</a></li>
								<li><a href="surveyor" target="myiframe">质检员管理</a></li>
							</ul>
						</div></li>
					<li class="nav-item menu-item"><a class="nav-link"
						href="personal" target="myiframe"> <i
							class="menu-icon fa fa-user"></i>我的账户
					</a></li>
					<!--
					<li class="nav-item menu-item"><a class="nav-link"
						href="mynews" target="myiframe"> <i
							class="menu-icon fa fa-cogs"></i>系统配置
					</a></li>
  -->

				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</nav>
	</aside>
	<!-- /#left-panel -->
	<!-- Right Panel -->
	<div id="right-panel" class="right-panel" style="height: 100%">
		<!-- Header-->
		<header id="header" class="header">
			<div class="top-left">
				<div class="navbar-header">
					<a class="navbar-brand" href="http://www.globalinsp.com"><img
						src="images/logo.jpg" alt="Logo"></a> <a id="menuToggle"
						class="menutoggle"><i class="fa fa-bars"></i></a>
				</div>
			</div>
			<div class="top-right">
				<div class="header-menu">
					<div class="header-left">
						<div class="dropdown for-language">
							<a href="#">English</a>
						</div>

						<button class="search-trigger">
							<i class="fa fa-search"></i>
						</button>
						<div class="form-inline">
							<form class="search-form">
								<input class="form-control mr-sm-2" type="text"
									placeholder="请输入订单号" aria-label="Search">
								<button class="search-close" type="submit">
									<i class="fa fa-close"></i>
								</button>
							</form>
						</div>

						<div class="dropdown for-notification">
							<a href="mynews" target="myiframe"> <i class="fa fa-bell"></i>
							</a>

						</div>
					</div>

					<div class="user-area dropdown float-right">
						<a href="#" class="dropdown-toggle active" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> <img
							class="user-avatar rounded-circle" src="images/admin.jpg"
							alt="User Avatar">
						</a>

						<div class="user-menu dropdown-menu">
							<a class="nav-link" href="personal" target="myiframe"><i
								class="fa fa- user"></i>账户设置</a> <a class="nav-link"
								href="user-login-out"><i class="fa fa- user"></i>安全退出</a>

						</div>
					</div>

				</div>
			</div>
		</header>
		<!-- /#header -->
		<!--content-->
		<div class="content"
			style="width: 100%; height: 100%; padding: 0px; background: #f1f2f7">
			<div style="width: 100%; height: 100%">
				<iframe name="myiframe" src="index-content" frameborder="no"
					scrolling="auto" style="height: 100%; width: 100%;"
					allowtransparency="true"> </iframe>
			</div>

		</div>
		<!-- Footer -->

		<!-- /.site-footer -->
	</div>
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
	<script>
		//一级激活
		function hasClass(elements, cName) {
			return !!elements.className.match(new RegExp("(\\s|^)" + cName
					+ "(\\s|$)"));
		};
		function addClass(elements, cName) {
			if (!hasClass(elements, cName)) {
				elements.className += " " + cName;
			}
			;
		};
		function removeClass(elements, cName) {
			if (hasClass(elements, cName)) {
				elements.className = elements.className.replace(new RegExp(
						"(\\s|^)" + cName + "(\\s|$)"), " ");
			}
			;
		};
		var li = document.querySelectorAll('#nky li');

		for (var i = 0; i < li.length; i++)
			li[i].onclick = function() {
				//   for (var i = 0; i < li.length; i++) li[i].className = '';
				//  this.className = 'active'
				for (var i = 0; i < li.length; i++)
					removeClass(li[i], 'active');
				addClass(this, 'active')
			}
	</script>
</body>

</html>