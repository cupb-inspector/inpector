package cn.hxy.inspect.entity.customer.service;

import cn.hxy.inspect.entity.Account;
import cn.hxy.inspect.entity.dao.AccountDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class AccountService {
	

	private final static Logger logger = LoggerFactory.getLogger(AccountService.class);

	// 插入订单
	public boolean insert(Account order) throws IOException {
		AccountDao orderDao = new AccountDao();
	
			int flag = orderDao.insert(order);
			if (flag == 1) {
				return true;
			}
		
		return false;
	}
	public List<Account> selectAllByTel(String tel) throws IOException {
		AccountDao orderDao = new AccountDao();
		List<Account> list = orderDao.selectAllByTel(tel);
		return list;
	}
	
	public List<Account> selectAllByUserId(String tel) throws IOException {
		AccountDao orderDao = new AccountDao();
		List<Account> list = orderDao.selectAllByUserId(tel);
		return list;
	}
}
