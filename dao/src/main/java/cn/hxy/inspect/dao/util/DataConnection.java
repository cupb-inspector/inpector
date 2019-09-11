package cn.hxy.inspect.entity.dao.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

public class DataConnection {

	private final static Logger logger = LoggerFactory.getLogger(DataConnection.class);

//	private static ThreadLocal<SqlSession> threadLocal = new ThreadLocal<>();
	// mybatis配置文件
	private static String resource = "SqlMapConfig.xml";
	private static SqlSessionFactory sqlSessionFactory;

	static {
		try {
			File file = new File(resource);
//			logger.info("数据库配置资源路径：" + file.getAbsolutePath());
			InputStream inputStream = Resources.getResourceAsStream(resource);
//			logger.info("创建会话工厂，传入MyBatis配置文件信息");
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
//			logger.info("创建会话工厂完成");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static SqlSession getSqlSession() throws IOException {
		if (logger.isDebugEnabled()) {
//			logger.debug("获取数据库会话");
		}
		File file = new File(resource);
		if (logger.isDebugEnabled()) {
//			logger.debug("数据库配置资源路径：" + file.getAbsolutePath());
		}
		// 如果sqlSessionFactory没有被创建就读取全局配置文件，假如已经被创建过了，就使用已经存在的sqlsessionfactory。
		// 这样就有了单例模式的效果
		if (sqlSessionFactory == null) {
			InputStream inputStream = Resources.getResourceAsStream(resource);
//			logger.info("创建会话工厂，传入MyBatis配置文件信息");
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
//			logger.info("创建会话工厂完成");
		}
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		if (logger.isDebugEnabled()) {
//			logger.debug("返回数据库会话");
		}
		return sqlSession;
	}
	{}
	public static void main(String args[]) {

	}

}
