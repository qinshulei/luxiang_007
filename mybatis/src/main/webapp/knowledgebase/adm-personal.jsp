<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        if(session.getAttribute("username")!=null){
%>

<%
    }
    else
    {
    %>
    <script language="javascript">

        alert("请先登录!");

        top.location='Login.jsp';

    </script>
        <%
	}
%>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="/mybatis/knowledgebase/css/bootstrap.min.css">
        <script src="/mybatis/knowledgebase/js/jquery.min.js"></script>
        <script src="/mybatis/knowledgebase/js/bootstrap.min.js"></script>
        <script src="/mybatis/knowledgebase/js/html5shiv.min.js"></script>
        <script src="/mybatis/knowledgebase/js/respond.min.js"></script>
        <script src="/mybatis/knowledgebase/js/common.js"></script>
        <script src="/mybatis/knowledgebase/js/adm_personal.js"></script>

        <style type="text/css">
            .nav{
                margin-bottom: 5px;
                text-align:center;
            }
            .hr{
                margin: 0 auto;
            }
            .container{
                width: 1320px !important;
            }

        </style>
        <script>
            <%--$(function(){--%>
                <%--var register_time = "${userinfo.getUserRegisterTime()}";--%>
                <%--var time = timeStampFormatDay(register_time*1000);--%>
                <%--console.log(time);--%>
                <%--$("#show_user_name").html("${username}");--%>
                <%--$("#show_user_role").html("${userinfo.getUserRole()}");--%>
                <%--$("#show_register_time").html(time);--%>
            <%--})--%>

        </script>
        <script type="text/javascript">
            window.onload=function(){
                var register_time = "${userinfo.getUserRegisterTime()}";
                var time = timeStampFormatDay(register_time*1000);
                console.log(time);
                $("#show_user_name").html("${username}");
                $("#show_user_role").html("${userrole}");
                $("#show_register_time").html(time);
                var oldpswobj=document.getElementById("oldpsw");
                var psw1obj=document.getElementById("password1");
                var psw2obj=document.getElementById("password2");
                var btnobj=document.getElementById("btnclick");
                var username = document.getElementById("show_user_name").innerText;
                console.log(username);
                <%--var oldpsw='<%=session.getAttribute("password")%>';--%>
                oldpswobj.onblur=checkoldpsw;
                psw1obj.onblur=checkpsw;
                btnobj.onclick=checkrepsw;
                function checkoldpsw(){
//                    if ((oldpswobj.value)!=oldpsw){
//                        var msg="<font color='red' size='2px'>原密码错误!</font>";
//                    }
//                    else{
//                        var msg="";
//                    }
                    if(oldpswobj.value != ""){
//                        console.log(oldpswobj.value);
                        $.ajax({
                            type:'post',
                            url:"/mybatis/UserInfoController/get_psw.do",
                            data:{"username":username,"oldpassword":oldpswobj.value},
                            dataType:"json",
                            success:function(data){
                                if(data["flag"] == false){
                                    document.getElementById("spanusername").innerHTML = "<font color='red' size='2px'>原密码错误!</font>";
                                }else{
                                    document.getElementById("spanusername").innerHTML = "<font color='red' size='2px'>原密码正确!</font>";
                                }
                            }
                        })
                    }else{
                        document.getElementById("spanusername").innerHTML = "<font color='red' size='2px'>请输入密码!</font>";
                    }
                    var span=document.getElementById("spanusername");
//                    span.innerHTML=msg;
                    return;
                }
                function checkpsw(){

                    if (psw1obj.value.length<6) {
                        var msg="<font color='red' size='2px'>密码应大于六位数!</font>";
                    }
                    else{
                        var msg="";
                    }
                    var span=document.getElementById("spanpsw");
                    span.innerHTML=msg;
                    return;
                }
                function checkrepsw(){
                    if(psw1obj.value!=psw2obj.value ){
                        var msg="<font color='red' size='2px'>两次密码不一致!</font>";
                        return;
                    }else if(oldpswobj.value == ""){
                        document.getElementById("spanusername").innerHTML = "<font color='red' size='2px'>原密码不能为空!</font>";
                        return;
                    }else if(psw1obj.value.length < 6){
                        document.getElementById("spanpsw").innerHTML = "<font color='red' size='2px'>密码应大于六位数!</font>";
                    }
                    else{
                        var msg="";
                        $.ajax(
                                {
                                    type:'post',
                                    url:"/mybatis/UserInfoController/alterpsw.do",
                                    data:{"username":username,"oldpassword":oldpswobj.value,"newpassword":psw1obj.value},
                                    dataType:"json",
                                    success:function(data){
                                        var result = data["flag"];
                                        if(result){
                                            alert("修改密码成功！");
                                        }else{
                                            alert("修改密码失败");
                                        }
                                    }
                                }
                        )
                    }
                    var span=document.getElementById("spanrepsw");
                    span.innerHTML=msg;
                    return;
                }
            }
        </script>

</head>
<body>

