package cn.hxy.inspect.dao;

import cn.hxy.inspect.dao.util.DataConnection;
import cn.hxy.inspect.entity.Orders;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class OrdersDao {
	private final static Logger logger = LoggerFactory.getLogger(OrdersDao.class);
	
	public Orders selectUserByOrdersId(String ordersId) {

		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Orders user = sqlSession.selectOne("Orders.findUserByOrdersId", ordersId);
		sqlSession.commit();//清空缓存
		sqlSession.close();
		return user;
	}
	
	
	//某个用户查看自己的订单
	public List<Orders> selectAllByTel(String custel) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findOrdersByTel", custel);
		logger.info("查询结果条数"+goodsList.size());
		for (Orders good : goodsList) {
//			System.out.format("%s\n", good.getNetName());
		}
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	
	/**
	 * 
	 * @param 插入订单信息
	 * @return 返回订单的id号
	 * @throws IOException
	 * eric
	 */
	public int insert(Orders order) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.insert("Orders.insert", order);
		sqlSession.commit();
		sqlSession.close();
		logger.info("插入后结果：" + flag);
		return flag;
	}
	
	public Orders selectAllById(String ordersId) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		Orders goodsList = sqlSession.selectOne("Orders.findOrdersById", ordersId);
		logger.info("查询结果条数"+goodsList);
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	
	//修改订单的状态
	public int updateStatus(Orders order) {
		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int flag=sqlSession.update("Orders.updateStatus", order);
		logger.info("修改订单的质检员号码,结果为："+flag);
		sqlSession.commit();//清空缓存
		sqlSession.close();
		return flag;
	}


	public List<Orders> selectAllByIdAndStatus(HashMap<String, Object>  tel) throws IOException {
		// TODO Auto-generated method stub

		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findAllByIdAndStatus", tel);
		logger.info("查询结果条数"+goodsList.size());
		for (Orders good : goodsList) {
//			System.out.format("%s\n", good.getNetName());
		}
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	
	}
	
	public List<Orders> findByPage(HashMap<String, Object> map) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findByPage", map);
		logger.info("查询结果条数"+goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	public List<Orders> findOrdersByStatusJudge(HashMap<String, Object> map) throws IOException {
		logger.info("查询参数"+map);
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findOrdersByStatusJudge", map);
//		logger.info("查询结果条数"+goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}


	public List<Orders> selectAllByCusId(String cusId) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findOrdersByCusId", cusId);
		logger.info("查询结果条数"+goodsList.size());

		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}


	public List<Orders> findOrdersByRange(HashMap<String, Object> map) throws IOException {
		// TODO Auto-generated method stub
		logger.info("查询参数"+map);
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findOrdersByRange", map);
		logger.info("查询结果条数"+goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}


	public List<Orders> selectAllByFinishedStatus(HashMap<String, Object> tel) throws IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findOrdersByFinishedStatus", tel);
		logger.info("查询结果条数"+goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList; 
	}

	public List<Orders> selectAll() throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findAllOrders");
		logger.info("查询结果条数" + goodsList.size());
		for (Orders good : goodsList) {
//			System.out.format("%s\n", good.getNetName());
		}
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	public List<Orders> selectOrdersByStatus(int status) throws IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findOrdersByStatus", status);
		logger.info("查询结果条数" + goodsList);

		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	public List<Orders> selectOrdersByDateAndStatus(HashMap<String, Object> map) throws IOException {
		// TODO Auto-generated method stub
		logger.info(String.valueOf(map));
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.selectOrdersByDateAndStatus", map);
		logger.info("查询结果条数" + goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	public List<Orders> selectOrdersByStatusJudge(HashMap map) throws IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Orders> goodsList = sqlSession.selectList("Orders.findOrdersByStatusJudge", map);
		logger.info("查询结果条数" + goodsList);

		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	public int updateInspect(Orders order) {
		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int flag = sqlSession.update("Orders.updateInspect", order);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return flag;

	}
	public int updateInspector(Orders order) {
		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int flag = sqlSession.update("Orders.updateInspector", order);
		logger.info("修改订单的质检员号码,结果为：" + flag);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return flag;
	}
	
	
}
