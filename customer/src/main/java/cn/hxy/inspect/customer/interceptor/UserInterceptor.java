package cn.hxy.inspect.customer.interceptor;

import cn.hxy.inspect.customer.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserInterceptor implements HandlerInterceptor {
	private final static Logger logger = LoggerFactory.getLogger(UserInterceptor.class);

	// 返回值：是否将当前的请求拦截下来
	// 如果返回true：请求会被继续执行
	// 如果返回false：请求将会被拦截
	// Object org ：表示的是被拦截的请求的目标对象
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object org) throws Exception {
		// 根据session查询用户信息，如果用户不为空返回true
		logger.info(String.format("拦截预处理%s", request.getRequestURI()));
		User user = (User) request.getSession().getAttribute("user");

		if (user != null) {
			logger.info("拦截器检测到了用户");
			return true;
		} else {
			// 这里可以写登录超时返回给页面的错误信息。或者跳转页面
			logger.info("用户登录信息不存在");
			org.json.JSONObject user_data = new org.json.JSONObject();
			user_data.put("resultCode", 404);
			user_data.put("msg", "用户登录信息不存在");
			String jsonStr2 = user_data.toString();
			response.setCharacterEncoding("UTF-8");
			try {
				response.getWriter().append(jsonStr2);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return false;
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.servlet.HandlerInterceptor#postHandle(javax.servlet.
	 * http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, org.springframework.web.servlet.ModelAndView)
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		logger.info("post方法拦截");

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.servlet.HandlerInterceptor#afterCompletion(javax.
	 * servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, java.lang.Exception)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}
}
//--------------------- 
//作者：坚持并奋斗 
//来源：CSDN 
//原文：https://blog.csdn.net/qq_38236927/article/details/82879091 
//版权声明：本文为博主原创文章，转载请附上博文链接！