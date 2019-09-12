package cn.hxy.inspect.dao;

import cn.hxy.inspect.dao.util.DataConnection;
import cn.hxy.inspect.entity.Account;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;



public class AccountDao {
	private final static Logger logger = LoggerFactory.getLogger(AccountDao.class);
	public int insert(Account user) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.insert("Account.insert", user);
		sqlSession.commit();
		sqlSession.close();
		logger.info("插入后结果：" + flag);
		return flag;
	}
	public List<Account> selectAllByUserId(String id) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Account> goodsList = sqlSession.selectList("Account.findOrdersByUserId", id);
		logger.info("查询结果条数"+goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	
	}

	public List<Account> selectAllByTel(String tel) throws IOException {
		// TODO Auto-generated method stub

		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Account> goodsList = sqlSession.selectList("Account.findOrdersByTel", tel);
		logger.info("查询结果条数"+goodsList.size());

		sqlSession.commit();
		sqlSession.close();
		return goodsList;

	}
	public List<Account> selectAllByStatus(String tel) throws IOException {
		// TODO Auto-generated method stub

		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Account> goodsList = sqlSession.selectList("Account.findAllByStatus", tel);
		logger.info("查询结果条数"+goodsList.size());

		sqlSession.commit();
		sqlSession.close();
		return goodsList;

	}
	public List<Account> selectAll() throws IOException {

		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Account> goodsList = sqlSession.selectList("Account.selectAll");
		logger.info("查询结果条数"+goodsList.size());

		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	public Account selectAccountById(String id) throws IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession = DataConnection.getSqlSession();
		Account goodsList = sqlSession.selectOne("Account.selectAccountById",id);
		logger.info("查询结果"+goodsList);

		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}
	public int updateStatus(Account account) throws IOException {
		// TODO Auto-generated method stub
		SqlSession  sqlSession = DataConnection.getSqlSession();
		logger.info("更新的Account:"+account);
		int flag=sqlSession.update("Account.updateStatus", account);
		sqlSession.commit();//清空缓存
		sqlSession.close();
		return flag;

	}
	public List<Account> selectAllByType(String type) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<Account> goodsList = sqlSession.selectList("Account.selectAllByType",type);
		logger.info("查询结果条数"+goodsList.size());
		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}

}
