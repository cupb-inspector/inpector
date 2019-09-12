<!doctype html>
<jsp:include page="/WEB-INF/views/commons.jsp"/>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>环球质检用户后台</title>
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
    <script src="js/jquery-1.8.2.min.js"></script>
       <script src="http://code.jquery.com/ui/1.12.0/jquery-ui.min.js"
        integrity="sha256-eGE6blurk5sHj+rmkfsGYeKyZx3M4bG+ZlFyA7Kns7E=" crossorigin="anonymous"></script>
    <style>
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

        #right-panel {

            height: 100%;
            margin-bottom: 0px;
            padding-bottom: 0px;
        }

        .content {
            width: 100%;
            height: 100%;
        }
    </style>
    <script>
    function skip(href) {
    	//myiframe.location.target="myiframe";
    	myiframe.location.href = href;
    }
        $(function () {
          //  $("#accordion").accordion()
          console.log('手风琴')
            $('#accordion').accordion({ 
             //   active: false, 
              //  header: '.head', 
              //  navigation: true, 
           //     event: 'mouseover', 
                fillSpace: true, 
                height: true ,
                fit:true,
                animated:'easeslide'
            });
        })


    </script>
 

</head>

<body>
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default sidebar sidebar-offcanvas" id="sidebar">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
            <ul>
            </ul>
                <ul id="accordion" class="nav navbar-nav">
                    <li class="nav-item menu-item">
                            <a class="nav-link" href="index-content" target="myiframe" onclick=skip(this.href) >
                                <i class="menu-icon fa fa-laptop"></i>
                                我的主页
                            </a>
                    </li>
                    <li class="nav-item menu-item">
                            <a class="nav-link" href="check-content" target="myiframe" onclick=skip(this.href)>
                                <i class="menu-icon fa fa-file-text"></i>
                                我要下单
                            </a>
                    </li>
                    <li class="nav-item menu-item-has-children">
                        <a class="nav-link" data-toggle="collapse" href="#bill" aria-haspopup="true"
                            aria-expanded="false" aria-controls="bill">
                            <i class="menu-icon fa fa-file-text"></i>
                            我的订单
                        </a>
                        <div class="collapse" id="bill">
                            <ul class="nav flex-column sub-menu">
                                    <li><a href="orders-all-content" target="myiframe">全部</a></li>
                                  <!-- <li><a href="orders-draft" target="myiframe">草稿</a></li>  -->  
                                    <li><a href="orders-finished" target="myiframe">已完成</a></li>
                                    <li><a href="orders-unfinished" target="myiframe">未完成</a></li>
<%--                                    <li><a href="orders-cancel" target="myiframe">已取消</a></li>--%>
                                    <li><a href="orders-draft" target="myiframe">草稿</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item menu-item-has-children">
                        <a class="nav-link" data-toggle="collapse" href="#reports" aria-haspopup="true"
                            aria-expanded="false" aria-controls="reports">
                            <i class="menu-icon fa fa-file-text"></i>
                            我的报告
                        </a>
                        <div class="collapse" id="reports">
                            <ul class="nav flex-column sub-menu">
                                <li><a href="reports" target="myiframe">验货报告</a></li>
                            </ul>
                        </div>
                    </li>
                    <!-- 
                    
                    <li class="nav-item menu-item-has-children">
                        <a class="nav-link" data-toggle="collapse" href="#evaluation" aria-haspopup="true"
                            aria-expanded="false" aria-controls="evaluation">
                            <i class="menu-icon fa  fa-edit"></i>
                            我的评价
                        </a>
                        <div class="collapse" id="evaluation">
                            <ul class="nav flex-column sub-menu">
                                <li><a href="evaluation-unfinished" target="myiframe">待评价</a></li>
                                <li><a href="evaluation-finished" target="myiframe">已评价</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item menu-item-has-children">
                        <a class="nav-link" data-toggle="collapse" href="#complaint" aria-haspopup="true"
                            aria-expanded="false" aria-controls="complaint">
                            <i class="menu-icon fa fa-thumbs-down"></i>
                            我的投诉
                        </a>
                        <div class="collapse" id="complaint">
                            <ul class="nav flex-column sub-menu">
                                <li><a href="complaint-lists" target="myiframe">投诉列表</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item menu-item-has-children">
                        <a class="nav-link" data-toggle="collapse" href="#data" aria-haspopup="true"
                            aria-expanded="false" aria-controls="data">
                            <i class="menu-icon fa  fa-bar-chart"></i>
                            数据报表
                        </a>
                        <div class="collapse" id="data">
                            <ul class="nav flex-column sub-menu">
                                <li><a href="#" target="myiframe">工厂分析</a></li>
                            </ul>
                        </div>
                    </li>
                     -->
                    
                    <li class="nav-item menu-item-has-children">
                        <a class="nav-link" data-toggle="collapse" href="#account1" aria-haspopup="true"
                            aria-expanded="false" aria-controls="account1">
                            <i class="menu-icon fa fa-cusUser"></i>
                            我的账户
                        </a>
                        <div class="collapse" id="account1">
                            <ul class="nav flex-column sub-menu">
                            	<li><a href="personal" target="myiframe">账户设置</a></li>
                                <li><a href="wallet" target="myiframe">我的钱包</a></li>
                                <li><a href="integral" target="myiframe">我的等级与积分</a></li>
                            </ul>
                        </div>
                    </li>

