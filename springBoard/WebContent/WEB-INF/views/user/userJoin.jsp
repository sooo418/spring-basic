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
	var overlapCheck = false;
	
	$j.validator.addMethod("addr1Regx", function(value, element){
		return this.optional(element) || /^\d{3}-\d{3}$/.test(value);
	});

	$j(document).ready(function(){
		$j('.joinInput').css('height', '18px');
		
		$j('input[name=userId]').keyup(function(event){
			overlapCheck = false;
		});
		
		$j('#idOverlapCheck').click(function(){
			var id = $j('#userId').val()
			id = id.trim();
			
			if(id.length<1 || id==null){
				alert("�ߺ�Ȯ���� ID�� �Է����ּ���.");
				return false;
			}
			if(id.length<3 || id.length>15){
				alert("ID���̴� 3���̻� 15�������Դϴ�.");
				return false;
			}
			var param = {'id' : id};
			$j.ajax({
				url : "/user/userIdOverlapCheck.do",
				type : "POST",
				data  :param,
				timeout : 2000,
				dataType : "json",
				traditional : true,
				success : function(data, textStatus){
					if(data.result=="Y"){
						alert("����Ͻ� �� �ִ� ID�Դϴ�.");
						overlapCheck = true;
					}else{
						alert("�ش� ID�� ����� �� �����ϴ�.");
						overlapCheck = false;
					}
				},
				error : function(){
					alert('error');
				}
			});
		});
		$j(".joinForm").validate({
			onkeyup : function (element){
				if($j(element).attr('name')=="userPwcheck"){
					$j(element).valid();
				}
			},
			onfocusout : false,
			rules : {
				userId : {required:true, minlength:3, maxlength:15},
				userPw : {required:true, minlength:8, maxlength:16},
				userPwcheck : {required:true, equalTo:"#userPw"},
				userName : {required:true, minlength:2, maxlength:7},
				userPhone2 : {required:true, digits:true, minlength:4},
				userPhone3 : {required:true, digits:true, minlength:4},
				userAddr1 : {addr1Regx:true},
				userAddr2 : {maxlength:75},
				userCompany : {maxlength:30}
			},
			messages : {
				userId : {required:"ID�� �Է����ּ���",
					minlength:$j.validator.format( "ID�� {0}�� �̻� �Է��ϼ���." ),
					maxlength:$j.validator.format( "ID�� {0}�ڸ� ���� �� �����ϴ�. " )},
				
				userPw : {required:"PW�� �Է����ּ���",
					minlength:$j.validator.format( "PW�� {0}�� �̻� �Է��ϼ���." ),
					maxlength:$j.validator.format( "PW�� {0}�ڸ� ���� �� �����ϴ�. " )},
					
				userPwcheck : {required:"PW CHECK�� �Է����ּ���", equalTo:"�Է��� ���� PW�� �ٸ��ϴ�."},
				
				userName : {required:"NAME�� �Է����ּ���",
					minlength:$j.validator.format( "NAME�� {0}�� �̻� �Է��ϼ���." ),
					maxlength:$j.validator.format( "NAME�� {0}�ڸ� ���� �� �����ϴ�. " )},
					
				userPhone2 : {required:"PHONE�� �Է����ּ���", digits:"PHONE�� ���ڸ� �Է� �����մϴ�.",
					minlength:$j.validator.format( "PHONE�� {0}�� �̻� �Է��ϼ���." )},
					
				userPhone3 : {required:"PHONE�� �Է����ּ���", digits:"PHONE�� ���ڸ� �Է� �����մϴ�.",
					minlength:$j.validator.format( "PHONE {0}�� �̻� �Է��ϼ���." )},
					
				userAddr1 : {addr1Regx:$j.validator.format( "xxx-xxx�������� �Է����ּ���." )},
				userAddr2 : {maxlength:$j.validator.format( "{0}�ڸ� ���� �� �����ϴ�. " )},
				userCompany : {maxlength:$j.validator.format( "{0}�ڸ� ���� �� �����ϴ�. " )}
			},
			errorPlacement : function(error, element){
				if($j(element).attr('name')=="userPwcheck"){
					element.after(error);
				}
			},
			submitHandler: function(form) { //��� �׸��� ����Ǹ� ȣ��� showError �� �Բ� ���� ���������ʴ´�
				if(overlapCheck!=true){
					alert("ID�� �ߺ�Ȯ�����ּ���.");
					return false;
				}
				$j('.joinForm').attr("onsubmit", "event.preventDefault();");
				if($j('#userName').val().trim()==""){
					alert('name�� ���� ä���ּ���');
					return false;
				}
				var $frm = $j('.joinForm :input');
				var param = $frm.serialize();
				$j.ajax({
					url : "/user/userJoinAction.do",
					type : "POST",
					data : param,
					dataType : "json",
					timeout : 1000,
					traditional : true,
					success : function(data, textStatus, jqXHR){
						alert("ȸ������ ����!!");
						window.location.href = "/board/boardList.do";
					},
					error : function(jqXHR, textStatus, errorThrown){
						alert("ȸ������ ����!!");
					}
				});
			},
			invalidHandler: function(form, validator){ //�Է°��� �߸��� ���¿��� submit �Ҷ� ȣ��
				var errors = validator.numberOfInvalids();
				if (errors) {
					alert(validator.errorList[0].message);
					validator.errorList[0].element.focus();
				}
			}
		});
		
		$j('input[name=userId]').keyup(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[^a-z0-9]/gi,""));
			}
		});
		$j('input[name=userName]').keyup(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[a-z0-9]|[\[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g,""));
			}
		});
		$j('input[class=userPhone]').keyup(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[^0-9]/gi,""));
			}
		});
		$j('input[class=userPhone]').focusout(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[^0-9]/gi,""));
			}
		});
		$j('input[name=userPhone2]').keyup(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				if(inputVal.length==4){
					$j('input[name=userPhone3]').focus();
				}
			}
		});
		$j('input[name=userAddr2]').keyup(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[a-z]|[\[\]{}()<>?|`~!@#$%^&*_+=,.;:\"'\\]/g,""));
			}
		});
		$j('input[name=userAddr1]').keyup(function(event){
			if(!(event.keyCode > 37 && event.keyCode <= 40)){
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[^-0-9]/gi,""));
				if(inputVal.valueOf().substr(0,3).indexOf('-')!=-1){
					var idx = inputVal.valueOf().substr(0,3).indexOf('-');
					$j(this).val(inputVal.valueOf().substr(0,idx));
				}
				if(event.keyCode!=8){
					if(inputVal.length>=3){
						if(inputVal.length==3){
							$j(this).val(inputVal+'-');
						}else if(inputVal.length>3 && inputVal.length<7 && inputVal.valueOf().substr(3,1)!='-'){
							$j(this).val(inputVal.valueOf().substr(0,3)+'-'+inputVal.valueOf().substr(3));
						}else if(inputVal.length==7 && inputVal.valueOf().substr(3,1)!='-'){
							$j(this).val(inputVal.valueOf().substr(0,3)+'-'+inputVal.valueOf().substr(4,3));
						}
					}
				}
				else{
					if(inputVal.length==3){
						$j(this).val(inputVal.valueOf().substr(0,2));
					}else if(inputVal.length==4 && inputVal.valueOf().substr(3,1)=='-'){
						$j(this).val(inputVal.valueOf().substr(0,3));
					}
				}
			}
		});
		
	});
</script>
<body>
<form id="joinForm" name="joinForm" class="joinForm">
	<table align="center">
		<tr>
			<td align="left"><a href="/board/boardList.do">list</a></td>
		</tr>
		<tr>
			<td>
				<table border=1>
					<tr>
						<td width=120 align="center">
						<label for="id">id</label>
						</td>
						<td width = 300>
						<input type="text" id="userId" name="userId" maxlength="15"
						 value="${user.userId}">
							<input id="idOverlapCheck" style="margin-left: 1px" type="button"
							value="�ߺ�Ȯ��">
						</td>
						
					</tr>
					<tr>
						<td align="center">
						<label for="pw">pw</label>
						</td>
						<td>
						<input type="password" id="userPw" name="userPw" maxlength="16"
						 value="${user.userPw}">
						</td>
					</tr>
					<tr>
						<td align="center">
						<label for="pwcheck">pw check</label>
						</td>
						<td>
						<input type="password" id="userPwcheck" name="userPwcheck" maxlength="16">
						</td>
					</tr>
					<tr>
						<td align="center">
						<label for="name">name</label>
						</td>
						<td>
						<input type="text" id="userName" name="userName" maxlength="6"
						 value="${user.userName}">
						</td>
					</tr>
					<tr>
						<td align="center">
						phone
						</td>
						<td>
						<select style="height: 23px" name="phoneSelectBox">
							<c:forEach items="${codePhoneList}" var="phone">
								<option value="${phone.codeName}">${phone.codeName}</option>
							</c:forEach>
						</select>
						-
						<input type="text" maxlength="4" style="width: 40px"
						 id="userPhone2" name="userPhone2" class="userPhone" value="${user.userPhone2}">
						-
						<input type="text" maxlength="4" style="width: 40px"
						 id="userPhone3" name="userPhone3" class="userPhone" value="${user.userPhone3}">
						</td>
					</tr>
					<tr>
						<td align="center">
						<label for="userAddr1">postNo</label>
						</td>
						<td>
						<input type="text" id="userAddr1" maxlength="7"
						 name="userAddr1" value="${user.userAddr1}">
						</td>
					</tr>
					<tr>
						<td align="center">
						<label for="userAddr2">address</label>
						</td>
						<td>
						<input type="text" id="userAddr2" name="userAddr2"
						 maxlength="75" value="${user.userAddr2}">
						</td>
					</tr>
					<tr>
						<td align="center">
						<label for="userCompany">company</label>
						</td>
						<td>
						<input type="text" id="userCompany" name="userCompany"
						 maxlength="30" value="${user.userCompany}">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<button id="submit" style="margin-left: 1px">
				join
				</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>