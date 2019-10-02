$(document).ready(function () {
	var $wrapper = $('#wrap-content');
	var orderId;
	//仅选择日期
	$("#excdate").datetimepicker({
		//language: "zh-CN",
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0,
		format: "yyyy-mm-dd"
	});
	//提交按钮
	$("#btn1").click(function () {
		var excdate = $("#excdate").val();
		var facname = $("#facname").val();
		var facaddress = $("#facaddress").val();
		var facman = $("#facman").val();
		var factel = $("#factel").val();
		var profile = $("#profile").val();
		var goods = $("#goods").val();
		var type = $("#select").val();
		var goodsType = $("#goodsselect").val();
		console.log(excdate + "\t" + facname + "\t" + facaddress + "\t" + facman + "\t" + factel + "\t" + profile + "\t" + goods + "\t" + type + "\t" + goodsType)
		if (excdate == "") {
			$('.hxy-alert').removeClass('hxy-alert-success')
			$('.hxy-alert').html('请选择验货日期').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
			return false;
		}
		if (facname == "") {
			$('.hxy-alert').removeClass('hxy-alert-success')
			$('.hxy-alert').html('请填写工厂名称').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
			return false;
		}

		var file_obj = document.getElementById('afile').files[0];
		var fd = new FormData();
		fd.append('excdate', excdate)
		fd.append('facname', facname);
		fd.append("facaddress", facaddress);
		fd.append("facman", facman);
		fd.append("factel", factel);
		fd.append("profile", profile);
		fd.append("goods", goods);
		fd.append("type", type);
		fd.append("goodsType", goodsType);
		fd.append("file", file_obj);
		fd.append("post_type", 'unpay');//提交未付款
		//		document.getElementById('fade').style.display = 'block';
		//		document.getElementById('pay').style.display = 'block';

		//手动控制遮罩
		$wrapper.spinModal();
		$.ajax({
			//几个参数需要注意一下
			url: getRootPath() + "/cusInsertOrder",//url
			type: "POST",//方法类型
			async: false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。
			dataType: "json",//预期服务器返回的数据类型
			cache: false,
			data: fd,//这个是发送给服务器的数据
			processData: false, //tell jQuery not to process the data
			contentType: false, //tell jQuery not to set contentType
			success: function (result) {
				console.log(result);//打印服务端返回的数据(调试用)
				if (result.resultCode == 200) {
					//服务器成功保存之后，开始付款
					//关闭遮罩
					$wrapper.spinModal(false);
					//跳转到首页	$('.hxy-alert').removeClass('hxy-alert-success')


					if (result.fresh) {
						document.getElementById('fresh').style.display = 'block'
						document.getElementById('fade').style.display = 'block';
					} else {
						console.log("老用户")
						document.getElementById('fade').style.display = 'block'
						document.getElementById('pay').style.display = 'block';
						$("#cusMoney").html(result.cusMoney);
						$("#billPrice").html(result.billPrice);
						orderId = result.orderId;
						//先判断是否为新人

						if (result.moneyStatus == 1) {
							console.log("余额充足")
							//余额充足，继续支付
						} else if (result.moneyStatus == 0) {
							//余额不足，支付按钮改成充值
							console.log("余额不足")
							$('#moneyStatus').removeClass('fade')
							$("#payBtn").html("充值");
							$("#payBtn").val("充值");
						}
					}

				} else if (result.resultCode == 607) {
					// 等待开发
					//	$(this).remove();
					// $('.hxy-alert').removeClass('hxy-alert-success')
					// $('.hxy-alert').html('余额不足').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
					// document.getElementById("passwd").value = ''
				} else if (result.resultCode == 404) {
					//	$(this).remove();
					$('.hxy-alert').removeClass('hxy-alert-success')
					$('.hxy-alert').html('手机号未注册').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
				} else if (result.resultCode == 604) {
					//跳转到首页
					window.location.href = 'login';
				}
				;
			},
			error: function () {
				//console.log(data);
				$('.hxy-alert').removeClass('hxy-alert-success')
				$('.hxy-alert').html('检查网络是否连接').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
			}
		});
	});

	//保存草稿
	$("#btn3").click(
		function () {
			var excdate = $("#excdate").val();
			var facname = $("#facname").val();
			var facaddress = $("#facaddress").val();
			var facman = $("#facman").val();
			var factel = $("#factel").val();
			var profile = $("#profile").val();
			var goods = $("#goods").val();
			var type = $("#select").val();
			var goodsType = $("#goodsselect").val();

			console.log(excdate + "\t" + facname + "\t" + facaddress + "\t" + facman + "\t" + factel + "\t" + profile + "\t" + goods + "\t" + type + "\t" + goodsType)
			var file_obj = document.getElementById('afile').files[0];
			var fd = new FormData();
			fd.append('excdate', excdate)
			fd.append('facname', facname);
			fd.append("facaddress", facaddress);
			fd.append("facman", facman);
			fd.append("factel", factel);
			fd.append("profile", profile);
			fd.append("goods", goods);
			fd.append("type", type);
			fd.append("goodsType", goodsType);
			fd.append("file", file_obj);
			fd.append("post_type", 'temp');//按钮的请求类型

			$.ajax({
				//几个参数需要注意一下
				url: getRootPath() + "/cusInsertOrder",//url
				type: "POST",//方法类型
				async: false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。
				dataType: "json",//预期服务器返回的数据类型
				cache: false,
				data: fd,//这个是发送给服务器的数据
				processData: false,  //tell jQuery not to process the data
				contentType: false,  //tell jQuery not to set contentType
				success: function (result) {
					console.log(result);//打印服务端返回的数据(调试用)
					if (result.resultCode == 200) {
						//跳转到首页	
						$('.hxy-alert').removeClass('hxy-alert-warning')
						$('.hxy-alert').html('草稿保存成功').addClass('hxy-alert-success').show().delay(2000).fadeOut();
						document.getElementById("excdate").value = ''
						document.getElementById("facname").value = ''
						document.getElementById("facaddress").value = ''
						document.getElementById("facman").value = ''
						document.getElementById("factel").value = ''
						document.getElementById("profile").value = ''
						document.getElementById("goods").value = ''
						document.getElementById("afile").value = ''
					} else if (result.resultCode == 601) {
						//	$(this).remove();
						$('.hxy-alert').removeClass('hxy-alert-success')
						$('.hxy-alert').html('密码错误').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
						document.getElementById("passwd").value = ''
					} else if (result.resultCode == 404) {
						//	$(this).remove();
						$('.hxy-alert').removeClass('hxy-alert-success')
						$('.hxy-alert').html('手机号未注册').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
					} else if (result.resultCode == 604) {
						//跳转到首页
						window.location.href = 'login';
					};
				},
				error: function () {
					$('.hxy-alert').removeClass('hxy-alert-success')
					$('.hxy-alert').html('检查网络是否连接').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
				}
			});
		});
	//取消按钮
	$("#btn2").click(function () {
		document.getElementById("excdate").value = ''
		document.getElementById("facname").value = ''
		document.getElementById("facaddress").value = ''
		document.getElementById("facman").value = ''
		document.getElementById("factel").value = ''
		document.getElementById("profile").value = ''
		document.getElementById("goods").value = ''
	});

	//支付按钮
	$("#payBtn").click(function () {
		//获取按钮的值
		var value = $("#payBtn").val();
		console.log(value)
		if (value == "充值") {
				//跳转到首页
				window.location.href = 'wallet';
		} else {

			$.ajax({
				type: 'POST',
				url: getRootPath() + '/orderPay',
				data: {
					'orderId': orderId,
					'pay': 'true'
				},
				dataType: "json",//预期服务器返回的数据类型
				success: function (result) {
					if (result.resultCode == 200) {
						//支付成功
						$('.hxy-alert').removeClass('hxy-alert-warning')
						$('.hxy-alert').html('支付成功').addClass('hxy-alert-success').show().delay(2000).fadeOut();
						document.getElementById('pay').style.display = 'none';
						document.getElementById('fade').style.display = 'none';

					} else if (result.resultCode == 607) {
						//支付失败
						$('.hxy-alert').removeClass('hxy-alert-success')
						$('.hxy-alert').html('余额不足').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
						document.getElementById('pay').style.display = 'none';
						document.getElementById('fade').style.display = 'none';
						// 弹出一个提示界面，然后有两个按钮。退出和跳转支付界面
					}
					else {
						//支付失败
						$('.hxy-alert').removeClass('hxy-alert-success')
						$('.hxy-alert').html('支付失败').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
						document.getElementById('pay').style.display = 'none';
						document.getElementById('fade').style.display = 'none';
					}

				}
			});

			document.getElementById("excdate").value = ''
			document.getElementById("facname").value = ''
			document.getElementById("facaddress").value = ''
			document.getElementById("facman").value = ''
			document.getElementById("factel").value = ''
			document.getElementById("profile").value = ''
			document.getElementById("goods").value = ''
		}
	});

});


function getRootPath() {
	//获取当前网址，如： http://localhost:8088/test/test.jsp
	var curPath = window.document.location.href;
	//获取主机地址之后的目录，如： test/test.jsp
	var pathName = window.document.location.pathname;
	var pos = curPath.indexOf(pathName);
	//获取主机地址，如： http://localhost:8088
	var localhostPath = curPath.substring(0, pos);
	//获取带"/"的项目名，如：/test
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	return (localhostPath + projectName);//发布前用此
}

