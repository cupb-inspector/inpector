<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>Ela Admin - HTML5 Admin Template</title>
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
    </style>
</head>

<body>
        <!-- Content -->
        <div class="content" style="background:#f1f2f7;height: 100%">
            <!-- Animated -->
            <div class="animated fadeIn">
                <!-- Widgets  -->

                <!-- /Widgets -->
                <!--  moneytable  -->
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="custom-tab">

                                <nav>
                                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                        <a class="nav-item nav-link active show" id="custom-nav-home-tab"
                                            data-toggle="tab" href="#custom-nav-home" role="tab"
                                            aria-controls="custom-nav-home" aria-selected="true">
                                            <h4>我的伙伴</h4>
                                        </a>
                                        <a class="nav-item nav-link" id="custom-nav-profile-tab" data-toggle="tab"
                                            href="#custom-nav-profile" role="tab" aria-controls="custom-nav-profile"
                                            aria-selected="false">
                                            <h4>正在合作</h4>
                                        </a>
                                        <a class="nav-item nav-link" id="custom-nav-contact-tab" data-toggle="tab"
                                            href="#custom-nav-contact" role="tab" aria-controls="custom-nav-contact"
                                            aria-selected="false">
                                            <h4>历史合作</h4>
                                        </a>
                                    </div>
                                </nav>
                                <div class="tab-content pl-3 pt-2" id="nav-tabContent">
                                    <div class="tab-pane fade active show" id="custom-nav-home" role="tabpanel"
                                        aria-labelledby="custom-nav-home-tab">
                                        <div class='row'>
                                            <div class="col-lg-12">
                                                <div class="card">
                                                    <div class="card-head">
                                                        <input placeholder="请输入伙伴的ID或手机号">
                                                            <button type="button" class="btn btn-link"><i class="fa fa-search"></i></button>
                                                        <a href="#">
                                                            <span class="badge badge-warning float-right mt-1">+ 加伙伴</span>
                                                        </a>
                                                    </div>
                                                    <div class="table-stats order-table ov-h">
                                                        <table class="table ">
                                                            <thead>
                                                                <tr>
                                                                    <th class="serial"><h4>#</h4></th>
                                                                    <th class="avatar"><h4>头像</h4></th>
                                                                    <th><h4>ID</h4></th>
                                                                    <th><h4>手机号</h4></th>
                                                                    <th><h4>名称</h4></th>
                                                                    <th><h4>操作</h4></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="serial">1.</td>
                                                                    <td class="avatar">
                                                                        <div class="round-img">
                                                                            <a href="#"><img class="rounded-circle"
                                                                                    src="images/avatar/1.jpg"
                                                                                    alt=""></a>
                                                                        </div>
                                                                    </td>
                                                                    <td> #5469 </td>
                                                                    <td> 5469 </td>

                                                                    <td> <span class="name">Louis Stanley</span> </td>
                                                                    <td>
                                                                            <span class="badge badge-primary pull-right">查看</span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="serial">2.</td>
                                                                    <td class="avatar">
                                                                        <div class="round-img">
                                                                            <a href="#"><img class="rounded-circle"
                                                                                    src="images/avatar/2.jpg"
                                                                                    alt=""></a>
                                                                        </div>
                                                                    </td>
                                                                    <td> #5468 </td>
                                                                    <td> 5469 </td>
                                                                    <td> <span class="name">Gregory Dixon</span> </td>
                                                                    <td>
                                                                            <span class="badge badge-primary pull-right">查看</span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="serial">3.</td>
                                                                    <td class="avatar">
                                                                        <div class="round-img">
                                                                            <a href="#"><img class="rounded-circle"
                                                                                    src="images/avatar/3.jpg"
                                                                                    alt=""></a>
                                                                        </div>
                                                                    </td>
                                                                    <td> #5467 </td>
                                                                    <td> 5469 </td>
                                                                    <td> <span class="name">Catherine Dixon</span> </td>
                                                                    <td>
                                                                            <span class="badge badge-primary pull-right">查看</span>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div> <!-- /.table-stats -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/little_tab-->
                                    <div class="tab-pane fade" id="custom-nav-profile" role="tabpanel"
                                        aria-labelledby="custom-nav-profile-tab">
                                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>订单号</th>
                                                    <th>验货日期</th>
                                                    <th>工厂名称</th>
                                                    <th>产品名称</th>
                                                    <th>状态</th>
                                                    <th>工作量</th>
                                                    <th>我的伙伴</th>
                                                    <th>操作</th>

                                                </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                    <!--/little_tab-->
                                    <div class="tab-pane fade" id="custom-nav-contact" role="tabpanel"
                                        aria-labelledby="custom-nav-contact-tab">
                                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>订单号</th>
                                                    <th>验货日期</th>
                                                    <th>工厂名称</th>
                                                    <th>产品名称</th>
                                                    <th>状态</th>
                                                    <th>工作量</th>
                                                    <th>我的伙伴</th>
                                                    <th>操作</th>

                                                </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                    <!--/little_tab-->
                                </div>

                            </div>
                        </div>
                    </div>
                </div>


                <!--  /moneytable -->

                <!-- Orders -->

                <!-- /.orders -->
                <!-- To Do and Live Chat -->

                <!-- /To Do and Live Chat -->
                <!-- Calender Chart Weather  -->

                <!-- /Calender Chart Weather -->

            </div>
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
    <script src="assets/calendar/fullcalendar-init.js"></script>cript>
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
</body>
</html>