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
		$j("#boardDelete").click(function(){
			if(confirm("정말 삭제하시겠습니까?")==true){
				var $frm = $j(".boardView :input");
				var param = $frm.serialize();
				$j.ajax({
					url : "/board/boardDelete.do",
					data : param,
					dataType : "json",
					type : "POST",
					timeout : 1000,
					traditional : true,
					success : function(data, textStatus, jqHXR){
						alert("삭제완료");
						
						window.location.href = "/board/boardList.do?pageNo=1";
					},
					error : function(jqHXR, textStatus, errorThrown){
						alert("error");
					}
				});
			}else{
				return false;
			}
		});
	});

</script>
<body>
<form class="boardView">
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
						${board.boardTitle}
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td>
						${board.boardComment}
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${board.creator}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
				<c:if test="${!empty login}">
					<c:set var="writer" value="${board.creator}"></c:set>
					<c:set var="userName" value="${login.userName}"></c:set>
					<c:if test="${writer eq userName}">
						<a href = "/board/${board.boardType}/${board.boardNum}/boardUpdate.do">Update</a>
						<a href id="boardDelete">Delete</a>
					</c:if>
				</c:if>
			</td>
		</tr>
	</table>
</form>
</body>
</html>