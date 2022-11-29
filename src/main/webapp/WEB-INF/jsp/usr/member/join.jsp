<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 가입" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<script>
	let submitJoinFormDone = false;
	
	function submitJoinForm(form){
		if(submitJoinFormDone){
			alert('처리중입니다.');
			return;
		}
		
  		form.loginId.value = form.loginId.value.trim();
  
  		if(form.loginId.value == 0) {
			alert('아이디을 입력해주세요.');
		  	return;
		}
  		
  		form.loginPw.value = form.loginPw.value.trim();
  	  
  		if(form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요.');
		  	return;
		}
  		
  		form.name.value = form.name.value.trim();
  	  
  		if(form.name.value == 0) {
			alert('이름을 입력해주세요.');
		  	return;
		}
  		
  		form.nickname.value = form.nickname.value.trim();
    	  
  		if(form.nickname.value == 0) {
			alert('닉네임을 입력해주세요.');
		  	return;
		}
  		
  		form.cellphoneNum.value = form.cellphoneNum.value.trim();
    	  
  		if(form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해주세요.');
		  	return;
		}
  		
  		form.email.value = form.email.value.trim();
    	  
  		if(form.email.value == 0) {
			alert('이메일을 입력해주세요.');
		  	return;
		}
		
	  	form.submit();
	  
	  	submitJoinFormDone = true;
	}
</script>

<section class="mt-12 text-xl">
	<div class="container-md main mx-auto px-3">
		<form onsubmit="submitJoinForm(this); return false;" class="table-box-type-1" method="POST"
			action="../member/doJoin">
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input required="required" class="w-full input input-bordered input-info w-full max-w-xs"
								type="text" name="loginId" placeholder="아이디를 입력해주세요." autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input required="required" class="w-full input input-bordered input-info w-full max-w-xs" 
								name="loginPw" type="password" placeholder="비밀번호를 입력해주세요." autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input required="required" class="w-full input input-bordered input-info w-full max-w-xs" 
								name="name" type="text" placeholder="이름을 입력해주세요." autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>
							<input required="required" class="w-full input input-bordered input-info w-full max-w-xs" 
								name="nickname" type="text" placeholder="닉네임을 입력해주세요." autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input required="required" class="w-full input input-bordered input-info w-full max-w-xs" 
								name="cellphoneNum" type="text" placeholder="전화번호를 입력해주세요." autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input required="required" class="w-full input input-bordered input-info w-full max-w-xs" 
								name="email" type="text" placeholder="이메일을 입력해주세요." autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><button class="btn btn-outline btn-success" type="submit" value="가입">가입</button></td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<div class="btns mt-2">
			<button class="btn-text-link btn btn-outline btn-success float-right" type="button" 
				onclick="history.back();">뒤로가기</button>
		</div>
		
	</div>


</section>

<%@ include file="../common/foot.jspf"%>