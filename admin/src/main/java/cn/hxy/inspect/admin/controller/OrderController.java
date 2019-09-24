package cn.hxy.inspect.admin.controller;

import cn.hxy.inspect.admin.service.AdminUserService;
import cn.hxy.inspect.admin.service.CusUserService;
import cn.hxy.inspect.admin.service.InspectorService;
import cn.hxy.inspect.admin.service.OrderService;
import cn.hxy.inspect.dao.GetOrderStatusWithList;
import cn.hxy.inspect.entity.Orders;
import cn.hxy.inspect.entity.admin.AdminUser;
import cn.hxy.inspect.entity.customer.CusUser;
import cn.hxy.inspect.entity.inspector.Inspector;
import cn.hxy.inspect.util.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/")
public class OrderController {
    private final static Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Resource
    OrderService orderService;
    @Resource
    CusUserService cusUserService;
    @Resource
    AdminUserService adminUserService;
    @Resource
    InspectorService inspectorService;

    @RequestMapping(value = "/cusInsertOrder", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> cusInsertOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        AdminUser user = (AdminUser) request.getSession().getAttribute("user");
        int resultCode = -1;
        if (user != null) {
            // https://blog.csdn.net/u013230511/article/details/48314491
            String excdate = null;
            String facname = null;
            String facaddress = null;
            String facman = null;
            String factel = null;
            String profile = null;
            String file = null;
            String reports = null;
            int status = 0;
            String fee = null;
            String cost = null;
            String otherCost = null;
            String profit = null;
            String goods = null;
            boolean flag = false;
            try {
                excdate = request.getParameter("excdate").trim();// 执行日期
                facname = request.getParameter("facname").trim();// 工厂名称
                facaddress = request.getParameter("facaddress").trim();// 工厂地址
                facman = request.getParameter("facman").trim();// 联系人
                factel = request.getParameter("factel").trim();// 联系人电话
                profile = request.getParameter("profile").trim();// 备注
                goods = request.getParameter("goods").trim();// 备注
//			file = request.getParameter("file").trim();// 附件
                flag = true;
            } catch (NullPointerException e) {
                logger.warn("传入的是一个null");
            }
            if (flag) {
//			获取时间
                Date now = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 可以方便地修改日期格式
                String date = dateFormat.format(now);
                status = Configuration.BILL_ASSIGNED;// 1.提交成功 2.正在验货员正在接单 3.验货员已经出发，4.报告撰写中，5，已完成
                Orders order = new Orders();
                order.setCusId(user.getAdminTel());
                order.setCost(cost);
                order.setDate(date);
                order.setExcedate(excdate);
                order.setFactoryaddress(facaddress);
                order.setFactoryman(facman);
                order.setFactoryname(facname);
                order.setFactorytel(factel);
                order.setFile(file);
                order.setReportfile(reports);
                order.setProfile(profile);
                order.setStatus(status);
                order.setGoods(goods);
//				OrderService orderService = new OrderService();
                if (orderService.insert(order)) {
                    resultCode = 200;
                } else {
                    resultCode = 500;
                }
            } else {
                resultCode = 400;// bad request
            }
        } else {
            resultCode = 604;// 返回没有数据
        }
        logger.info("返回注册信息");
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("resultCode", resultCode);
        return hashMap;
    }

    @RequestMapping(value = "/orders-new", method = RequestMethod.GET)
    public String customer_getUnfinishOrders(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("utf-8");
        AdminUser adminUser = (AdminUser) request.getSession().getAttribute("user");
        List<Orders> ls = null;
        // 将status放入list中
        List<Integer> list = new ArrayList<>();
//		OrderService o = new OrderService();
        HashMap<String, Object> map = new HashMap<String, Object>();
        // 获得一部分status
        list.add(Configuration.BILL_PAY);
        list.add(Configuration.BILL_UNPAY);
        logger.info("{}", list);
        map.put("list", list);
        ls = orderService.findOrdersByRange(map);
        model.addAttribute("list", ls);
        logger.info("orders-new model: " + model);
        return "orders/orders-new";
    }

    @RequestMapping(value = "new-orders-details", method = RequestMethod.GET)
    public String newOrders(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 返回页面防止出现中文乱码
        request.setCharacterEncoding("UTF-8");
        // 获取用户是否登录
        AdminUser user = (AdminUser) request.getSession().getAttribute("user");
        String ordersId = request.getParameter("id");
        logger.info("id：" + ordersId);
        // 依据id查询数据库得知数据库的订单详细信息
        Orders orders = null;
        CusUser cusUser = null;

        orders = orderService.selectOrderById(ordersId);

        // 依据订单查询订单的客户信息
        cusUser = cusUserService.selectUserById(orders.getCusId());


        if (orders != null && cusUser != null) {
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
            model.addAttribute("cusName", cusUser.getCusname());
            model.addAttribute("city", cusUser.getCity());
            model.addAttribute("email", cusUser.getEmail());
            model.addAttribute("cusOrders", cusUser.getCusOrders());
            model.addAttribute("money", cusUser.getCusMoney());
            model.addAttribute("integral", cusUser.getCusgrade());
        }

        List<Inspector> inspectorLs = inspectorService.selectAll();
        model.addAttribute("list", inspectorLs);

        return "orders/new-orders-details";

    }

