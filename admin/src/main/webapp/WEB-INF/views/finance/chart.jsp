<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>    <html class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>    <html class="lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->

<head>
	<title>AIR - Premium Bootstrap Admin Template</title>

	<!-- Meta -->
	<meta charset="UTF-8" />
	<meta name="viewport"
		content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />

	<!-- Bootstrap -->
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />

	<!-- Bootstrap Extended -->
	<link href="bootstrap/extend/jasny-bootstrap/css/jasny-bootstrap.min.css" rel="stylesheet" />
	<link href="bootstrap/extend/jasny-bootstrap/css/jasny-bootstrap-responsive.min.css" rel="stylesheet" />
	<link href="bootstrap/extend/bootstrap-wysihtml5/css/bootstrap-wysihtml5-0.0.2.css" rel="stylesheet" />

	<!-- JQueryUI v1.9.2 -->
	<link rel="stylesheet" href="theme/scripts/jquery-ui-1.9.2.custom/css/smoothness/jquery-ui-1.9.2.custom.min.css" />

	<!-- Glyphicons -->
	<link rel="stylesheet" href="theme/css/glyphicons.css" />

	<!-- Bootstrap Extended -->
	<link rel="stylesheet" href="bootstrap/extend/bootstrap-select/bootstrap-select.css" />
	<link rel="stylesheet"
		href="bootstrap/extend/bootstrap-toggle-buttons/static/stylesheets/bootstrap-toggle-buttons.css" />

	<!-- Uniform -->
	<link rel="stylesheet" media="screen" href="theme/scripts/pixelmatrix-uniform/css/uniform.default.css" />

	<!-- JQuery v1.8.2 -->
	<script src="theme/scripts/jquery-1.8.2.min.js"></script>

	<!-- Modernizr -->
	<script src="theme/scripts/modernizr.custom.76094.js"></script>

	<!-- MiniColors -->
	<link rel="stylesheet" media="screen" href="theme/scripts/jquery-miniColors/jquery.miniColors.css" />

	<!-- Theme -->
	<link rel="stylesheet" href="theme/css/style.min.css?1361377786" />



	<!-- LESS 2 CSS -->
	<script src="theme/scripts/less-1.3.3.min.js"></script>


	<!--[if IE]><script type="text/javascript" src="theme/scripts/excanvas/excanvas.js"></script><![endif]-->
	<!--[if lt IE 8]><script type="text/javascript" src="theme/scripts/json2.js"></script><![endif]-->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body style="background:#f1f2f7">


	<br />
	<!-- Start Content -->
	<div class="container-fluid fixed">


		<div id="content">

			<div class="heading-buttons">
				<h3 class="glyphicons coins"><i></i> 财务统计<span>| 图表分析</span></h3>

			</div>
			<div class="separator line"></div>

			<div class="filter-bar">
				<form />
				<div class="lbl glyphicons cogwheel"><i></i>查询</div>
				<div>
					<label>From:</label>
					<div class="input-append">
						<input type="text" name="from" id="dateRangeFrom" class="input-mini" value="08/05/13"
							style="width: 53px;" />
						<span class="add-on glyphicons calendar"><i></i></span>
					</div>
				</div>
				<div>
					<label>To:</label>
					<div class="input-append">
						<input type="text" name="to" id="dateRangeTo" class="input-mini" value="08/18/13"
							style="width: 53px;" />
						<span class="add-on glyphicons calendar"><i></i></span>
					</div>
				</div>
				<div>
					<label>Min:</label>
					<div class="input-append">
						<input type="text" name="from" class="input-mini" style="width: 30px;" value="100" />
						<span class="add-on glyphicons euro"><i></i></span>
					</div>
				</div>
				<div>
					<label>Max:</label>
					<div class="input-append">
						<input type="text" name="from" class="input-mini" style="width: 30px;" value="500" />
						<span class="add-on glyphicons euro"><i></i></span>
					</div>
				</div>
				<div>
					<label>Select:</label>
					<select name="from" style="width: 80px;">
						<option />Some option
						<option />Other option
						<option />Some other option
					</select>
				</div>
				<div class="clearfix"></div>
				</form>
			</div>
			<div class="separator line"></div>

			<div class="widget widget-4 finances_summary">
				<div class="widget-head">
					<h4 class="heading">统计</h4>
				</div>
				<div class="widget-body" style="padding: 10px 0;">
					<div class="row-fluid">
						<div class="span4">
							<div class="well">
								总订单金额 <strong>&euro;32,156.00</strong>
							</div>
							<div class="separator bottom center">
								<span class="glyphicons flash standard"><i></i></span>
							</div>
							<div class="well">
								总收益金额 <strong>&euro;122,134.00</strong>
							</div>
						</div>
						<div class="span8">
							<div id="chart_simple" style="height: 290px;"></div>
						</div>
					</div>
					<a href="#link_a" class="glyphicons list single"><i></i> View details</a>
				</div>
			</div>
			<div class="widget widget-4" id="link_a">
				<div class="widget-head">
					<h4 class="heading">详情</h4>
				</div>
				<div class="widget-body" style="padding: 10px 0;">
					<table class="table table-condensed table-primary table-vertical-center table-thead-simple">
						<thead>
							<tr>
								<th class="center" style="width: 1%">No.</th>
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
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
							<tr class="selectable">
								<td class="center">1</td>
								<td class="important">123
								</td>
								<td class="center">xiao</td>
								<td class="center">xiaoxiao</td>
								<td class="center">上海</td>
								<td class="center">700</td>
								<td class="center">0</td>
								<td class="center">7</td>
								<td class="right actions">
									<a href="details.html" class="btn-action glyphicons eye_open btn-info"><i></i></a>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="separator top"><a href="" class="glyphicons list single"><i></i> Show all</a></div>
				</div>
			</div>


		</div>

	</div>

	<!-- JQueryUI v1.9.2 -->
	<script src="theme/scripts/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.min.js"></script>

	<!-- JQueryUI Touch Punch -->
	<!-- small hack that enables the use of touch events on sites using the jQuery UI user interface library -->
	<script src="theme/scripts/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>

	<!-- MiniColors -->
	<script src="theme/scripts/jquery-miniColors/jquery.miniColors.js"></script>

	<!-- Themer -->
	<script>
		var themerPrimaryColor = '#71c39a';
	</script>
	<script src="theme/scripts/jquery.cookie.js"></script>
	<script src="theme/scripts/themer.js"></script>


	<script type="text/javascript" src="https://www.google.com/jsapi"></script>


	<!--  Flot (Charts) JS -->
	<script src="theme/scripts/flot/jquery.flot.js" type="text/javascript"></script>
	<script src="theme/scripts/flot/jquery.flot.pie.js" type="text/javascript"></script>
	<script src="theme/scripts/flot/jquery.flot.tooltip.js" type="text/javascript"></script>
	<script src="theme/scripts/flot/jquery.flot.selection.js"></script>
	<script src="theme/scripts/flot/jquery.flot.resize.js" type="text/javascript"></script>
	<script src="theme/scripts/flot/jquery.flot.orderBars.js" type="text/javascript"></script>


	<script>
		var charts =
		{
			// init all charts
			init: function () {

				// init simple chart
				this.chart_simple.init();
			},

			// utility class
			utility:
			{
				chartColors: ["#71c39a", "#444", "#777", "#999", "#DDD", "#EEE"],
				chartBackgroundColors: ["#fff", "#fff"],

				applyStyle: function (that) {
					that.options.colors = charts.utility.chartColors;
					that.options.grid.backgroundColor = { colors: charts.utility.chartBackgroundColors };
					that.options.grid.borderColor = charts.utility.chartColors[0];
					that.options.grid.color = charts.utility.chartColors[0];
				},


				// generate random number for charts
				randNum: function () {
					return (Math.floor(Math.random() * (1 + 40 - 20))) + 20;
				}
			},


			// simple chart
			chart_simple:
			{
				// data
				data:
				{
					sin: [],
					cos: []
				},

				// will hold the chart object
				plot: null,

				// chart options
				options:
				{
					grid:
					{
						show: true,
						aboveData: true,
						color: "#3f3f3f",
						labelMargin: 5,
						axisMargin: 0,
						borderWidth: 0,
						borderColor: null,
						minBorderMargin: 5,
						clickable: true,
						hoverable: true,
						autoHighlight: true,
						mouseActiveRadius: 20,
						backgroundColor: {}
					},
					series: {
						grow: { active: false },
						lines: {
							show: true,
							fill: false,
							lineWidth: 4,
							steps: false
						},
						points: {
							show: true,
							radius: 5,
							symbol: "circle",
							fill: true,
							borderColor: "#fff"
						}
					},
					legend: { position: "se" },
					colors: [],
					shadowSize: 1,
					tooltip: true, //activate tooltip
					tooltipOpts: {
						content: "%s : %y.3",
						shifts: {
							x: -30,
							y: -50
						},
						defaultTheme: false
					}
				},

				// initialize
				init: function () {
					// apply styling
					charts.utility.applyStyle(this);

					if (this.plot == null) {
						for (var i = 0; i < 14; i += 0.5) {
							this.data.sin.push([i, Math.sin(i)]);
							this.data.cos.push([i, Math.cos(i)]);
						}
					}
					this.plot = $.plot(
						$("#chart_simple"),
						[{
							label: "Sin",
							data: this.data.sin,
							lines: { fillColor: "#DA4C4C" },
							points: { fillColor: "#fff" }
						},
						{
							label: "Cos",
							data: this.data.cos,
							lines: { fillColor: "#444" },
							points: { fillColor: "#fff" }
						}], this.options);
				}
			},
		};

		$(function () {
			// initialize charts
			charts.init();
		});
	</script>


	<!-- Resize Script -->
	<script src="theme/scripts/jquery.ba-resize.js"></script>

	<!-- Uniform -->
	<script src="theme/scripts/pixelmatrix-uniform/jquery.uniform.min.js"></script>

	<!-- Bootstrap Script -->
	<script src="bootstrap/js/bootstrap.min.js"></script>

	<!-- Bootstrap Extended -->
	<script src="bootstrap/extend/bootstrap-select/bootstrap-select.js"></script>
	<script src="bootstrap/extend/bootstrap-toggle-buttons/static/js/jquery.toggle.buttons.js"></script>
	<script src="bootstrap/extend/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js"></script>
	<script src="bootstrap/extend/jasny-bootstrap/js/jasny-bootstrap.min.js" type="text/javascript"></script>
	<script src="bootstrap/extend/jasny-bootstrap/js/bootstrap-fileupload.js" type="text/javascript"></script>
	<script src="bootstrap/extend/bootbox.js" type="text/javascript"></script>
	<script src="bootstrap/extend/bootstrap-wysihtml5/js/wysihtml5-0.3.0_rc2.min.js" type="text/javascript"></script>
	<script src="bootstrap/extend/bootstrap-wysihtml5/js/bootstrap-wysihtml5-0.0.2.js" type="text/javascript"></script>

	<!-- Custom Onload Script -->
	<script src="theme/scripts/load.js"></script>

	<!-- jQuery Knob -->
	<script src="theme/scripts/jquery-knob/js/jquery.knob.js"></script>

</body>

</html>