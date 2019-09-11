package cn.hxy.inspect.entity.customer.controller;

import cn.hxy.inspect.entity.Account;
import cn.hxy.inspect.entity.customer.User;
import cn.hxy.inspect.entity.customer.service.AccountService;
import cn.hxy.inspect.entity.customer.service.UserService;
import cn.hxy.inspect.util.Configuration;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/")
public class AccountController {
	private final static Logger logger = LoggerFactory.getLogger(OrderController.class);

	@RequestMapping(value = "/account-charge", method = RequestMethod.POST)
	public void cusInsertOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 获取用户是否登录
		User user = (User) request.getSession().getAttribute("user");
		int resultCode = 0;
		String fileUuid = null;
		if (user != null) {
			// 查询最新的个人信息
			UserService userService = new UserService();
			user = userService.selectUserByTel(user.getCustel());

			Account account = new Account();
			account.setUserId(user.getCusid());
			account.setOperate("1");
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 可以方便地修改日期格式

			String StartTime = dateFormat.format(now);
			logger.info(String.format("现在时间：%s", StartTime));
			account.setTime(StartTime);
			account.setType("1");// 充值 1充值
			account.setStatus("0");

			logger.info("开始接收凭证");
			// 使用Apache文件上传组件处理文件上传步骤：
			// 1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 3、判断提交上来的数据是否是上传表单的数据
			if (!ServletFileUpload.isMultipartContent(request)) {
				// 按照传统方式获取数据
				return;
			}

			// 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项

			List<FileItem> list = null;

			// 解决：https://blog.csdn.net/sinat_34104446/article/details/82755403

			RequestContext context = new ServletRequestContext(request);
			try {
				list = upload.parseRequest(context);
				logger.info("遍历的大小" + list.size());
			} catch (FileUploadException e) {
				e.printStackTrace();
			}

			for (FileItem item : list) {
				logger.info("遍历文件");
				if (item.isFormField()) {
					String key = item.getFieldName();
					String value = null;
					try {
						value = item.getString("UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					logger.info(key);
					switch (key) {
					case "value":
						account.setValue(value);

						break;
					case "notes":
						account.setNotes(value);
						break;
					default:
						break;
					}

				} else {
					String fileName = item.getName();
					String uuid = UUID.randomUUID().toString().replace("-", "");
					// 全球唯一标识码
					fileUuid = uuid + fileName;
					File file = new File(Configuration.FILE_ROOT_DIR, fileUuid);
					try { // 创建一个文件输出流
						InputStream in = item.getInputStream();
						FileOutputStream out = new FileOutputStream(file);
						// 创建一个缓冲区
						byte buffer[] = new byte[1024]; // 判断输入流中的数据是否已经读完的标识
						int len = 0;
						// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
						while ((len = in.read(buffer)) > 0) {
							out.write(buffer, 0, len);
						} // 关闭输入流
						in.close();
						// 关闭输出流
						out.close(); // 删除处理文件上传时生成的临时文件
						item.delete();
						resultCode = 200;
					} catch (FileNotFoundException e) {
						e.printStackTrace();
						resultCode = 601;// 错误
					} catch (IOException e) {
						e.printStackTrace();
					}
					account.setFile(fileName);
					logger.info("Length of fileUuid:" + fileUuid.length());
					account.setFileUuid(fileUuid);
					logger.info("文件名路径：" + file.getAbsolutePath());
				}
			}
			AccountService accountService = new AccountService();
//			logger.info(user.getCusMoney());
			logger.info(account.getValue());

//			float a = Float.parseFloat(user.getCusMoney())+ Float.parseFloat(account.getValue());
			// 获取上一次的余额
			float a = Float.parseFloat(user.getCusTempMoney()) + Float.parseFloat(account.getValue());

			account.setSurplus(String.valueOf(a));

			try {
				if (accountService.insert(account)) {
					resultCode = 200;
					// 处理用户的临时余额
					user.setCusTempMoney(String.valueOf(a));
					userService.update(user);
					// 充值成功。获取用户的货币余额，处理下
					// 应该由管理员通过后再加上去。
					// int money =Integer.parseInt(
					// account.getValue())+Integer.parseInt(user.getCusMoney());
					// 更新用户的余额
				} else
					resultCode = 599;// 数据库内部操作异常
			} catch (IOException e) {
				e.printStackTrace();
				resultCode = 598;// 数据库内部错误
			}
		}
		String param = "fileUuid=" + fileUuid;

		sendPost(Configuration.IMAGE_URL, param);

		// 返回信息
		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		user_data.put("key2", "today4");
		user_data.put("key3", "today2");
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().append(jsonStr2);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 向指定 URL 发送POST方法的请求
	 * 
	 * @param url   发送请求的 URL
	 * @param param 请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
	 * @return 所代表远程资源的响应结果
	 */
	public static String sendPost(String url, String param) {
		logger.info("发送图片迁移指令的url" + url + "param" + param);
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// 设置通用的请求属性
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			logger.info("发送 POST 请求出现异常！" + e);
//			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输出流、输入流
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}

	@RequestMapping(value = "/account-withdraw", method = RequestMethod.POST)
	public void cusWithdraw(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		logger.info("提现响应");
		// 获取用户是否登录
		User user = (User) request.getSession().getAttribute("user");
		int resultCode = 0;
		if (user != null) {
			String value = request.getParameter("value").trim();
			String notes = request.getParameter("notes").trim();
			logger.info("提现的信息：" + value + "\t" + notes);
			// 查询用户的实际金额是否充足！
			if (value != null && !"null".equals(value)) {
				UserService userService = new UserService();
				user = userService.selectUserById(user.getCusid());
				int money =user.getCusMoney();
				float temMoney = Float.parseFloat(user.getCusTempMoney());
				float valuef = Float.parseFloat(value);
				if (money >= valuef) {
					logger.info("符合提现");
					// 第一步检查是判断是否提现合理，但是这个时候还不去减少真正的余额，也就是可以继续消费。
					// 等管理员审核的时候，再次检查提现额度是否合理，合理就提现成功，不合理就提现失败。

//					说明可以提现
//					float a = money -valuef;//实际剩下余额
					float b = temMoney - valuef;
//					user.setCusMoney(String.valueOf(a));
					user.setCusTempMoney(String.valueOf(b));
					userService.update(user);

					resultCode = 200;

					AccountService accountService = new AccountService();
					Account account = new Account();
					account.setNotes(notes);
					account.setValue(value);
					account.setSurplus(String.valueOf(b));
					account.setType("2");// 提现
					account.setUserId(user.getCusid());
					account.setOperate("2");
					account.setStatus("0");

					Date now = new Date();
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 可以方便地修改日期格式
					String StartTime = dateFormat.format(now);
					logger.info(String.format("现在时间：%s", StartTime));
					account.setTime(StartTime);
					try {
						accountService.insert(account);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				} else {
					logger.info("余额不足");
					// 返回逻辑错误提示，余额不够提现这么多。
					resultCode = 665;// 余额不足提示
				}
			}

		} else {
			resultCode = 404;// 用户未登录
		}

		// 返回信息
		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		user_data.put("key2", "today4");
		user_data.put("key3", "today2");
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().append(jsonStr2);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
