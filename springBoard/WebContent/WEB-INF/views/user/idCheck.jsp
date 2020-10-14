<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR" --%>
<%--     pageEncoding="EUC-KR"%> --%>
<%-- <%@include file="/WEB-INF/views/common/common.jsp"%> --%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"> -->
<!-- <title>Id Overlap Check Form</title> -->
<!-- </head> -->
<!-- <script type="text/javascript"> -->
// 	$j(document).ready(function(){
// 		$j("input[name=id]").keyup(function(event){
// 			console.log(event.keyCode);
// 			if(!(event.keyCode > 37 && event.keyCode <= 40)){
// 				var inputVal = $j(this).val();
// 				$j(this).val(inputVal.replace(/[^a-z0-9]/gi,""));
// 			}
// 		});
// 	});
	
// 	$j(document).ready(function(){
// 		$j('#idOverlapCheck').click(function(){
// 			var id = $j('#id').val()
// 			id = id.trim();
			
// 			if(id.length<1 || id==null){
// 				alert("중복확인할 ID를 입력해주세요.");
// 				return false;
// 			}
// 			if(id.length<3 || id.length>15){
// 				alert("ID길이는 3자이상 15자이하입니다.");
// 				return false;
// 			}
// 			var param = {'id' : id};
// 			$j.ajax({
// 				url : "/user/userIdOverlapCheck.do",
// 				type : "POST",
// 				data  :param,
// 				timeout : 2000,
// 				traditional : true,
// 				success : function(data, textStatus){
// 					if(data.result==0){
// 						window.location.href="/user/userIdCheckProc.do?id="+id+"&cnt="+data.result;
// 					}else{
// 						alert("해당 ID는 사용할 수 없습니다.")
// 						window.location.href="/user/userIdOverlapCheck.do";
// 					}
// 				},
// 				error : function(){
// 					alert('error');
// 				}
// 			});
// 		});	
// 	});
<!-- </script> -->
<!-- <body> -->
<!-- 	<div style="text-align: center"> -->
<!-- 		<h3>* 아이디 중복확인 *</h3> -->
<!-- 		<form method="post" action="/user/userIdOverlapCheck.do	" onsubmit="return blankCheck(this)">  -->
<!-- 			아이디 :  -->
<!-- 			<input type="text" id="id" name="id" maxlength="15" placeholder="영문, 숫자만 입력가능" autofocus>  -->
<!-- 			<input id="idOverlapCheck" type="submit" value="중복확인">  -->
<!-- 		</form>  -->
<!-- 	</div> -->

<!-- </body> -->
<!-- </html> -->