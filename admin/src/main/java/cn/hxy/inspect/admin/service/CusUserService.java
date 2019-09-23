package cn.hxy.inspect.admin.service;

import cn.hxy.inspect.dao.admin.CusUserDao;
import cn.hxy.inspect.entity.customer.CusUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class CusUserService {
	private final static Logger logger = LoggerFactory.getLogger(CusUserService.class);
	public List<CusUser> selectAll() throws IOException {
		CusUserDao ordersDao = new CusUserDao();
		List<CusUser> list = ordersDao.selectAll();
		return list;
	}

//	查找质检员信息
	public CusUser findCusUserByTel(String tel) {

		CusUserDao ordersDao = new CusUserDao();

		CusUser inspector = ordersDao.findCusUserByTel(tel);

		return inspector;

	}

	public CusUser selectUserById(String id) {
		// TODO Auto-generated method stub
		// 依据电话号码查询数据库，返回对象，比对是否正确
		logger.info("查询是否存在:" + id);
		CusUserDao userDao = new CusUserDao();
		return userDao.selectUserById(id);

	}

	public int update(CusUser cusUser) throws IOException {
		// TODO Auto-generated method stub
		CusUserDao cusUserDao = new CusUserDao();
		return cusUserDao.update(cusUser);
	}

}
