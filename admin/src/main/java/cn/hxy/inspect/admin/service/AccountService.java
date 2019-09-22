package cn.hxy.inspect.admin.service;


import cn.hxy.inspect.dao.AccountDao;
import cn.hxy.inspect.entity.Account;
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
	public List<Account> selectAll() throws IOException {
		AccountDao orderDao = new AccountDao();
		List<Account> list = orderDao.selectAll();
		return list;
	}
	public List<Account> selectAllByStatus(String tel) throws IOException {
		AccountDao orderDao = new AccountDao();
		List<Account> list = orderDao.selectAllByStatus(tel);
		return list;
	}
	
	public List<Account> selectAllByType(String type) throws IOException {
		AccountDao orderDao = new AccountDao();
		List<Account> list = orderDao.selectAllByType(type);
		return list;
	}
	
	
	public Account selectAccountById(String id) throws IOException {
		// TODO Auto-generated method stub
		logger.info("查询账户流水号"+id);
		AccountDao orderDao = new AccountDao();
		Account list = orderDao.selectAccountById(id);
		return list;
	}
	public int updateStatus(Account account) throws IOException {
		// TODO Auto-generated method stub
		
		AccountDao orderDao = new AccountDao();
		int list = orderDao.updateStatus(account);
		logger.info("更新订单状态,状态字"+list);
		return list;
	}

}
