<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.hxy.inspect.entity.customer.User"%>
<%
request.setCharacterEncoding("utf-8");
User user = (User) request.getSession().getAttribute("user");
if (user == null) {
	//登录过期！重新登录提示页！
	%>
	<script type="text/javascript">
	window.top.location.href = 'login';
	</script>
<% 
} else {
	
}
%>