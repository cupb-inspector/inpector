<jsp:include page="/WEB-INF/views/commons.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<%
AdminUserService cusUserService = new AdminUserService();
List< AdminUser> c=   cusUserService.selectAll();
%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>管理员</title>
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
    <link href="assets/weather/css/weather-icons.css" rel="stylesheet" />
    <link href="assets/calendar/fullcalendar.css" rel="stylesheet" />
    <link href="assets/css/charts/chartist.min.css" rel="stylesheet">
    <link href="assets/css/lib/vector-map/jqvmap.min.css" rel="stylesheet">
  <script src="js/jquery.min.js"></script>
  <!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->

  <script src="hxy/js/hxy-alert.js"></script>
  <link rel="stylesheet" href="hxy/css/hxy-alert.css">
    <style>
            .white_content { 
            display: none; 
            position: absolute; 
            top: 15%; 
            left: 25%; 
            width: 55%; 
            height: 55%; 
            padding: 20px; 
            
            z-index:1002; 
        } 
        .black_overlay{ 
            display: none; 
            position: absolute; 
            top: 0%; 
            left: 0%; 
            width: 100%; 
            height: 100%; 
            background-color:dimgray; 
            z-index:1001; 
            -moz-opacity: 0.8; 
            opacity:.80; 
            filter: alpha(opacity=88); 
        } 
        html,
        body {
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
    </style>
</head>

<body>
<div class="hxy-alert"></div>
    <!-- Content -->
    <div class="content" style="background:#f1f2f7; height: 100%;">
        <!-- Animated -->
        <div class="animated fadeIn">
            <div class='row'>
                <div class="col-lg-6 col-md-6 col-sd-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="stat-widget-one">
                                <div class="stat-icon dib"><i class="ti-user text-primary border-primary"></i></div>
                                <div class="stat-content dib">
                                    <div class="stat-text">超级管理员</div>
                                    <div class="stat-digit">1</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--fist_col-->
                <div class="col-lg-6 col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-user text-success border-success"></i></div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">普通管理员</div>
                                        <div class="stat-digit"><%=c.size() %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--second-->
            </div>
            <!--table-->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <strong class="card-title">管理员</strong>
                            <a href = "JavaScript:void(0)" onclick = "openDialog()">
                                <span class="badge badge-success float-right mt-1">+ 添加管理员</span>
                           
                            </a>
                        </div>
                        <div class="table-stats order-table ov-h">
                           <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>电话</th>
                                            <th>昵称</th>
                                            <th>邮箱</th>
                                            <th>权限</th>  
                                             <th>时间</th>                                             
                                            <th>操作</th>           
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                 if(c!=null&&c.size()!=0){
                                	 for(int i=0;i<c.size();i++){
                                		 AdminUser cus = c.get(i);
                                		 %>
                                		    <tr>
                                            <td><%=cus.getAdminTel() %></td>
                                            <td><%=cus.getAdminName()%></td>
                                            <td><%=cus.getAdminEmail() %></td>
                                            <td><%=cus.getAdminGrade() %></td>
                                            <td><%=cus.getAdminDate() %></td>
                                            <td >
                                                <a href = "JavaScript:void(0)" onclick = "openDialogl()" style="color:blue">详细</a>
                                            </td>
                                        </tr>
                                		 <%
                                	 }
                                 }
                                    %>
                                    </tbody>
                            </table>
                        </div> <!-- /.table-stats -->
                    </div>
                </div>
            </div>
            <!--/table-->

            <!-- Modal - Calendar - Add New Event -->
            <div class="modal fade none-border" id="event-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><strong>Add New Event</strong></h4>
                        </div>
                        <div class="modal-body"></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default waves-effect"
                                data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-success save-event waves-effect waves-light">Create
                                event</button>
                            <button type="button" class="btn btn-danger delete-event waves-effect waves-light"
                                data-dismiss="modal">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#event-modal -->
            <!-- Modal - Calendar - Add Category -->
            <div class="modal fade none-border" id="add-category">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><strong>Add a category </strong></h4>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="control-label">Category Name</label>
                                        <input class="form-control form-white" placeholder="Enter name" type="text"
                                            name="category-name" />
                                    </div>
                                    <div class="col-md-6">
                                        <label class="control-label">Choose Category Color</label>
                                        <select class="form-control form-white" data-placeholder="Choose a color..."
                                            name="category-color">
                                            <option value="success">Success</option>
                                            <option value="danger">Danger</option>
                                            <option value="info">Info</option>
                                            <option value="pink">Pink</option>
                                            <option value="primary">Primary</option>
                                            <option value="warning">Warning</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default waves-effect"
                                data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-danger waves-effect waves-light save-category"
                                data-dismiss="modal">Save</button>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /#add-category -->
        </div>
        <!-- .animated -->
                <!--点击添加管理员-->
        <div id="light" class="white_content">
                <div class="card">
                        <div class="card-header">
                            <strong class="card-title">管理员添加</strong>
                        </div>
                        <div class="card-body">
                            <div action="register-user" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="row form-group">
                                        <div class="col col-md-3"><label for="text-input" class=" form-control-label">姓名</label></div>
                                        <div class="col-12 col-md-9"><input type="text" id="name" name="username" placeholder="name" class="form-control"></div>
                                    </div>
                                    <div class="row form-group">
                                            <div class="col col-md-3"><label for="text-input" class=" form-control-label">账号</label></div>
                                            <div class="col-12 col-md-9"><input type="text" id="tel" name="account" placeholder="account" class="form-control"></div>
                                        </div>
                                        <div class="row form-group">
                                                <div class="col col-md-3"><label for="text-input" class=" form-control-label">密码</label></div>
                                                <div class="col-12 col-md-9"><input type="password" name ='passwd'id="passwd" class="form-control" placeholder="password" value="111111"><small class="form-text text-muted">密码初始值为6个1</small></div>
                                            </div>
                                        <div class="row form-group">
                                                <div class="col col-md-3"><label for="select" class=" form-control-label">管理员权限</label></div>
                                                <div class="col-12 col-md-9">
                                                    <select name="select" name='role' id="role" class="form-control">
                                                      
                                                        <option value="1">普通管理员</option>
                                                        <option value="2">超级管理员</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-actions form-group">
                                               
                                                    <button id = 'submitbtn1' class="btn btn-primary btn-sm">
                                                            <i class="fa fa-dot-circle-o"></i> 提交
                                                        </button>
                                                        <a href = "javascript:void(0)" onclick = "closeDialog()">
                                                        <button type="reset" class="btn btn-danger btn-sm">
                                                            <i class="fa fa-ban"></i> 取消
                                                        </button>
                                                    </a>
                                                    
                                                </div>

                            </div>

                        </div><!--/.card-body-->
                    </div> <!-- /.card -->
               
            </div> 
            <div id="fade" class="black_overlay"></div>
        <!--/点击添加管理员-->
        <!--点击修改管理员权限-->
        <div id="light-l" class="white_content">
                <div class="card">
                        <div class="card-header">
                            <strong class="card-title">管理员修改</strong>
                        </div>
                        <div class="card-body">
                            <form action="#" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="row form-group">
                                        <div class="col col-md-3"><label class=" form-control-label">姓名</label></div>
                                        <div class="col-12 col-md-9">
                                                <p class="form-control-static">开发中</p>
                                            </div>
                                    </div>
                                    <div class="row form-group">
                                            <div class="col col-md-3"><label class=" form-control-label">账号</label></div>
                                            <div class="col-12 col-md-9">
                                                    <p class="form-control-static">18175306921</p>
                                                </div>
                                        </div>
                                        <div class="row form-group">
                                                <div class="col col-md-3"><label for="select" class=" form-control-label">管理员权限</label></div>
                                                <div class="col-12 col-md-9">
                                                    <select name="select" id="select" class="form-control">
                                                        <option value="0">请选择管理员权限</option>
                                                        <option value="1">普通管理员</option>
                                                        <option value="2">超级管理员</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-actions form-group">
                                                    <a href = "javascript:void(0)" onclick = "closeDialogl()">
                                                    <button type="submit" class="btn btn-primary btn-sm">
                                                            <i class="fa fa-dot-circle-o"></i> 提交
                                                        </button></a>
                                                        <a href = "javascript:void(0)" onclick = "closeDialogl()">
                                                        <button type="reset" class="btn btn-danger btn-sm">
                                                            <i class="fa fa-ban"></i> 取消
                                                        </button>
                                                    </a>
                                                </div>
                            </form>

                        </div><!--/.card-body-->
                    </div> <!-- /.card -->
               
            </div> 
            <div id="fade" class="black_overlay"></div> 
        <!--/点击修改管理员权限-->

    </div>
    <!-- /.content -->
    <div class="clearfix"></div>
    <!-- Footer -->

    <!-- /.site-footer -->

    <!-- /#right-panel -->

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

    <!--Local Stuff-->
    <script>

    function openDialog(){
        document.getElementById('light').style.display='block';
        document.getElementById('fade').style.display='block'
    }
    function closeDialog(){
        document.getElementById('light').style.display='none';
        document.getElementById('fade').style.display='none'
    }
    function openDialogl(){
        document.getElementById('light-l').style.display='block';
        document.getElementById('fade').style.display='block'
    }
    function closeDialogl(){
        document.getElementById('light-l').style.display='none';
        document.getElementById('fade').style.display='none'
    }
    
    //添加管理员
     $(document).ready(function () {
      $("#submitbtn1").click(function () {
    	  var tel =$("#tel").val()
    	  var passwd=$("#passwd").val()
    	  var name =$("#name").val()
    	  var role =$("#role").val()
    	  console.log(name+"\t"+passwd)
    	  if(name==""){
    			$('.hxy-alert').removeClass('hxy-alert-success')
				$('.hxy-alert').html('请输入手机号码').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    		  return false;
    	  }
    	  if(passwd==""){
  			$('.hxy-alert').removeClass('hxy-alert-success')
				$('.hxy-alert').html('请输入密码').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
				
  		  return false;
  	  }
    		$.ajax({
    			//几个参数需要注意一下
    			url : "${pageContext.request.contextPath}/register-user",//url
    			type : "POST",//方法类型
    			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

    			dataType : "json",//预期服务器返回的数据类型
    			cache : false,
    			data : {
    				'name':name,
    				"tel" : tel,
    				"passwd":passwd,
    				'role':role
    			},//这个是发送给服务器的数据

    			success : function(result) {
    				console.log(result);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					closeDialog()
    					$('.hxy-alert').removeClass('hxy-alert-warning')
    					$('.hxy-alert').html('添加成功').addClass('hxy-alert-success').show().delay(2000).fadeOut();
    				} else if (result.resultCode == 601) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('添加失败').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
        				
    					document.getElementById("passwd").value=''
    					
    				}else if (result.resultCode == 404) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('手机号未注册').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				}else if (result.resultCode == 101) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('账号已经存在').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				};
    			},
    			error : function() {
    				//console.log(data);
    				$('.hxy-alert').removeClass('hxy-alert-success')
					$('.hxy-alert').html('检查网络是否连接').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    			}
    		});
        });
    });
    </script>
</body>

</html>