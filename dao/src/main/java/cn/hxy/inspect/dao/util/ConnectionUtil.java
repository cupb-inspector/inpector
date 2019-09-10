package cn.hxy.inspect.dao.util;

import org.apache.ibatis.io.Resources;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.InputStream;
import java.sql.*;
import java.util.Iterator;

public class ConnectionUtil {
	private final static Logger logger = LoggerFactory.getLogger(ConnectionUtil.class);
	private static String dbDriver = "com.mysql.jdbc.Driver";
	// Serverip：129.28.19.203
	private static String url = "jdbc:mysql://localhost:3306/ttkd?useUnicode=true&useSSL=true&characterEncoding=UTF8";
	// 登录数据库的用户名
	private static String user = "root";
	// 我的manjaro密码
	private static String pwd = "";
	private static String host = "";
	// 客户服务器密码
//	private static String pwd = "018299%zxw";
	// 远程连接数据的密码
//	private static String pwd = "authentication_string";

	public static Connection getConnection() {
		Connection connection = null;
		// 获取用户名和密码

		try {
			File f = new File("sqlConfig.xml");
			logger.info("配置文件路径" + f.getAbsolutePath());
			
			String resource = "sqlConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SAXReader reader = new SAXReader();
			Document doc = reader.read(inputStream);
			Element root = doc.getRootElement();
			Element foo;
			root.getName();
			for (Iterator i = root.elementIterator("VALUES"); i.hasNext();) {
				foo = (Element) i.next();
				user = foo.elementText("KEY");
				pwd = foo.elementText("VALUE");
				host = foo.elementText("HOST");
				logger.info("数据库用户名和密码" + user + "\t" + pwd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			// 设置驱动
			Class.forName(dbDriver);
			url = "jdbc:mysql://" + host + ":3306/inspect?useUnicode=true&useSSL=true&characterEncoding=UTF8";
			connection = DriverManager.getConnection(url, user, pwd);
			return connection;
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	// 获取对象Statement
	public static Statement getStatement(Connection connection) {

		Statement statement = null;
		try {
			statement = connection.createStatement();

		} catch (SQLException e) {
		}

		return statement;

	}

	public static PreparedStatement getPreparedStatement(Connection conn, String sql) {

		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = conn.prepareStatement(sql);
		} catch (Exception e) {
		}
		return preparedStatement;

	}

	public static void close(ResultSet resultSet, PreparedStatement preparedStatement, Connection connection) {
		// TODO Auto-generated method stub
		if (null != resultSet) {
			try {
				resultSet.close();
			} catch (SQLException e) {
			} finally {
				resultSet = null;
			}
		}
		if (null != preparedStatement) {
			try {
				preparedStatement.close();
			} catch (SQLException e) {
			} finally {
				preparedStatement = null;
			}
		}
		if (null != connection) {
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO: handle exception
			} finally {
				connection = null;
			}
		}

	}

	public static void main(String[] args) {

		// 检查数据库是否存在表，若是没有新建一个
		String[] table = { "user", "billtable" };
		Connection connection = ConnectionUtil.getConnection();
		String sql = "create table IF NOT EXISTS  user (iduser int not null primary key  AUTO_INCREMENT,  `name` VARCHAR(45) NULL,\n"
				+ "  `passwd` VARCHAR(45) NULL,\n" + "  `phone` VARCHAR(45) NULL,\n"
				+ "  `address` VARCHAR(45) NULL); ";
		PreparedStatement preparedStatement = ConnectionUtil.getPreparedStatement(connection, sql);
		try {
			int resultSet = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String sql1 = "create table IF NOT EXISTS  billtable (`uuid` VARCHAR(45) NOT NULL,\n"
				+ "  `phone` VARCHAR(15) NULL,\n" + "  `fileUuidName` VARCHAR(120) NULL,\n"
				+ "  `fileName` VARCHAR(100) NULL,\n" + "  `filePath` VARCHAR(100) NULL,\n"
				+ "  `pageNumber` VARCHAR(10) NULL,\n" + "  `documentType` VARCHAR(45) NULL,\n"
				+ "  `instruct` VARCHAR(100) NULL,\n" + "  `status` VARCHAR(45) NULL,\n"
				+ "  `cost` VARCHAR(45) NULL,\n" + "  `time` VARCHAR(45) NULL,\n" + "  PRIMARY KEY (`uuid`))";
		PreparedStatement preparedStatement1 = ConnectionUtil.getPreparedStatement(connection, sql1);
		try {
			int resultSet1 = preparedStatement1.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String sql2 = "create table IF NOT EXISTS  billtable (`uuid` VARCHAR(45) NOT NULL,\n"
				+ "  `phone` VARCHAR(15) NULL,\n" + "  `fileUuidName` VARCHAR(120) NULL,\n"
				+ "  `fileName` VARCHAR(100) NULL,\n" + "  `filePath` VARCHAR(100) NULL,\n"
				+ "  `pageNumber` VARCHAR(10) NULL,\n" + "  `documentType` VARCHAR(45) NULL,\n"
				+ "  `instruct` VARCHAR(100) NULL,\n" + "  `status` VARCHAR(45) NULL,\n"
				+ "  `cost` VARCHAR(45) NULL,\n" + "  `time` VARCHAR(45) NULL,\n" + "  PRIMARY KEY (`uuid`))";
		PreparedStatement preparedStatement2 = ConnectionUtil.getPreparedStatement(connection, sql1);
		try {
			int resultSet1 = preparedStatement1.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public static void close(PreparedStatement preparedStatement, Connection connection) {

		if (null != preparedStatement) {
			try {
				preparedStatement.close();
			} catch (SQLException e) {
			} finally {
				preparedStatement = null;
			}
		}
		if (null != connection) {
			try {
				connection.close();
			} catch (SQLException e) {
			} finally {
				connection = null;
			}
		}

	}

}
