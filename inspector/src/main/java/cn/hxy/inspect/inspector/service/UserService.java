package cn.hxy.inspect.inspector.service;


import cn.hxy.inspect.dao.inspector.InspectorDao;
import cn.hxy.inspect.entity.inspector.Inspector;
import org.apache.tomcat.jni.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;



public class UserService {
	private final static Logger logger = LoggerFactory.getLogger(UserService.class);
	public Inspector login(String phone) {
		//依据电话号码查询数据库，返回对象，比对是否正确
		logger.info("查询是否存在:"+phone);
		InspectorDao inspectorDao = new InspectorDao();
		return inspectorDao.findInspectorByTel(phone);
	}
	
	public Inspector findUserById(String id) throws IOException {
		InspectorDao inspectorDao = new InspectorDao();
		return inspectorDao.findInspectorById(id);
	}
	public boolean insert(Inspector user) {
		InspectorDao inspectorDao = new InspectorDao();
		try {
		int flag=	inspectorDao.insert(user);
		if (flag==1) {
			return true;
		}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
		
	}
	public boolean update(Inspector user) {
		// TODO Auto-generated method stub
		InspectorDao inspectorDao = new InspectorDao();
		return	inspectorDao.update(user);
	}

}
