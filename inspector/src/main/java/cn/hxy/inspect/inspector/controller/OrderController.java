package cn.hxy.inspect.inspector.controller;

import cn.hxy.inspect.entity.Orders;
import cn.hxy.inspect.entity.inspector.Inspector;
import cn.hxy.inspect.inspector.service.OrderService;
import org.apache.tomcat.jni.User;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;

import static cn.hxy.inspect.util.Configuration.BILL_ASSIGNING;


@Controller
@RequestMapping("/")
public class OrderController {
    private final static Logger logger = LoggerFactory.getLogger(OrderController.class);
    @Resource
    OrderService orderService;


    @RequestMapping(value = "/checks", method = RequestMethod.GET)
    public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //找到已经分配的订单
        Inspector user = (Inspector) request.getSession().getAttribute("user");

        return "orders/checks";
    }

    @RequestMapping(value = "/orders-cancel", method = RequestMethod.GET)
    public String cancel(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //找到已经分配的订单
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        //枚举模板，只要是迭代类型变量都可以
        List<Integer> odUD = new Vector<Integer>();
        int[] temp = new int[]{1, 2, 3, 4, 5};
        for (int i : temp) odUD.add(i);
        OrderService orderService = new OrderService();
        List<Orders> ls = orderService.findOrdersByStatusAndInspector(odUD, user.getUserId());
        model.addAttribute("list", ls);
        return "orders/orders-cancel";
    }

    @RequestMapping(value = "/orders-checking", method = RequestMethod.GET)
    public String checking(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //找到已经分配的订单
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        Orders orders = new Orders();
        orders.setQualId(user.getUserId());
        orders.setStatus(3);//查询订单已分配的订单
        orderService = new OrderService();
        List<Orders> ls = orderService.findUserByQualIdAndStatus(orders);
        model.addAttribute("list", ls);
        return "orders/orders-checking";
    }

    @RequestMapping(value = "/orders-examining", method = RequestMethod.GET)
    public String examining(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //找到已经分配的订单
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        Orders orders = new Orders();
        orders.setQualId(user.getUserId());
        orders.setStatus(BILL_ASSIGNING);//查询订单已分配的订单
        logger.info("{} 查询所有管理员分配到的订单",user.getUserId());
        orderService = new OrderService();
        List<Orders> ls = orderService.findUserByQualIdAndStatus(orders);
        model.addAttribute("list", ls);
        return "orders/orders-examining";
    }

    @RequestMapping(value = "/orders-all", method = RequestMethod.GET)
    public String all(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Inspector user = (Inspector) request.getSession().getAttribute("user");

        logger.info("{} 查询质检员的所有订单",user.getUserId());

        List<Orders> ls = orderService.findAllOrdersByQualId(user.getUserId());
        model.addAttribute("list", ls);
        return "orders/orders-all";
    }

    @RequestMapping(value = "/check", method = RequestMethod.GET)
    public String check(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //找到已经分配的订单
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        //枚举模板，只要是迭代类型变量都可以
        List<Integer> odUD = new Vector<Integer>();

        int[] temp = new int[]{1, 2, 3, 4, 5};
        for (int i : temp) odUD.add(i);

        List<Orders> ls = orderService.findOrdersByStatus(odUD);
        model.addAttribute("list", ls);
        return "orders/check";
    }

    @RequestMapping(value = "/orders-check", method = RequestMethod.GET)
    public String orderCheck(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //找到已经分配的订单
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        Orders orders = new Orders();
        orders.setQualId(user.getUserId());
        orders.setStatus(2);//查询订单已分配的订单
        List<Orders> ls = orderService.findUserByQualIdAndStatus(orders);
        model.addAttribute("list", ls);
        return "orders/orders-check";
    }

    @RequestMapping(value = "/cusInsertOrder", method = RequestMethod.POST)
    public void cusInsertOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        Inspector user = (Inspector) request.getSession().getAttribute("user");
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
                status = 1;// 1.提交成功 2.正在验货员正在接单 3.验货员已经出发，4.报告撰写中，5，已完成
                Orders order = new Orders();
                order.setCusId(user.getUserTel());
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
                OrderService orderService = new OrderService();
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
        org.json.JSONObject user_data = new org.json.JSONObject();
        user_data.put("resultCode", resultCode);
        user_data.put("key2", "today4");
        user_data.put("key3", "today2");
        String jsonStr2 = user_data.toString();
        response.setCharacterEncoding("UTF-8");
        try {
            response.getWriter().append(jsonStr2);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/cusSelectOrder", method = RequestMethod.POST)
    public void cusSelectOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        Inspector user = (Inspector) request.getSession().getAttribute("user");

    }


    @RequestMapping(value = "/conform", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String,Object> conformOrders( HttpServletRequest request,@RequestParam("id")String id) {
        // 获取用户是否登录
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        HashMap<String,Object> hashMap =new HashMap<>();
        //TODO 这里有一个bug,前端传传入函数的值是错误的

        logger.info("质检员确认是否接受订单{}",id);


        int resultCode = -1;
        if (user != null) {
            String flag = request.getParameter("flag").trim();// 执行日期
            Orders order = new Orders();
            order.setOrderid(String.valueOf(id));
            order.setQualId(user.getUserId());

            if ("cancel".equals(flag)) {
                logger.info("质检员拒绝了订单");
                order.setStatus(1);//如果质检员拒绝，那么直接修改状态为1
            } else if ("conform".equals(flag)) {
                logger.info("质检员接受了订单");
                order.setStatus(3);//自己抢单的订单直接正在验货
            }


//			为该用户更新订单，依据订单的id查找订单，修改质检员的电话号码
            if (orderService.updateInspector(order)) {
                resultCode = 200;
            } else {
                resultCode = 500;
            }
            ;

        } else {

        }

        hashMap.put("resultCode",resultCode);
        return hashMap;

    }

    @RequestMapping(value = "/rob", method = RequestMethod.POST)
    public void robOrders(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        Inspector user = (Inspector) request.getSession().getAttribute("user");

        int resultCode = -1;
        if (user != null) {
            String id = request.getParameter("id").trim();// 执行日期
            Orders order = new Orders();
            order.setQualId(user.getUserTel());
            order.setOrderid(id);
            order.setStatus(3);//自己抢单的订单直接正在验货

//			为该用户更新订单，依据订单的id查找订单，修改质检员的电话号码
            OrderService orderService = new OrderService();
            if (orderService.updateInspector(order)) {
                resultCode = 200;
            } else {
                resultCode = 500;
            }
            ;

        } else {

        }
        logger.info("返回注册信息");
        org.json.JSONObject user_data = new org.json.JSONObject();
        user_data.put("resultCode", resultCode);
        user_data.put("key2", "today4");
        user_data.put("key3", "today2");
        String jsonStr2 = user_data.toString();
        response.setCharacterEncoding("UTF-8");
        try {
            response.getWriter().append(jsonStr2);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @RequestMapping(value = "/orders-details", method = RequestMethod.GET)
    public String details(ModelMap model, HttpServletRequest request, @RequestParam("id") String ordersId) {
        // 获取用户是否登录
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        if (user != null) {
            //先依据id查询该订单，再判断该订单是否是该用户的，防止恶意的爬虫
            try {
                Orders orders = orderService.selectOrderByOrderId(ordersId);

                model.addAttribute("order",orders);

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
                }
            } catch (IOException e) {
                e.printStackTrace();
            }


            return "orders/orders-details";
        } else
            return "lose";

    }


    @RequestMapping(value = "/details2", method = RequestMethod.GET)
    public String details2(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        // 获取用户是否登录
        Inspector user = (Inspector) request.getSession().getAttribute("user");
        if (user != null) {

            String ordersId = request.getParameter("id").trim();// 备注
            //先依据id查询该订单，再判断该订单是否是该用户的，防止恶意的爬虫
            OrderService orderService = new OrderService();
            try {
                Orders orders = orderService.selectOrderByOrderId(ordersId);
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
                }
            } catch (IOException e) {
                e.printStackTrace();
            }


            return "orders/orders-details2";
        } else
            return "lose";

    }


}