    @RequestMapping(value = "/details-orders2", method = RequestMethod.GET)
    public String cusSelectOrder2(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 获取用户是否登录
        AdminUser user = (AdminUser) request.getSession().getAttribute("user");
        String ordersId = request.getParameter("id");
        logger.info("id：" + ordersId);

        // 依据id查询数据库得知数据库的订单详细信息
        OrderService orderService = new OrderService();
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
//			model.addAttribute("", orders.getExcedate());

            // 通过订单的验货员信息与用户信息找到两个人资料
            CusUserService cusUserService = new CusUserService();
            CusUser cusUser = cusUserService.selectUserById(orders.getCusId());

            if (cusUser != null) {
                model.addAttribute("culName", cusUser.getCusname());
                model.addAttribute("culAddress", cusUser.getCusaddress());
                model.addAttribute("culEmail", cusUser.getEmail());
                model.addAttribute("culMoney", cusUser.getCusMoney());
                model.addAttribute("culGrade", cusUser.getCustrade());
                model.addAttribute("culOrders", cusUser.getCusOrders());
            }

            InspectorService inspectorService = new InspectorService();
            Inspector inspector = inspectorService.findInspectorById(orders.getQualId());
            if (inspector != null) {
                model.addAttribute("inspName", inspector.getUserName());
                model.addAttribute("inspAddress", inspector.getAddress());
                model.addAttribute("inspTel", inspector.getUserTel());
                model.addAttribute("inspOrders", inspector.getOrders());
                model.addAttribute("inspMoney", inspector.getMoney());
                model.addAttribute("integral", inspector.getIntegral());

            }

        }

