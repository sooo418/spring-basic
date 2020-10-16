<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		$j("#updateSubmit").click(function(){
			if($j('#boardTitle').val().trim()==""){
				alert("TITLE을 입력해주세요.");
				return false;
			}
			if($j('#boardComment').val().trim()==""){
				alert("COMMENT를 입력해주세요.");
				return false;
			}
			var $frm = $j(".boardUpdate :input");
			var param = $frm.serialize();
			$j.ajax({
				url : "/board/boardUpdateAction.do",
				data : param,
				dataType : "json",
				type : "POST",
				timeout : 1000,
				traditional : true,
				success : function(data, textStatus, jqHXR){
					alert("수정완료");
					
					window.location.href = "/board/boardList.do?pageNo=1";
				},
				error : function(jqHXR, textStatus, errorThrown){
					alert("error");
				}
			});
		});
		
	});
	
</script>
<body>
<form class="boardUpdate">
	<input name="boardType" value="${board.boardType}" style="display: none;">
	<input name="boardNum" value="${board.boardNum}" style="display: none;">
	<table align="center">
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input id="boardTitle" name="boardTitle" type="text" size="50" maxlength="25" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
							<textarea id="boardComment" name="boardComment"  rows="20" maxlength="500" cols="55">${board.boardComment}</textarea>
							</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${board.userVo.userName}
						<input name="creator" value="${board.creator}" style="display: none">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
				<a href id="updateSubmit">Update</a>
			</td>
		</tr>
	</table>	
</form>
</body>
</html>