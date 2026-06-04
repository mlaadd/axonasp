<%@ Language="JScript" %>
<!--#include file="includes/config.asp" -->
<!--#include file="includes/helpers.asp" -->
<!--#include file="includes/auth.asp" -->
<%
LogoutUser();
RedirectTo(AppUrl("login.asp"));
%>