<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 16/05/2025
  Time: 09:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (role.equals("user")) {
%>
<%@include file="navbar_users.jsp"%>
<%
} else if (role.equals("admin")) {
%>
<%@include file="navbar_users.jsp"%>
<%@include file="navbar_admins.jsp"%>
<%
  }
%>