<!--  
                    <li class="nav-item menu-item">
                            <a class="nav-link" href="check-content" target="myiframe">
                                <i class="menu-icon fa  fa-bell"></i>
                                我的消息
                            </a>
                    </li>
                    <li class="nav-item menu-item">
                            <a class="nav-link" href="check-content.html" target="myiframe">
                                <i class="menu-icon fa fa-mail-forward"></i>
                                业务推荐
                            </a>
                    </li>
         
                    

                    <li class="nav-item menu-item-has-children">
                            <a class="nav-link" data-toggle="collapse" href="#profile" aria-haspopup="true"
                                aria-expanded="false" aria-controls="profile">
                                <i class="menu-icon fa fa-list-alt"></i>
                                资料管理
                            </a>
                            <div class="collapse" id="profile">
                                <ul class="nav flex-column sub-menu">
                                        <li><a href="#" target="myiframe">发票资料</a></li>
                                        <li><a href="#" target="myiframe">工厂资料</a></li>
                                        <li><a href="#" target="myiframe">报告接收邮箱</a></li>
                                </ul>
                            </div>
                        </li>
                        
                        -->
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside>
    <!-- /#left-panel -->
    <!-- Right Panel -->
    <div id="right-panel" class="right-panel" style="height:100%">
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-left">
                <div class="navbar-header">
                    <a class="navbar-brand" href="http://www.globalinsp.com"><img src="images/logo.jpg" alt="Logo"></a>

                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>
                </div>
            </div>
            <div class="top-right">
                <div class="header-menu">
                    <div class="header-left">
                        <div class="dropdown for-language">
                            <a href="./">English</a>
                        </div>

                        <button class="search-trigger"><i class="fa fa-search"></i></button>
                        <div class="form-inline">
                            <form class="search-form">
                                <input class="form-control mr-sm-2" type="text" placeholder="请输入订单号"
                                    aria-label="Search">
                                <button class="search-close" type="submit"><i class="fa fa-close"></i></button>
                            </form>
                        </div>

                        <div class="dropdown for-notification">
                            <a href="./">
                                <i class="fa fa-bell"></i>
                            </a>

                        </div>
                    </div>

                    <div class="cusUser-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false">
                            <img class="cusUser-avatar rounded-circle" src="images/admin.jpg" alt="User Avatar">
                        </a>

                        <div class="cusUser-menu dropdown-menu">
                            <a class="nav-link" target="myiframe"  href="personal"><i class="fa fa- cusUser"></i>账户设置</a>

                            <a class="nav-link" href="cusUser-login-out"><i class="fa fa- cusUser"></i>安全退出</a>

                        </div>
                    </div>

                </div>
            </div>
        </header>
        <!-- /#header -->
        <!-- Content -->
        <div class="content" style="width:100%;height:100%;padding: 0px;background:#f1f2f7">
            <div style="width:100%;height:100%">
                <iframe name="myiframe" src="index-content" frameborder="no" scrolling="auto"
                    style="height: 100%; width: 100%;" allowtransparency="true"> </iframe>
            </div>

            <!-- Animated -->
            <div class="animated fadeIn">


                <!-- Modal - Calendar - Add New Event -->
                <div class="modal fade none-border" id="event-modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                    aria-hidden="true">&times;</button>
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
                                <button type="button" class="close" data-dismiss="modal"
                                    aria-hidden="true">&times;</button>
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
        </div>
        <!-- /.content -->

        <!-- Footer -->

        <!-- /.site-footer -->
    </div>
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
 
    <!-- 
       <script src="assets/weather/js/jquery.simpleWeather.min.js"></script>
    <script src="assets/weather/js/weather-init.js"></script>
 -->
    <script src="assets/js/lib/moment/moment.js"></script>

    <script src="assets/calendar/fullcalendar.min.js"></script>
    <script src="assets/calendar/fullcalendar-init.js"></script>
    <!-- 
    <script src="assets/js/init/weather-init.js"></script>
 -->
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
    <script>
        function hasClass(elements, cName) {
            return !!elements.className.match(new RegExp("(\\s|^)" + cName + "(\\s|$)"));
        };
        function addClass(elements, cName) {
            if (!hasClass(elements, cName)) {
                elements.className += " " + cName;
            };
        };
        function removeClass(elements, cName) {
            if (hasClass(elements, cName)) {
                elements.className = elements.className.replace(new RegExp("(\\s|^)" + cName + "(\\s|$)"), " ");
            };
        };
        var li = document.querySelectorAll('#nky li');


        for (var i = 0; i < li.length; i++)
            li[i].onclick = function () {
                //   for (var i = 0; i < li.length; i++) li[i].className = '';
                //  this.className = 'active'
                for (var i = 0; i < li.length; i++)  removeClass(li[i], 'active');
                addClass(this, 'active');
            }
            
    </script>
</body>

</html>