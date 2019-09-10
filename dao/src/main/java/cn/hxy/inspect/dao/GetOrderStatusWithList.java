package cn.hxy.inspect.dao;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class GetOrderStatusWithList {
	private final static Logger logger = LoggerFactory.getLogger(GetOrderStatusWithList.class);
	//将所有状态放入list中
	static List<Integer> list;
	//使用静态代码块来实现对象的实例创建，保证创建此实例只需要执行一次
	static {
		list = new ArrayList<Integer>();
		//利用java反射机制获取类中各成员
		try {
			Class clazz = Class.forName("hxy.inspec.admin.util.Configuration");
			Field[] fields = clazz.getFields();
			for (Field field : fields) {
				if (field.getName() == "FILE_ROOT_DIR" || field.getName() == "BILL_PRICE" || field.getName() == "IMAGE_URL" || field.getName() == "MYSQL_HOST"
						|| field.getName() == "MYSQL_PASSWD" || field.getName() == "MYSQL_USER" )
					continue;
				System.out.println(field.getName() + " " + field.get(clazz));
				list.add((Integer) field.get(clazz));
				System.out.println(list);
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.getMessage());
		}
		/*--------------------- 
		作者：忘尘_追忆 
		来源：CSDN 
		原文：https://blog.csdn.net/qq369201191/article/details/49561281/ 
		版权声明：本文为博主原创文章，转载请附上博文链接！*/
		logger.info("get the order status list: " + list);
	}

	public static List<Integer> getOrderStatus() {
		return list;
	}
	/**
	 * TODO get a sublist from the scope [start,end) of list
	 * lzdmk
	 * @param start :value of status
	 * @param end
	 * @return sublist
	 */
	public static List<Integer> getStatusSublist(int start,int end){
		int from = list.indexOf(start);
		int to = list.indexOf(end);
		List<Integer> subList = list.subList(from, to);
		return subList;
	}
	
	public static void main(String arg[]) {
		System.out.println(getStatusSublist(0,150));
	}
}
