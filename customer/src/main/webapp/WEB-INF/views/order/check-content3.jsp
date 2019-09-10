<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<title>Ela Admin - HTML5 Admin Template</title>
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

	<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->



	<script src="js/jquery.min.js"></script>
	<!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->
	<link rel="stylesheet" href="hxy/css/hxy-alert.css">
	<script src="hxy/js/hxy-alert.js"></script>

	<script type="text/javascript">
		$(document)
			.ready(
				function () {
					$("#btn1")
						.click(
							function () {
								var excdate = $("#date").val();
								var facname = $("#facname").val();
								var facaddress = $("#facaddress")
									.val();
								var facman = $("#facman").val();
								var factel = $("#factel").val();
								var profile = $("#profile").val();
								var goods = $("#goods").val();
								//	var file = $("#file").val();
								console.log(excdate + "\t"
									+ facname)

								if (excdate == "") {

									$('.alert').removeClass(
										'alert-success')
									$('.alert')
										.html('请选择验货日期')
										.addClass(
											'alert-warning')
										.show().delay(2000)
										.fadeOut();
									return false;
								}
								if (facname == "") {
									$('.alert').removeClass(
										'alert-success')
									$('.alert')
										.html('请填写工厂名称')
										.addClass(
											'alert-warning')
										.show().delay(2000)
										.fadeOut();

									return false;
								}

								$
									.ajax({
										//几个参数需要注意一下
										url: "${pageContext.request.contextPath}/cusInsertOrder",//url
										type: "POST",//方法类型
										async: false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

										dataType: "json",//预期服务器返回的数据类型
										cache: false,
										data: {
											"excdate": excdate,
											"facname": facname,
											"facaddress": facaddress,
											"facman": facman,
											"factel": factel,
											"profile": profile,
											"goods": goods
											//	"file":file
										},//这个是发送给服务器的数据

										success: function (
											result) {
											console.log(result);//打印服务端返回的数据(调试用)
											if (result.resultCode == 200) {
												//跳转到首页	$('.alert').removeClass('alert-success')
												$('.alert')
													.html(
														'提交成功')
													.addClass(
														'alert-success')
													.show()
													.delay(
														2000)
													.fadeOut();
												document
													.getElementById("facname").value = ''
												document
													.getElementById("facaddress").value = ''
												document
													.getElementById("facman").value = ''
												document
													.getElementById("factel").value = ''
												document
													.getElementById("profile").value = ''
												document
													.getElementById("goods").value = ''
											} else if (result.resultCode == 601) {
												//	$(this).remove();
												$('.alert')
													.removeClass(
														'alert-success')
												$('.alert')
													.html(
														'密码错误')
													.addClass(
														'alert-warning')
													.show()
													.delay(
														2000)
													.fadeOut();
												document
													.getElementById("passwd").value = ''
											} else if (result.resultCode == 404) {
												//	$(this).remove();
												$('.alert')
													.removeClass(
														'alert-success')
												$('.alert')
													.html(
														'手机号未注册')
													.addClass(
														'alert-warning')
													.show()
													.delay(
														2000)
													.fadeOut();
											} else if (result.resultCode == 604) {
												//跳转到首页
												window.location.href = 'login';
											}
											;
										},
										error: function () {
											//console.log(data);
											$('.alert')
												.removeClass(
													'alert-success')
											$('.alert')
												.html(
													'检查网络是否连接')
												.addClass(
													'alert-warning')
												.show()
												.delay(2000)
												.fadeOut();
										}
									});
							});

				});
	</script>
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
	<div class="alert"></div>
	<!-- Header-->
	<div class="content" style="background: #f1f2f7;;height:100%width:100%">
		<div class="animated fadeIn">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<strong class="card-title">自助下单</strong>
						</div>
						<div class="card-body">
							<form action="${pageContext.request.contextPath}/cusInsertOrder" method="post"
								enctype="multipart/form-data" class="form-horizontal">
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="text-input" class=" form-control-label">工厂名称</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="facname" name="text-input"
											placeholder="请填写工厂有效名称，百度高德地图可以搜到" class="form-control"><small
											class="form-text text-muted">建议先地图搜索确定下再填写</small>
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="email-input" class=" form-control-label">工厂地址</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="facaddress" name="email-input" placeholder="工厂有效地址"
											class="form-control"><small
											class="help-block form-text">地图上确定可以搜到的地址</small>
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="password-input" class=" form-control-label">联系人</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="facman" name="password-input" placeholder="请填写联系人姓名"
											class="form-control"><small class="help-block form-text">不要填写一些别名</small>
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="disabled-input" class=" form-control-label">联系人电话</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="text" id="factel" name="disabled-input" placeholder="请填写有效的电话"
											class="form-control">
									</div>
								</div>

								<div class="row form-group">
									<div class="col col-md-3">
										<label for="select" class=" form-control-label">验货类型</label>
									</div>
									<div class="col-12 col-md-9">
										<select name="select" id="select" class="form-control">
											<option value="0">在线检验 $150</option>
											<option value="1">监柜 $200</option>
											<option value="2">抽样 $250</option>
											<option value="3">验货加监柜 $500</option>
											<option value="3">工厂审核 $300</option>
										</select>
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="textarea-input" class=" form-control-label">产品名称</label>
									</div>
									<div class="col-12 col-md-9">
										<input name="text" id="goods" rows="5" placeholder="产品名称，货号"
											class="form-control"></input>
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="textarea-input" class=" form-control-label">验货日期</label>
									</div>
									<div class="col-12 col-md-9">
										<input name="text" id="date" rows="5" placeholder="请填写一些注意事项或者要求，建议等"
											class="form-control"></input>
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="textarea-input" class=" form-control-label">备注</label>
									</div>
									<div class="col-12 col-md-9">
										<textarea name="textarea-input" id="profile" rows="5"
											placeholder="请填写一些注意事项或者要求，建议等" class="form-control"></textarea>
									</div>
								</div>
								<div class="row form-group">
									<div class="col col-md-3">
										<label for="file-multiple-input" class=" form-control-label">资料</label>
									</div>
									<div class="col-12 col-md-9">
										<input type="file" id="file" name="file-multiple-input" multiple=""
											class="form-control-file">
									</div>
								</div>
								<div>
									<!--提交之后由主页接收文件过后，然后返回一个PayPal付款的界面，无论是不是ajax，都可以完成文件的传输与信息的交互。-->
									<button type="submit" id="btn1" class="btn btn-primary btn-sm">
										<i class="fa fa-dot-circle-o"></i> 提交
									</button>
									<button type="reset" id="btn2" class="btn btn-danger btn-sm">
										<i class="fa fa-ban"></i> 重置
									</button>
								</div>
							</form>
							<!--.form-->


						</div>
					</div>
				</div>


			</div>
		</div>
		<!-- .animated -->
	</div>
	<!-- .content -->




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