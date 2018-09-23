<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/common.jsp"></jsp:include>
</head>

<body class="navbar-top">
	<div class="modal-shiftfix">
		<div class="container-fluid main-content">
			<div class="widget-container fluid-height clearfix mwi1200">
				<div class="heading clearfix">
					基本信息 <i class="icon-reply pull-right" onclick="history.go(-1);"></i>
				</div>
				<div class="widget-content padded">
					<div class="table-responsive">
						<table class="table table-hover">
							<tbody>
								<tr>
									<th>负责人：</th>
									<td><a class="weiBoxs-dialog"
										href="manage/ajax-info.html?manage_id=2" dialog-title="管理员信息"
										dialog-button="false">${customer.name}</a>
									</td>
									<th>创建时间：</th>
									<td><fmt:formatDate value="${customer.createTime}"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
								</tr>
								<tr>
									<th>修改时间：</th>
									<td><fmt:formatDate value="${customer.updateTime}"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th style="width: 15%" nowrap>客户名称：</th>
									<td>${customer.customerName}</td>
									<th style="width: 15%" nowrap>邮编：</th>
									<td>${customer.postCode}</td>
								</tr>
								<tr>
									<th style="width: 15%" nowrap>所属行业：</th>

									<td>${customer.fieldName}<input type="hidden" id="fieldId"
										value="${customer.sourceId }" />
									</td>
									<th style="width: 15%" nowrap>客户来源：</th>
									<td>${customer.sourceName}</td>
								</tr>
								<tr>
									<th style="width: 15%" nowrap>年营业额：</th>
									<c:if test="${customer.busubessVolume=='2001'}">
										<td>1000万以上</td>
									</c:if>
									<c:if test="${customer.busubessVolume=='2002'}">
										<td>500万以上</td>
									</c:if>
									<c:if test="${customer.busubessVolume=='2003'}">
										<td>100万以上</td>
									</c:if>
									<c:if test="${customer.busubessVolume=='2004'}">
										<td>10万以上</td>
									</c:if>
									<c:if test="${customer.busubessVolume=='2005'}">
										<td>10万以下</td>
									</c:if>
									<th style="width: 15%" nowrap>员工数：</th>
									<td>${customer.employeeNumbers}</td>
								</tr>
								<tr>
									<th style="width: 15%" nowrap>标签：</th>
									<td colspan="3">${customer.tag}</td>
								</tr>
								<tr>
									<th style="width: 15%" nowrap>备注：</th>
									<td colspan="3">${customer.remarks}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
