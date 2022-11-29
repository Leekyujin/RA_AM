<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="댓글 수정"/>
<%@ include file="../common/head.jspf" %>

<script>
	let ReplyModify__submitDone = false;
	function ReplyModify__submit(form) {
		if (ReplyModify__submitDone) {
			return;
		}
		
		form.body.value = form.body.value.trim();
		
		if (form.body.value.length == 0) {
			alert('댓글을 입력해주세요');
			form.body.focus();
			return;
		}
		
		if (form.body.value.length < 2) {
			alert('2글자 이상 입력해주세요');
			form.body.focus();
			return;
		}
		
		ReplyModify__submitDone = true;
		form.submit();
	}
</script>


<section>
	<div class="container-md reply-md mx-auto px-3 mt-3">
		<form class="table-box-type-1" method="POST" action="../reply/doModify" 
			onsubmit="ReplyModify__submit(this); return false;">
		<input type="hidden" name="id" value="${reply.id }"/>
		<input type="hidden" name="replaceUri" value="${param.replaceUri }"/>
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>게시물 번호</th>
						<td>${reply.relId}</td>
					</tr>
					<tr>
						<th>게시물 내용</th>
						<td>${relDataTitle}</td>
					</tr>
					<tr>
						<th>작성날짜</th>
						<td>${reply.regDate.substring(2,16)}</td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td>${reply.updateDate.substring(2,16)}</td>
					</tr>
					<tr>
						<th>추천</th>
						<td>
							<c:if test="${actorCanMakeReaction }">
								<button class="btn-text-link btn btn-outline btn-accent">좋아요 👍</button>
								<span>&nbsp;</span>
							</c:if>
							<span class="badge badge-accent">👍 ${reply.goodReactionPoint }</span>
							<c:if test="${actorCanMakeReaction }">
								<button class="btn-text-link btn btn-outline btn-accent ml-2">싫어요 👎</button>
								<span>&nbsp;</span>
							</c:if>
							<span class="badge badge-accent">👎 ${reply.badReactionPoint }</span>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${reply.extra__writerName}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea class="w-full textarea textarea-info" name="body" placeholder="내용을 입력해주세요." >${reply.body }</textarea>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><button class="btn btn-outline btn-success" type="submit" value="수정">수정</button></td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btns float-right mt-1">
			<a class="btn btn-outline btn-success" href="${param.replaceUri }">뒤로가기</a>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>