package cn.hxy.inspect.customer.service;

import cn.hxy.inspect.entity.admin.DataStatistic;
import cn.hxy.inspect.dao.DataStatisticDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class DataStatisticService {

	private final static Logger logger = LoggerFactory.getLogger(DataStatistic.class);

	public boolean Insert(DataStatistic dataStatistic) throws IOException {
		DataStatisticDao dataStatisticDao = new DataStatisticDao();
		dataStatisticDao.insert(dataStatistic);
		return false;
	}

	public DataStatistic select() {
		DataStatisticDao dataStatisticDao = new DataStatisticDao();
		DataStatistic dataStatistic = null;
		try {
			dataStatistic = dataStatisticDao.select();
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
