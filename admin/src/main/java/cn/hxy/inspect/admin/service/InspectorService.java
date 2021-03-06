package cn.hxy.inspect.admin.service;

import cn.hxy.inspect.dao.inspector.InspectorDao;
import cn.hxy.inspect.entity.inspector.Inspector;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class InspectorService {
	public List<Inspector> selectAll() throws IOException {
		InspectorDao ordersDao = new InspectorDao();
		List<Inspector> list = ordersDao.selectAll();
		return list;
	}
	
//	查找质检员信息
	public Inspector findInspectorByTel(String tel) {
		
		InspectorDao ordersDao = new InspectorDao();
		
		Inspector inspector = ordersDao.findInspectorByTel(tel);
		
		return inspector;
		
	}
	
//	查找质检员信息
	public Inspector findInspectorById(String id) throws IOException {
		
		InspectorDao ordersDao = new InspectorDao();
		
		Inspector inspector = ordersDao.findInspectorById(id);
		
		return inspector;
		
	}
	

}
