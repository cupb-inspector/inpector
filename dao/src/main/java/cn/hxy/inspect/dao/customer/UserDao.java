package cn.hxy.inspect.dao.customer;

import cn.hxy.inspect.customer.User;
import cn.hxy.inspect.dao.util.DataConnection;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class UserDao {
	private final static Logger logger = LoggerFactory.getLogger(UserDao.class);

	public User selectUserByPhone(String phone) {

		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		User user = sqlSession.selectOne("User.findUserByNumber", phone);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return user;
	}

	public int insert(User user) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.insert("User.insert", user);
		sqlSession.commit();
		sqlSession.close();
		logger.info("插入后结果：" + flag);
		return flag;
	}

	public int updateOrders(User user) {
		// TODO Auto-generated method stub

		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int flag = sqlSession.update("User.updateOrders", user);
		logger.info("修改订单的质检员号码,结果为：" + flag);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return flag;

	}

	public User selectUserById(String id) {

		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		User user = sqlSession.selectOne("User.findUserById", id);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return user;
	}

	public int update(User user) {
		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int flag = sqlSession.update("User.update", user);
		logger.info("更新用户的信息：" + flag);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return flag;

	}

}
