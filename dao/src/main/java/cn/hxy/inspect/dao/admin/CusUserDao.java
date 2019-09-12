package cn.hxy.inspect.dao.admin;

import cn.hxy.inspect.dao.util.DataConnection;
import cn.hxy.inspect.entity.customer.CusUser;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

public class CusUserDao {

	private final static Logger logger = LoggerFactory.getLogger(CusUserDao.class);

	public List<CusUser> selectAll() throws IOException {

		SqlSession sqlSession = DataConnection.getSqlSession();
		List<CusUser> goodsList = sqlSession.selectList("CusUser.selectAll");
		logger.info("质检员查询结果条数" + goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}

	public CusUser findCusUserByTel(String tel) {
		SqlSession sqlSession = null;
		try {
			sqlSession = DataConnection.getSqlSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		CusUser user = sqlSession.selectOne("CusUser.findUserByNumber", tel);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return user;
	}

	public int update(CusUser cusUser) throws IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.update("CusUser.update", cusUser);
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
		CusUser user = sqlSession.selectOne("CusUser.findUserById", id);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return user;
	}

}
