package cn.hxy.inspect.customer.controller;

import cn.hxy.inspect.entity.customer.CusUser;
import cn.hxy.inspect.customer.service.DataStatisticService;
import cn.hxy.inspect.customer.service.OrderService;
import cn.hxy.inspect.customer.service.UserService;
import cn.hxy.inspect.entity.Account;
import cn.hxy.inspect.entity.Orders;
import cn.hxy.inspect.entity.admin.DataStatistic;
import cn.hxy.inspect.dao.GetOrderStatusWithList;
import cn.hxy.inspect.util.Configuration;
import cn.hxy.inspect.util.DateUtil;
import cn.hxy.inspect.util.SystemProperties;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping("/")
public class OrderController {
    private final static Logger logger = LoggerFactory.getLogger(OrderController.class);

    // 用户下单后接收订单信息
    @RequestMapping(value = "/cusInsertOrder", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> cusInsertOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        HashMap<String, Object> hashMap = new HashMap<>();
        CusUser cusUser = (CusUser) request.getSession().getAttribute("user");
        int resultCode = -1;
        int cusMoney = -1;// 用户钱包余额
        int moneyStatus = -1;// 0不足，1充足
        int billPrice = Configuration.BILL_PRICE;// 订单默认价格
        if (cusUser != null) {
            String orderId = DateUtil.getCurrentDateStr();// 采用微信的同样方式生成订单号，长度17
            // 返回订单号
            hashMap.put("orderId", orderId);

            // https://blog.csdn.net/u013230511/article/details/48314491

            String excdate = null;
            String facname = null;
            String facaddress = null;
            String facman = null;
            String factel = null;
            String profile = null;
            String type = null;
            String reports = null;
            int status = 0;
            String fee = null;
            String cost = null;
            String otherCost = null;
            String profit = null;
            String goods = null;
            String goodsType = null;
            String fileName = null;
            String fileUuidName = null;

            boolean freshMan = false;
            // 判断是否为新用户，如果是新用户，则第一单免费
            UserService userService = new UserService();
            cusUser = userService.selectUserById(cusUser.getCusid());

            if (cusUser.getCusOrders() == 0) {
                freshMan = true;
                status = Configuration.BILL_SUBMITTED;//新用户直接提交成功！
            }
            // 如果是新用户，订单界面直接提示新用户
            hashMap.put("fresh", freshMan);

            boolean flag = false;
            try {
                // 使用Apache文件上传组件处理文件上传步骤：
                // 1、创建一个DiskFileItemFactory工厂
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // 2、创建一个文件上传解析器
                ServletFileUpload upload = new ServletFileUpload(factory);
                // 解决上传文件名的中文乱码
                upload.setHeaderEncoding("UTF-8");
                // 3、判断提交上来的数据是否是上传表单的数据
                if (!ServletFileUpload.isMultipartContent(request)) {
                    // 按照传统方式获取数据
                    resultCode = 1;
                } else {

                    // 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项

                    List<FileItem> list = null;

                    // 解决：https://blog.csdn.net/sinat_34104446/article/details/82755403

                    RequestContext context = new ServletRequestContext(request);
                    try {
                        list = upload.parseRequest(context);
                        logger.info("遍历的大小" + list.size());
                    } catch (FileUploadException e) {
                        e.printStackTrace();
                    }

                    for (FileItem item : list) {
                        logger.info("遍历文件");
                        if (item.isFormField()) {

                            String key = item.getFieldName();
                            String value = null;
                            try {
                                value = item.getString("UTF-8");
                            } catch (UnsupportedEncodingException e) {
                                e.printStackTrace();
                            }
                            logger.info(key + "\t" + value);
                            switch (key) {
                                case "excdate":
                                    excdate = value;
                                    break;
                                case "facname":
                                    facname = value;
                                    break;
                                case "facaddress":
                                    facaddress = value;
                                    break;
                                case "facman":
                                    facman = value;
                                    break;
                                case "factel":
                                    factel = value;
                                    break;
                                case "profile":
                                    profile = value;
                                    break;
                                case "goods":
                                    goods = value;
                                    break;
                                case "goodsType":
                                    goodsType = value;
                                    break;
                                case "post_type":
                                    if ("temp".equals(value)) {
                                        status = Configuration.BILL_TEMP;// 保存草稿
                                    } else if ("unpay".equals(value)) {
                                        status = Configuration.BILL_UNPAY;// 提交未付款，下一步就是付款
                                    } else {
                                        status = Configuration.BILL_EXCEPTION;// 未知订单状态，处理一些反爬虫等。
                                    }
                                default:
                                    break;
                            }

                        } else {
                            String uuid = UUID.randomUUID().toString().replace("-", "");

                            // 生成随机数和id，文件重新命名为id+原来名字，存入数据库.
                            fileName = item.getName();
                            fileUuidName = uuid + fileName;
                            String reportDir = SystemProperties.getProperty("reportDir");

                            File file = new File(reportDir, fileUuidName);
                            try (InputStream in = item.getInputStream();
                                 FileOutputStream out = new FileOutputStream(file)) { // 创建一个文件输出流

                                // 创建一个缓冲区
                                byte buffer[] = new byte[1024]; // 判断输入流中的数据是否已经读完的标识
                                int len = 0;
                                // 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
                                while ((len = in.read(buffer)) > 0) {
                                    out.write(buffer, 0, len);
                                } // 关闭输入流
                                in.close();
                                // 关闭输出流
                                out.close();
                                // 删除处理文件上传时生成的临时文件
                                item.delete();
                                resultCode = 200;

                            } catch (FileNotFoundException e) {
                                e.printStackTrace();
                                resultCode = 601;// 错误
                            } catch (IOException e) {

                            }
                            logger.info("文件名路径：" + file.getAbsolutePath());
                        }
                    }
                }
                flag = true;
            } catch (NullPointerException e) {
                logger.warn("传入的是一个null");
            }
            if (flag) {
//			获取时间
                Date now = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 可以方便地修改日期格式
                String date = dateFormat.format(now);
                Orders order = new Orders();
                order.setOrderid(orderId);
                order.setCusId(cusUser.getCusid());
                order.setCost(cost);
                order.setDate(date);
                order.setExcedate(excdate);
                order.setFactoryaddress(facaddress);
                order.setFactoryman(facman);
                order.setFactoryname(facname);
                order.setFactorytel(factel);
                order.setFile(type);
                order.setReportfile(reports);
                order.setProfile(profile);
                order.setStatus(status);
                order.setGoods(goods);
                order.setGoodsType(goodsType);
                order.setFileuuid(fileUuidName);
                order.setFile(fileName);
                OrderService orderService = new OrderService();
                //新用户直接付款完成
                if (freshMan) {
                    status = Configuration.BILL_PAY;//新用户第一单直接
                }

                // 无论是新用户还是啥用户，订单提交后都是先存储到数据库，并且记录状态为未付款
                if (orderService.insert(order)) {
                    resultCode = 200;
                    // 更新订单总数
                    int a = cusUser.getCusOrders() + 1;
                    cusUser.setCusOrders(a);
                    //更新用户信息
                    userService.updateOrders(cusUser);
                    //更新总订单信息
                    DataStatisticService dataStatisticService = new DataStatisticService();
                    DataStatistic dataStatistic = dataStatisticService.select();
                    int b = dataStatistic.getTotal();
                    b = b + 1;
                    dataStatistic.setTotal(b);
                    int c = dataStatistic.getUnfinishedBill();
                    c = c + 1;
                    dataStatistic.setUnfinishedBill(c);

                    try {
                        // 更新统计订单信息
                        dataStatisticService.update(dataStatistic);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } else {
                    resultCode = 500;
                }
            } else {
                resultCode = 400;// bad request
            }

            if (status == Configuration.BILL_UNPAY) {
                // 返回钱包信息，
                cusMoney = cusUser.getCusMoney();

                if (cusMoney >= billPrice) {
                    // 余额充足
                    moneyStatus = 1;

                } else {
                    // 余额不足
                    moneyStatus = 0;
                }

            }

        } else {
            resultCode = 604;// 返回没有数据
        }

        //用户提交了订单之后，直接以未支付的状态插入数据库，然后返回用户信息钱包等信息，由前端给出继续付款。还是提示余额不足，需要充足等信息。
        logger.info("返回金额信息");


        hashMap.put("resultCode", resultCode);// 返回操作状态
        hashMap.put("moneyStatus", moneyStatus);// 返回订单是否有足够支付的的余额
        hashMap.put("cusMoney", cusMoney);// 用户余额
        hashMap.put("billPrice", billPrice);// 订单价格

        return hashMap;
    }

    @RequestMapping(value = "/cusSelectOrder", method = RequestMethod.POST)
    public void cusSelectOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        CusUser cusUser = (CusUser) request.getSession().getAttribute("user");

    }

