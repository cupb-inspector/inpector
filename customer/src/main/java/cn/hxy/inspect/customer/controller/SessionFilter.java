package cn.hxy.inspect.entity.customer.controller;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

/**
 * 登录过滤
 * 
 * @author geloin
 * @date 2012-4-10 下午2:37:38
 */
public class SessionFilter extends OncePerRequestFilter {

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.springframework.web.filter.OncePerRequestFilter#doFilterInternal(
	 * javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		logger.info(String.format("过滤器%s", request.getRequestURI()));
		String[] notFilter = new String[] { "login", "register","css","js","jpg","png" };
		// 请求的uri
		String uri = request.getRequestURI();
		String indexUrl = uri.substring(uri.lastIndexOf("/"));

		// uri中包含background时才进行过滤
//		if (uri.indexOf("customer") != -1) {
		logger.info("indexUrl" + indexUrl + !"".equals(indexUrl));
		if (!"/".equals(indexUrl)) {
			// 是否过滤
			boolean doFilter = true;
			for (String s : notFilter) {
				if (uri.indexOf(s) != -1) {
					// 如果uri中包含不过滤的uri，则不进行过滤
					doFilter = false;
					break;
				}
			}
			if (doFilter) {
				// 执行过滤
				// 从session中获取登录者实体
				Object obj = request.getSession().getAttribute("user");
				if (null == obj) {
					// 这里可以写登录超时返回给页面的错误信息。或者跳转页面
					logger.info("用户登录信息不存在");
					request.getRequestDispatcher("login").forward(request, response);

				} else {
					logger.info("过滤器检测用户存在");
					// 如果session中存在登录者实体，则继续
					filterChain.doFilter(request, response);
				}
			} else {
				// 如果不执行过滤，则继续
				logger.info(String.format("过滤器不检测的请求%s", request.getRequestURI()));
				filterChain.doFilter(request, response);
			}
		} else {
			logger.info(String.format("过滤器不检测的首页请求%s", request.getRequestURI()));
			filterChain.doFilter(request, response);
		}
	}

}