<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("username") != null) {
%>

<%
} else {
%>
<script language="javascript">

    alert("请先登录!");

    top.location = 'Login.jsp';

</script>
<%
    }
%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
    System.out.println("路径"+path);
    System.out.println("路径"+basePath);
%>
<c:set value="0" var="is_manager"/>
<c:set value="0" var="is_worker"/>
<c:forEach items="${userrole}" var="role">
    <c:if test="${role == '管理员'}">
        <c:set value="1" var="is_manager"/>
    </c:if>
    <c:if test="${role == '普通用户'}">
        <c:set value="1" var="is_worker"/>
    </c:if>
</c:forEach>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script type="text/javascript">
        window.onload = function () {
            var register_time = "${time}";
            var time = timeStampFormatDay(register_time * 1000);
            console.log(time);
            $("#show_user_name").html("${username}");
            $("#show_user_name").html("${username}");
            $("#show_user_role").html("${userrole}");
            $("#show_register_time").html(time);

        }
    </script>
    <link rel="stylesheet" type="text/css" href="/mybatis/knowledgebase/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/mybatis/knowledgebase/css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="/mybatis/knowledgebase/css/common.css">
<script src="/mybatis/knowledgebase/js/jquery.min.js"></script>
<script src="/mybatis/knowledgebase/js/bootstrap.min.js"></script>
<script src="/mybatis/knowledgebase/js/html5shiv.min.js"></script>
<script src="/mybatis/knowledgebase/js/respond.min.js"></script>
<script src="/mybatis/knowledgebase/js/common.js"></script>
<script src="/mybatis/knowledgebase/js/public_search.js"></script>
<script src="/mybatis/knowledgebase/js/adm_personal.js"></script>
<script src="/mybatis/knowledgebase/js/jquery-ui.min.js"></script>


<style type="text/css">
	

</style>

</head>
<body>


<jsp:include page="public-part.jsp" flush="true"/>
<div class="container">

		<div class="col-xs-2 left_nav">
		<ul class="nav nav-menu">
					<li class="active"><a href="/mybatis/knowledgebase/adm-personal.jsp">个人中心&nbsp;&nbsp;&nbsp;</a></li>
					<li><a href="#user-manage" data-toggle="collapse">用户管理<span class="glyphicon glyphicon-menu-down" ></span></a></li>
						<ul id="user-manage" class="panel-collapse collapse in">
							<li><a href="/mybatis/knowledgebase/adm-inquire.jsp">用户查询</a></li>
							<li><a href="/mybatis/knowledgebase/adm-check.jsp">用户审核</a></li>
						</ul>
					<c:if test="${is_manager == 1}">
					<li><a href="#source-manage" data-toggle="collapse">资源管理<span class="glyphicon glyphicon-menu-down" ></span></a></li>
						<ul id="source-manage" class="panel-collapse collapse in col_a">
							<li><a href="/mybatis/knowledgebase/adm-private.jsp">我的文件</a></li>
							<li><a href="/mybatis/knowledgebase/adm-waitforcheck.jsp">待审文件</a></li>
							<li><a href="/mybatis/knowledgebase/adm-public.jsp">公有文件</a></li>
							<li><a href="/mybatis/knowledgebase/adm-download.jsp">我的下载</a></li>
							<li><a href="/mybatis/knowledgebase/adm-upload.jsp">文件上传</a></li>
							<li><a href="/mybatis/knowledgebase/adm-draft.jsp">草稿箱</a></li>
						</ul>
					</c:if>
					 <c:if test="${is_manager == 1}">
					<li><a href="#system-manage" data-toggle="collapse">系统管理<span class="glyphicon glyphicon-menu-down" ></span></a></li>
						<ul id="system-manage" class="panel-collapse collapse in">
							<li><a href="/mybatis/knowledgebase/adm-category.jsp">类别管理</a></li>
							<li><a href="/mybatis/knowledgebase/adm-checkfile.jsp">资源审核</a></li>
							<li><a href="#">数据还原</a></li>
							<li><a href="#">数据备份</a></li>
						</ul>
					</c:if>
					</ul>
		<div style="clear: both;"></div>
		</div>
         <div class="col-xs-10 r_body" >	
            <div class="panel panel-info"  id="default_panel">
                <div class="panel-heading">
                    <h3 class="panel-title">个人信息</h3>
                </div>
                <div class="panel-body">


                    <div style="float:left;margin-top:50px;margin-left:100px;">
                        <img src="/mybatis/knowledgebase/img/1.png">
                    </div>
                    <div style="font-size:15px;float:right;margin-top:120px;margin-right:150px;">
                        <p>用户名：<span id="show_user_name">xxxx</span></p>

                        <p>用户角色：<span id="show_user_role">xxxx</span></p>

                        <p>注册时间：<span id="show_register_time">xxxx</span></p>
                    </div>
                    <div align="center" style="margin-top:400px;">
                        <button class="btn btn-info" data-toggle="modal" data-target="#changepsw"
                                onclick="change_password()">修改密码
                        </button>
                    </div>
                </div>
            </div>
            <jsp:include page="search-result.jsp" flush="true"/>
            <div style="clear:both;"></div>
        </div>
    </div>
    <div class="modal fade" id="changepsw" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel">修改密码</h4>
                </div>
                <div class="modal-body">
                    <ul style="padding-left:0px;">
                        <li><input type="password" placeholder="请输入原密码" class="form-control" id="oldpsw"></li>
                        <div id="spanusername" style="margin-left:6px;margin-bottom:10px;height:6px;"></div>
                        <li><input type="password" id="password1" class="form-control" placeholder="请输入新密码"></li>
                        <div id="spanpsw" style="margin-left:6px;margin-bottom:10px;height:6px;"></div>
                        <li><input type="password" id="password2" class="form-control" placeholder="请再次输入新密码"></li>
                        <div id="spanrepsw" style="margin-left:6px;margin-bottom:10px;height:6px;"></div>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary " id="btnclick" data-dismiss="modal">确认</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="logout-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel-logout">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel-logout">退出提示</h4>
                </div>
                <div class="modal-body">
                    <p id="logout-username"></p>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary " data-dismiss="modal" id="logout-dismiss">确认</button>
                </div>
            </div>
        </div>
    </div>


</div>


<style type="text/css">
    .modal {
        margin-top: 20%;
    }

    .modal-body li {
        list-style-type: none;
        padding: 0px 5px;
        border: 1px solid #ffffff;
        padding: 5px 0px;
    }

    #username1, #password1 {
        font-size: 15px;

    }

    .footer {
        position: absolute;
        top: 94%;
        height: 6%;
        background-color: #e1e1e1;
        width: 100%;

        text-align: center;
        min-width: 1190px;
    }

    .footer span.footerText {
        font-size: 14px;
        margin-top: 0.5%;
        color: #606060;
        display: inline-block;
    }
</style>
<%--<div class="footer"> <span class="footerText">Copyright © 1956-2016 电子科技大学</span> </div>--%>
</body>
</html>
