<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons.jsp" />
<!doctype html>
<html class="no-js" lang="">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>自助下单</title>
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
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
	<script src="js/jquery.min.js"></script>
	<link href="zui/lib/datetimepicker/datetimepicker.min.css" rel="stylesheet">
	<script src="zui/lib/datetimepicker/datetimepicker.min.js"></script>
	<!-- 遮罩层 -->
	<script src="js/jquery.spin.merge.js"></script>
	<!-- 提取到文件了 -->
	<script src="js/checkcontent.js"></script>
	<style>


		.white_content {
			display: none;
			position: fixed;
			width: 55%;
			height: 55%;
			left: 0px;
			right: 0px;
			bottom: 0px;
			top: 0px;
			margin: auto;
			z-index: 1002;
		}

		.black_overlay {
			display: none;
			position: fixed;
			top: 0%;
			left: 0%;
			width: 100%;
			height: 100%;
			background-color: dimgray;
			z-index: 1001;
			-moz-opacity: 0.8;
			opacity: .80;
			filter: alpha(opacity=88);
		}

		html,body {
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

		#connect {
			color: chocolate
		}
	</style>
	<!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->
	<link rel="stylesheet" href="hxy/css/hxy-alert.css">
	<script src="hxy/js/hxy-alert.js"></script>
	<script type="text/javascript">
	</script>
	<script type="text/javascript">
		var maxstrlen = 200;
		function Q(s) {
			return document.getElementById(s);
		}
		function checkWords(c) {
			len = maxstrlen;
			var str = c.value;
			myLen = getStrleng(str);
			var wck = Q("wordCheck");
			if (myLen > len * 2) {
				c.value = str.substring(0, i + 1);
			} else {
				wck.innerHTML = Math.floor((len * 2 - myLen) / 2);
			}
		}
		function getStrleng(str) {
			myLen = 0;
			i = 0;
			for (; (i < str.length) && (myLen <= maxstrlen * 2); i++) {
				if (str.charCodeAt(i) > 0 && str.charCodeAt(i) < 128)
					myLen++;
				else
					myLen += 2;
			}
			return myLen;
		}
	</script>
</head>

