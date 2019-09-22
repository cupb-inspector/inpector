package cn.hxy.inspect.inspector.service;



import java.io.IOException;
import java.util.List;
import java.util.Vector;
import java.util.stream.Collectors;

import cn.hxy.inspect.dao.OrdersDao;
import cn.hxy.inspect.entity.Orders;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


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

	public List<Orders> findUserByQualIdAndStatus(Orders tel) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list = ordersDao.findUserByQualIdAndStatus(tel);
		return list;
	}
	
	public List<Orders> findOrdersByStatus(String status) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list = ordersDao.findOrdersByStatus(status);
		return list;
	}
	////枚举模板，只要是迭代类型变量都可以,重载方法，代码架构可以不变。
	public List<Orders> findOrdersByStatus(List<Integer> status_s) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list=new Vector<Orders>();
		for (Integer status:status_s)
			list.addAll(ordersDao.findOrdersByStatus(status.toString() ));
		return list;
	}
	public List<Orders> findOrdersByStatusAndInspector(List<Integer> status_s,String qualId) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list=new Vector<Orders>();
		for (Integer status:status_s)
			list.addAll(ordersDao.findOrdersByStatus(status.toString() ));
		//lambda 过滤出只有需要的检查员的订单
		try{
			List<Orders> temp = list.stream().filter(
					(Orders b) -> b.getQualId().equals(qualId)).collect(Collectors.toList());list=temp;
		}catch(Exception e) {//订单为空
			list=null;}
				
		return list;
	}
	
	public Orders selectAllById(String ordersId) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		Orders list = ordersDao.selectAllById(ordersId);
		return list;
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

	public boolean updateReport(Orders order) {
		// TODO Auto-generated method stub
		OrdersDao ordersDao = new OrdersDao();
		int flag = ordersDao.updateReport(order);
		if (flag == 1) {
			return true;
		} else {
			return false;
		}
	}
	
	
	
	
	

}
