package cn.hxy.inspect.admin.service;

import cn.hxy.inspect.dao.GetOrderStatusWithList;
import cn.hxy.inspect.dao.OrdersDao;
import cn.hxy.inspect.entity.Orders;
import cn.hxy.inspect.entity.inspector.Inspector;
import cn.hxy.inspect.util.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class OrderService {

    private final static Logger logger = LoggerFactory.getLogger(OrderService.class);

    // 插入订单
    public boolean insert(Orders order) {
        OrdersDao orderDao = new OrdersDao();
        try {
            int flag = orderDao.insert(order);
            if (flag == 1) {
                return true;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Orders> selectAllByTel(String tel) throws IOException {
        OrdersDao ordersDao = new OrdersDao();
        List<Orders> list = ordersDao.selectAllByTel(tel);
        return list;
    }

    public List<Orders> selectAll() throws IOException {
        OrdersDao ordersDao = new OrdersDao();
        List<Orders> list = ordersDao.selectAll();
        return list;
    }


    public List<Orders> findUserByQualtelAndStatus(Orders orders) throws IOException {
        OrdersDao ordersDao = new OrdersDao();
        List<Orders> list = ordersDao.selectAll();
        return list;
    }

    public Orders selectOrderById(String ordersId) throws IOException {
        OrdersDao ordersDao = new OrdersDao();
        Orders list = ordersDao.selectAllById(ordersId);
        return list;
    }


    public List<Orders> selectOrdersByStatus(int status) throws IOException {
        logger.info("查询状态为" + status + "的订单");
        OrdersDao ordersDao = new OrdersDao();
        List<Orders> list = ordersDao.selectOrdersByStatus(status);
        return list;
    }

    public List<Orders> selectOrdersByDateAndStatus(HashMap<String, Object> status) throws IOException {
        OrdersDao ordersDao = new OrdersDao();
        List<Orders> list = ordersDao.selectOrdersByDateAndStatus(status);
        return list;
    }

    //查询今天和明天的订单
    public List<Orders> selectTodayTomorrowOrders() throws IOException {
        Date date = new Date();
        DateFormat df1 = DateFormat.getDateInstance();//日期格式，精确到日,这个会有一点问题,如果是2019-5-17就不会是2019-05-17
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today = formatter.format(date);
        logger.info("今日:" + today);
        HashMap<String, Object> status = new HashMap<>();
        status.put("excedate", today);
        status.put("status", "5");
        status.put("start", 0);
        status.put("size", 5);//查询最近5条

        OrdersDao ordersDao = new OrdersDao();
        List<Orders> list = ordersDao.selectOrdersByDateAndStatus(status);
        return list;
    }


    public List<Orders> selectOrdersByStatusJudge(HashMap<String, Object> status) throws IOException {
        OrdersDao ordersDao = new OrdersDao();
        List<Orders> list = ordersDao.selectOrdersByStatusJudge(status);
        return list;
    }

    public List<Orders> selectUnfinishedOrders() throws IOException {
        OrdersDao ordersDao = new OrdersDao();


        // 将status放入list中
        List<Integer> listParam = new ArrayList<>();
        OrderService o = new OrderService();
        HashMap<String, Object> map = new HashMap<String, Object>();
        // 获得一部分status
        listParam.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_SUBMITTED,
                Configuration.BILL_REFUSED_BY_ADMIN));

        listParam.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_ASSIGNING_BY_ADMIN_UNPAID,
                Configuration.BILL_REFUSED_BY_ADMIN_UNPAID));

        listParam.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_INSPECTOR_CONFIRM,
                Configuration.BILL_REPORT_VERIFIED));

        listParam.addAll(GetOrderStatusWithList.getStatusSublist(Configuration.BILL_REPORT_REFUSED_BY_ADMIN_UNPAID,
                Configuration.BILL_REPORT_PASSED_BY_ADMIN_UNPAID));

        map.put("list", listParam);
        List<Orders> list = ordersDao.findOrdersByRange(map);

        return list;
    }


    public boolean updateInspect(Orders order) {
        OrdersDao ordersDao = new OrdersDao();
        int flag = ordersDao.updateInspect(order);
        if (flag == 1) {
            return true;
        } else {
            return false;
        }
    }

    public boolean updateInspector(Orders order) {
        OrdersDao ordersDao = new OrdersDao();
        int flag = ordersDao.updateInspector(order);
        if (flag == 1) {
            return true;
        } else {
            return false;
        }
    }

    public boolean assignOrders(Orders order) {
        OrdersDao ordersDao = new OrdersDao();
        int flag = ordersDao.updateInspector(order);
        if (flag == 1) {
            //新建线程发送邮件到质检员
            new Thread(new SendEmailRunnable(order)).start();
            return true;
        } else {
            return false;
        }
    }

    public void updateReport(Orders orders) {


    }

    public List<Orders> findOrdersByRange(HashMap<String, Object> map) throws IOException {

        cn.hxy.inspect.dao.OrdersDao ordersDao = new cn.hxy.inspect.dao.OrdersDao();
        List<Orders> list = ordersDao.findOrdersByRange(map);
        return list;
    }

    public List<Orders> selectFinishedOrders(HashMap<String, Object> map) throws IOException {
        cn.hxy.inspect.dao.OrdersDao ordersDao = new cn.hxy.inspect.dao.OrdersDao();
        List<Orders> list = ordersDao.findOrdersByRange(map);
        return list;
    }
}


class SendEmailRunnable implements Runnable {

    private final static Logger logger = LoggerFactory.getLogger(SendEmailRunnable.class);
    Orders orders;

    SendEmailRunnable(Orders orders) {
        this.orders = orders;
    }

    @Override
    public void run() {

        InspectorService inspectorService = new InspectorService();
        Inspector inspector = inspectorService.findInspectorById(orders.getQualId());
        if (inspector != null && !"null".equals(inspector)) {
            // 发送邮件给质检员
            MailService mailService = new MailService();
            mailService.sendMailToInspector(inspector);
        } else {
            logger.error("该质检员不存在：" + orders.getQualId());
        }
    }

}
