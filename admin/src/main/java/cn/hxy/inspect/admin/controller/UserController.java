package cn.hxy.inspect.admin.controller;

import cn.hxy.inspect.admin.service.AdminUserService;
import cn.hxy.inspect.entity.admin.AdminUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

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
	public void loginVerify(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
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
			AdminUserService userService = new AdminUserService();
			AdminUser user = userService.login(tel);
			if (user != null) {
				logger.info("用户存在" + user.getAdminName()+"\tTel:"+user.getAdminTel());
				// 检查密码
				if (password.equals(user.getAdminPasswd())) {
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
	public void userRegister(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		int resultCode = 0;
		try {
			// 返回页面防止出现中文乱码
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String username = request.getParameter("name").trim();// 这个应该是电话号码
		String password = request.getParameter("passwd").trim();
		String tel = request.getParameter("tel").trim();
		String role = request.getParameter("role").trim();
		logger.info("register Post username is:" + username + tel + " register Post password is:" + password);

		AdminUser user = new AdminUser();
		user.setAdminName(username);
		user.setAdminPasswd(password);
		user.setAdminTel(tel);
		user.setRole(role);
		if (username != null && password != null && !"".equals(username) && !"".equals(password)) {
			AdminUserService userService = new AdminUserService();
			// 检查用户是否存在
			AdminUser user1 = userService.login(tel);
			if (user1 != null) {
				logger.info("用户存在" + user1.getAdminName());
				// 检查密码
				if (password.equals(user1.getAdminPasswd())) {
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
				} else
					;
			}
		}
		logger.info("返回注册信息");

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

	@RequestMapping(value = "/user-login-out", method = RequestMethod.GET)
	public String userLoginOut(ModelMap model, HttpServletRequest request) {
		AdminUser user = (AdminUser) request.getSession().getAttribute("user");
		if (user != null) {
			logger.info(user.getAdminName() + "将要退出登录");
			// false代表：不创建session对象，只是从request中获取。
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.removeAttribute("user");
			} else
				;
//	https://blog.csdn.net/u010143291/article/details/51597507 
		}
		return "login";
	}


}
