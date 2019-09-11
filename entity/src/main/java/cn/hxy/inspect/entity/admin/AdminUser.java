package cn.hxy.inspect.entity.admin;

import lombok.Data;

@Data
public class AdminUser {
	private String adminId;//所有的业务应该与这个id关联，而不是应该与tel关联，因为电话号码后期允许更换的
	private String adminName;
	private String adminPasswd;
	private String adminTel;
	private String adminGrade;
	private String adminPhoto;
	private String adminAddress;
	private String adminDate;
	private String adminEmail;
	private String role;
}
