<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<link href="${pageContext.request.contextPath }/css/bootstrap.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/google-fonts.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/font-awesome.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/isotope.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/style.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/csstable/dataTables.bootstrap-1.10.13.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jstable/jquery-3.0.0.js"></script>
<script src="${pageContext.request.contextPath }/js/jquery-ui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jstable/bootstrap-3.3.4.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jstable/jquery.dataTables-1.10.13.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jstable/dataTables.bootstrap-1.10.13.js"></script>
</head>

<body class="navbar-top">
	<div class="modal-shiftfix">
		<div class="container-fluid main-content">
			<div class="widget-container fluid-height clearfix mwi1200">
				<div class="heading clearfix">
					<i class="icon-reorder"></i> 更新用户信息 <a href="javascript:;"
						class="pull-right" onclick="history.go(-1);"><i
						class="icon-reply"></i> </a>
				</div>
				<div class="widget-content padded clearfix">
					<form id="w0" class="form-horizontal"
						action="view/customerManage/customer/index.jsp" method="get">
						<input type="text" id="userInfoId" class="form-control" value="${userInfo.id}">
						<div class="form-group field-customer-customer_name required">
							<label class="control-label col-sm-2" for="customer-owner_name">姓名</label>
							<div class="col-sm-8">
								<input type="text" id="customerId" class="form-control">
							</div>
							
						</div>
						<div class="form-group field-customer-customer_name required">
							<label class="control-label col-sm-2" for="customer-owner_name">性别</label>
							<div class="col-sm-8">
								<input type="text" id="customerId" class="form-control">
							</div>
							
						</div>
						<div class="form-group field-customer-customer_name required">
							<label class="control-label col-sm-2" for="customer-owner_name">年龄</label>
							<div class="col-sm-8">
								<input type="text" id="customerId" class="form-control">
							</div>
							
						</div>
						<div class="form-group field-customer-customer_name required">
							<label class="control-label col-sm-2" for="customer-owner_name">账户</label>
							<div class="col-sm-8">
								<input type="text" id="customerId" class="form-control">
							</div>
							
						</div>
						<div class="form-group field-customer-customer_name required">
							<label class="control-label col-sm-2"
								for="customer-customer_name">密码</label>

							<div class="col-sm-8">
								<input type="text" id="CUSTOMERNAME" class="form-control">
							</div>
							
						</div>
						<div class="form-group field-customer-customer_name required">
							<label class="control-label col-sm-2" for="customer-owner_name">住址</label>
							<div class="col-sm-8">
								<input type="text" id="customerId" class="form-control">
							</div>
							
						</div>
						<div class="form-group field-customer-customer_zipcode required">
							<label class="control-label col-sm-2"
								for="customer-customer_zipcode">学校</label>

							<div class="col-sm-8">
								<input type="text" id="POST_CODE" class="form-control">
							</div>
							<div class="help-block help-block-error"></div>
						</div>
						
						<div class="form-group field-customer-customer_tag required">
							<label class="control-label col-sm-2" for="customer-customer_tag">班级</label>

							<div class="col-sm-8">
								<input type="text" id="TAG" class="form-control">
							</div>
							<div class="help-block help-block-error"></div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label"></label>

							<div class="col-lg-10">
								<button type="button" class="btn btn-primary"
									onclick="updateCustomer()">修改</button>
								<button type="button" class="btn btn-default"
									onClick="history.go(-1);">返回</button>
								<input type="hidden" name="reback">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 	联系人模态框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<input type="hidden" id="referencepositionId" name="referencepositionId">
					<h4 class="modal-title" id="myModalLabel">选择关联菜单</h4>
				</div>
				<div class="modal-body">
					<table class="table" id="example">
<!-- 							<caption>响应式表格布局</caption> -->
							<thead>
								<tr>
									<th>选择</th>
									<th>姓名</th>
									<th>职位</th>
									<th>手机号码</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listLinkMan}" var="listLinkManss"
									varStatus="status">
									<tr>
										<td>
											<input type="radio"  name ="radioName" style=" opacity: 1;margin-top: -6px " id="${listLinkManss.linkMainId }"/>
											
										</td>
										<td id="${listLinkManss.linkMainId }_lg">${listLinkManss.name }
										</td>
										<td>${listLinkManss.position }</td>
										<td>${listLinkManss.phonenum }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
				</div>
			<div class="modal-footer">
					<button type="button" id="checkPass" class="btn btn-primary"
						onclick="postCheckInfo()()">确认</button>
					<button type="button" id="checkRefuse" class="btn btn-primary"
						onclick="postCheckDocInfo()">取消</button>
				</div>
			</div>
			
		</div>
	</div>

</body>
<script type="text/javascript">
	$(function(){
		alert($("#userInfoId").val());
		var id = $("#userInfoId").val();
		$.ajax({
			type : 'post',
			url : '<%=request.getContextPath()%>/user/userInfo',
			data : {"id":id},
			success : function(data) {
				debugger
				alert(112);
				
			},
			error : function() {
				alert("请求失败!");
			}
		});
	});
</script>


</html>
