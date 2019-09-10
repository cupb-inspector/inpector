package cn.hxy.inspect.dao;

import cn.hxy.inspect.admin.DataStatistic;
import cn.hxy.inspect.dao.util.DataConnection;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;



public class DataStatisticDao {
	private final static Logger logger = LoggerFactory.getLogger(DataStatisticDao.class);

	public int insert(DataStatistic user) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.insert("DataStatistic.insert", user);
		sqlSession.commit();
		sqlSession.close();
		logger.info("插入后结果：" + flag);
		return flag;
	}

	public int update(DataStatistic cusUser) throws IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.update("DataStatistic.update", cusUser);
		sqlSession.commit();// 清空缓存
		sqlSession.close();
		return flag;
	}

	public DataStatistic select() throws IOException {

		SqlSession sqlSession = DataConnection.getSqlSession();
		DataStatistic goodsList = sqlSession.selectOne("DataStatistic.select");
		logger.info("查询结果" + goodsList);
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}

}
