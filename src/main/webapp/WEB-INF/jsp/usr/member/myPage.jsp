<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 정보"/>
<%@ include file="../common/head.jspf" %>
<%@ page import="com.lkj.exam.demo4.util.Ut" %>

<section class="mt-12 text-xl">
	<div class="container-md main mx-auto px-3">
		<div class="table-box-type-1">
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
					<th>이름</th>
					<td>${rq.loginedMember.name }</td>
				</tr>
				<tr>
					<th>nickname</th>
					<td>${rq.loginedMember.nickname }</td>
				</tr>
				<tr>
					<th>cellphoneNum</th>
					<td>${rq.loginedMember.cellphoneNum }</td>
				</tr>
				<tr>
					<th>email</th>
					<td>${rq.loginedMember.email }</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<a class="btn-text-link btn btn-outline btn-success" 
							href="../member/checkPassword?replaceUri=${Ut.getUriEncoded('../member/modify') }">회원정보 수정</a>
					</td>
				</tr>
			</table>
		</div>

		<div class="btns text-right mt-2">
			<button type="button" class="btn-text-link btn btn-outline btn-success" onclick="history.back();">뒤로가기</button>
			<c:if test="${rq.logined }">
				<a class="btn-text-link btn btn-outline btn-success" onclick="if(confirm('정말 탈퇴하시겠습니까?') == false) return false;" 
					href="../member/doDelete?id=${rq.loginedMember.id }">회원 탈퇴</a>
			</c:if>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>