    // 订单支付
    @ResponseBody
    @RequestMapping(value = "/orderPay", method = RequestMethod.POST)
    public HashMap<String, Object> orderPay(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        CusUser cusUser = (CusUser) request.getSession().getAttribute("user");
        int resultCode = 0;
        HashMap<String, Object> hashMap = new HashMap<>();
        if (cusUser != null) {
            logger.info(String.format("用户%s在支付订单", cusUser.getCusname()));

            // 获取订单号即可完成支付？这个逻辑有点扯？
            boolean flag = false;
            String ordersId = null;
            String pay = null;
            try {
                ordersId = request.getParameter("orderId").trim();// 订单号
                pay = request.getParameter("pay").trim();// 备注
                flag = true;
            } catch (Exception e) {
            }
            if (flag) {
                OrderService orderService = new OrderService();
                try {
                    Orders orders = orderService.selectOrderById(ordersId);
                    if (orders != null && "true".equals(pay)) {
                        //第一步确定是否余额充足，不充足天转充值界面，充足就不跳转充值界面

                        // 扣款
                        UserService userService = new UserService();
                        cusUser = userService.selectUserById(cusUser.getCusid());

                        int a = cusUser.getCusMoney() - Configuration.BILL_PRICE;// 每单的定价
                        //如果余额充足，则完成订单支付。如果余额不足返回不足提示信息
                        if (a >= 0) {
                            logger.info(String.format("%s 余额充足 %s", cusUser.getCusname(), cusUser.getCusMoney()));
                            cusUser.setCusMoney(a);
                            userService.update(cusUser);
                            // 更新订单状态
                            orders.setStatus(Configuration.BILL_PAY);// 订单已支付
                            orderService.updateStatus(orders);
                            resultCode = 200;
                        } else {
                            //余额不足，跳转到充值界面
                            logger.warn(String.format("%s余额不足：%s", cusUser.getCusname(), cusUser.getCusMoney()));
                            resultCode = 607;
                        }


                        // 需要加上钱包明细
                        Account account = new Account();
//					account.set
                    } else {
                        resultCode = 601;
                    }

                } catch (IOException e) {
                    e.printStackTrace();
                }

            } else {
                resultCode = 404;
            }
        }
        logger.info(String.format("返回支付信息%s", resultCode));
        hashMap.put("resultCode", resultCode);
        return hashMap;

    }

