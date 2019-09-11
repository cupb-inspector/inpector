<jsp:include page="/WEB-INF/views/commons.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>我的钱包</title>
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
	<link href="assets/weather/css/weather-icons.css" rel="stylesheet" />
	<link href="assets/calendar/fullcalendar.css" rel="stylesheet" />
	<link href="assets/css/charts/chartist.min.css" rel="stylesheet">
	<link href="assets/css/lib/vector-map/jqvmap.min.css" rel="stylesheet">

	<style>

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
	<div class="content" style="background:#f1f2f7;height: 100%;">
		<!-- Animated -->
		<div class="animated fadeIn">
			<!-- Widgets  -->
			<div class="row">
				<!-- 
                    <div class="col-lg-3 col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="stat-widget-five">
                                    <div class="stat-icon dib flat-color-1">
                                        <i class="pe-7s-cash"></i>
                                    </div>
                                    <div class="stat-content">
                                        <div class="text-left dib">
                                            <div class="stat-text">$<span class="count">23569</span></div>
                                            <div class="stat-heading">美元余额</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
 -->
				<div class="col-lg-3 col-md-6">
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-2">
									<i class="pe-7s-cash"></i>
								</div>
								<div class="stat-content">
									<div class="text-left dib">
										<div class="stat-text">
											￥<span class="">${user.cusMoney}</span>
										</div>
										<div class="stat-heading">人民币余额</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3 col-md-6">
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-3">
									<i class="pe-7s-cash"></i>
								</div>
								<div class="stat-content">
									<div>
										<a href="withdraw">
											<button type="button" class="btn btn-outline-primary">提现</button>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3 col-md-6">
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-2">
									<i class="pe-7s-cash"></i>
								</div>
								<div class="stat-content">
									<div class="text-left dib">
										<div class="stat-text">
											￥<span class="">${user.cusTempMoney}</span>
										</div>
										<div class="stat-heading">过渡货币</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3 col-md-6">
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-3">
									<i class="pe-7s-cash"></i>
								</div>
								<div class="stat-content">
									<div>
										<a href="payment">
											<button type="button" class="btn btn-outline-primary">充值</button>
										</a>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>
			<!-- /Widgets -->
			<!--  moneytable  -->
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h4>我的钱包</h4>
						</div>
						<div class="card-body">
							<div class="default-tab">
								<nav>
									<div class="nav nav-tabs" id="nav-tab" role="tablist">
										<a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab"
											href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">
											<h4>钱包明细</h4>
										</a>
										<!-- 
										<a class="nav-item nav-link" id="nav-profile-tab"
											data-toggle="tab" href="#nav-profile" role="tab"
											aria-controls="nav-profile" aria-selected="false">
											<h4>钱包收入</h4>
										</a> <a class="nav-item nav-link" id="nav-contact-tab"
											data-toggle="tab" href="#nav-contact" role="tab"
											aria-controls="nav-contact" aria-selected="false">
											<h4>钱包支出</h4>
										</a>
										 -->
									</div>
								</nav>
								<div class="tab-content pl-3 pt-2" id="nav-tabContent">
									<div class="tab-pane fade show active" id="nav-home" role="tabpanel"
										aria-labelledby="nav-home-tab">
										<table class="table">
											<thead>
												<tr>
													<th scope="col">#</th>
													<th scope="col">时间</th>
													<th scope="col" colspan=‘2’>详情</th>
													<th scope="col">钱包变化</th>
													<!--  
													<th scope="col">钱包余额</th>-->
													<th scope="col">状态</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${list}" var="order" varStatus="status">
												<tr>
													<td>${order.id }</td>
													<td>${order.time}</td>
													<td>${order.typeString}</td>
													<td>${order.operateString}${order.value}</td>
													<td>${order.statusString}</td>
												</tr>
											</c:forEach>

											<%--												<%--%>
<%--												AccountService accountService = new AccountService();--%>
<%--												--%>
<%--												List<Account>  ls = accountService.selectAllByUserId(user.getCusid());--%>
<%--													if(ls!=null&&ls.size()!=0){--%>
<%--														for(int i=0;i<ls.size();i++){--%>
<%--															Account a = ls.get(i);--%>
<%--														%>--%>
<%--												<tr>--%>
<%--													<th scope="row"><%=i+1 %></th>--%>
<%--													<td><%=a.getTime() %></td>--%>
<%--													<td><%=a.getTypeString() %></td>--%>
<%--													<td><%=a.getOperateString()+a.getValue() %></td>--%>
<%--													<!--  --%>
<%--													<td><%=a.getSurplus() %></td>--%>
<%--													-->--%>
<%--													<td><%=a.getStatusString() %></td>--%>
<%--												</tr>--%>
<%--												<% --%>
<%--														}--%>
<%--													}--%>
<%--												%>--%>
											</tbody>
										</table>
									</div>
									<div class="tab-pane fade" id="nav-profile" role="tabpanel"
										aria-labelledby="nav-profile-tab">
										<table class="table">
											<thead>
												<tr>
													<th scope="col">#</th>
													<th scope="col">时间</th>
													<th scope="col" colspan=‘2’>详情</th>
													<th scope="col">钱包变化</th>
													<th scope="col">钱包余额</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th scope="row">1</th>
													<td>2018/12/09</td>
													<td>支付宝充值100</td>
													<td>+100</td>
													<td>200</td>
												</tr>
												<tr>
													<th scope="row">2</th>
													<td>2018/12/08</td>
													<td>支付宝充值100</td>
													<td>+100</td>
													<td>100</td>
												</tr>

											</tbody>
										</table>

									</div>
									<div class="tab-pane fade" id="nav-contact" role="tabpanel"
										aria-labelledby="nav-contact-tab">
										<table class="table">
											<thead>
												<tr>
													<th scope="col">#</th>
													<th scope="col">时间</th>
													<th scope="col" colspan=‘2’>详情</th>
													<th scope="col">钱包变化</th>
													<th scope="col">钱包余额</th>
												</tr>
											</thead>
											<tbody>

											</tbody>
										</table>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

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
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
	<script src="assets/js/init/fullcalendar-init.js"></script>
</body>

</html>