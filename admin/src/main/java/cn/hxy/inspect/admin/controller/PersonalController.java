package cn.hxy.inspect.admin.controller;

import cn.hxy.inspect.entity.admin.AdminUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/")
public class PersonalController {
	private final static Logger logger = LoggerFactory.getLogger(PersonalController.class);

	@RequestMapping(value = "/wallet", method = RequestMethod.GET)
	public void downloadReport(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// 返回页面防止出现中文乱码
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// 获取用户是否登录
		AdminUser user = (AdminUser) request.getSession().getAttribute("user");
	
		//查找客户的钱包信息
		if(user!=null) {
	

		//	model.addAttribute("status", orders.getStatusString());
		}
		
		
	}

}