    @RequestMapping(value = "/details2", method = RequestMethod.GET)
    public String details2(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        CusUser cusUser = (CusUser) request.getSession().getAttribute("user");
        if (cusUser != null) {

            String ordersId = request.getParameter("id").trim();// 备注
            // 先依据id查询该订单，再判断该订单是否是该用户的，防止恶意的爬虫
            OrderService orderService = new OrderService();
            try {
                Orders orders = orderService.selectOrderById(ordersId);
                if (orders != null) {
                    model.addAttribute("status", orders.getStatusString());
                    model.addAttribute("ordersId", ordersId);
                    model.addAttribute("goods", orders.getGoods());
                    model.addAttribute("custel", orders.getCusId());
                    model.addAttribute("exceData", orders.getExcedate());
                    String inspectTel = orders.getQualId();
                    if ("null".equals(inspectTel)) {
                        model.addAttribute("inspec", "请填写质检员号码");
                    } else
                        model.addAttribute("inspec", orders.getQualId());

                    model.addAttribute("exceData", orders.getExcedate());
                    model.addAttribute("factoyName", orders.getFactoryname());
                    model.addAttribute("facAddress", orders.getFactoryaddress());
                    model.addAttribute("facMan", orders.getFactoryman());
                    model.addAttribute("facTel", orders.getFactorytel());
                    model.addAttribute("date", orders.getDate());
                    model.addAttribute("", orders.getExcedate());
                    String report = orders.getReportfile();
                    String reportuuid = orders.getReportfileuuid();

                    if (report != null && !"".equals(report) && !"null".equals(report)) {
                        model.addAttribute("report", report);
                    } else
                        model.addAttribute("report", "没有报告文件");

                    if (reportuuid != null && !"".equals(reportuuid) && !"null".equals(reportuuid)) {
                        model.addAttribute("reportuuid", reportuuid);
                    } else {
                        model.addAttribute("reportuuid", "null");
                    }

                }
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            return "order/orders-details2";
        } else
            return "lose";

    }

    //	报告完成后的详情，已经不可以修改报告了
    @RequestMapping(value = "/details3", method = RequestMethod.GET)
    public String details3(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        CusUser cusUser = (CusUser) request.getSession().getAttribute("user");
        if (cusUser != null) {

            String ordersId = request.getParameter("id").trim();// 备注
            // 先依据id查询该订单，再判断该订单是否是该用户的，防止恶意的爬虫
            OrderService orderService = new OrderService();
            try {
                Orders orders = orderService.selectOrderById(ordersId);
                if (orders != null) {
                    model.addAttribute("status", orders.getStatusString());
                    model.addAttribute("ordersId", ordersId);
                    model.addAttribute("goods", orders.getGoods());
                    model.addAttribute("custel", orders.getCusId());
                    model.addAttribute("exceData", orders.getExcedate());
                    String inspectTel = orders.getQualId();
                    if ("null".equals(inspectTel)) {
                        model.addAttribute("inspec", "请填写质检员号码");
                    } else
                        model.addAttribute("inspec", orders.getQualId());

                    model.addAttribute("exceData", orders.getExcedate());
                    model.addAttribute("factoyName", orders.getFactoryname());
                    model.addAttribute("facAddress", orders.getFactoryaddress());
                    model.addAttribute("facMan", orders.getFactoryman());
                    model.addAttribute("facTel", orders.getFactorytel());
                    model.addAttribute("date", orders.getDate());
                    model.addAttribute("", orders.getExcedate());
                    String report = orders.getReportfile();
                    String reportuuid = orders.getReportfileuuid();

                    if (report != null && !"".equals(report) && !"null".equals(report)) {
                        model.addAttribute("report", report);
                    } else
                        model.addAttribute("report", "没有报告文件");

                    if (reportuuid != null && !"".equals(reportuuid) && !"null".equals(reportuuid)) {
                        model.addAttribute("reportuuid", reportuuid);
                    } else {
                        model.addAttribute("reportuuid", "null");
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            return "order/orders-details-finished";
        } else
            return "lose";
    }

    @RequestMapping(value = "/orders-unfinished", method = RequestMethod.GET)
    public String customer_getUnfinishOrders(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        CusUser cusUser = (CusUser) request.getSession().getAttribute("user");
        List<Orders> ls = null;
        // 将status放入list中
        List<Integer> list = new ArrayList<>();
        OrderService o = new OrderService();
        HashMap<String, Object> map = new HashMap<String, Object>();
        // 获得一部分status
        list.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_SUBMITTED,
                Configuration.BILL_REFUSED_BY_ADMIN));
        logger.info("" + list);
        list.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_ASSIGNING_BY_ADMIN_UNPAID,
                Configuration.BILL_REFUSED_BY_ADMIN_UNPAID));
        logger.info("" + list);
        list.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_INSPECTOR_CONFIRM,
                Configuration.BILL_REPORT_VERIFIED));
        logger.info("" + list);
        list.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_REPORT_REFUSED_BY_ADMIN_UNPAID,
                Configuration.BILL_REPORT_PASSED_BY_ADMIN_UNPAID));
        logger.info("" + list);
        map.put("cusId", cusUser.getCusid());
        map.put("list", list);
        ls = o.findOrdersByRange(map);
        model.addAttribute("list", ls);
        logger.info("unfinish order model: " + model);
        return "order/orders-unfinished";
    }

    @RequestMapping(value = "/orders-finished", method = RequestMethod.GET)
    public String customer_getFinishOrders(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        CusUser cusUser = (CusUser) request.getSession().getAttribute("user");
        List<Orders> ls = null;
        // 将status放入list中
        OrderService o = new OrderService();
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("cusId", cusUser.getCusid());
        //用户确认报告通过
        map.put("status", Configuration.BILL_REPORT_PASSED);
        try {
            ls = o.selectAllByIdAndStatus(map);
        } catch (IOException e) {
            e.printStackTrace();
        }
        model.addAttribute("list", ls);
        logger.info("unfinish order model: " + model);
        return "order/orders-finished";
    }


}
