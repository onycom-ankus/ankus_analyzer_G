﻿<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page import="org.ankus.web.member.Member"%>
<%
Member member = (Member)session.getAttribute("user");
String userId = "admin";
if(null != member){
	userId = member.getUsername();
}

Cookie[] cookies = request.getCookies();
boolean isLogin = false;
if(cookies != null){
	for(int i=0; i<cookies.length; i++){
		String name = cookies[i].getName();
		if(name != null){
			if(name.equals("authenticate")){
				isLogin = true;
				break;
			}
		}
	}
}

if(isLogin == false){
	return;
//	Cookie c = new Cookie("authenticate", "admin"+"/"+"ROLE_ADMIN");
//	response.addCookie(c);
}


%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title><spring:message code="MFDS_TITLE"/></title>
	<link rel="shortcut icon" href="../resources/images/favicon.ico"><!-- 파비콘 이미지 -->
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/jquery-layout/layout-default-latest.css"/>
	<link type="text/css" rel="stylesheet" href="/resources/lib/main/jquery-ui/jquery-ui.structure.min.css">
	<link type="text/css" rel="stylesheet" href="/resources/lib/main/jquery-ui/jquery-ui.theme.min.css">
	<link type="text/css" rel="stylesheet" href="/resources/lib/main/jquery-contextMenu/jquery.contextMenu.min.css">
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/jquery-uploadfile/uploadfile.css">
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/jsTree/style.min.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/jqgrid/css/ui.jqgrid.min.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/jqgrid/css/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/codemirror/lib/codemirror.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/codemirror/addon/hint/show-hint.css">
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/bootstrap/css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/bootstrap/css/bootstrap-theme.min.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/datepicker/css/datepicker.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/lib/main/nvd3/css/nv.d3.min.css"/>
    
    <style>
    .display_none {
    	display : none;
    }
    .browser_button {
    	margin : 3px;
    }
    #_main_alert,#_main_confirm {
    	z-index : 99999;
    }
    #_main_tabmenu {
    	z-index: 3 !important;
    	overflow: initial !important;
   	} 
        
    </style>
    <script>
	    function autoResize(i)
		{
			var iframeHeight=
		    (i).contentWindow.document.body.scrollHeight;
		    (i).height=iframeHeight+20;
		}
    </script>
