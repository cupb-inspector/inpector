package cn.hxy.inspect.customer.controller;

import cn.hxy.inspect.entity.customer.CusUser;
import cn.hxy.inspect.customer.service.UserService;
import cn.hxy.inspect.util.CodeMd5;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

@Controller
@RequestMapping("/")
public class UserController {
	private final static Logger logger = LoggerFactory.getLogger(UserController.class);
	@RequestMapping(value = "/loginVerify", method = RequestMethod.POST)
	public void loginVerify(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		int resultCode = 0;
		String tel = null;
		String password = null;

		try {
			tel = request.getParameter("tel").trim();// 这个应该是电话号码
			password = request.getParameter("passwd").trim();
		} catch (NullPointerException e) {
			logger.warn("传入的是一个null");
		}

//		logger.info("login Post tel is:" + tel + "Post password is:" + password);
		UserService userService = new UserService();
		if (tel != null && password != null && !"".equals(tel) && !"".equals(password)) {

			CusUser cusUser = userService.login(tel);
			if (cusUser != null) {
				logger.info("用户存在" + cusUser.getCusname());
				// 检查密码
				String newpasswd = null;
				CodeMd5 codeMd5 = new CodeMd5();
				try {
					newpasswd = codeMd5.codeMd5(password);
				} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				if (newpasswd.equals(cusUser.getCuspasswd())) {
					// 匹配成功
					resultCode = 200;
					// 把用户对象存储到session
					request.getSession().setAttribute("user", cusUser);
					logger.info("成功登录用户：" + cusUser.getCusname() + "\t" + cusUser.getCustel() + "\t" + cusUser.getCusid());
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

	@RequestMapping(value = "/modify-email", method = RequestMethod.POST)
	public void modifyEmail(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		CusUser cusUser = (CusUser) request.getSession().getAttribute("cusUser");
		int resultCode = 0;
		if (cusUser != null) {
			String email = null;
			try {
				email = request.getParameter("email").trim();// 这个应该是新邮箱
			} catch (Exception e) {
			}
			if (email != null && !email.isEmpty()) {

				cusUser.setEmail(email);
				UserService userService = new UserService();
				userService.update(cusUser);

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
		CusUser cusUser = (CusUser) request.getSession().getAttribute("cusUser");
		int resultCode = 0;
		if (cusUser != null) {
			String origin = null;
			String new2 = null;
			try {
				origin = request.getParameter("origin").trim();// 这个应该是电话号码
				new2 = request.getParameter("new2").trim();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (origin != null && new2 != null) {
				// 先比对原密码是否一致
				CodeMd5 codeMd5 = new CodeMd5();
				try {
					origin = codeMd5.codeMd5(origin);
					new2 = codeMd5.codeMd5(new2);
					if (cusUser.getCuspasswd().equals(origin)) {
						// 更新密码
						cusUser.setCuspasswd(new2);
						UserService userService = new UserService();
						userService.update(cusUser);
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
		logger.info("返回注册信息");
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

	@RequestMapping(value = "/register-user", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> userRegister(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String,Object> hashMap =new HashMap<>();
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
		String newpasswd = null;
		try {
			username = request.getParameter("username").trim();// 这个应该是电话号码
			password = request.getParameter("passwd").trim();
			tel = request.getParameter("tel").trim();
			email = request.getParameter("email").trim();
			flag = true;
			CodeMd5 codeMd5 = new CodeMd5();
			try {
				newpasswd = codeMd5.codeMd5(password);
			} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
				logger.error("{}",e.getMessage());
			}
		} catch (NullPointerException e) {
			logger.error("{}",e.getMessage());
		}
		if (flag) {

			logger.info("register Post username is:" + username + tel + " register Post password is:" + password);

			if (username != null && password != null && !"".equals(username) && !"".equals(password)) {

				CusUser cusUser = new CusUser();
				cusUser.setCusname(username);
				cusUser.setCuspasswd(newpasswd);
				cusUser.setCustel(tel);
				cusUser.setEmail(email);
				cusUser.setCusgrade("0");
				cusUser.setCusMoney(0);
				cusUser.setCusOrders(0);
				cusUser.setCusTempMoney(0);
				// 检查用户是否存在
				UserService userService = new UserService();
				CusUser cusUser1 = userService.login(tel);
				if (cusUser1 != null) {
					logger.info("用户存在" + cusUser1.getCusname());
					// 检查密码
					if (password.equals(cusUser1.getCuspasswd())) {
						// 匹配成功
						logger.info("密码正确");
						request.getSession().setAttribute("user", cusUser);
						resultCode = 200;
					} else {
						// 提示密码不正确
						logger.info("密码不正确");
						resultCode = 101;// 用户已经存在，但是密码不正确
					}

				} else {
					logger.info("用户未注册");
					// 提示用户未注册
					if (userService.insert(cusUser)) {
						logger.info("用户注册成功");
						// 新注册的用户是没有id的，因此需要再次读取数据库查看id
						cusUser = userService.selectUserByTel(cusUser.getCustel());
						request.getSession().setAttribute("user", cusUser);
						resultCode = 200;
					} else
						;
				}
			}

		} else {
			resultCode = 404;
		}
		logger.info("返回注册信息");
		hashMap.put("resultCode",resultCode);
		return hashMap;
	}

	@RequestMapping(value = "/user-login-out", method = RequestMethod.GET)
	public String userLoginOut(ModelMap model, HttpServletRequest request) {
		CusUser cusUser = (CusUser) request.getSession().getAttribute("cusUser");
		if (cusUser != null) {
			logger.info(cusUser.getCusname() + "将要退出登录");
			// false代表：不创建session对象，只是从request中获取。
			HttpSession session = request.getSession(false);
			if (session == null) {

			} else
				session.removeAttribute("cusUser");
//	https://blog.csdn.net/u010143291/article/details/51597507 
		}
		return "login";
	}
}
