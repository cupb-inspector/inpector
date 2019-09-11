package cn.hxy.inspect.customer.service;

import cn.hxy.inspect.entity.customer.User;
import cn.hxy.inspect.dao.customer.UserDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class UserService {
	private final static Logger logger = LoggerFactory.getLogger(UserService.class);
	public User login(String custel) {
		//依据电话号码查询数据库，返回对象，比对是否正确
		logger.info("查询是否存在:"+custel);
		UserDao userDao = new UserDao();
		return userDao.selectUserByPhone(custel);
	}
	public boolean insert(User user) {
		UserDao userDao = new UserDao();
		try {
		int flag=	userDao.insert(user);
		if (flag==1) {
			return true;
		}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
		
	}
	public User selectUserByTel(String custel) {
		// TODO Auto-generated method stub
		//依据电话号码查询数据库，返回对象，比对是否正确
		logger.info("查询是否存在:"+custel);
		UserDao userDao = new UserDao();
		return userDao.selectUserByPhone(custel);
	
	}
	
	public User selectUserById(String id) {
		// TODO Auto-generated method stub
		//依据电话号码查询数据库，返回对象，比对是否正确
		logger.info("查询是否存在:"+id);
		UserDao userDao = new UserDao();
		return userDao.selectUserById(id);
	
	}
	
	public int updateOrders(User user) {
		// TODO Auto-generated method stub
		UserDao userDao = new UserDao();
		return  userDao.updateOrders(user);
		
		
		
		
	}
	public int update(User user) {
		// TODO Auto-generated method stub
		UserDao userDao = new UserDao();
	return	userDao.update(user);
		
	}

}
