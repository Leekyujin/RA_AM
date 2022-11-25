<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 수정"/>
<%@ include file="../common/head.jspf" %>

<section class="mt-8">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../article/doModify">
		<input type="hidden" name="id" value="${article.id }"/>
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>

				<tr>
					<th>번호</th>
					<td>${article.id}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input class="w-full input input-bordered input-info w-full max-w-xs" autocomplete="off" type="text" name="title"
						 placeholder="제목을 입력해주세요." value="${article.title}" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea class="w-full input input-bordered input-info w-full max-w-xs" name="body" placeholder="내용을 입력해주세요." >${article.body }</textarea>
					</td>
				</tr>
				<tr>
					<th></th>
					<td><button class="btn btn-outline btn-success" type="submit" value="수정">수정</button></td>
				</tr>
			</table>
		</form>

		<div class="btns float-right mt-2">
			<button type="button" class="btn btn-outline btn-success" onclick="history.back();">뒤로가기</button>
			<a class="btn btn-outline btn-success" href="../article/modify?id=${article.id }">수정</a>
			<c:if test="${article.extra__actorCanDelete }">
				<a class="btn btn-outline btn-success" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" 
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>