package cn.hxy.inspect.admin.service;

import cn.hxy.inspect.dao.DataStatisticDao;
import cn.hxy.inspect.entity.admin.DataStatistic;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class DataStatisticService {

	private final static Logger logger = LoggerFactory.getLogger(DataStatistic.class);
	public boolean Insert(DataStatistic dataStatistic) throws IOException{
		DataStatisticDao dataStatisticDao = new DataStatisticDao();
		dataStatisticDao.insert(dataStatistic);
		return false;
	}
	public DataStatistic select()  {
		DataStatisticDao dataStatisticDao = new DataStatisticDao();
		DataStatistic dataStatistic = null;
		try {
			dataStatistic=dataStatisticDao.select();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return dataStatistic;
	}
	public boolean update(DataStatistic dataStatistic) throws IOException {

		DataStatisticDao dataStatisticDao = new DataStatisticDao();
		dataStatisticDao.update(dataStatistic);
		
		return false;
		
	}

}
