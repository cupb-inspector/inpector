package cn.hxy.inspect.dao.order;

import cn.hxy.inspect.dao.util.DataConnection;
import cn.hxy.inspect.entity.Orders;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

public class OrderTest {

    public static void main(String[] args) {
        Orders order = new Orders();
        order.setOrderid("20190901074006136");
        order.setQualId("5");
        order.setStatus(3);

        SqlSession sqlSession = null;
        try {
            sqlSession = DataConnection.getSqlSession();
        } catch (IOException e) {
            e.printStackTrace();
        }
        int flag = sqlSession.update("Orders.updateInspector", order);
        System.out.println("修改订单的质检员号码,结果为：" + flag);
        sqlSession.commit();// 清空缓存
        sqlSession.close();

    }
}
