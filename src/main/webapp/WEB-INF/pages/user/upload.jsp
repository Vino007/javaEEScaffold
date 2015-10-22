<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">新增用户</h4>
			</div>
			<form id="uploadForm" action="user/upload" method="post" enctype="multipart/form-data">
			<div class="modal-body">
					<div class="form-group">
						<label for="file" class="control-label"><font color="red">*</font>上传文件:</label>
						<input id="file" type="file" name="file" class="form-control">
					</div>
					<div class="form-group">
						<label for="fileName" class="control-label"><font color="red">*</font>文件名:</label> <input
							class="form-control" id="fileName" name="fileName">
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" id="uploadSubmitBtn">提交</button>
			</div>
			</form>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
<script>
 	$('#uploadModal').on('shown.bs.modal', function(event) { 
				 $("#uploadForm").submit(function(event){
					 var file=$("#file").val();
					  var fileType=file.substring(file.lastIndexOf(".")+1); 
					 alert(fileType);
					 if(file==""){
						 alert("请选择要上传的文件");
						return false;
					 }else if(fileType!="xls"&&fileType!="xlsx"){
						 alert("文件类型错误,请是上传xls或者xlsx文件");
						 return false;
					 }
				 $(this).ajaxSubmit({
					success:function(data){
						alert(data);
					},
					error:function(){
						alert("失败");
					}
				 });
				 return false;
			 }); 						
 		}); 
	
</script>