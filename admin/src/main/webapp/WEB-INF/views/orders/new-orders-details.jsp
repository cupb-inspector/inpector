<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>新订单详情</title>
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
    <script src="js/jquery.min.js"></script>
    <!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->
    <link rel="stylesheet" href="hxy/css/hxy-alert.css">
    <script src="hxy/js/hxy-alert.js"></script>
    <style>
        .black_overlay {
            display: none;
            position: fixed;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index: 1001;
            -moz-opacity: 0.8;
            opacity: .80;
            filter: alpha(opacity=80);
        }

        .white_content {
            display: none;
            position: fixed;
            top: 10%;
            left: 10%;
            width: 80%;
            height: 80%;
            border: 16px solid lightblue;
            background-color: white;
            z-index: 1002;
            overflow: auto;
        }

    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#showInspector").click(function () {
                document.getElementById('MyDiv').style.display = 'block';
                document.getElementById('fade').style.display = 'block';
                var bgdiv = document.getElementById('fade');
                bgdiv.style.width = document.body.scrollWidth; // bgdiv.style.height = $(document).height();
                $("#fade").height($(document).height());
            });

            $("#closeInspector").click(function () {
                document.getElementById('MyDiv').style.display = 'none';
                document.getElementById('fade').style.display = 'none';
            });
            $('.selectInspector').click(function () {
                var inspId = $(this).val();//质检员id
                var ordersId = $('#ordersId').text();//订单id
                console.log(inspId + "\t" + ordersId);

                $.ajax({
                    //几个参数需要注意一下
                    url: "${pageContext.request.contextPath}/assign",//url
                    type: "POST",//方法类型
                    //	async: false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。
                    dataType: "json",//预期服务器返回的数据类型
                    //	cache: false,
                    data: {
                        "tel": inspId,
                        "id": ordersId
                    },//这个是发送给服务器的数据

                    success: function (result) {
                        console.log(result);//打印服务端返回的数据(调试用)
                        if (result.resultCode == 200) {
                            //$('#closeInspector').click();
                            document.getElementById('MyDiv').style.display = 'none';
                            document.getElementById('fade').style.display = 'none';
                            //跳转到首页
                            $('.hxy-alert').removeClass('hxy-alert-warning')
                            $('.hxy-alert').html('分配成功').addClass('hxy-alert-success').show().delay(2000).fadeOut();

                        } else if (result.resultCode == 601) {
                            //	$(this).remove();
                            $('.alert').removeClass('alert-success')
                            $('.alert').html('密码错误').addClass('alert-warning').show().delay(2000).fadeOut();

                            document.getElementById("passwd").value = ''

                        } else if (result.resultCode == 404) {
                            //	$(this).remove();
                            $('.alert').removeClass('alert-success')
                            $('.alert').html('手机号未注册').addClass('alert-warning').show().delay(2000).fadeOut();
                        }
                        ;
                    },
                    error: function () {
                        //console.log(data);
                        $('.alert').removeClass('alert-success')
                        $('.alert').html('检查网络是否连接').addClass('alert-warning').show().delay(2000).fadeOut();

                    }
                });
            })
        });
    </script>
</head>

