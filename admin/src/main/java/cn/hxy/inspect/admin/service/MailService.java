package cn.hxy.inspect.admin.service;

import cn.hxy.inspect.entity.customer.CusUser;
import cn.hxy.inspect.entity.inspector.Inspector;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class MailService {
	// 发送邮件

	public boolean sendMailToInspector(Inspector inspector) {
		String email = inspector.getEmail().trim();

		// 邮件主题
		String title = "验货通知";
		// 质检员的用户名，邮箱
		// 邮件正文
		String htmlContent = inspector.getUserName() + ",您好！您有新的订单请及时处理。环球验货质检\n地址：浙江宁波";

		// 收件人
		List<String> receivers = new ArrayList<String>();
//		receivers.add("aohanhongzhi@qq.com");
//		receivers.add("aohanhongzhi@126.com");
		if (email != null && !"null".equals(email)) {
			receivers.add(email);
			// 附件
			String fileName1 = "/home/yz/有点东西.png";
			File file1 = new File(fileName1);
			String fileName2 = "/home/yz/我的简历.pdf";
			File file2 = new File(fileName2);
			List<File> fileList = new ArrayList<File>();
//			fileList.add(file1);
//			fileList.add(file2);
			// 执行发送
			return new SendMail().sendEmail(title, htmlContent, receivers, fileList);
		} else
			return false;

	}

	public boolean sendMailToCustomer(CusUser cusUser) {

		// 邮件主题
		String title = "验货通知";
		// 质检员的用户名，邮箱
		// 邮件正文
		String htmlContent = cusUser.getCusname() + ",您好！您的订单已验货完成，报告已经生成，请及时确认。环球验货质检\n地址：浙江宁波";

		// 收件人
		List<String> receivers = new ArrayList<String>();
//		receivers.add("aohanhongzhi@qq.com");
//		receivers.add("aohanhongzhi@126.com");
		String email = cusUser.getEmail().trim();
		if (email != null && "null".equals(email)) {
			receivers.add(email);
			// 附件
//			String fileName1 =Configration.FILE_ROOT_DIR+ "/home/yz/有点东西.png";
//			File file1 = new File(fileName1);
			String fileName2 = "/home/yz/我的简历.pdf";
			File file2 = new File(fileName2);
			List<File> fileList = new ArrayList<File>();
//			fileList.add(file1);
//			fileList.add(file2);
			// 执行发送
			return new SendMail().sendEmail(title, htmlContent, receivers, fileList);
		} else
			return false;

	}

}
