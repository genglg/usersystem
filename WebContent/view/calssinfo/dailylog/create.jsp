<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                写日志 <i class="icon-reply pull-right" onclick="history.go(-1);"></i>
            </div>
            <div class="widget-content padded">
                <form id="w0" class="form-horizontal" action="" method="post">
<!--                     <input type="hidden" name="_csrf" value="TUtKTFZURC0vPBwnby0HVRwlehwbbCtmEiE7KToELXU6HwQEJBI.Gg=="> -->

                    <div class="form-group field-dailylog-daily_type required">
                        <label class="control-label col-sm-2" for="dailylog-daily_type">日志类型</label>

                        <div class="col-sm-8">
                            <input type="hidden" name="Dailylog[daily_type]" value="">

                            <div id="dailylog-daily_type">
                                <label class="label-radio inline">
                                    <input type="radio" name="Dailylog[daily_type]" value="日报" checked> <span
                                        class="custom-radio"></span>日报 </label>
                                <label class="label-radio inline">
                                    <input type="radio" name="Dailylog[daily_type]" value="周报"> <span
                                        class="custom-radio"></span>周报 </label>
                                <label class="label-radio inline">
                                    <input type="radio" name="Dailylog[daily_type]" value="月报"> <span
                                        class="custom-radio"></span>月报 </label>
                            </div>
                        </div>
                        <div class="help-block help-block-error"></div>
                    </div>
                    <div class="form-group field-dailylog-subject required">
                        <label class="control-label col-sm-2" for="dailylog-subject">主题</label>

                        <div class="col-sm-8">
                            <input type="text" id="dailylog-subject" class="form-control" name="Dailylog[subject]"
                                    maxlength="50" placeholder="主题">
                        </div>
                        <div class="help-block help-block-error"></div>
                    </div>
                    <div class="form-group field-dailylog-content required">
                        <label class="control-label col-sm-2" for="dailylog-content">内容</label>
						
                        <div class="col-sm-8">
                        <textarea id="dailylogText" class="form-control" >
                        
                        
                        </textarea>
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"></label>

                        <div class="col-lg-10">
                        	<input type="hidden" id="userId" value="${sessionScope.currentUser.employeeId }"/>
                        	<input type="hidden" id="" value=""/>
                            <button type="button" class="btn btn-success" onclick="addDail()">创建</button>
                            <button type="button" class="btn btn-default" onClick="history.go(-1);">返回</button>
                            <input type="hidden" name="reback"></div>
                        <!-- /.col -->
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
	function addDail(){
		var data={};
		var list=document.getElementsByName("Dailylog[daily_type]");
		for ( var i = 0; i < list.length; i++) {
			if (list[i].checked==true) {
				var dailylogLx=list[i].value;
			}
		}
		data.dailylogLx=dailylogLx;
		data.djr=$("#userId").val();
		data.dailylogZt=$("#dailylog-subject").val();
		data.dailylogText=$("#dailylogText").val();
		data.linkUrl="web_project2/DailyRecordServlet?method=selectDailRecod";
		$.ajax({
			type: 'post',
           url: 'DailyRecordServlet?method=addDailyRecord',
           data: data,
           cache: false,
           sync: true,
           contentType:'application/x-www-form-urlencoded; charset=UTF-8',
           success: function (msg) {
             	var json=JSON.parse(msg);
             	if(0== json.flag){
             		alert(json.msg);
             		return;
             	}else{
             		window.location.href='DailyRecordServlet?method=getAllDailyRecord';
             	}
             	
           },error :function (){
           		alert("请求失败");
           		return false;
           }
		});
	}
</script>
</html>
