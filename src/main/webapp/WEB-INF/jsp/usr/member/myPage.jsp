<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MY PAGE"/>
<%@ include file="../common/head.jspf" %>

<section class="mt-12 text-xl">
	<div class="container-md main mx-auto px-3">
		<div class="table-box-type-1">
			<table>
				<colgroup>
						<col width="200" />
				</colgroup>

				<tr>
					<th>가입날짜</th>
					<td>${member.regDate }</td>
				</tr>
				<tr>
					<th>로그인 아이디</th>
					<td>${member.loginId }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${member.name }</td>
				</tr>
				<tr>
					<th>nickname</th>
					<td>${member.nickname }</td>
				</tr>
				<tr>
					<th>cellphoneNum</th>
					<td>${member.cellphoneNum }</td>
				</tr>
				<tr>
					<th>email</th>
					<td>${member.email }</td>
				</tr>
			</table>
		</div>

		<div class="btns text-right mt-2">
			<button type="button" class="btn-text-link btn btn-outline btn-success" onclick="history.back();">뒤로가기</button>
			<c:if test="${article.extra__actorCanModify }">
				<a class="btn-text-link btn btn-outline btn-success" href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.extra__actorCanDelete }">
				<a class="btn-text-link btn btn-outline btn-success" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" 
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>