package cn.hxy.inspect.dao.customer;

import cn.hxy.inspect.entity.customer.CusUser;
import cn.hxy.inspect.dao.util.DataConnection;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class UserDao {
	private final static Logger logger = LoggerFactory.getLogger(UserDao.class);

	public CusUser selectUserByPhone(String phone) {

		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		CusUser cusUser = sqlSession.selectOne("CusUser.findUserByNumber", phone);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return cusUser;
	}

	public int insert(CusUser cusUser) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.insert("CusUser.insert", cusUser);
		sqlSession.commit();
		sqlSession.close();
		logger.info("插入后结果：" + flag);
		return flag;
	}

	public int updateOrders(CusUser cusUser) {
		// TODO Auto-generated method stub

		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int flag = sqlSession.update("CusUser.updateOrders", cusUser);
		logger.info("修改订单的质检员号码,结果为：" + flag);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return flag;

	}

	public CusUser selectUserById(String id) {

		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		CusUser cusUser = sqlSession.selectOne("CusUser.findUserById", id);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return cusUser;
	}

	public int update(CusUser cusUser) {
		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int flag = sqlSession.update("CusUser.update", cusUser);
		logger.info("更新用户的信息：" + flag);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return flag;

	}

}
