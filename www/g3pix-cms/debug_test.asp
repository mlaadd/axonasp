<%@ Language="JScript" %>
<!--#include file="includes/config.asp" -->
<!--#include file="includes/helpers.asp" -->
<!--#include file="includes/i18n.asp" -->
<!--#include file="includes/db.asp" -->
<%
var defaultLang = NormalizeLanguageCode(GetSettingValue("default_locale", "en"), "en");
var userSet = false;
var langQS = NormalizeLanguageCode(Request.QueryString("lang"), "");
if (langQS != "") userSet = true;

var sessionLang = "";
try { sessionLang = SafeToString(Session("g3pix_lang")); } catch (ex) { sessionLang = "EX:" + ex.message; }
var sessionNormalized = NormalizeLanguageCode(sessionLang, "");

var cookieValRaw = "";
try { cookieValRaw = TrimString(Request.Cookies("g3pix_lang")); } catch (ex) { cookieValRaw = "EX:" + ex.message; }
var cookieLang = NormalizeLanguageCode(cookieValRaw, "");

Response.Write("langQS=" + langQS + "\n");
Response.Write("sessionLang=" + sessionLang + "\n");
Response.Write("cookieValRaw=[" + cookieValRaw + "]\n");
Response.Write("cookieLang=" + cookieLang + "\n");
%>