<body>
	<div class="hxy-alert"></div>
	<!-- Header-->
	<div id="wrap-content" class="content" style="background: #f1f2f7;; height: 100% width:100%">
		<div class="animated fadeIn">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">自助下单</strong>
						</div>
						<div class="card-body">
							<div class="form-horizontal">
								<div class="row form-group">
									<div class="col col-md-2">
										<label for="text-input" class=" form-control-label"
											style="float: right">工厂名称</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="facname" name="text-input"
											placeholder="请填写工厂有效名称，百度高德地图可以搜到" class="form-control">
										<!-- 
											<small
											class="form-text text-muted">建议先地图搜索确定下再填写</small>
											 -->
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-2">
										<label for="email-input" class=" form-control-label"
											style="float: right">工厂地址</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="facaddress" name="email-input" placeholder="工厂有效地址"
											class="form-control">
										<!-- 
											<small
											class="help-block form-text">地图上确定可以搜到的地址</small>
											 -->
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-2">
										<label for="password-input" class=" form-control-label"
											style="float: right">联系人</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="facman" name="password-input" placeholder="请填写联系人姓名"
											class="form-control">
										<!--  
											<small class="help-block form-text">不要填写一些别名</small>-->
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-2">
										<label for="disabled-input" class=" form-control-label"
											style="float: right">联系人电话</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="factel" name="disabled-input" placeholder="请填写有效的电话"
											class="form-control">
									</div>
								</div>
							</div>
							<div class="row form-group">
								<div class="col col-md-2">
									<label for="select" class=" form-control-label" style="float: right">验货类型</label>
								</div>
								<div class="col-12 col-md-9">
									<select name="select" id="select" class="form-control">
										<option value="0">在线检验</option>
										<option value="1">监柜</option>
										<option value="2">抽样</option>
										<option value="3">验货加监柜</option>
										<option value="4">工厂审核</option>
									</select>
								</div>
							</div>
							<div class="row form-group">
								<div class="col col-md-2">
									<label for="textarea-input" class=" form-control-label"
										style="float: right">产品名称</label>
								</div>
								<div class="col-12 col-md-9">
									<input name="text" id="goods" rows="5" placeholder="产品名称，货号"
										class="form-control"></input>
								</div>
							</div>
							<div class="row form-group">
								<div class="col col-md-2">
									<label for="select" class=" form-control-label" style="float: right">产品类型</label>
								</div>
								<div class="col-12 col-md-9">
									<select name="select" id="goodsselect" class="form-control">
										<option value="0">电子</option>
										<option value="1">食品</option>
										<option value="2">交通工具</option>
										<option value="3">零食</option>
										<option value="4">家具</option>
									</select>
								</div>
							</div>
							<div class="row form-group">
								<div class="col col-md-2">
									<label for="textarea-input" class=" form-control-label"
										style="float: right">验货日期</label>
								</div>
								<div class="col-12 col-md-9">
									<input class="form-control form-date" id="excdate"
										placeholder="选择或者输入一个日期：yyyy-MM-dd">
								</div>
							</div>

							<div class="row form-group">
								<div class="col col-md-2">
									<label for="profile" class=" form-control-label"
										style="float: right">备注</label>
								</div>
								<div class="col-12 col-md-9">
									<textarea name="textarea-input" id="profile" rows="5"
										placeholder="请填写一些注意事项或者要求，建议等" class="form-control"
										onkeyup="javascript:checkWords(this);"
										onmousedown="javascript:checkWords(this);"></textarea>
									<small class="help-block form-text">还可以输入<span
											style="font-family: Georgia; font-size: 26px;" id="wordCheck">200</span>个汉字
									</small>
								</div>
							</div>

							<div class="row form-group">
								<div class="col col-md-2">
									<label for="afile" class=" form-control-label"
										style="float: right">资料</label>
								</div>
								<div class="col-12 col-md-9">
									<input type="file" id="afile" name="file-multiple-input" class="form-control-file">
								</div>
							</div>
							<div>
								<button type="submit" id="btn1" class="btn btn-primary btn-sm">
									<i class="fa fa-dot-circle-o"></i> 提交
								</button>
								<button type="reset" id="btn2" class="btn btn-danger btn-sm">
									<i class="fa fa-ban"></i> 重置
								</button>
								<button id="btn3" class="btn btn-danger btn-sm">
									<i class="fa fa-ban"></i> 草稿
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- .animated -->

	<!-- 弹窗 -->
	<div>
		<!--点击弹出付款的界面-->
		<div id="pay" class="white_content">
			<div class="card">
				<div class="card-header">
					<strong class="card-title">付款</strong>
				</div>
				<div class="card-body">
					<div>
						<div class="row form-group">
							<div class="col col-md-5">
								<div align="center" style="margin:50px">

									<h1 id="billPrice">$100</h1>
								</div>

							</div>
							<div class="col col-md-7">
								<div class="row form-group" style="margin:50px">

									<div class="col col-md-3"><label style="float:right;" for="text-input"
											class=" form-control-label">钱包</label></div>
									<div class="col-12 col-md-9">
										<h3 id="cusMoney">$1236</h3>
									</div>
									<div id="moneyStatus" class="fade" align="center">
										余额不足
									</div>

								</div>
								<div class="row form-group" align="center">
									<div align="center">
										<button id='payBtn' value="付款" class="btn btn-primary btn-sm" style="margin-right: 10px">
											<i class="fa fa-dot-circle-o"></i> 付款
										</button>
										<button type="reset" onclick="closeDialog()" class="btn btn-danger btn-sm">
											<i class="fa fa-ban"></i> 取消
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/.card-body-->
				</div>
				<!-- /.card -->
			</div>
		</div>
		<div id="fade" class="black_overlay"></div>
		<!--/点击弹出付款的界面-->
	</div>

		<!-- 新用户提示 -->
		<div>
			<!--点击弹出付款的界面-->
			<div id="fresh" class="white_content">
				<div class="card">
					<div class="card-header">
						<strong class="card-title">付款</strong>
					</div>
					<div class="card-body">
						<div>
							亲爱的新用户您好！感谢您信任××质检。为了您的良好体验，我们公司推出第一单优惠活动。
						</div>
						<div align="center">
						
							<button type="reset" onclick="closeDialogFresh()" class="btn btn-danger btn-sm">
								<i class="fa fa-ban"></i> 确定
							</button>
						</div>
						<!--/.card-body-->
					</div>
					<!-- /.card -->
				</div>
			</div>
			<div id="fade" class="black_overlay"></div>
			<!--/点击弹出付款的界面-->
		</div>
	<!-- .content -->
	<!-- Scripts -->
	<script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>

	<script>
		function openDialog() {
			document.getElementById('pay').style.display = 'block';
			document.getElementById('fade').style.display = 'block'
		}
		function closeDialog() {
			document.getElementById('pay').style.display = 'none';
			document.getElementById('fade').style.display = 'none'
		}
		function closeDialogFresh() {
			document.getElementById('fresh').style.display = 'none';
			document.getElementById('fade').style.display = 'none'
		}
	</script>


</body>

</html>