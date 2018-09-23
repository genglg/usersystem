<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="cn">
<jsp:include page="/common.jsp"></jsp:include>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>学生录首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/common/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/common/style.css" />
  
</head>
<script type="text/javascript">
 /* var token = localStorage.token;
if(token == null || token == ''){
	window.location.href="login/login.html"
} */
</script>
<body>
    <div class="layui-header header header-demo">
        <div class="layui-main">
            <a>
                <h1>心缘学生录</h1>
            </a>
        </div>
        <div class="layui-admin">
            <span id="user_name">*****登录</span>
            <button class="layui-btn">退出</button>
        </div>
    </div>
    <ul class="layui-nav layui-nav-tree layui-nav-side" lay-filter="test">
        <li class="layui-nav-item">
            <a href="javascript:;">用户管理</a>
            <dl class="layui-nav-child">
                <dd name="UserManagement/UserManagement/UserManagement.html">
                    <a href="javascript:;">用户管理</a>
                </dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">信息查询</a>
            <dl class="layui-nav-child">
                <dd name="VehicleManagement/VehicleManagement/VehicleManagement.html">
                    <a href="javascript:;">信息查询</a>
                </dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">班级管理</a>
            <dl class="layui-nav-child">
                <dd name="OrderManagement/OrderManagement/OrderManagement.html">
                    <a href="javascript:;">班级管理</a>
                </dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">照片管理</a>
            <dl class="layui-nav-child">
                <dd name="AccountManagement/AccountManagement/AccountManagement.html">
                    <a href="javascript:;">照片管理</a>
                </dd>
              
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">留言信息</a>
            <dl class="layui-nav-child">
                <dd name="NewsManagement/evaluateManagement/evaluateManagement.html" id="notice_active">
                    <a href="javascript:;">留言信息</a>
                </dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">管理员</a>
            <dl class="layui-nav-child">
                <dd name="CustomerShareActive/CustomerRecommend.html" id="notice_active">
                    <a href="javascript:;">管理员</a>
                </dd>
            </dl>
        </li>
    </ul>
    <div id="myContent" class="layui-body layui-tab-content site-demo site-demo-body"> </div>

</body>

</html>