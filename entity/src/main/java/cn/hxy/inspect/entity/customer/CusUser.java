package cn.hxy.inspect.entity.customer;

import lombok.Data;

@Data
public class CusUser {
	private String cusid;
	private String custel;
	private String cusname;
	private String cuspasswd;
	private String country;// 国家
	private String province;// 省州
	private String city;// 城市
	private String email; // 邮箱
	private String cusgrade;// 等级，与信用相关
	private String cusvip;
	private String cusaddress;// 地址
	private String cusdate;// 注册日期
	private String custrade;// 行业
	private int cusMoney;// 钱包实际余额，扣款用实际余额扣
	private int cusTempMoney;// 钱包变化后的余额。充值用临时余额冲。
//思路：如果是订单付款，用实际余额与单价比较，同时也会减临时余额，到达一致。
	// 充钱的时候，实际金额不变，临时余额增加，等待管理员审核通过，管理员系统会修改实际金额，临时金额不变。
	// 提现的时候，实际金额减少，临时余额也减少。提现可以取消
	private int cusOrders;// 订单数

}
