<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="../common/head.jspf"%>

<section class="mt-12 text-xl">
	<div class="container-md main mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../member/doLogin">
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th>아이디</th>
						<td><input class="w-96 input input-bordered input-info max-w-xs" name="loginId"
							 type="text" placeholder="아이디를 입력해주세요." autocomplete="off" /></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input class="w-96 input input-bordered input-info max-w-xs" name="loginPw" type="password" placeholder="비밀번호를 입력해주세요." /></td>
					</tr>
					<tr>
						<th></th>
						<td><button class="btn btn-outline btn-success" type="submit" value="로그인">로그인</button>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns mt-2">
			<button class="btn btn-outline btn-success float-right" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>

	
</section>

<%@ include file="../common/foot.jspf" %>