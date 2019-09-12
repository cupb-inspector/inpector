<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons.jsp"/>
<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>个人中心</title>
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
    <link href="assets/weather/css/weather-icons.css" rel="stylesheet" />
    <link href="assets/calendar/fullcalendar.css" rel="stylesheet" />
    <link href="assets/css/charts/chartist.min.css" rel="stylesheet">
    <link href="assets/css/lib/vector-map/jqvmap.min.css" rel="stylesheet">
	<script src="js/jquery.min.js"></script>
	<!--基于jQuery写的消息提示
  https://www.awaimai.com/1627.html
    -->
	<link rel="stylesheet" href="hxy/css/hxy-alert.css">
	<script src="hxy/js/hxy-alert.js"></script>
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
</head>

<body>
	<div class="hxy-alert"></div>
        <!-- Content -->
                <div class="content"  style="background:#f1f2f7;height: 100%;">
            <!-- Animated -->
            <div class="animated fadeIn">
                <!-- Widgets  -->

                <!-- /Widgets -->
                <!--  moneytable  -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4>个人中心</h4>
                            </div>
                            <div class="card-body">
                                <div class="default-tab">
                                    <nav>
                                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab"
                                                href="#nav-home" role="tab" aria-controls="nav-home"
                                                aria-selected="true">
                                                <h4>基本资料</h4>
                                            </a>
                                            <!-- 
                                            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab"
                                                href="#nav-profile" role="tab" aria-controls="nav-profile"
                                                aria-selected="false">
                                                <h4>账户安全</h4>

                                            </a>
                                            <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab"
                                                href="#nav-contact" role="tab" aria-controls="nav-contact"
                                                aria-selected="false">
                                                <h4>公司资料</h4>
                                            </a>
 -->
                                        </div>
                                    </nav>
                                    <div class="tab-content pl-3 pt-2" id="nav-tabContent">
                                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel"
                                            aria-labelledby="nav-home-tab">
                                            <div class="card">

                                                <div class="card-body">
                                                    <div class="mx-auto d-block">
                                                        <img class="rounded-circle mx-auto d-block"
                                                            src="images/admin.jpg" alt="Card image cap">
                                                        <br />
                                                        
                                                             <!--  
                                                        <div class="location text-sm-center">
                                                            <button type="submit" class="btn btn-primary btn-sm">
                                                                <i class="fa fa-pencil-square-o"></i> 修改头像
                                                            </button>
                                                        </div>
                                                   
                                                        <div class="text-sm-center mt-2 mb-1">

                                                            <i>请点击“保存”按钮保存头像</i>
                                                        </div>
                                                        -->
                                                    </div>
                                                    <hr>
                                                    <div class="card-text text-sm-center">
                                                    
                                            <table class="table">
                                                <tr>
                                                    <td><i class='fa fa-check-circle'
                                                            style='color:forestgreen'></i> 用户名</td>
                                                    <td >${cusUser.cusname}</td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><i class='fa fa-check-circle' style='color:forestgreen'></i> 手机号码
                                                    </td>
                                                    <td>${cusUser.custel}</td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><i class='fa fa-exclamation-circle'
                                                            style='color:chocolate'></i> 登录密码</td>
                                                    <td>********</td>
                                                    <td><a class='connect' href = "JavaScript:void(0)" onclick = "openDialog()" style='color:mediumblue'>修改登录密码</a>
                                                    </td>
                                                </tr>
                                                <!-- 
                                                <tr>
                                                    <td><i class='fa fa-exclamation-circle'
                                                            style='color:chocolate'></i> 币种选择</td>
                                                    <td>      <select name="select" id="select"
                                                                        class="form-control">
                                                                        <option value="0">Please select</option>
                                                                        <option value="1">人民币</option>
                                                                        <option value="2">美元</option>
                                                                    </select></td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'></a>
                                                    </td>
                                                </tr>
                                                 -->
                                                <tr>
                                                    <td><i class='fa fa-check-circle' style='color:forestgreen'></i> 绑定邮箱
                                                    </td>
                                                    <td><div id ="displayEmail">${cusUser.email}</div></td>
                                                    <td><a class='connect' href = "JavaScript:void(0)" onclick = "openEmail()" style='color:mediumblue'>修改邮箱</a>
                                                   
                                                    </td>
                                                </tr>
                                            </table>
                                                    
                                                    
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="tab-pane fade" id="nav-profile" role="tabpanel"
                                            aria-labelledby="nav-profile-tab">
                                            <div class="col-lg-4">
                                                <section class="card">
                                                    <div class="twt-feed blue-bg">
                                                        <div class="corner-ribon black-ribon">
                                                            <i class="fa fa-shield"></i>
                                                        </div>
                                                        <div class="fa fa-shield wtt-mark"></div>

                                                        <div class="mx-auto d-block">

                                                            <div class="location text-sm-center">
                                                                <br>
                                                                <p>
                                                                    <font size='38' color="white">60</font>
                                                                </p>
                                                            </div>
                                                            <div class="text-sm-center mt-2 mb-1">

                                                                <p>
                                                                    <font color='white'>账号安全评分</font>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </section>
                                            </div>

                                            <table class="table">
                                                <tr>
                                                    <td><i class='fa fa-exclamation-circle'
                                                            style='color:chocolate'></i> 绑定手机</td>
                                                    <td>未绑定手机</td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'>绑定手机</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><i class='fa fa-exclamation-circle'
                                                            style='color:chocolate'></i> 支付密码</td>
                                                    <td>未设置</td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'>设置支付密码</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><i class='fa fa-exclamation-circle'
                                                            style='color:chocolate'></i> 公司资料</td>
                                                    <td>未完善公司资料</td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'>修改资料</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><i class='fa fa-check-circle' style='color:forestgreen'></i> 绑定邮箱
                                                    </td>
                                                    <td>已绑定邮箱</td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'>修改邮箱</a>
                                                    </td>
                                                </tr>
                                            </table>

                                        </div>
                                        <div class="tab-pane fade" id="nav-contact" role="tabpanel"
                                            aria-labelledby="nav-contact-tab">
                                            <div class="card-text text-sm-center">
                                                <form action="#" method="post" enctype="multipart/form-data"
                                                    class="form-horizontal">
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label
                                                                class=" form-control-label">Static</label></div>
                                                        <div class="col-12 col-md-9">
                                                            <p class="form-control-static">Username</p>
                                                        </div>
                                                    </div>

                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="password-input"
                                                                class=" form-control-label">Password</label>
                                                        </div>
                                                        <div class="col-12 col-md-9"><input type="password"
                                                                id="password-input" name="password-input"
                                                                placeholder="Password" class="form-control"><small
                                                                class="help-block form-text">Please enter a
                                                                complex password</small></div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="disabled-input"
                                                                class=" form-control-label">Disabled
                                                                Input</label></div>
                                                        <div class="col-12 col-md-9"><input type="text"
                                                                id="disabled-input" name="disabled-input"
                                                                placeholder="Disabled" disabled="" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="textarea-input"
                                                                class=" form-control-label">Textarea</label>
                                                        </div>
                                                        <div class="col-12 col-md-9"><textarea name="textarea-input"
                                                                id="textarea-input" rows="9" placeholder="Content..."
                                                                class="form-control"></textarea></div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="select"
                                                                class=" form-control-label">Select</label></div>
                                                        <div class="col-12 col-md-9">
                                                            <select name="select" id="select" class="form-control">
                                                                <option value="0">Please select</option>
                                                                <option value="1">Option #1</option>
                                                                <option value="2">Option #2</option>
                                                                <option value="3">Option #3</option>
                                                            </select>
                                                        </div>
                                                    </div>


                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="disabledSelect"
                                                                class=" form-control-label">Disabled
                                                                Select</label></div>
                                                        <div class="col-12 col-md-9">
                                                            <select name="disabledSelect" id="disabledSelect"
                                                                disabled="" class="form-control">
                                                                <option value="0">Please select</option>
                                                                <option value="1">Option #1</option>
                                                                <option value="2">Option #2</option>
                                                                <option value="3">Option #3</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="multiple-select"
                                                                class=" form-control-label">Multiple
                                                                select</label></div>
                                                        <div class="col col-md-9">
                                                            <select name="multiple-select" id="multiple-select"
                                                                multiple="" class="form-control">
                                                                <option value="1">Option #1</option>
                                                                <option value="2">Option #2</option>
                                                                <option value="3">Option #3</option>
                                                                <option value="4">Option #4</option>
                                                                <option value="5">Option #5</option>
                                                                <option value="6">Option #6</option>
                                                                <option value="7">Option #7</option>
                                                                <option value="8">Option #8</option>
                                                                <option value="9">Option #9</option>
                                                                <option value="10">Option #10</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label
                                                                class=" form-control-label">Radios</label></div>
                                                        <div class="col col-md-9">
                                                            <div class="form-check">
                                                                <div class="radio">
                                                                    <label for="radio1" class="form-check-label ">
                                                                        <input type="radio" id="radio1" name="radios"
                                                                            value="option1"
                                                                            class="form-check-input">Option 1
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="radio2" class="form-check-label ">
                                                                        <input type="radio" id="radio2" name="radios"
                                                                            value="option2"
                                                                            class="form-check-input">Option 2
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="radio3" class="form-check-label ">
                                                                        <input type="radio" id="radio3" name="radios"
                                                                            value="option3"
                                                                            class="form-check-input">Option 3
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label
                                                                class=" form-control-label">Inline
                                                                Radios</label></div>
                                                        <div class="col col-md-9">
                                                            <div class="form-check-inline form-check">
                                                                <label for="inline-radio1" class="form-check-label ">
                                                                    <input type="radio" id="inline-radio1"
                                                                        name="inline-radios" value="option1"
                                                                        class="form-check-input">One
                                                                </label>
                                                                <label for="inline-radio2" class="form-check-label ">
                                                                    <input type="radio" id="inline-radio2"
                                                                        name="inline-radios" value="option2"
                                                                        class="form-check-input">Two
                                                                </label>
                                                                <label for="inline-radio3" class="form-check-label ">
                                                                    <input type="radio" id="inline-radio3"
                                                                        name="inline-radios" value="option3"
                                                                        class="form-check-input">Three
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="file-input"
                                                                class=" form-control-label">File input</label>
                                                        </div>
                                                        <div class="col-12 col-md-9"><input type="file" id="file-input"
                                                                name="file-input" class="form-control-file"></div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col col-md-3"><label for="file-multiple-input"
                                                                class=" form-control-label">Multiple File
                                                                input</label></div>
                                                        <div class="col-12 col-md-9"><input type="file"
                                                                id="file-multiple-input" name="file-multiple-input"
                                                                multiple="" class="form-control-file"></div>
                                                    </div>
                                                    <div>
                                                        <button type="submit" class="btn btn-primary btn-sm">
                                                            <i class="fa fa-dot-circle-o"></i> 提交
                                                        </button>
                                                        <button type="reset" class="btn btn-danger btn-sm">
                                                            <i class="fa fa-ban"></i> 重置
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- 弹窗 -->
        <div>
        
                        <!--点击修改密码-->
        <div id="light" class="white_content">
                <div class="card">
                        <div class="card-header">
                            <strong class="card-title">修改密码</strong>
                        </div>
                        <div class="card-body">
                            <div action="register-cusUser" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="row form-group">
                                        <div class="col col-md-3"><label style="float:right" for="text-input" class=" form-control-label">原密码</label></div>
                                        <div class="col-12 col-md-9"><input type="text" id="origin" name="username"  class="form-control"></div>
                                    </div>
                                    <div class="row form-group">
                                            <div class="col col-md-3"><label style="float:right" for="text-input" class=" form-control-label">新密码</label></div>
                                            <div class="col-12 col-md-9"><input type="password" id="new1" name="account"  class="form-control"></div>
                                        </div>
                                        <div class="row form-group">
                                                <div class="col col-md-3"><label style="float:right" for="text-input" class=" form-control-label">新密码</label></div>
                                                <div class="col-12 col-md-9"><input type="password" name ='passwd'id="new2" class="form-control" ><small class="form-text text-muted">再次填写一遍新密码</small></div>
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
        <!--/点击修改密码-->
             <!--点击修改邮箱-->
        <div id="mail" class="white_content">
                <div class="card">
                        <div class="card-header">
                            <strong class="card-title">修改邮箱</strong>
                        </div>
                        <div class="card-body">
                            <div action="register-cusUser" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="row form-group">
                                        <div class="col col-md-3"><label style="float:right" for="text-input" class=" form-control-label">新邮箱</label></div>
                                        <div class="col-12 col-md-9"><input type="text" id="email"  class="form-control"></div>
                                    </div>
                                            <div class="form-actions form-group">
                                               
                                                    <button id = 'submitbtn2' class="btn btn-primary btn-sm">
                                                            <i class="fa fa-dot-circle-o"></i> 提交
                                                        </button>
                                                        <a href = "javascript:void(0)" onclick = "closeEmail()">
                                                        <button type="reset" class="btn btn-danger btn-sm">
                                                            <i class="fa fa-ban"></i> 取消
                                                        </button>
                                                    </a>
                                                    
                                                </div>

                            </div>

                        </div><!--/.card-body-->
                    </div> <!-- /.card -->
               
            </div> 
              <div id="fade1" class="black_overlay"></div> 
        <!--/点击修改邮箱-->
        </div>
        


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
    function openEmail(){
        document.getElementById('mail').style.display='block';
        document.getElementById('fade1').style.display='block'
    }
    function closeEmail(){
        document.getElementById('mail').style.display='none';
        document.getElementById('fade1').style.display='none'
    }
    

    //修改密码
     $(document).ready(function () {
      $("#submitbtn1").click(function () {
    	  var origin=$("#origin").val()
    	  var new1=$("#new1").val()
    	  var new2 =$("#new2").val()
    	  console.log(new1+"\t"+new2)
    	
    	  if(origin==""){
  			$('.hxy-alert').removeClass('hxy-alert-success')
			$('.hxy-alert').html('请输入原密码').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
  		  	return false;
  	  }
    	  if(new1==""){
    			$('.hxy-alert').removeClass('hxy-alert-success')
  				$('.hxy-alert').html('请输入新密码').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    		  	return false;
    	  }
    	  if(new2==""){
    			$('.hxy-alert').removeClass('hxy-alert-success')
  				$('.hxy-alert').html('请再次输入新密码').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    		  	return false;
    	  }
    	  if(new1!=new2){
  				$('.hxy-alert').removeClass('hxy-alert-success')
				$('.hxy-alert').html('两次输入的新密码不一样').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
  		  return false;
  	  }
    		$.ajax({
    			//几个参数需要注意一下
    			url : "${pageContext.request.contextPath}/modify-passwd",//url
    			type : "POST",//方法类型
    			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。

    			dataType : "json",//预期服务器返回的数据类型
    			cache : false,
    			data : {
    				'origin':origin,
    				"new2" : new2,
    			},//这个是发送给服务器的数据

    			success : function(result) {
    				console.log(result);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					closeDialog()
    					$('.hxy-alert').removeClass('hxy-alert-warning')
    					$('.hxy-alert').html('修改成功').addClass('hxy-alert-success').show().delay(2000).fadeOut();
    				} else if (result.resultCode == 601) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('修改失败').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				
    				}else if (result.resultCode == 404) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('手机号未注册').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				}else if (result.resultCode == 101) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('账号已经存在').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				}else if (result.resultCode == 502) {
    					//	$(this).remove();
    					console.log('原密码不正确');
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('原密码不正确').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				};
    			},
    			error : function() {
    				//console.log(data);
    				
    				$('.hxy-alert').removeClass('hxy-alert-success')
					$('.hxy-alert').html('检查网络是否连接').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    			}
    		});
        });
      
      $("#submitbtn2").click(function () {
    	  var email=$("#email").val()
    	  console.log(email+"\t")
    	
    	  if(email==""){
  			$('.hxy-alert').removeClass('hxy-alert-success')
			$('.hxy-alert').html('请输入邮箱').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
  		  	return false;
  	  }
    		$.ajax({
    			//几个参数需要注意一下
    			url : "${pageContext.request.contextPath}/modify-email",//url
    			type : "POST",//方法类型
    			async : false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。
    			dataType : "json",//预期服务器返回的数据类型
    			cache : false,
    			data : {
    				'email':email
    			},//这个是发送给服务器的数据

    			success : function(result) {
    				console.log(result);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					closeEmail()
    					
    					$('#displayEmail').html(email);
    					$('.hxy-alert').removeClass('hxy-alert-warning')
    					$('.hxy-alert').html('修改成功').addClass('hxy-alert-success').show().delay(2000).fadeOut();
    				} else if (result.resultCode == 601) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('修改失败').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				
    				}else if (result.resultCode == 404) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('手机号未注册').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				}else if (result.resultCode == 101) {
    					//	$(this).remove();
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('账号已经存在').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
    				}else if (result.resultCode == 502) {
    					//	$(this).remove();
    					console.log('原密码不正确');
    					$('.hxy-alert').removeClass('hxy-alert-success')
    					$('.hxy-alert').html('原密码不正确').addClass('hxy-alert-warning').show().delay(2000).fadeOut();
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