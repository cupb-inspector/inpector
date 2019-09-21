package cn.hxy.inspect.inspector.controller;

import cn.hxy.inspect.entity.inspector.Inspector;
import cn.hxy.inspect.inspector.service.UserService;
import cn.hxy.inspect.util.CodeMd5;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;


@Controller
@RequestMapping("/")
public class UserController {

	private final static Logger logger = LoggerFactory.getLogger(UserController.class);

	@RequestMapping(value = "/lo", method = RequestMethod.GET)
	public String login(ModelMap model) {
		model.addAttribute("greeting", "Hello World Again, from Spring 4 MVC");
		return "index";
	}

	@RequestMapping(value = "/loginVerify", method = RequestMethod.POST)
	public void loginVerify(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, NoSuchAlgorithmException {
		int resultCode = 0;
		String tel = null;
		String password = null;

		try {
			tel = request.getParameter("tel").trim();// 这个应该是电话号码
			password = request.getParameter("passwd").trim();
		} catch (NullPointerException e) {
			logger.warn("传入的是一个null");
		}

		logger.info("login Post tel is:" + tel + "Post password is:" + password);

		if (tel != null && password != null && !"".equals(tel) && !"".equals(password)) {
			UserService userService = new UserService();
			Inspector user = userService.login(tel);
			if (user != null) {
				logger.info("用户存在" + user.getUserName());
				// 检查密码
				CodeMd5 codeMd5 = new CodeMd5();
				String newpasswd = codeMd5.codeMd5(password);
				
				if (newpasswd.equals(user.getUserPasswd())) {
					// 匹配成功
					resultCode = 200;
					// 把用户对象存储到session
					request.getSession().setAttribute("user", user);
				} else {
					// 提示密码不正确
					resultCode = 601;
				}
			} else {
				// 提示用户未注册
				resultCode = 404;
			}
		} else
			resultCode = 701;
		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		user_data.put("key2", "today4");
		user_data.put("key3", "today2");
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().append(jsonStr2);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/register-user", method = RequestMethod.POST)
	public void userRegister(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, NoSuchAlgorithmException, ServletException {
		int resultCode = 0;
		try {
			// 返回页面防止出现中文乱码
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		boolean flag = false;
		String username = null;
		String password = null;
		String tel = null;
		String email = null;
		try {
			username = request.getParameter("username").trim();// 这个应该是电话号码
			password = request.getParameter("passwd").trim();
			tel = request.getParameter("tel").trim();
			email = request.getParameter("email").trim();
			logger.info("register Post username is:" + username + tel +email+ " register Post password is:" + password);
			flag=true;
		} catch (Exception e) {
			// TODO: handle exception
			logger.info("存在null");
		}
		if (flag) {
			
			CodeMd5 codeMd5 = new CodeMd5();
			String newpasswd = codeMd5.codeMd5(password);
			Inspector user = new Inspector();
			user.setUserName(username);
			user.setUserPasswd(newpasswd);
			user.setUserTel(tel);
			user.setEmail(email);
			user.setIntegral("0");
			user.setOrders("0");
			user.setRmb("0");
			user.setStatus("0");

			if (username != null && password != null && !"".equals(username) && !"".equals(password)) {
				UserService userService = new UserService();
				// 检查用户是否存在
				Inspector user1 = userService.login(tel);
				if (user1 != null) {
					logger.info("用户存在" + user1.getUserName());
					// 检查密码
					if (password.equals(user1.getUserPasswd())) {
						// 匹配成功
						logger.info("密码正确");
						request.getSession().setAttribute("user", user);
						resultCode = 200;
					} else {
						// 提示密码不正确
						logger.info("密码不正确");
						resultCode = 101;// 用户已经存在，但是密码不正确
					}

				} else {
					logger.info("用户未注册");
					// 提示用户未注册
					if (userService.insert(user)) {
						logger.info("用户注册成功");
						request.getSession().setAttribute("user", user);
						resultCode = 200;
					} 
					else;
				}
			}
		} else {
			resultCode = 404;
		}
		logger.info("返回结果信息");
		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		user_data.put("key2", "today4");
		user_data.put("key3", "today2");
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		try {
			//request.getRequestDispatcher("index").forward(request, response);
			response.getWriter().append(jsonStr2);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/user-login-out", method = RequestMethod.GET)
	public String userLoginOut(ModelMap model, HttpServletRequest request) {
		Inspector user = (Inspector) request.getSession().getAttribute("user");
		if (user != null) {
			logger.info(user.getUserName() + "将要退出登录");
			// false代表：不创建session对象，只是从request中获取。
			HttpSession session = request.getSession(false);
			if (session == null) {

			} else
				session.removeAttribute("user");
//	https://blog.csdn.net/u010143291/article/details/51597507 
		}
		return "login";
	}
	@RequestMapping(value = "/user-update-basic-info", method = RequestMethod.POST)
	public void userUpdateBasicInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		Inspector user = (Inspector) request.getSession().getAttribute("user");
		int resultCode = 0;
		if (user != null) {
			String status = null;
			String address = "";
			String userName = "";
			try {
				address = request.getParameter("address").trim();
				status = request.getParameter("status").trim();
				userName = request.getParameter("userName").trim();
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			System.out.println("userName basic info update:"+userName+status+address);
						user.setUserName(userName);
						user.setStatus(status);
						user.setAddress(address);
						UserService userService = new UserService();
						userService.update(user);
						resultCode = 200;
		}
		else {
				resultCode = 601;
			}
		
		logger.info("返回结果信息");
		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().append(jsonStr2);
			System.out.println("response writer over "+resultCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
//	public void cusInsertOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
//		// 获取用户是否登录
//		User user = (User) request.getSession().getAttribute("user");
//		System.out.println("user-update-basic-info");
//		int resultCode = -1;
//		String address = null;
//		int status = 0;
//		String userName = null;
//		boolean flag = false;
//		try {
//			// 使用Apache文件上传组件处理文件上传步骤：
//			// 1、创建一个DiskFileItemFactory工厂
//			DiskFileItemFactory factory = new DiskFileItemFactory();
//			// 2、创建一个文件上传解析器
//			ServletFileUpload upload = new ServletFileUpload(factory);
//			// 解决上传文件名的中文乱码
//			upload.setHeaderEncoding("UTF-8");
//			// 3、判断提交上来的数据是否是上传表单的数据
//			if (!ServletFileUpload.isMultipartContent(request)) {
//				// 按照传统方式获取数据
//				return;
//			}
//			// 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
//			List<FileItem> list = null;
//			// 解决：https://blog.csdn.net/sinat_34104446/article/details/82755403
//			RequestContext context = new ServletRequestContext(request);
//			try {
//				list = upload.parseRequest(context);
//				logger.info("遍历的大小" + list.size());
//			} catch (FileUploadException e) {
//				e.printStackTrace();
//			}
//			for (FileItem item : list) {
//				logger.info("遍历文件");
//				if (item.isFormField()) {
//
//					String key = item.getFieldName();
//					String value = null;
//					try {
//						value = item.getString("UTF-8");
//					} catch (UnsupportedEncodingException e) {
//						e.printStackTrace();
//					}
//					logger.info(key + "\t" + value);
//					switch (key) {
//					case "excdate":
//						excdate = value;
//						break;
//					case "facname":
//						facname = value;
//						break;
//					case "facaddress":
//						facaddress = value;
//						break;
//					case "facman":
//						facman = value;
//						break;
//					case "factel":
//						factel = value;
//						break;
//					case "profile":
//						profile = value;
//						break;
//					case "goods":
//						goods = value;
//						break;
//					case "goodsType":
//						goodsType = value;
//						break;
//					default:
//						break;
//					}
//				} else {
//					String uuid = UUID.randomUUID().toString().replace("-", "");
//
//					// 生成随机数和id，文件重新命名为id+原来名字，存入数据库.
//					fileName = item.getName();
//					fileUuidName = uuid + fileName;
//					File file = new File(Configuration.FILE_ROOT_DIR, fileUuidName);
//					try { // 创建一个文件输出流
//						InputStream in = item.getInputStream();
//						FileOutputStream out = new FileOutputStream(file);
//						// 创建一个缓冲区
//						byte buffer[] = new byte[1024]; // 判断输入流中的数据是否已经读完的标识
//						int len = 0;
//						// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
//						while ((len = in.read(buffer)) > 0) {
//							out.write(buffer, 0, len);
//						} // 关闭输入流
//						in.close();
//						// 关闭输出流
//						out.close(); // 删除处理文件上传时生成的临时文件
//						item.delete();
//						resultCode = 200;
//
//					} catch (FileNotFoundException e) {
//						e.printStackTrace();
//						resultCode = 601;// 错误
//					} catch (IOException e) {
//						// TODO: handle exception
//					}
//					logger.info("文件名路径：" + file.getAbsolutePath());
//				}
//			}
//			flag = true;
//		} catch (NullPointerException e) {
//			logger.warn("传入的是一个null");
//		}
//		if (flag) {
////			获取时间
//			Date now = new Date();
//			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 可以方便地修改日期格式
//			String date = dateFormat.format(now);
//			User userTemp = new User();
//			UserService userService = new UserService();
////			
//			if (userService.update(userTemp)) {
//				resultCode = 200;
//			} else {
//				resultCode = 500;
//			}
//		} else {
//			resultCode = 400;// bad request
//		}
//		logger.info("修改是否成功信息返回");
//		org.json.JSONObject user_data = new org.json.JSONObject();
//		user_data.put("resultCode", resultCode);// 返回操作状态
////		user_data.put("orderId", orderId);// 返回订单号
////		user_data.put("moneyStatus", moneyStatus);// 返回订单是否有足够支付的的余额
////		user_data.put("cusMoney", cusMoney);// 用户余额
////		user_data.put("billPrice", billPrice);// 订单价格
//		String jsonStr2 = user_data.toString();
//		response.setCharacterEncoding("UTF-8");
//		try {
//			response.getWriter().append(jsonStr2);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	
@RequestMapping(value = "/modify-email", method = RequestMethod.POST)
public void modifyEmail(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	Inspector user = (Inspector) request.getSession().getAttribute("user");
	int resultCode = 0;
	if (user != null) {
		String email = null;
		try {
			email = request.getParameter("email").trim();// 这个应该是新邮箱
		} catch (Exception e) {
		}
		if (email != null && !email.isEmpty()) {
			user.setEmail(email);
			UserService userService = new UserService();
			userService.update(user);

			resultCode = 200;
		} else {
			resultCode = 502;
		}
	} else {
		resultCode = 404;
	}

	org.json.JSONObject user_data = new org.json.JSONObject();
	user_data.put("resultCode", resultCode);
	String jsonStr2 = user_data.toString();
	response.setCharacterEncoding("UTF-8");
	try {
		response.getWriter().append(jsonStr2);
	} catch (IOException e) {
		e.printStackTrace();
	}
}

@RequestMapping(value = "/modify-passwd", method = RequestMethod.POST)
public void modify(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	Inspector user = (Inspector) request.getSession().getAttribute("user");
	int resultCode = 0;
	if (user != null) {
		String origin = null;
		String new2 = null;
		try {
			origin = request.getParameter("origin").trim();// 这个应该是原来的密码
			new2 = request.getParameter("new2").trim();
		} catch (Exception e) {
			// TODO: handle exception
		}
		if (origin != null && new2 != null) {
			// 先比对原密码是否一致
			CodeMd5 codeMd5 = new CodeMd5();
			try {
				origin = codeMd5.codeMd5(origin);
				new2 = codeMd5.codeMd5(new2);
				if (user.getUserPasswd().equals(origin)) {
					// 更新密码
					user.setUserPasswd(new2);
					UserService userService = new UserService();
					userService.update(user);
					resultCode = 200;
				} else {
					resultCode = 502;// 原密码错误
				}
			} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else {
			resultCode = 601;
		}
	} else {
		resultCode = 404;
	}
	logger.info("返回结果信息");
	org.json.JSONObject user_data = new org.json.JSONObject();
	user_data.put("resultCode", resultCode);
	String jsonStr2 = user_data.toString();
	response.setCharacterEncoding("UTF-8");
	try {
		response.getWriter().append(jsonStr2);
	} catch (IOException e) {
		e.printStackTrace();
	}
}


}