<body>
<div class="hxy-alert"></div>
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
                            <div class="card border"
                                 style="background-color: #e2e3e5; border-color: #d6d8db; color: #383d41">
                                <div class="card-body">
                                    <p style="color: #383d41">
                                    <h4>订单信息</h4>
                                    <small>订单可以在验货日期的24小时前取消。24小时内取消会扣分。</small>
                                    <code>重要</code>
                                    </p>
                                    <form action=" #" method="post" class="form-horizontal">
                                        <div class="row form-group">
                                            <div class="col col-md-6">
                                                <p>
                                                    订单号：<span id='ordersId' value='${orders.orderid}'>${orders.orderid}</span>
                                                </p>
                                            </div>
                                            <div class="col col-md-6">
                                                <p>
                                                    订单状态：<span>${orders.statusString}</span>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="row form-group">
                                            <div class="col col-md-4">
                                                <p>
                                                    验货时间：<span>${orders.excedate}</span>
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
                                                    产品信息：<span>${orders.goods}</span>
                                                </p>
                                            </div>
                                            <div class="col col-md-4">
                                                <p>
                                                    工厂名称：<span>${orders.factoryname}</span>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="row form-group">
                                            <div class="col col-md-4">
                                                <p>
                                                    工厂地址：<span>${orders.factoryaddress}</span>
                                                </p>
                                            </div>
                                            <div class="col col-md-4">
                                                <p>
                                                    联系人姓名：<span>${orders.factoryname}</span>
                                                </p>
                                            </div>
                                            <div class="col col-md-4">
                                                <p>
                                                    手机号：<span>${orders.factorytel}</span>
                                                </p>
                                            </div>
                                        </div>
                                        <hr/>
                                        <div class="row form-group">
                                            <div class="col col-md-4">
                                                <p>
                                                    下单日期：<span>${orders.date}</span>
                                                </p>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="card border"
                                 style="background-color: #d1ecf1; border-color: #bee5eb; color: #0c5460">

                                <div class="card-body">
                                    <p style="color: #383d41">
                                    <h4>附件</h4>
                                    <small>管理员需要审核附件中信息是否存在异常，可以更新该附件，然后批准给质检员下载。</small>
                                    <code>重要</code>
                                    </p>
                                    <p>
                                        <i class="fa fa-envelope-o"></i> ${orders.file}
                                        <a href="downloadFile?fileuuid=${orders.fileuuid}&filename=${orders.file}">
                                            <span class="pull-right">下载</span></a>
                                    </p>
                                    <p>
                                    <div style="float: left">
                                        <button type="button" id="btn1" class="btn btn-success btn-lg">通过</button>
                                        <button type="button" id="btn2"  class="btn btn-danger btn-lg">更新</button>
                                    </div>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.card -->
            </div>
            <!-- /.col-lg-8 -->

            <div class="col-xl-4">
                <div class="">
                    <div class="col-lg-6 col-xl-12">
                        <div class="card br-0">
                            <div class="card">
                                <div class="card-header">
                                    <i class="fa fa-user"></i><strong class="card-title pl-2">客户资料</strong>
                                </div>
                                <div class="card-body">
                                    <div class="mx-auto d-block">
                                        <img class="rounded-circle mx-auto d-block" src="images/admin.jpg"
                                             alt="Card image cap">
                                        <h5 class="text-sm-center mt-2 mb-1">${cusUser.cusname}</h5>
                                        <div class="location text-sm-center">
                                            <i class="fa fa-map-marker"></i> ${cusUser.city}
                                        </div>
                                    </div>
                                    <br/>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="#"> <i class="fa fa-envelope-o"></i> 邮箱
                                            <span class="pull-right">${cusUser.email }</span></a>
                                        </li>
                                        <li class="list-group-item"><a href="#"> <i class="fa fa-tasks"></i> 总订单数 <span
                                                class="pull-right">${cusUser.cusOrders}</span></a>
                                        </li>
                                        <li class="list-group-item"><a href="#"> <i class="fa fa-money"></i> 钱包 <span
                                                class="pull-right">${cusUser.cusMoney}</span></a>
                                        </li>
                                        <li class="list-group-item"><a href="#"> <i class="fa fa-star-o"></i> 积分<span
                                                class="pull-right r-activity">${cusUser.custrade}</span></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.card -->
                    <div class="col-lg-6 col-xl-12">
                        <div class="card br-0  ">
                            <div class="card">
                                <div class="card-header">
                                    <i class="fa fa-user"></i><strong class="card-title pl-2">验货员资料</strong>
                                </div>
                                <div class="card-body">
                                    <div class="mx-auto d-block col-sm-4" style="float: left">
                                        <img class="rounded-circle mx-auto d-block" src="images/admin.jpg"
                                             alt="Card image cap">
                                        <h5 class="text-sm-center mt-2 mb-1">待选择</h5>
                                        <div class="location text-sm-center"><i class="fa fa-map-marker"></i>
                                            有待确定
                                        </div>
                                    </div>
                                    <div class="col-sm-8" align="center">
                                        <div>
                                            <button id="showInspector" type="submit" class="btn btn-primary btn-sm">
                                                <i class="fa fa-pencil-square-o"></i> 选择质检员
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.col-md-4 -->
            </div>
        </div>
        <!-- .row -->
    </div>
    <!-- .animated -->
    <!-- .content -->
    <!-- 下面的内容是那个质检员选择的界面 -->
    <!--弹出层时背景层DIV-->
    <div id="fade" class="black_overlay"></div>
    <div id="MyDiv" class="white_content">

        <div style="text-align: right; cursor: default; height: 40px;">
            <span style="font-size: 16px;" id='closeInspector'>关闭</span>
        </div>
        <div class="content" style="background:#f1f2f7;height: 100%">
            <div class="animated fadeIn">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">
                                    验货员
                                </strong>
                            </div>
                            <div class="card-body">
                                <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>姓名</th>
                                        <th>电话</th>
                                        <th>城市</th>
                                        <th>历史订单数</th>
                                        <th>积分</th>
                                        <th>状态</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!-- 显示质检员信息 -->
                                    <c:forEach items="${list}" var="inspector" varStatus="status">
                                        <tr>
                                            <td>${status.index +1 }</td>
                                            <td>${inspector.userName }</td>
                                            <td>${inspector.userTel }</td>
                                            <td>${inspector.city }</td>
                                            <td>${inspector.orders }</td>
                                            <td>${inspector.integral}</td>
                                            <td>${inspector.status}</td>
                                            <td>	<button type="button"  value ='${inspector.userId}'
                                                            class="selectInspector btn btn-outline-success btn-sm"><i class="fa fa-magic"></i>&nbsp; 选择</button></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- .animated -->
        </div><!-- .content -->
    </div>
    <div class="clearfix"></div>

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