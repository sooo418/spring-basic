<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		$j("input[name=userId]").keyup(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[^a-z0-9]/gi,""));
			}
		});
		
		$j('.loginForm').validate({
			
			rules : {
				userId : {required:true},
				userPw : {required:true}
			},
			messages : {
				userId : {required:"ID를 입력해주세요."},
				userPw : {required:"PW를 입력해주세요."}
			},
			errorPlacement(error,element){
				console.log(error);
			},
			submitHandler : function(form){
				$j('.loginForm').attr("onsubmit", "event.preventDefault();");
				
				var $frm = $j('.loginForm :input');
				var param = $frm.serialize();
				$j.ajax({
					url : "/user/userLoginAction.do",
					data : param,
					type : "POST",
					dataType : "json",
					timeout : 1000,
					traditional : true,
					success : function(data, textStatus, jqXHR){
						if(data.result=="notpw"){
							alert("PW가 잘못되었습니다.");
							$j("#userPw").val("");
						}else if(data.result=="emptyid"){
							alert("ID가 존재하지 않습니다.");
							$j("#userId").val("");
						}else if(data.result=="loginsuccess"){
							window.location.href="/board/boardList.do";
						}
					},
					error : function(jqXHR, textStatus, errorThrown){
						alert("에러")
					}
				});
			},
			invalidHandler : function(form, validator){
				var errors = validator.numberOfInvalids();
				if(errors){
					alert(validator.errorList[0].message);
					validator.errorList[0].element.focus();
				}
			}
		});
	});

</script>
<body>
<form class="loginForm">
	<table align="center">
		<tr>
			<td>
				<table border=1>
					<tr>
						<td width=120 align="center">
							<label for="userId">id</label>
							</td>
						<td width = 200>
						<input type="text" id="userId" name="userId" maxlength="15"
							 value="${user.userId}">
						</td>
					</tr>
					<tr>
						<td align="center">
							<label for="userPw">pw</label>
						</td>
						<td>
							<input type="password" id="userPw" name="userPw" maxlength="16"
							 value="${user.userPw}">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
			<button>login</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>