<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="../knowledgebase/css/bootstrap.min.css">
<script src="../knowledgebase/js/jquery.min.js"></script>
<script src="../knowledgebase/js/jquery.cookie.min.js"></script>
<script src="../knowledgebase/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.login{
		width: 100%;
		min-width: 1200px;
		background-color: white;
	}
	.login-top{
		height: 60px;
		margin-left: 50px;
		background-color: white;
	}
	.login-mid{
		background: url(../knowledgebase/img/img_4.jpg) center center no-repeat #fff;
		height: 480px;
		min-width: 1200px;
	}
	.biao1{
		width: 250px;
		height: auto;
		background-image:url(../knowledgebase/img/white.png);
		border-radius: 5px;
		padding: 22px 30px;
		position: absolute;
		right: 150px;
		margin-top:100px;
	}
	.name1{
		font-size: 22px;
		line-height: 33px;
		color: #ffffff;
		padding-bottom: 22px;
		height: 35px;
		margin-bottom: 10px;
	}
    .footer {
	height: 60px;
	background-color: #e1e1e1;
	width: 100%;
	text-align: center;
	margin-top: 20px;
	line-height: 60px;
	min-width: 1190px;
}
.footer span.footerText {
	font-size: 14px;

	color: #606060;
	display: inline-block;
}
.loginform{
line-height: 18px;
margin-bottom: 10px;
	font-size: 14px;
}
.loginform.loginusername input[type="text"], .loginform.loginpassword input[type="password"] {
	width: 100%;
	border: none;
	
	border: 1px solid #ffffff;
	padding: 8px 0px 8px 5px;
	
}
body {
  height: 100%;
  min-width: 1000px;
}
</style>

<script type="text/javascript">
	window.onload=function(){
		var usernameobj=document.getElementById("username");
		var passwordobj=document.getElementById("password");
		passwordobj.onblur=checkpassword;
		usernameobj.onblur=checkusername;
		function checkusername(){
			if (usernameobj.value.length==0) {
				var msg="<font color='red' size='2px'>用户名不能为空!</font>";
			}
			else{
				var msg="";
			}
			var span=document.getElementById("spanusername");
			span.innerHTML=msg;
			return;
		}
		function checkpassword(){
		if (passwordobj.value.length==0) {
 			var msg="<font color='red' size='2px'>密码不能为空!</font>";
 		}
 		else if (passwordobj.value.length<6&&passwordobj.value.length>0) {
 			var msg="<font color='red' size='2px'>密码应大于六位数！</font>";
 		}
 		else{
 			var msg="";
 		}
 		var span=document.getElementById("spanpassword");
 		span.innerHTML=msg;
 		return ;
	}
		
}
</script>
</head>
<body>
	<div class="login">
		<div class="login-top">
		<img src="img/zhishiku_2.png">
		</div>
		<div class="login-mid">
	
			<div class="biao1" >
			<form action="/mybatis/UserInfoController/login.do" method="post">
				 <div class="name1">用户平台登录</div>
				 <div class="loginform loginusername" style="margin-top:5px;margin-bottom:5px;">
				 	<input type="text" id="username" name="username" placeholder="请输入用户名">
				 </div>
				 <div id="spanusername" style="height:16px"></div>
				 <div class="loginform loginpassword" style="margin-top:5px;margin-bottom:5px;">
				 	<input type="password" name="password"  id="password" placeholder="请输入密码">
				 </div>
				 <div id="spanpassword" style="height:16px"></div>
				 
				<div class="button-group" style="margin-top:5px;margin-bottom:5px;">
				<input type="submit" class="btn btn-primary" id="denglu" value="登录">
				<input type="button" class="btn btn-primary" value="注册" style="float:right;" onclick="window.open('../knowledgebase/Register.jsp','_self')">
				</div>
				</form>
     		</div>
		</div>
	</div>
	<div class="footer"> <span class="footerText">Copyright © 1956-2016 电子科技大学</span> </div>

</body>
</html>