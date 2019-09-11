package cn.hxy.inspect.entity.admin;

import lombok.Data;

@Data
public class DataStatistic {
	private int dataId;//自定义的id用来更新
	private int total;//总的订单数
	private int today;//今天订单
	private int users;//总的用户
	private int unfinishedBill;//未处理订单
	private int finishedBill;//处理订单
	private int unfinishedReport;//未处理报告
	private int finishedReport;//已处理报告
//	private String date;//统计时间
}
