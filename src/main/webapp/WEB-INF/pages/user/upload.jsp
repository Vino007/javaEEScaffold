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
					
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" id="uploadSubmitBtn">提交</button>
			</div>
			</form>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
<script>
 	$('#modal').on('shown.bs.modal', function(event) { 
				 $("#uploadForm").submit(function(event){
					 var file=$("#file").val();
					 var fileType=file.substring(file.lastIndexOf(".")+1); 
					
					 if(file==""){
						 alert("请选择要上传的文件");
						return false;
					 }else if(fileType!="xls"){
						 alert("文件类型错误,请上传xls文件");
						 return false;
					 }
				 $(this).ajaxSubmit({
					success:function(data){
						switch(data){
						case "\"uploadSuccess\"":
							alert("上传成功");break;
						case "\"fileEmpty\"":
							alert("文件为空");break;
						case "\"entityDuplicate\"":
							alert("文件中有与数据库中重复的对象");break;
						case "\"saveFileError\"":
							alert("保存文件出错");break;		
						case "\"fileStreamError\"":
							alert("读取文件出错");break;	
						}
						
					},
					error:function(){
						alert("失败");
					}
				 });
				 return false;
			 }); 						
 		}); 
	
</script>