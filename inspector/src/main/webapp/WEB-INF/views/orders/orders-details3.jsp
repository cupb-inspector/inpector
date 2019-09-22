<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>详情</title>
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
<style>
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
}
</style>
</head>

<body style="background: #f1f2f7">

	<div class="animated fadeIn">
		<div class="container">

			<div class="orders">
				<div class="row">

					<div class="col-xl-8">
						<div class="card">
							<div class="card-header">
								<h4>详情</h4>
							</div>
							<div class="card-body">
								<div class="alert alert-secondary" role="alert">
									<h4 class="alert-heading">订单</h4>
									<br />
									<form action="#" method="post" class="form-horizontal">
										<div class="row form-group">
											<div class="col col-md-6">
												<p>
													订单号：<span>${ordersId}</span>
												</p>
											</div>
											<div class="col col-md-6">
												<p>
													订单状态：<span>${status}</span>
												</p>
											</div>
										</div>
										<div class="row form-group">
											<div class="col col-md-4">
												<p>
													验货时间：<span>${exceData}</span>
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
													产品名称：<span>${goods}</span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													工厂名称：<span>${factoyName}</span>
												</p>
											</div>
										</div>
										<div class="row form-group">
											<div class="col col-md-4">
												<p>
													工厂地址：<span>${facAddress}</span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													联系人姓名：<span>${facMan}</span>
												</p>
											</div>
											<div class="col col-md-4">
												<p>
													手机号：<span>${facTel}</span>
												</p>
											</div>
										</div>
										<hr />
										<div class="row form-group">
											<div class="col col-md-4">
												<p>
													下单日期：<span>${date}</span>
												</p>
												<p>
													接单日期：<span>2019/01/09</span>
												</p>
											</div>

										</div>

									</form>
								</div>
								<div class="alert alert-info" role="alert">
									<h4 class="alert-heading">报告</h4>
									<br />
									<p>
										<i class="fa fa-envelope-o"></i> 报告 <a href=""> <span
											class="pull-right">下载</span></a>
									<p>
								</div>
								<div class="alert alert-secondary" role="alert">
									<h4 class="alert-heading">评价</h4>
									<br />
									<p>
										<sapn>Aww yeah, you successfully read this important
										alert message. This example text is going to run a bit longer
										so that you can see how spacing within an alert works with
										this kind of content.</sapn>
									</p>

								</div>
								<div class="alert alert-info" role="alert">
									<h4 class="alert-heading">付款</h4>
									<p>Aww yeah, you successfully read this important alert
										message. This example text is going to run a bit longer so
										that you can see how spacing within an alert works with this
										kind of content.</p>
									<hr>
									<p class="mb-0">Whenever you need to, be sure to use margin
										utilities to keep things nice and tidy.</p>
								</div>

							</div>
						
						</div>
						<!-- /.card -->
					</div>
					<!-- /.col-lg-8 -->

				</div>
			</div>
			<!-- /.orders -->
			<!-- </div> -->
		</div>
	</div>

	<script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>

</body>

</html>