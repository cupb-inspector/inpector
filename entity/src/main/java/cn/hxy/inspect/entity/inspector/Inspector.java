package cn.hxy.inspect.entity.inspector;

import lombok.Data;

@Data
public class Inspector {
	private String userId;
	private String userName;
	private String userTel;
	private String userPasswd;
	private String userGrade;
	private String province;
	private String city;
	private String district;
	private String address;
	private String rmb;//人民币
	private String orders;//订单数
	private String integral;//积分
	private String status;
	private String money;
	private String email;//邮箱，用来发送邮件

}
