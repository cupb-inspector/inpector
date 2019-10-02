package cn.hxy.inspect.dao.order;


import cn.hxy.inspect.dao.OrdersDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class DaoLogTest {

    private final static Logger logger = LoggerFactory.getLogger(DaoLogTest.class);
    public static void main(String[] args) throws IOException {
        logger.info("测试");
        OrdersDao ordersDao =new OrdersDao();
        ordersDao.selectAll();

    }
}
