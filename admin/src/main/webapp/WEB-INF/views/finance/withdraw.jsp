<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/commons.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>提现管理</title>
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
    <script type="text/javascript">
        function verifyReport2(e, id, flag) {

            //e是获取当前标签元素对象。parentNode是获取父类元素对象
            var thisE = e.parentNode;
            console.log(thisE.id)

            // document.getElementById("btn").setAttribute("disabled", true);
            //  document.getElementById("btn1").setAttribute("disabled", true);
            $.ajax({
                //几个参数需要注意一下
                url: "${pageContext.request.contextPath}/account-verify",//url
                type: "POST",//方法类型
                async: false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

                dataType: "json",//预期服务器返回的数据类型
                cache: false,
                data: {
                    "id": id,
                    "flag": flag
                },//这个是发送给服务器的数据

                success: function (result) {
                    console.log(result);//打印服务端返回的数据(调试用)
                    if (result.resultCode == 200) {
                        //跳转到首页		$('.alert').removeClass('alert-success')
                        $('.alert').html('报告审核通过').addClass('alert-success').show().delay(2000).fadeOut();
                        if (flag == "conform") {
                            thisE.innerHTML = "已通过"
                        } else if (flag == "cancel") {
                            thisE.innerHTML = "已拒绝"
                        }
                        var value;
                        switch (result.resultStatus) {

                            case 1:
                                value = "充值失败";
                                break;
                            case 2:
                                value = "充值成功";
                                break;
                            case 3:
                                value = "提现失败";
                                break;
                            case 4:
                                value = "提现成功";
                                break;
                        }
                        thisE.previousElementSibling.innerHTML = value;
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
        }
    </script>
</head>
<body>
<div class="content" style="background:#f1f2f7;height: 100%">
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">提现统计</strong>
                    </div>
                    <div class="card-body">
                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th>提现时间</th>
                                <th>用户ID</th>
                                <th>金额</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${list}" var="account" varStatus="status">
                                <tr>
                                    <td>${account.time }</td>
                                    <td>${account.userId }</td>
                                    <td>${account.value}</td>
                                    <td>${account.statusString}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${account.status==0}">
                                                <button type="button"
                                                        onclick="verifyReport2(this,${account.id},'conform')"
                                                        class="btn btn-success btn-sm">通过
                                                </button>
                                                <button type="button"
                                                        onclick="verifyReport2(this,${account.id},'cancel')"
                                                        class="btn btn-danger btn-sm">拒绝
                                                </button>
                                            </c:when>

                                            <c:otherwise>
                                                否则1通过2拒绝
                                            </c:otherwise>
                                        </c:choose>


                                    </td>


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
    $(document).ready(function () {
        $('#bootstrap-data-table').DataTable({
            destroy: true,
            "order": [0, "desc"]
        });

    });
</script>


</body>
</html>
