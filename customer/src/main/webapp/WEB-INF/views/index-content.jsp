<%@page import="cn.hxy.inspect.util.Configuration"%>
<%@page import="cn.hxy.inspect.entity.Orders"%>
<%@page import="java.util.List"%>
<%@page import="cn.hxy.inspect.customer.service.OrderService"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons.jsp" />
<%@page import="cn.hxy.inspect.customer.service.UserService"%>
<%@page import="cn.hxy.inspect.entity.customer.CusUser"%>
<!DOCTYPE html>
<html class="no-js" lang="">
<%
//查询个人信息
request.setCharacterEncoding("utf-8");
CusUser cusUser = (CusUser) request.getSession().getAttribute("user");
CusUser u =null;
if(cusUser !=null){
	//查询最新的金额数字
	UserService s = new UserService();
	 u =	s.login(cusUser.getCustel());
}
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>首页内容</title>
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


    <style>
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

        html,
        body {
            margin: 0px;
            width: 100%;
            height: 100%;
        }
    </style>
</head>

<!-- Content -->
<div class="content" style="background:#f1f2f7;height: 100%;">
    <!-- Animated -->
    <div class="animated fadeIn">
        <!-- Widgets  -->
        <div class="row">
            <!--
                    <div class="col-lg-3 col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="stat-widget-five">
                                    <div class="stat-icon dib flat-color-1">
                                        <i class="pe-7s-cash"></i>
                                    </div>
                                    <div class="stat-content">
                                        <div class="text-left dib">
                                            <div class="stat-text">$<span class="count">23569</span></div>
                                            <div class="stat-heading">美元余额</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                      -->

            <div class="col-lg-3 col-md-6">
                <a href="wallet">
                    <div class="card">
                        <div class="card-body">
                            <div class="stat-widget-five">
                                <div class="stat-icon dib flat-color-2">
                                    <i class="pe-7s-cash"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="text-left dib">
                                        <div class="stat-text">￥<span class=""><%=u.getCusMoney() %></span></div>
                                        <div class="stat-heading">人民币余额</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="stat-widget-five">
                            <div class="stat-icon dib flat-color-3">
                                <i class="pe-7s-browser"></i>
                            </div>
                            <div class="stat-content">
                                <div class="text-left dib">
                                    <div class="stat-text"><span class=""><%=u.getCusgrade() %></span></div>
                                    <div class="stat-heading">我的积分</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="stat-widget-five">
                            <div class="stat-icon dib flat-color-4">
                                <i class="pe-7s-cart"></i>
                            </div>
                            <div class="stat-content">
                                <div class="text-left dib">
                                    <div class="stat-text"><span class=""><%=u.getCusOrders() %></span></div>
                                    <div class="stat-heading">处理中订单</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <a href='orders-all-content'>
                    <div class="card">
                        <div class="card-body">
                            <div class="stat-widget-five">
                                <div class="stat-icon dib flat-color-1">
                                    <i class="pe-7s-cash"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="text-left dib">
                                        <div class="stat-text"><span class=""><%=u.getCusOrders() %></span></div>
                                        <div class="stat-heading">总订单</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <!-- /Widgets -->
        <!--table-->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">未完成订单</strong>
                        <a href='orders-all-content'>
                            <small><span class="badge badge-success float-right mt-1">全部订单 ></span></small>
                        </a>
                    </div>
                    <div class="card-body">
                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>订单号</th>
                                    <th>验货日期</th>
                                    <th>工厂名称</th>
                                    <th>产品名称</th>
                                    <th>状态</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    //列举最近的5条
                                    HashMap<String,Object> hashMap2 = new HashMap<String,Object>();
                                    
											hashMap2.put("start", 0);
											hashMap2.put("size", 5);
											hashMap2.put("cusId", cusUser.getCusid());
											hashMap2.put("status", Configuration.BILL_REPORT_PASSED);
											
											OrderService orderService = new OrderService();
											List<Orders> ls =	orderService.findOrdersByStatusJudge(hashMap2);
                                    		if(ls != null&& ls.size()!=0){
                                    			for(int i=0;i<ls.size();i++){
                                    				Orders os = ls.get(i);
                                    				%>
                                <tr>
                                    <td scope="row"><%=os.getOrderid() %></td>
                                    <td><%=os.getExcedate() %></td>
                                    <td><%=os.getFactoryname() %></td>
                                    <td><%=os.getGoods() %></td>
                                    <td><%=os.getStatusString() %></td>
                                </tr>
                                <% 
                                    			}
                                    		}
                                    
                                    
                                    %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
        <!--/table-->
        <!--fast-orders-->

        <!--  
                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header"><strong class="card-title">快速下单</strong></div>
                            <div class="card-body">
                                <form action="#" method="post" class="form-horizontal">
                                    <div class="row form-group">
                                        <div class="col col-md-6"><select name="select" id="select" class="form-control">
                                                <option value="0">请选择服务类型</option>
                                                <option value="1">DPI</option>
                                                <option value="2">FRI</option>
                                                <option value="3">FUI</option>
                                            </select></div>
                                        <div class="col col-md-6"><input type="text" placeholder="请输入时间"
                                                class="form-control"></div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-6"><select name="select" id="select" class="form-control">
                                                <option value="0">请选择产品类目</option>
                                                <option value="1">电子机械类</option>
                                                <option value="2">服装纺织类</option>
                                                <option value="3">其他</option>
                                            </select></div>
                                        <div class="col col-md-6"><select name="select" id="select" class="form-control">
                                                <option value="0">请选择产品类型</option>
                                                
                                            </select></div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-6"><select name="select" id="select" class="form-control">
                                                <option value="0">国家</option>
                                                <option value="1">中国</option>
                                                <option value="2">美国</option>
                                                <option value="3">印度</option>
                                            </select></div>
                                        <div class="col col-md-6"><select name="select" id="select" class="form-control">
                                                <option value="0">省份</option>
                                                
                                            </select></div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-6"><select name="select" id="select" class="form-control">
                                                <option value="0">城市</option>
                                            </select></div>
                                        <div class="col col-md-6"><select name="select" id="select" class="form-control">
                                                <option value="0">区县</option>
                                            </select></div>
                                    </div>
                                    <div class="row form-group">
                                            <div class="col col-md-12">
                                            <textarea name="textarea-input" id="textarea-input" rows="2" placeholder="请输入详细地址" class="form-control"></textarea>
                                            </div>
                                    </div>
                                    <div>
                                            <button type="submit" class="btn btn-primary btn-sm">
                                                    <i class="fa fa-dot-circle-o"></i> 提交订单
                                                </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">订单完成率</strong>
                            </div>
                            <div class="card-body">
                                <div class="mx-auto d-block">
                                    <div class="progress mb-3">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 75%"
                                            aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                                <hr>
                                <div class="card-text text-sm-center">
                                    <p><i class="fa fa-square" style="color:goldenrod"></i>已完成订单数：<span>30</span>单</p>
                                    <p>订单总数：<span>40</span>单</p>
                                    <p>订单完成率：<span>75</span>%</p>
                                </div>
                               
                               

                            </div>
                        </div>

                    </div>
                </div>
                
                -->

        <!--/fast-orders-->

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
                        <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
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
                        <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
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
<div class="clearfix"></div>
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
<script src="assets/weather/js/jquery.simpleWeather.min.js"></script>

<script src="assets/js/lib/moment/moment.js"></script>
<script src="assets/calendar/fullcalendar.min.js"></script>
<script src="assets/calendar/fullcalendar-init.js"></script>
<!-- 
    <script src="assets/js/init/weather-init.js"></script>
  <script src="assets/weather/js/weather-init.js"></script>
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


</html>