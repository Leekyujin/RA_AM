<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원정보 수정"/>
<%@ include file="../common/head.jspf" %>

<script>
	let MemberModify__submitDone = false;
	function MemberModify__submit(form) {
		if (MemberModify__submitDone) {
			alert('처리중입니다');
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPwConfirm.value.length > 0) {
			
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호 확인을 입력해주세요');
				form.loginPwConfirm.focus();
				return;
			}
			
			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호가 일치하지 않습니다');
				form.loginPw.focus();
				return;
			}
		}
		
		form.name.value = form.name.value.trim();
		
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}
		
		form.nickname.value = form.nickname.value.trim();
		
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요');
			form.nickname.focus();
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		
		if (form.cellphoneNum.value.length == 0) {
			alert('전화번호를 입력해주세요');
			form.cellphoneNum.focus();
			return;
		}
		
		form.email.value = form.email.value.trim();
		
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		
		MemberModify__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-12">
	<div class="container-md main mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../member/doModify"
			onsubmit="MemberModify__submit(this); return false;">
			<table>
				<colgroup>
						<col width="200" />
				</colgroup>

				<tr>
					<th>로그인 아이디</th>
					<td>${rq.loginedMember.loginId }</td>
				</tr>
				<tr>
					<th>가입날짜</th>
					<td>${rq.loginedMember.regDate }</td>
				</tr>
				<tr>
					<th>새 비밀번호</th>
					<td>
						<input class="w-96 input input-bordered input-info w-full max-w-xs" 
							name="loginPw" type="password" placeholder="새 비밀번호를 입력해주세요." />
					</td>
				</tr>
				<tr>
					<th>새 비밀번호 확인</th>
					<td>
						<input class="w-96 input input-bordered input-info w-full max-w-xs" 
							name="loginPwConfirm" type="password" placeholder="새 비밀번호를 입력해주세요." />
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input class="w-96 input input-bordered input-info w-full max-w-xs" type="text" name="name" 
							placeholder="이름을 입력해주세요." autocomplete="off" value="${rq.loginedMember.name }"/>
					</td>
				</tr>
				<tr>
					<th>nickname</th>
					<td>
						<input class="w-96 input input-bordered input-info w-full max-w-xs" type="text" name="nickname" 
							placeholder="닉네임을 입력해주세요." autocomplete="off" value="${rq.loginedMember.nickname }"/>
					</td>
				</tr>
				<tr>
					<th>cellphoneNum</th>
					<td>
						<input class="w-96 input input-bordered input-info w-full max-w-xs" type="text" name="cellphoneNum" 
							placeholder="전화번호를 입력해주세요." autocomplete="off" value="${rq.loginedMember.cellphoneNum }"/>
					</td>
				</tr>
				<tr>
					<th>email</th>
					<td>
						<input class="w-96 input input-bordered input-info w-full max-w-xs" type="text" name="email" 
							placeholder="이메일을 입력해주세요." autocomplete="off" value="${rq.loginedMember.email }"/>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<button class="btn btn btn-outline btn-success" type="submit" value="수정">수정</button>
					</td>
				</tr>
			</table>
		</form>
		
		<div class="btns text-right mt-2">
			<button type="button" class="btn-text-link btn btn-outline btn-success" onclick="history.back();">뒤로가기</button>
			<c:if test="${rq.logined }">
				<a class="btn-text-link btn btn-outline btn-success" 
					onclick="if(confirm('정말 탈퇴하시겠습니까?') == false) return false;" 
					href="../member/doDelete?id=${rq.loginedMember.id }">회원 탈퇴</a>
			</c:if>
		</div>
		
	</div>


</section>

<%@ include file="../common/foot.jspf" %>