</head>
<body>
	<input type="hidden" id="_main_userId" value="<%=userId%>" />
	<input type="hidden" id="_main_script_language" value="${script_language }" />

	<div class="ui-layout-north" id="_main_tabmenu">
		<nav class="navbar navbar-default" style="margin-bottom:0px;">
			<div class="container-fluid">				
				<ul class="nav navbar-nav" style="line-height:0px;">					
					<li id="_tabAnalyzer" data-body="_conAnalyzer" class="active"><a href="#"><spring:message code="MENU_WORKFLOW"/></a></li>
					<li id="_tabScheduler" data-body="_conSchduler"><a href="#"><spring:message code="MENU_SCHEDULER"/></a></li>
					<li id="_tabDashboard" data-body="_conDashboard"><a href="#"><spring:message code="MENU_FLOWMANAGE"/></a></li> 
					<li id="_tabFileSystem" data-body="_conFileSystem"><a href="#"><spring:message code="MENU_HDFS_BROWSER"/></a></li>
					<li id="_tabMonitoring" data-body="_conMonitoring"><a href="#"><spring:message code="MENU_MONITORING"/></a></li>
					<li id="_tabVisual" data-body="_conVisual"><a href="#"><spring:message code="MENU_CHART_TOOL"/></a></li>
					<li id="_tabHQryMgr" data-body="_conHQryMgr"><a href="#"><spring:message code="MENU_HIVE_QUERY_TOOL"/></a></li>						
					<li id="_tabMyInfo" data-body="_conMyInfo"><a href="#"><spring:message code="MENU_MY_INFO"/></a></li>	
					<li class="dropdown">
						<a href = "#" class = "dropdown-toggle" data-toggle = "dropdown">관리자 도구<span class="caret"></span></a> 
						<ul class="dropdown-menu">
							<li id="_tabUserMgr" data-body="_conUserMgr"><a href="#"><spring:message code="MENU_USER_MANAGE"/></a></li>	
			            	<li id="_tabHadoopMgr" data-body="_conHadoopMgr"><a href="#"><spring:message code="MENU_HADOOP_MANAGE"/></a></li>	
			            	<li id="_tabSrvMgr" data-body="_conSrvMgr"><a href="#"><spring:message code="MENU_SERVER_MANAGE"/></a></li>	
			            	<li id="_tabAlgMgr" data-body="_conAlgMgr"><a href="#"><spring:message code="MENU_ALGORITHM_MANAGE"/></a></li>	
			            	<li id="_tabHMetaMgr" data-body="_conHMetaMgr"><a href="#"><spring:message code="MENU_HIVE_META_MANAGE"/></a></li>	
			            	<li id="_tabLanguage" data-body="_conLanguage"><a href="#"><spring:message code="MENU_LANGUAGE_SETTING"/></a></li>	
						</ul>
					</li>
					
						
					<li id="_tabLogout"><a href="javascript:logout();"><spring:message code="MENU_LOGOUT"/></a></li>
				</ul>
			</div>
		</nav>
		
	</div>
	<div class="ui-layout-center">
		<div class="_body container" id="_conAnalyzer"><jsp:include page="../main/analyzer.jsp"/></div>
		<div class="_body" id="_conSchduler" style="display:none"><jsp:include page="../main/scheduler.jsp"/></div>
		<div class="_body" id="_conDashboard" style="display:none"><jsp:include page="../main/dashboard.jsp"/></div>
		<div class="_body" id="_conFileSystem" style="display:none"><jsp:include page="../main/filesystem.jsp"/></div>
		<div class="_body" id="_conVisual" style="display:none"><jsp:include page="../main/visual.jsp"/></div>
		<div class="_body" id="_conMonitoring" style="display:none"><jsp:include page="../main/monitoring.jsp"/></div>

		<div class="_body" id="_conSrvMgr" style="display:none"><jsp:include page="../main/srvmgr.jsp"/></div>		
		<div class="_body" id="_conHadoopMgr" style="display:none"><jsp:include page="../main/hadoopmgr.jsp"/></div>		
		<div class="_body" id="_conAlgMgr" style="display:none"><jsp:include page="../main/algmgr.jsp"/></div>		
		<div class="_body" id="_conHMetaMgr" style="display:none"><jsp:include page="../main/hmetamgr.jsp"/></div>		
		<div class="_body" id="_conHQryMgr" style="display:none"><jsp:include page="../main/hqrymgr.jsp"/></div>		
		<div class="_body" id="_conUserMgr" style="display:none"><jsp:include page="../main/usermgr.jsp"/></div>		
		<div class="_body" id="_conMyInfo" style="display:none"><jsp:include page="../main/myinfo.jsp"/></div>
		<div class="_body" id="_conLanguage" style="display:none"><jsp:include page="../main/language.jsp"/></div>		
	</div>
	<style>
	.wrap-loading{
		position : fixed;
		left : 0;
		right : 0;
		top : 0;
		bottom :0;
		background : rgba(0,0,0,0.2);
		filter : progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');
		z-index:99999;
	}
	.wrap-loading div{
		position : fixed;
		top : 50%;
		left : 50%;
		margin-left : -21px;
		margin-top : -21px;
	}
	
	</style>	
	<script src="/resources/lib/main/jquery/jquery.js"></script>
	<script src="/resources/lib/main/jquery-ui/jquery-ui.min.js"></script>	
	<script src="/resources/lib/main/jquery-contextMenu/jquery.contextMenu.min.js"></script>		
	<script src="/resources/lib/main/jquery-render/jsrender.min.js"></script>	
	<script src="/resources/lib/main/jquery-layout/jquery.layout-latest.js"></script>
	<script src="/resources/lib/main/jsTree/jstree.min.js"></script>
	<script src="/resources/lib/main/jqgrid/i18n/grid.locale-kr.min.js"></script>
	<script src="/resources/lib/jquery/jquery.i18n.properties.js"></script>
	<script src="/resources/lib/main/jqgrid/jquery.jqgrid.min.js"></script>
	<script src="/resources/lib/main/jqgrid/modules/jqdnr.js"></script>
	<script src="/resources/lib/main/jqgrid/modules/jqmodal.js"></script>
	<script src="/resources/lib/main/jqgrid/modules/grid.formedit.js"></script>
	<script src="/resources/lib/main/jqgrid/modules/grid.common.js"></script>
	<script src="/resources/lib/main/d3/js/d3.v3.min.js"></script>
	
	<script src="/resources/lib/main/opengraph/OpenGraph-0.1-SNAPSHOT.js"></script>
	<script src="/resources/lib/main/codemirror/lib/codemirror.js"></script>
	<script src="/resources/lib/main/codemirror/addon/hint/show-hint.js"></script>
	<script src="/resources/lib/main/codemirror/addon/hint/xml-hint.js"></script>
	<script src="/resources/lib/main/codemirror/mode/xml/xml.js"></script>
	<script src="/resources/lib/main/bootstrap/js/bootstrap.min.js"></script>
	<script src="/resources/lib/main/datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/resources/lib/main/jquery-uploadfile/jquery.uploadfile.min.js"></script>
	<script src="/resources/lib/main/saveSvgAsPng/saveSvgAsPng.js"></script>
	<script src="/resources/lib/main/nvd3/js/nv.d3.min.js"></script>
	
	<script src="/resources/js/main/ankusApi.js"></script>
	<script src="/resources/js/main/language.js"></script>
	<script src="/resources/js/main/main.js"></script>
	<script src="/resources/js/main/analyzer.js"></script>
	<script src="/resources/js/main/scheduler.js"></script>
	<script src="/resources/js/main/dashboard.js"></script>
	<script src="/resources/js/main/filesystem.js"></script> 
	<script src="/resources/js/main/monitoring.js"></script>
	<script src="/resources/js/main/visual.js"></script>
	
	<script src="/resources/js/main/srvmgr.js"></script>
	<script src="/resources/js/main/myinfo.js"></script>
	<script src="/resources/js/main/hadoopmgr.js"></script>
	<script src="/resources/js/main/usermgr.js"></script>

	<script src="/resources/js/main/hmetamgr.js"></script>
	<script src="/resources/js/main/hqrymgr.js"></script>
	<script src="/resources/js/main/algmgr.js"></script>


	<script>
	$(document).ready(function () {
		$('#_tabAnalyzer').trigger('click'); 
	});
	</script>
</body>
</html>
