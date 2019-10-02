package cn.hxy.inspect.customer.service;

import cn.hxy.inspect.entity.Orders;
import cn.hxy.inspect.dao.OrdersDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

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
	public List<Orders> selectAllByCusId(String tel) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list = ordersDao.selectAllByCusId(tel);
		return list;
	}
	

	public List<Orders> findByPage(HashMap<String, Object> tel) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list = ordersDao.findByPage(tel);
		return list;
	}
	
	public List<Orders> findOrdersByStatusJudge(HashMap<String, Object> tel) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list = ordersDao.findOrdersByStatusJudge(tel);
		return list;
	}
	
	

	public List<Orders> selectAllByIdAndStatus(HashMap<String, Object> tel) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list = ordersDao.selectAllByIdAndStatus(tel);
		return list;
	}

	public List<Orders> selectAllByFinishedStatus(HashMap<String, Object> tel) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list = ordersDao.selectAllByFinishedStatus(tel);
		return list;
	}

	public Orders selectOrderById(String ordersId) throws IOException {
		OrdersDao ordersDao = new OrdersDao();
		Orders list = ordersDao.selectOrderById(ordersId);
		return list;
	}

	public boolean updateInspector(Orders order) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean updateStatus(Orders orders) {
		// TODO Auto-generated method stub
		OrdersDao ordersDao = new OrdersDao();
		int flag = ordersDao.updateStatus(orders);
		if (flag == 1) {
			return true;
		} else
			return false;

	}

	public void updateReport(Orders orders) {
		// TODO Auto-generated method stub

	}

	public List<Orders> findOrdersByRange(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		OrdersDao ordersDao = new OrdersDao();
		List<Orders> list=null;
		try {
			list = ordersDao.findOrdersByRange(map);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

}
