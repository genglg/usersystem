<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/common.jsp"></jsp:include>
<title>用户登陆</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/login.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/common/layui/layui.js" />
<style>
</style>
</head>
<body>
	<div class="form_login">
		<div class="form_logo">
			<h1>心缘同学录系统</h1>
		</div>
		<form method="post" id="formlogin"
			action="LoginServlet?method=loginToCms">
			<div class="form-group">
				<i class="fa fa-user"></i> <input type="text" class="form-control"
					name="userName" id="userName" placeholder="输入工号">
			</div>
			<div class="form-group">
				<i class="fa fa-key"></i> <input type="password"
					class="form-control" name="password" id="password"
					placeholder="输入密码">
			</div>
			
			<div class="form-group">
				<button type="button" id="loginsubmit"
					class="btn btn-primary btn-block btn-login" onclick="mylogin()">登录</button>
			</div>
		</form>
		<div class="form_footer">
			<h4></h4>
		</div>
	</div>
</body>
<script type="text/javascript">
	 function mylogin() {
		var userName = $("#userName").val();
		var password = $("#password").val();
		if ("" == userName || undefined == userName) {
			alert("工号不能为空");
			return;
		}
		if ("" == password || undefined == password) {
			alert("密码不能为空");
			return;
		}
		var user={};
		user.username = userName;
		user.password = password;
		$.ajax({
			type : 'post',
			url : '<%=request.getContextPath()%>/user/login',
			data : user,
			success : function(data) {
				if(data==0){
					window.location.href = "<%=request.getContextPath()%>/index2.jsp";
				}else{
					alert("账号或密码错误!");
				}
				
			},
			error : function() {
				alert("请求失败!");
			}
		});
	} 
</script>
</html>
