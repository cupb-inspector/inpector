<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>订单取消</title>
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
    function rob(e,id,flag) {
    	  
    	  console.log(id+"\t");
    		$.ajax({
    			//几个参数需要注意一下
    			url : "${pageContext.request.contextPath}/conform",//url
    			type : "POST",//方法类型
    			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

    			dataType : "json",//预期服务器返回的数据类型
    			cache : false,
    			data : {
    				"id" : id,
    				"flag":flag
    			},//这个是发送给服务器的数据

    			success : function(result) {
    				console.log(result);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					//跳转到首页		$('.alert').removeClass('alert-success')
    					$('.alert').html('抢单成功').addClass('alert-success').show().delay(2000).fadeOut();
        				
    				} else if (result.resultCode == 601) {
    					//	$(this).remove();
    					$('.alert').removeClass('alert-success')
    					$('.alert').html('密码错误').addClass('alert-warning').show().delay(2000).fadeOut();
        				
    					document.getElementById("passwd").value=''
    					
    				}else if (result.resultCode == 404) {
    					//	$(this).remove();
    					$('.alert').removeClass('alert-success')
    					$('.alert').html('手机号未注册').addClass('alert-warning').show().delay(2000).fadeOut();
        				
    					
    				};
    			},
    			error : function() {
    				//console.log(data);
    				$('.alert').removeClass('alert-success')
					$('.alert').html('检查网络是否连接').addClass('alert-warning').show().delay(2000).fadeOut();
    				
    			}
    		});
    }
      
    </script>



</head>
<body>

	<div class="content" style="background: #f1f2f7; height: 100%">
		<div class="animated fadeIn">
			<div class="row">

				<div class="col-md-12">
					<div class="card">
							<div class="card-header">
								<h4>详情</h4>
							</div>
							<div class="card-body">
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
					
								<div class="card">
                                <div class="card-header">
                                    <strong>确认订单 </strong>
                                    <small>订单可以在验货日期的24小时前取消。24小时内取消会扣分。
                                        <code>重要</code>
                                    </small>
                                </div>
                                <div class="card-body">
                                    <button type="button"  onclick="rob(this,${ordersId},'conform')" class="btn btn-success btn-lg">接受</button>
                                    <button type="button"  onclick="rob(this,${ordersId},'cancel')" class="btn btn-danger btn-lg">拒绝</button>
                                </div>
                            </div><!-- /# card -->

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