        return "orders/orders-details2";

    }

    //    details3
    @RequestMapping(value = "/details3", method = RequestMethod.GET)
    public String detailsAll(@RequestParam("id") String id, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Orders orders = orderService.selectOrderById(id);
        //依据订单去查找用户信息和质检员信息
        CusUser cusUser = cusUserService.selectUserById(orders.getCusId());
        Inspector inspector = inspectorService.findInspectorById(orders.getQualId());
        model.addAttribute("orders", orders);
        model.addAttribute("cusUser", cusUser);
        model.addAttribute("inspector", inspector);
        return "orders/orders-details-all";
    }


    @RequestMapping(value = "/orders-details-all", method = RequestMethod.GET)
    public String cusSelectOrderAjax(@RequestParam("id") String ordersId, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 获取用户是否登录
        AdminUser user = (AdminUser) request.getSession().getAttribute("user");
        logger.info("id：" + ordersId);
        Orders orders = orderService.selectOrderById(ordersId);
        CusUser cusUser = cusUserService.selectUserById(orders.getCusId());
        Inspector inspector = inspectorService.findInspectorById(orders.getQualId());
        model.addAttribute("orders", orders);
        model.addAttribute("cusUser", cusUser);
        model.addAttribute("inspector", inspector);

        return "orders/orders-details-all";
    }


    @RequestMapping(value = "/orders-details-report-conform", method = RequestMethod.GET)
    public String ordersDetailsReportConform(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        try {
            // 返回页面防止出现中文乱码
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        // 获取用户是否登录
        AdminUser user = (AdminUser) request.getSession().getAttribute("user");

        String ordersId = request.getParameter("id");
        logger.info("id：" + ordersId);

        // 依据id查询数据库得知数据库的订单详细信息

        OrderService orderService = new OrderService();
        Orders orders = null;
        try {
            orders = orderService.selectOrderById(ordersId);
        } catch (IOException e) {
            e.printStackTrace();
        }
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
            model.addAttribute("report", orders.getReportfile());
            model.addAttribute("reportuuid", orders.getReportfileuuid());

            // 通过订单的验货员信息与用户信息找到两个人资料
            CusUserService cusUserService = new CusUserService();
            CusUser cusUser = cusUserService.findCusUserByTel(orders.getCusId());

            if (cusUser != null) {
                model.addAttribute("culName", cusUser.getCusname());
                model.addAttribute("culAddress", cusUser.getCusaddress());
                model.addAttribute("culEmail", cusUser.getEmail());
                model.addAttribute("culMoney", cusUser.getCusMoney());
                model.addAttribute("culGrade", cusUser.getCustrade());
                model.addAttribute("culOrders", cusUser.getCusOrders());
            } else
                logger.error("用户信息异常！" + orders.getCusId());

            InspectorService inspectorService = new InspectorService();
            Inspector inspector = inspectorService.findInspectorByTel(orders.getQualId());
            if (inspector != null) {
                logger.info("inspector:" + inspector);
                model.addAttribute("inspName", inspector.getUserName());
                model.addAttribute("inspAddress", inspector.getAddress());
                model.addAttribute("inspTel", inspector.getUserTel());
                model.addAttribute("inspOrders", inspector.getOrders());
                model.addAttribute("inspMoney", inspector.getMoney());
                model.addAttribute("integral", inspector.getIntegral());

            } else
                logger.error("质检员信息异常！" + orders.getQualId());

        }

        return "orders/orders-details-report-conform";

    }

    @RequestMapping(value = "/allotOrder", method = RequestMethod.POST)
    @ResponseBody
    public HashMap allotOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        AdminUser user = (AdminUser) request.getSession().getAttribute("user");
        HashMap<String, Object> hashMap = new HashMap<>();
        int resultCode = -1;
        if (user != null) {
            // https://blog.csdn.net/u013230511/article/details/48314491
            String inpectTel = null;
            String fee = null;
            int status = 0;
            String orderId = null;
            boolean flag = true;
            try {
                inpectTel = request.getParameter("inpectTel").trim();// 执行日期
                fee = request.getParameter("fee").trim();// 工厂名称
                orderId = request.getParameter("id").trim();// 工厂名称
                flag = true;
            } catch (NullPointerException e) {
                logger.warn("传入的是一个null");
            }
            if (flag) {
//			获取时间
                Date now = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 可以方便地修改日期格式
                String date = dateFormat.format(now);
                status = Configuration.BILL_ASSIGNING;// 1.提交成功 2.正在验货员正在接单 3.验货员已经出发，4.报告撰写中，5，已完成
                Orders order = new Orders();
                order.setFee(fee);
                order.setQualId(inpectTel);
                order.setOrderid(orderId);
                order.setStatus(status);

                OrderService orderService = new OrderService();
                if (orderService.updateInspect(order)) {
                    resultCode = 200;
                } else {
                    resultCode = 500;
                }
            } else {
                resultCode = 400;// bad request
            }
        } else {
            resultCode = 604;// 返回没有数据
        }

        hashMap.put("resultCode", resultCode);
        return hashMap;
    }

    @RequestMapping(value = "/assign", method = RequestMethod.POST)
    @ResponseBody
    public HashMap assignOrders(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        AdminUser user = (AdminUser) request.getSession().getAttribute("user");
        HashMap<String, Object> hashMap = new HashMap<>();
        int resultCode = -1;
        if (user != null) {
            boolean flag = false;
            String id = null;
            String qualId = null;
            try {
                id = request.getParameter("id").trim();// 订单号
                qualId = request.getParameter("tel").trim();// 质检员的id
                logger.info("传入两个参数" + id + "\t" + qualId);
                flag = true;
            } catch (NullPointerException e) {
                logger.warn("传入的是一个null");
            }
            if (flag) {
                Orders order = new Orders();
                order.setQualId(qualId);
                order.setOrderid(id);
                order.setStatus(Configuration.BILL_ASSIGNING);// 已分配

//			为该用户更新订单，依据订单的id查找订单，修改质检员的电话号码
                OrderService orderService = new OrderService();
                if (orderService.assignOrders(order)) {
                    resultCode = 200;
                } else {
                    resultCode = 500;
                };
            } else {

            }
            hashMap.put("resultCode", resultCode);
        }
        return hashMap;
    }

    @RequestMapping(value = "orders-all", method = RequestMethod.GET)
    public String ordersAll(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Orders> list = orderService.selectAll();
        modelMap.addAttribute("list", list);
        return "orders/orders-all";
    }

    @RequestMapping(value = "orders-checking", method = RequestMethod.GET)
    public String ordersChecking(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Orders> list = orderService.selectTodayTomorrowOrders();
        modelMap.addAttribute("list", list);
        return "orders/orders-checkings";
    }

    @RequestMapping(value = "orders-unfinished", method = RequestMethod.GET)
    public String ordersUnfinished(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Orders> list = orderService.selectUnfinishedOrders();
        modelMap.addAttribute("list", list);
        return "orders/orders-unfinished";
    }

    @RequestMapping(value = "orders-finished", method = RequestMethod.GET)
    public String ordersFinished(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Orders> list = orderService.selectFinishedOrders();
        modelMap.addAttribute("list", list);
        return "orders/orders-finished";
    }

}
