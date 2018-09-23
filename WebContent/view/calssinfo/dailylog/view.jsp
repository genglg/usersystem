<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="/common.jsp"></jsp:include>
</head>

<body class="navbar-top">
<div class="modal-shiftfix">
    <div class="container-fluid main-content">
        <div class="row">
            <div class="col-md-7 col-sm-7">
                <div class="widget-container fluid-height clearfix">
                    <div class="heading clearfix">
                        <i class="icon-reorder"></i> 任务详情
                        <a href="javascript:;" class="pull-right" onclick="history.go(-1);"><i
                                class="icon-reply"></i></a>
                    </div>
                    <div class="widget-content padded clearfix">
                        <div class="search-header">
                            <a class="h4 inline-block"><fmt:formatDate value="${dailyrecord.createTime }" pattern="yyyy-MM-dd" />工作日志 </a>

                            <div class="text-muted"><a class="weiBoxs-dialog" href="manage/ajax-info.html?manage_id=1"
                                dialog-title="管理员信息" dialog-button="false">${sessionScope.currentUser.employeeName }</a> : <fmt:formatDate value="${dailyrecord.createTime }" pattern="yyyy-MM-dd HH:mm" /> 评论(${num })
                            </div>
                        </div>
                        <p class="m-top-sm">

                        <p>${dailyrecord.content }</p>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-5 col-sm-5">
                <div class="widget-container fluid-height clearfix list rating-widget">
                    <div class="heading clearfix">日志评论</div>
                    <div class="widget-content padded clearfix">
                        <form method="post" id="comment_form">
                            <p class="m-top-sm">
                                <textarea rows="2" class="form-control" name="content" id="contentId"
                                          placeholder="评论内容"></textarea>
                                <input type="hidden" id="subject_id" value="${dailyrecord.recordId  }">
                                <input type="hidden" id="owner_id" value="${sessionScope.currentUser.employeeId }">
                                 <input type="hidden" id="userId" value="${userId}">
                                <input type="hidden" name="comment_type" value="10"></p>
                            <a class="btn btn-sm btn-primary margin-top-10" onclick="return sendForm();">提交</a>
                        </form>
                    </div>
                    <div id="tasks-list" data-pjax-container="" data-pjax-push-state data-pjax-timeout="1000">
                        <ul>
                        <c:forEach items="${listComment.list}" var ="listCommentss">
                            <li>
                                <div class="reviewer-info">
                                    <div class="star-rating pull-right">
                                        <a class="btn-delete-communicate"  id="${listCommentss.commentId}_gl"
                                           onclick="return deleteComment(this.id);"><i class="fa fa-trash-o"></i> 删除</a>
                                           <input type="hidden" id="${listCommentss.commentId}_glry" value="${listCommentss.commentEmployee }"/>
                                    </div>
                                    <img width="30" height="30" src="${pageContext.request.contextPath }/picture/1_avatar_middle.jpg">${listCommentss.employeeName }<em>${listCommentss.createTime }</em>
                                </div>
                                <div class="review-text">
                                    <p>${listCommentss.detail }</p>
                                </div>
                            </li>
                            </c:forEach>
                        </ul>
                         <page:htmlPage url="CommentServlet?method=getAllComment" pageInfo="${listComment}"></page:htmlPage>
                        <div class="text-right" style="margin: 10px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
	function sendForm(){
		var data={};
		var recordId=$("#subject_id").val();
		var  userId=$("#owner_id").val();
		data.recordId=$("#subject_id").val();
		data.userId=$("#owner_id").val();
		data.content=$("#contentId").val();
		$.ajax({
			type: 'post',
           url: 'CommentServlet?method=addComment',
           data: data,
           cache: false,
           sync: true,
           success: function (msg) {
             	var json=JSON.parse(msg);
             	if(0== json.flag){
             		alert(json.msg);
             		return;
             	}else{
             		window.location.href='DailyRecordServlet?method=selectDailRecod&id='+recordId+"&userId="+userId;
             	}
             	
           },error :function (){
           		alert("请求失败");
           		return false;
           }
		});
	}
	
	function deleteComment(id){
		var idU=id.split("_gl")[0];
		var userId=$("#owner_id").val();
		var glryId=$("#"+idU+"_glry").val();
		
		if (glryId==userId) {
			var data = {};
       		data.id = idU;
		
			$.ajax({
	   		   type: 'post',
	           url: 'CommentServlet?method=deleteComment',
	           data: data,
	           cache: false,
	           sync: true,
	           success: function (msg) {
	             	var json=JSON.parse(msg);
	             	//alert(json.status);
	             	if(0== json.flag){
	             		alert(json.msg);
	             		return;
             		}else{
	             		window.location.href='DailyRecordServlet?method=selectDailRecod&id='+idU+"&userId="+userId;
	             	}
	             	
	           },error :function (){
	           		alert("请求失败");
	           }
	   		});
		}else{
			alert("不是本人发表的评论，不能删除");
		}
	
	}
</script>
</html>
