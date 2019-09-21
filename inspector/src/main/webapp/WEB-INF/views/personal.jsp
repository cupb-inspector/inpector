<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="hxy.inspec.inspector.po.Orders"%>
<%@page import="hxy.inspec.inspector.po.User"%>
<%@page import="hxy.inspec.inspector.services.UserService"%>
<jsp:include page="/WEB-INF/views/commons.jsp"/>
<%
request.setCharacterEncoding("utf-8");
	User user = (User) request.getSession().getAttribute("user");

	if (user == null) {
		System.out.print("用户没有登录");
		request.getRequestDispatcher("login").forward(request, response);//保持浏览器地址不变
	}else {
		UserService userService = new UserService();
		if (user.getUserId() == null) {//新用户注册后的情形
			user = userService.login(user.getUserTel());
		} else {
			user = userService.findUserById(user.getUserId());
		}
		request.getSession().setAttribute("user", user);
	}
%>
<%! 
String addressGetter(String[] S){
	String address="";
	for (String s :S)
		if(s==null)continue;
		else address+=s;
	return address;
}
%>
<%
String[] S = {user.getProvince(),user.getCity(),user.getDistrict(),user.getAddress()}; 
String userAddress = addressGetter(S);
%>
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
    <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
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
    
    
         html,body{
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
                                            <a class="nav-item nav-link" id="nav-security-tab" data-toggle="tab"
                                                href="#nav-security" role="tab" aria-controls="nav-security"
                                                aria-selected="false">
                                                <h4>账户安全</h4>
                                            </a>
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
                                                        <div class="location text-sm-center">
                                                                <input type="file"
                                                                        id="head-file-input" name="head-file-input"
                                                                        class="fa fa-pencil-square-o">
                                                        </div>
                                                      
                                                        <div class="text-sm-center mt-2 mb-1">
                                                            <i>请点击下面“保存”按钮保存</i>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <div class="card-text text-sm-center">
                                                        <form action="#" method="post" enctype="multipart/form-data"
                                                            class="form-horizontal">
                                                            <div class="row form-group">
                                                                <div class="col col-md-3"><label
                                                                        class=" form-control-label">我的ID</label></div>
                                                                <div class="col-12 col-md-9">
                                                                    <p class="form-control-static"><%=user.getUserId()%></p>
                                                                </div>
                                                            </div>

                                                            <div class="row form-group">
                                                                <div class="col col-md-3"><label for="inspector-userName-input"
                                                                        class=" form-control-label">我的昵称</label>
                                                                </div>
                                                                <div class="col-12 col-md-9"><input type="text"
                                                                        id="inspector-userName-input" name="inspector-userName-input"
                                                                        value="<%=user.getUserName()%>"
                                                                        class="form-control"></div>
                                                            </div>
                                                            <div class="row form-group">
                                                                <div class="col col-md-3"><label for="user-grade"
                                                                        class=" form-control-label">我的积分</label></div>
                                                                <div class="col-12 col-md-9"><input type="text"
                                                                        id="user-grade" name="user-grade"
                                                                        placeholder="<%=user.getIntegral() %>" disabled=""
                                                                        class="form-control"></div>
                                                            </div>
                                                            <div class="row form-group">
                                                                <div class="col col-md-3"><label for="textarea-input"
                                                                        class=" form-control-label">我的签名</label>
                                                                </div>
                                                                <div class="col-12 col-md-9"><textarea
                                                                        name="textarea-input" id="textarea-input"
                                                                        rows="1" placeholder="快乐小神仙，春夏秋冬练。"
                                                                        class="form-control"></textarea></div>
                                                            </div>
                                                            <div class="row form-group">
                                                                <div class="col col-md-3"><label for="select"
                                                                        class=" form-control-label">我的状态</label></div>
                                                                <div class="col-12 col-md-9">
                                                                    <select name="inspector-status-select" id="inspector-status-select"
                                                                        class="form-control">
                                                                        <option value="0">正常上岗</option>
                                                                        <option value="1">休息中</option>
                                                                        <option value="2">即将离职</option>
                                                                        <option value="3">正在工作</option>
                                                                    </select>
                                                                    <script type="text/javascript">
                                                            		document.getElementById("inspector-status-select")[<%=user.getStatus()%>].selected=true;
                                                            		</script>
                                                                </div>
                                                            </div> 
                                                            <div class="row form-group">
                                                                <div class="col col-md-3"><label for="disabledSelect"
                                                                        class=" form-control-label">我的邮箱</label></div>
                                                                <div class="col-12 col-md-9">
                                                                    <select name="disabledSelect" id="disabledSelect"
                                                                        disabled="" class="form-control">
                                                                        <option value="0"><%=user.getEmail() %></option>
                                                                        <option value="1">Option #1</option>
                                                                        <option value="2">Option #2</option>
                                                                        <option value="3">Option #3</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="row form-group">
                                                                <div class="col col-md-3"><label for="inspector-user-address"
                                                                        class=" form-control-label">我的地点</label>
                                                                </div>
                                                                <div class="col-12 col-md-9"><input type="text"
                                                                        id="inspector-user-address" name="inspector-user-address"
                                                                        
                                                                        value="<%=userAddress%>"
                                                                        class="form-control"></div>
                                                            </div>
                                                           
                                                            <div>
                                                                <button type="submit" id="basicSaveBtn" class="btn btn-primary btn-sm">
                                                                    <i class="fa fa-dot-circle-o"></i> 保存
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="tab-pane fade show active" id="nav-security" role="tabpanel"
                                            aria-labelledby="nav-security-tab">
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
                                                    <td ><%=user.getUserName() %></td>
                                                    <td><a class='connect' href='#' style='color:mediumblue'></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><i class='fa fa-check-circle' style='color:forestgreen'></i> 手机号码
                                                    </td>
                                                    <td><%=user.getUserTel() %></td>
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
                                                <tr>
                                                    <td><i class='fa fa-check-circle' style='color:forestgreen'></i> 绑定邮箱
                                                    </td>
                                                    <td><div id ="displayEmail"><%=user.getEmail() %></div></td>
                                                    <td><a class='connect' href = "JavaScript:void(0)" onclick = "openEmail()" style='color:mediumblue'>修改邮箱</a>
                                                   
                                                    </td>
                                                </tr>
                                            </table>
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
                            <div action="register-user" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="row form-group">
                                        <div class="col col-md-3"><label style="float:right" for="text-input" class=" form-control-label">原密码</label></div>
                                        <div class="col-12 col-md-9"><input type="text" autocomplete="off" placeholder="原密码" id="origin" name="originUserpasswd"  class="form-control"></div>
                                    </div>
                                    <div class="row form-group">
                                            <div class="col col-md-3"><label style="float:right" for="text-input" class=" form-control-label">新密码</label></div>
                                            <div class="col-12 col-md-9"><input type="password" autocomplete="off" id="new1" name="passwd_"  class="form-control"></div>
                                        </div>
                                        <div class="row form-group">
                                                <div class="col col-md-3"><label style="float:right" for="text-input" class=" form-control-label">新密码</label></div>
                                                <div class="col-12 col-md-9"><input type="password" autocomplete="off" name ='passwd'id="new2" class="form-control" ><small class="form-text text-muted">再次填写一遍新密码</small></div>
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
                            <div action="register-user" method="post" enctype="multipart/form-data" class="form-horizontal">
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
        jQuery(document).ready(function ($) {
            "use strict";

            // Pie chart flotPie1
            var piedata = [
                { label: "Desktop visits", data: [[1, 32]], color: '#5c6bc0' },
                { label: "Tab visits", data: [[1, 33]], color: '#ef5350' },
                { label: "Mobile visits", data: [[1, 35]], color: '#66bb6a' }
            ];

            $.plot('#flotPie1', piedata, {
                series: {
                    pie: {
                        show: true,
                        radius: 1,
                        innerRadius: 0.65,
                        label: {
                            show: true,
                            radius: 2 / 3,
                            threshold: 1
                        },
                        stroke: {
                            width: 0
                        }
                    }
                },
                grid: {
                    hoverable: true,
                    clickable: true
                }
            });
            // Pie chart flotPie1  End
            // cellPaiChart
            var cellPaiChart = [
                { label: "Direct Sell", data: [[1, 65]], color: '#5b83de' },
                { label: "Channel Sell", data: [[1, 35]], color: '#00bfa5' }
            ];
            $.plot('#cellPaiChart', cellPaiChart, {
                series: {
                    pie: {
                        show: true,
                        stroke: {
                            width: 0
                        }
                    }
                },
                legend: {
                    show: false
                }, grid: {
                    hoverable: true,
                    clickable: true
                }

            });
            // cellPaiChart End
            // Line Chart  #flotLine5
            var newCust = [[0, 3], [1, 5], [2, 4], [3, 7], [4, 9], [5, 3], [6, 6], [7, 4], [8, 10]];

            var plot = $.plot($('#flotLine5'), [{
                data: newCust,
                label: 'New Data Flow',
                color: '#fff'
            }],
                {
                    series: {
                        lines: {
                            show: true,
                            lineColor: '#fff',
                            lineWidth: 2
                        },
                        points: {
                            show: true,
                            fill: true,
                            fillColor: "#ffffff",
                            symbol: "circle",
                            radius: 3
                        },
                        shadowSize: 0
                    },
                    points: {
                        show: true,
                    },
                    legend: {
                        show: false
                    },
                    grid: {
                        show: false
                    }
                });
            // Line Chart  #flotLine5 End
            // Traffic Chart using chartist
            if ($('#traffic-chart').length) {
                var chart = new Chartist.Line('#traffic-chart', {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    series: [
                        [0, 18000, 35000, 25000, 22000, 0],
                        [0, 33000, 15000, 20000, 15000, 300],
                        [0, 15000, 28000, 15000, 30000, 5000]
                    ]
                }, {
                        low: 0,
                        showArea: true,
                        showLine: false,
                        showPoint: false,
                        fullWidth: true,
                        axisX: {
                            showGrid: true
                        }
                    });

                chart.on('draw', function (data) {
                    if (data.type === 'line' || data.type === 'area') {
                        data.element.animate({
                            d: {
                                begin: 2000 * data.index,
                                dur: 2000,
                                from: data.path.clone().scale(1, 0).translate(0, data.chartRect.height()).stringify(),
                                to: data.path.clone().stringify(),
                                easing: Chartist.Svg.Easing.easeOutQuint
                            }
                        });
                    }
                });
            }
            // Traffic Chart using chartist End
            //Traffic chart chart-js
            if ($('#TrafficChart').length) {
                var ctx = document.getElementById("TrafficChart");
                ctx.height = 150;
                var myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
                        datasets: [
                            {
                                label: "Visit",
                                borderColor: "rgba(4, 73, 203,.09)",
                                borderWidth: "1",
                                backgroundColor: "rgba(4, 73, 203,.5)",
                                data: [0, 2900, 5000, 3300, 6000, 3250, 0]
                            },
                            {
                                label: "Bounce",
                                borderColor: "rgba(245, 23, 66, 0.9)",
                                borderWidth: "1",
                                backgroundColor: "rgba(245, 23, 66,.5)",
                                pointHighlightStroke: "rgba(245, 23, 66,.5)",
                                data: [0, 4200, 4500, 1600, 4200, 1500, 4000]
                            },
                            {
                                label: "Targeted",
                                borderColor: "rgba(40, 169, 46, 0.9)",
                                borderWidth: "1",
                                backgroundColor: "rgba(40, 169, 46, .5)",
                                pointHighlightStroke: "rgba(40, 169, 46,.5)",
                                data: [1000, 5200, 3600, 2600, 4200, 5300, 0]
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        tooltips: {
                            mode: 'index',
                            intersect: false
                        },
                        hover: {
                            mode: 'nearest',
                            intersect: true
                        }

                    }
                });
            }
            //Traffic chart chart-js  End
            // Bar Chart #flotBarChart
            $.plot("#flotBarChart", [{
                data: [[0, 18], [2, 8], [4, 5], [6, 13], [8, 5], [10, 7], [12, 4], [14, 6], [16, 15], [18, 9], [20, 17], [22, 7], [24, 4], [26, 9], [28, 11]],
                bars: {
                    show: true,
                    lineWidth: 0,
                    fillColor: '#ffffff8a'
                }
            }], {
                    grid: {
                        show: false
                    }
                });
            // Bar Chart #flotBarChart End
        });
    </script>
    <script type="text/javascript">
    $(document).ready(function () {
    	$("#basicSaveBtn").click(
				function () {
					var status = $("#inspector-status-select").val();
					var userName = $("#inspector-userName-input").val();
					var address = $("#inspector-user-address").val();

					console.log(userName + "\t" + address + "\t")
					//var file_obj = document.getElementById('afile').files[0];
					//var fd = new FormData();
					//fd.append('status', status)
					//fd.append('userName', userName);
					//fd.append("address", address);
					//fd.append("file", file_obj);
					//fd.append("post_type", 'temp');//按钮的请求类型

					$.ajax({
						//几个参数需要注意一下
						url: "${pageContext.request.contextPath}/user-update-basic-info",//url
						type: "POST",//方法类型
						async: false,//同步需要等待服务器返回数据后再执行后面的两个函数，success和error。如果设置成异步，那么可能后面的success可能执行后还是没有收到消息。
						dataType: "json",//预期服务器返回的数据类型
						cache: false,
						data : {
		    				'status':status,
		    				"address" : address,
		    				"userName":userName
		    			},//这个是发送给服务器的数据
						//data: fd,//这个是发送给服务器的数据
						//processData: false,  //tell jQuery not to process the data
						//contentType: false,  //tell jQuery not to set contentType
					success : function(result) {
    				console.log(result.resultCode);//打印服务端返回的数据(调试用)
    				if (result.resultCode == 200) {
    					location.reload();
    					$('.hxy-alert').removeClass('hxy-alert-warning')
    					$('.hxy-alert').html('修改成功').addClass('hxy-alert-success').show().delay(2000).fadeOut();
    				} else if (result.resultCode == 601) {
								//	$(this).remove();
								$('.hxy-alert')
									.removeClass(
										'hxy-alert-success')
								$('.hxy-alert')
									.html(
										'密码错误')
									.addClass(
										'hxy-alert-warning')
									.show()
									.delay(
										2000)
									.fadeOut();
								document
									.getElementById("passwd").value = ''
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
    });
    </script>
    
    <script type="text/javascript">
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
      	console.log("openEmail"+"\t")
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