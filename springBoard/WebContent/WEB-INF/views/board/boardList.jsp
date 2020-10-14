<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		$j('#checkAll').click(function(){
			if($j('#checkAll').prop("checked")){
				$j('input[name="check"]').prop("checked", true);
			}else{
				$j('input[name="check"]').prop("checked", false);
			}
		});
		
		$j('.check').click(function(){
			$j('.check').each(function(i, e){
				if($j(this).prop("checked")){
					if(i==$j('.check').length-1){
						$j('input[name="checkAll"]').prop("checked", true);
					}
				}else{
					if($j('#checkAll').prop("checked")){
						$j('input[name="checkAll"]').prop("checked", false);
					}
					return false;
				}
			});
		});
		
		$j('#checkcheck').click(function(){
			var checkValues = [];
			$j('input[name="check"]:checked').each(function(i) {
				checkValues.push($j(this).val());
			});
			if(checkValues==""){
				return false;
			}
			var param = {"check":checkValues};
			$j.ajax({
				url:"/board/boardCheck.do",
				type:"POST",
				timeout:1000,
				data:param,
				dataType: "json",
				traditional: true,
				success: function(data, textStatus, jqXHR){
					window.location.href = "/board/boardCheck.do?check=" + data.result;
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("error");
				}
			});
		});
	});
</script>
<body>

<table  align="center">
	<tr>
		<td align="left">
			<c:if test="${empty login}">
				<a href="${pageContext.request.contextPath}/user/userLogin.do">login</a>
			
				<a href="${pageContext.request.contextPath}/user/userJoin.do">join</a>
			</c:if>
			<c:if test="${!empty login}">
				${login.userName}
			</c:if>
		</td>
		
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
						<c:forEach items="${codeMenuList}" var="menu">
								<c:set var="id" value="${menu.codeId}"></c:set>
								<c:set var="boardType" value="${list.boardType}"></c:set>
								<c:if test="${id eq boardType}">
									${menu.codeName}
								</c:if>
							</c:forEach>
							
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<c:if test="${empty login}">
				<a href onclick="alert('login을 하셔야 글을 쓰실 수 있습니다.');return false;">글쓰기</a>
			</c:if>
			<c:if test="${!empty login}">
				<a href ="/board/boardWrite.do">글쓰기</a>
				<a href = "/user/userLogout.do">로그아웃</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" id="checkAll" name="checkAll" class="checkAll">전체
			<c:forEach items="${codeMenuList}" var="menu">
				<input type="checkbox" name="check" class="check" value="${menu.codeId}">${menu.codeName}
			</c:forEach>
			<button id="checkcheck">조회</button>
		</td>
	</tr>
	
	<tr>
		<td align="center">
		<c:forEach items="${pageNo}" var="p" varStatus="status">
			<c:set var="URL" value="${requestScope['javax.servlet.forward.servlet_path']}"/>
			<c:set var="total" value="${totalCnt}"></c:set>
			<c:if test="${fn:contains(URL, 'Check')}">
				<c:if test="${status.first && status.current ne 1}">
					<a href="${URL}?check=${param.check}&pageNo=${p-1}">
					<c:out value="<"></c:out>
					</a>
				</c:if>
				<a href="${URL}?check=${param.check}&pageNo=${p}">
				<c:out value="${p}"></c:out>
				</a>
				<c:if test="${status.last && status.current * 10 < total}">
					<a href="${URL}?check=${param.check}&pageNo=${p+1}">
					<c:out value=">"></c:out>
					</a>
				</c:if>
			</c:if>
			<c:if test="${fn:contains(URL, 'List')}">
				<c:if test="${status.first && status.current ne 1}">
					<a href="${URL}?pageNo=${p-1}">
					<c:out value="<"></c:out>
					</a>
				</c:if>
				<a href="${URL}?pageNo=${p}">
				<c:out value="${p}"></c:out>
				</a>
				<c:if test="${status.last && status.current * 10 < total}">
					<a href="${URL}?pageNo=${p+1}">
					<c:out value=">"></c:out>
					</a>
				</c:if>
			</c:if>
		</c:forEach>
		</td>
	</tr>
	
</table>

</body>
</html>