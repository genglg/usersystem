<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/common.jsp"></jsp:include>
<style>
.status_style {
	color: #D3D6DA;
}

.status_style strong {
	color: #001930;
}

.at {
	font-weight: bold;
	color: #000000;
}
</style>
</head>

<body class="navbar-top">
	<div class="modal-shiftfix">
		<div class="container-fluid main-content">
			<div class="widget-container fluid-height clearfix">
				<div class="heading clearfix">
					<i class="icon-table"></i> 工作日志 <a id="add-row"
						class="btn btn-sm btn-primary-outline pull-right"
						href="DailyRecordServlet?method=getWh"><i class="icon-plus"></i>
						新增日志</a>
				</div>
				<div class="widget-content padded clearfix">
					<div class="dataTables_filter">
						<div class="row">
							<div class="col-lg-12">
								<form class="form-inline" action="/dailylog/index.html"
									method="get">
									<input type="hidden" name="search_status"> <input
										type="hidden" name="daily_type">
								</form>
							</div>
						</div>
					</div>
					<form id="actionForm" action="/dailylog/index.html" method="post">
						<input type="hidden" name="_csrf"
							value="WmJieldtLnA4FTQRbhRtCAsMUioaVUE7BQgTHzs9RygtNiwyJStURw==">

						<div id="w0" class="grid-view">
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th nowrap>主题</th>
											<th nowrap>负责人</th>
											<th nowrap>创建时间</th>
											<th nowrap>更新时间</th>
										</tr>
									</thead>
									<c:forEach items="${dailrecodilist.list}" var="dailrecodilist">
										<tbody>
											<tr data-key="2">
												<td><a
													href="DailyRecordServlet?method=selectDailRecod&id=${dailrecodilist.recordId }&userId=${sessionScope.currentUser.employeeId}">${dailrecodilist.title
														}</a>
												</td>
												<td>${dailrecodilist.employeeName }</td>
												<td><fmt:formatDate
														value="${dailrecodilist.createTime }"
														pattern="yyyy-MM-dd HH:mm" />
												</td>
												<td><fmt:formatDate
														value="${dailrecodilist.updateTime}"
														pattern="yyyy-MM-dd HH:mm" />
												</td>
											</tr>
										</tbody>
									</c:forEach>
								</table>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
