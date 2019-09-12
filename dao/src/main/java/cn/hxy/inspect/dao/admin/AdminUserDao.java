package cn.hxy.inspect.dao.admin;

import cn.hxy.inspect.dao.util.DataConnection;
import cn.hxy.inspect.entity.admin.AdminUser;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

public class AdminUserDao {
	private final static Logger logger = LoggerFactory.getLogger(AdminUserDao.class);
	
	public AdminUser selectUserByPhone(String phone) throws IOException {

		SqlSession sqlSession = DataConnection.getSqlSession();
	
		AdminUser user = sqlSession.selectOne("AdminUser.findUserByNumber", phone);
		
		if(user!=null) {
			logger.info("用户"+user.getAdminName());
		}
		
		
		sqlSession.commit();//清空缓存
		sqlSession.close();
		return user;
	}
	public int insert(AdminUser user) throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.insert("AdminUser.insert", user);
		sqlSession.commit();
		sqlSession.close();
		logger.info("插入后结果：" + flag);
		return flag;
	}
	public int delete(String tel) throws IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession = DataConnection.getSqlSession();
		int flag = sqlSession.insert("AdminUser.delete", tel);
		sqlSession.commit();
		sqlSession.close();
		logger.info("插入后结果：" + flag);
		return flag;
		
	}
	public List<AdminUser> selectAll() throws IOException {
		SqlSession sqlSession = DataConnection.getSqlSession();
		List<AdminUser> goodsList = sqlSession.selectList("AdminUser.selectAll");
		logger.info("质检员查询结果条数"+goodsList.size());

		sqlSession.commit();
		sqlSession.close();
		return goodsList;
	}

}
