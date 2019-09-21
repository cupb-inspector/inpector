<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.hxy.inspect.entity.inspector.Inspector"%>
<%
request.setCharacterEncoding("utf-8");
	Inspector user = (Inspector) request.getSession().getAttribute("user");
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