<div style="margin:10px 20px;">
	<button type="button" class="btn btn-md btn-default" style="border:0px;float:right;" data-toggle="tooltip" data-placement="bottom" title="退出登录">
 		<span class="glyphicon glyphicon-off"></span>&nbsp;退出
	</button>
	<button type="button" class="btn btn-md btn-default" style="border:0px;float:right;" data-toggle="tooltip" data-placement="bottom" title="个人中心">
 		<span class="glyphicon glyphicon-user"></span>&nbsp;首页
	</button>
</div>
<div class="container">
			<div class="row" style="text-align:center;margin:40px auto;">
				<img src="/mybatis/knowledgebase/img/img_3.jpg" width="725px" height="80px">
			</div>
			<div class="row" style="margin:0px">
				<div class="col-md-3" style="width:283px;margin-right:16px;"> 
				<img src="/mybatis/knowledgebase/img/zhishiku_2.png" style="margin-left:30px;">
				</div>
				<div class="col-md-9" style="margin-top:16px;">
				<div  style="float:left;margin-right:0px;">
		  			<select  class="form-control"  onchange="value">
					<option value='' selected>类别&nbsp;&nbsp;&nbsp;</option>
					<option value=''>专利</option>
					<option value=''>论文</option>
					<option value=''>报告</option>
					</select>
				</div> 
				<div  style="float:left;margin-right:0px;">
		  			<select  class="form-control" onchange="value">
					<option value='' selected>全文</option>
					<option value=''>标题</option>
					<option value=''>作者</option>
					<option value=''>关键字</option>
					</select>
				</div> 
				<div class="input-group input-group-md" style="float:left;">
				<input type="text" class="form-control"  aria-describedby="sizing-addon1" style="width:521px;">
				<button class="btn btn-primary" style="width:78px;margin-left:5px;">搜&nbsp;索</button>
				</div>
				</div>
			</div>
			<hr>
			<div class="row" style="margin-left:80px;">
				<div class="col-md-2" style=" border-radius:10px;width:170px;font-size:16px;border-right:1px solid #eee">
					<ul class="nav nav-pills nav-stacked" >
				     <li class="active"><a href="/mybatis/knowledgebase/adm-personal.jsp">个人中心</a></li>
		
		 			</ul>
		 			<ul class="nav nav-pills nav-stacked">
				     <li class="active" readonly="true"><a href="##">用户管理</a></li>
				 	<li><a href="/mybatis/knowledgebase/adm-inquire.jsp">用户查询</a></li>
				 	<li><a href="/mybatis/knowledgebase/adm-check.jsp">用户审核</a></li>
		 			</ul>
		 			<ul class="nav nav-pills nav-stacked">
				     <li class="active"><a href="##">资源管理</a></li>
				     <li><a href="/mybatis/knowledgebase/adm-private.jsp">私有文件</a></li>
				     <li><a href="/mybatis/knowledgebase/adm-public.jsp">公有文件</a></li>
				 	<li><a href="/mybatis/knowledgebase/adm-download.jsp">我的下载</a></li>
				 	<li><a href="/mybatis/knowledgebase/adm-upload.jsp">文件上传</a></li>
				 	<li><a href="##">类别管理</a></li>
				 	<li><a href="##">资源审核</a></li>
		 			</ul>
		 			<ul class="nav nav-pills nav-stacked">
				     <li class="active"><a href="##">系统管理</a></li>
				 	<li><a href="##">数据还原</a></li>
				 	<li><a href="##">数据备份</a></li>
		 			</ul>
 				</div>
			 	<div class="col-md-8" style="margin-left:50px;">
			 		
			 		<div class="panel panel-primary" style="height:625px;">
						<div class="panel-heading" >
							<h3 class="panel-title">个人信息</h3>
						</div>
						<div class="panel-body">
							
						
							<div style="float:left;margin-top:50px;margin-left:100px;">
				 			<img src="/mybatis/knowledgebase/img/1.png" >
							</div>
				 			<div  style="font-size:15px;float:right;margin-top:120px;margin-right:150px;">
				 			<p >用户名：<span id="show_user_name">xxxx</span></p>
				 			<p >用户角色：<span id="show_user_role">xxxx</span></p>
				 			<p >注册时间：<span id="show_register_time">xxxx</span></p>
				 			</div>
				 			<div align="center" style="margin-top:400px;">
			 					<button class="btn btn-info" data-toggle="modal" data-target="#changepsw" >修改密码</button>
			 				</div>
						</div>	
				</div>
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
                        <li><input type="password"  id="password1" class="form-control" placeholder="请输入新密码"></li>
                        <div id="spanpsw" style="margin-left:6px;margin-bottom:10px;height:6px;"></div>
                        <li><input type="password"  id="password2" class="form-control"  placeholder="请再次输入新密码"></li>
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
</div>






<style type="text/css">
	.modal{
        margin-top: 20%;
    }
	.modal-body li{
		list-style-type:none;
		padding:0px 5px;
		border: 1px solid #ffffff;
		padding: 5px 0px;
	}
	#username1,#password1{
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
