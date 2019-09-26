package cn.hxy.inspect.util;

//静态变量类
public class Configuration {
	public static String FILE_ROOT_DIR = SystemProperties.getProperty("reportDir");// 用于存储文件目录,这个目录不可以采用应用下的目录，因为应用一旦更新就没了。
	public static String IMAGE_URL = SystemProperties.getProperty("IMAGE_URL");
	public static String MYSQL_HOST = "";
	public static String MYSQL_PASSWD = "";
	public static String MYSQL_USER = "";

	public static final int BILL_PRICE = 100;// 订单价格

	public static final int BILL_TEMP = 0; // 草稿订单
	public static final int BILL_SUBMITTED = 1;// 订单已提交
	public static final int BILL_UNPAY = 50;// 订单未付款
	public static final int BILL_PAY = 100;// 订单已经付款

	public static final int BILL_ASSIGNING = 150;// 订单被管理员接受并正在分配质检员
	public static final int BILL_ASSIGNED = 151;// 订单已分配
	public static final int BILL_DELAY_BY_ADMIN = 200; // 管理员延期分配订单
	public static final int BILL_REFUSED_BY_ADMIN = 250; // 订单被管理员取消

	public static final int BILL_ASSIGNING_BY_ADMIN_UNPAID = 300;// 订单被管理员接受并正在分配质检员
	public static final int BILL_ASSIGNED_BY_ADMIN_UNPAID = 301;// 订单已分配
	public static final int BILL_DELAY_BY_ADMIN_UNPAID = 350; // 管理员延期分配订单
	public static final int BILL_REFUSED_BY_ADMIN_UNPAID = 400; // 订单被管理员取消

	public static final int BILL_INSPECTOR_CONFIRM = 450;// 订单被验货员接受
	public static final int BILL_REFUSED_BY_INSPECTOR = 500;// 验货员拒绝
	public static final int BILL_DELAY_BY_ADMIN_0INSPECTOR = 550; // 管理员找不到验货员
	public static final int BILL_ASSIGNED_UNPAID = 600;// 验货员接单BILL_INSPECTOR_CONFIRM
	public static final int BILL_REFUSED_BY_INSPECTOR_UNPAID = 650;// 验货员拒绝
	public static final int BILL_DELAY_BY_ADMIN_0INSPECTOR_UNPAID = 700; // 管理员找不到验货员
	public static final int BILL_REPORT_SUBMIT = 750;// 验货员已提交报告
	public static final int BILL_REPORT_DELAY = 800;// 验货员延期提交报告
	public static final int BILL_CANCEL_BY_INSPECTOR = 850; // 验货员取消订单
	public static final int BILL_REPORT_SUBMIT_UNPAID = 900;// 验货员已提交报告
	public static final int BILL_REPORT_DELAY_UNPAID = 950;// 验货员延期提交报告
	public static final int BILL_CANCEL_BY_INSPECTOR_UNPAID = 1000; // 验货员取消订单
	public static final int BILL_REPORT_REFUSED_BY_ADMIN = 1050; // 订单报告被管理员拒绝
	public static final int BILL_REPORT_VERIFIED = 1100; // 订单报告被管理员通过
	public static final int BILL_REPORT_REFUSED_BY_ADMIN_UNPAID = 1150; // 订单报告被管理员拒绝
	public static final int BILL_REPORT_PASSED_BY_ADMIN_UNPAID = 1200; // 订单报告被管理员通过并等待付款

	public static final int BILL_REPORT_PASSED = 1250;// 用户确认报告通过
	public static final int BILL_REPORT_UNPASSED = 1300;// 用户拒绝报告，未通过

	public static final int BILL_PASSED_DONE = 1350; // 结清订单，付款给质检员。。。

	public static final int BILL_DELETE_BY_ADMIN = 1400; // 管理员删除的订单
	public static final int BILL_DELETE_BY_USER = 1450; // 用户删除的订单
	public static final int BILL_UNPAY_FOR_INSPECTOR = 1500; // 未给验货员结清订单
	public static final int BILL_DELETE_BY_INSPECTOR = 1650; // 质检员删除的订单
	public static final int BILL_EXCEPTION = 4040;// 未知的订单状态，或者错误的订单状态。比如有人故意爬虫提交自定义数据，无法识别。

}