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
  <script src="js/jquery.min.js"></script>
  <!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->
  <link rel="stylesheet" href="hxy/css/hxy-alert.css">
  <script src="hxy/js/hxy-alert.js"></script>
  
 <script type="text/javascript">  
        function jqSubmit() {
           // {# $('#fafafa')[0]#}
            var file_obj = document.getElementById('reportfile').files[0];

            var fd = new FormData();
            fd.append('id', ${ordersId});
            fd.append('file', file_obj);

            $.ajax({
                url:'submitReport',
                type:'POST',
                data:fd,
                dataType : "json",//预期服务器返回的数据类型
                processData:false,  //tell jQuery not to process the data
                contentType: false,  //tell jQuery not to set contentType
                //这儿的三个参数其实就是XMLHttpRequest里面带的信息。
                success:function (result,arg,a1,a2) {
                	 console.log(result);
                    console.log(arg);
                    console.log(a1);
                    console.log(a2);
            		if (result.resultCode == 200) {
        				//thisE.previousElementSibling.innerHTML = "允许"
        					//自动消失的消息
        					$('.alert').removeClass('alert-warning')
        					$('.alert').html('提交成功').addClass('alert-success').show().delay(2000).fadeOut();
            		}
                    
                }

            })
        }
</script>    

</head>

<body style="background: #f1f2f7">
<div class="alert"></div>
	<div class="content" style="background: #f1f2f7; height: 100%">
		<div class="animated fadeIn">
			<div class="row">
				<div class="col-xl-8">
					<div class="card">
						<div class="card-header">
							<h4>详情</h4>
						</div>
						<div class="card-body">



							<div class="col-md-12">
								<div class="card border border-secondary">
									<div class="card-header">
										<strong class="card-title">订单信息</strong>
									</div>
									<div class="card-body">
										<form action="#" method="post" class="form-horizontal">
											<div class="row form-group">
												<div class="col col-md-6">
													<p>
														订单号：<span id='ordersId' value='${ordersId}'>${ordersId}</span>
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
														产品信息：<span>${goods}</span>
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
												</div>

											</div>

										</form>
									</div>
								</div>
							</div>


							<div class="col-md-12">
								<div class="card bg-success">
									<div class="card-header">
										<h4>报告</h4>
									</div>
									<div class="card-body">
										<blockquote class="blockquote mb-0 text-light">

											<div action="" method="post" class="form-horizontal"> 
													<div class="row form-group">
												<div class="col col-md-6">
												<input type="file" id="reportfile" name="file-input" > 
											   
												</div>
												<div class="col col-md-6">
													<button type="submit" onclick="jqSubmit();" class="btn btn-primary btn-lg">提交报告</button>
											
												</div>
											</div>
											
											</div>

											<footer class="blockquote-footer text-light">
												选择你的报告文件，然后点击<cite title="Source Title">提交报告</cite>
											</footer>
										</blockquote>
									</div>
								</div>
							</div>




						</div>
					</div>
					<!-- /.card -->
				</div>
				<!-- /.col-lg-8 -->


			</div>
			<!-- .row -->
		</div>
		<!-- .animated -->
	</div>
	<!-- .content -->

	<script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>


</body>

</html>