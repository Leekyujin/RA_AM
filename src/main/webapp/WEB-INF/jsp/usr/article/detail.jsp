<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${article.id }번 게시물 상세보기"/>
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>

<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';
		
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		
		localStorage.setItem(localStorageKey, true);
		
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode: 'Y'
		}, function(data) {
			
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}	
	
	$(function(){
		setTimeout(ArticleDetail__increaseHitCount, 1000);
	})
</script>

<section class="mt-12">
	<div class="container-md main mx-auto px-3">
		<div class="table-box-type-1">
			<table>
				<colgroup>
						<col width="200" />
				</colgroup>
				
				<tr>
					<th>번호</th>
					<td>${article.id}</td>
				</tr>
				<tr>
					<th>작성날짜</th>
					<td>${article.regDate.substring(2,16)}</td>
				</tr>
				<tr>
					<th>수정날짜</th>
					<td>${article.updateDate.substring(2,16)}</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>
						<span class="badge article-detail__hit-count">${article.hitCount}</span>
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${article.extra__writerName}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${article.title}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="toast-ui-viewer">
      						<script type="text/x-template">${article.body}</script>
    					</div>
					</td>
				</tr>
				<tr>
					<th>추천</th>
					<td>
						<c:if test="${actorCanMakeReaction }">
							<span>&nbsp;</span>
							<a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri} "
									class="btn-text-link btn btn-outline btn-accent">좋아요 👍</a>
							<span>&nbsp;</span>
							<span class="badge badge-accent">👍 ${article.goodReactionPoint }</span>
							<span>&nbsp;</span>
							<a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
									class="btn-text-link btn btn-outline btn-accent">싫어요 👎</a>
							<span>&nbsp;</span>
							<span class="badge badge-accent">👎 ${article.badReactionPoint }</span>
						</c:if>
						<c:if test="${actorCanCancelGoodReaction }">
							<span>&nbsp;</span>
							<a href="/usr/reactionPoint/doCancelGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri} "
									class="btn btn-accent">좋아요 👍</a>
							<span>&nbsp;</span>
							<span class="badge badge-accent">👍 ${article.goodReactionPoint }</span>
							<span>&nbsp;</span>
							<a onclick="alert(this.title); return false;" title="좋아요를 먼저 취소해주세요." href="#" 
									class="btn-text-link btn btn-outline btn-accent">싫어요	👎</a>
							<span>&nbsp;</span>
							<span class="badge badge-accent">👎 ${article.badReactionPoint }</span>
						</c:if>
						<c:if test="${actorCanCancelBadReaction }">
							<span>&nbsp;</span>
							<a onclick="alert(this.title); return false;" title="싫어요를 먼저 취소해주세요." href="#"
								class="btn-text-link btn btn-outline btn-accent">좋아요 👍</a>
							<span>&nbsp;</span>
							<span class="badge badge-accent">👍 ${article.goodReactionPoint }</span>
							<span>&nbsp;</span>
							<a href="/usr/reactionPoint/doCancelBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"	
								class="btn btn-accent">싫어요	👎</a>
							<span>&nbsp;</span>
							<span class="badge badge-accent">👎 ${article.badReactionPoint }</span>
						</c:if>
					</td>
				</tr>
			</table>
		</div>

		<div class="btns text-right mt-2">
			<c:if test="${empty param.listUri }">
				<button type="button" class="btn btn-outline btn-success" onclick="history.back();">뒤로가기</button>
			</c:if>
			<c:if test="${not empty param.listUri }">
				<a class="btn btn-outline btn-success" href="${param.listUri }">뒤로가기</a>
			</c:if>
			<c:if test="${article.extra__actorCanModify }">
				<a class="btn btn-outline btn-success" href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.extra__actorCanDelete }">
				<a class="btn btn-outline btn-success" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
	</div>
</section>

<script>
	let ReplyWrite__submitFormDone = false;
	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
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
		
		ReplyWrite__submitFormDone = true;
		form.submit();
	}
</script>

<section>
	<div class="container-md reply-wr mx-auto px-3">
		<h2>댓글 작성</h2>
		<c:if test="${rq.logined }">
			<form class="table-box-type-1 mt-1" method="POST" action="../reply/doWrite"
				onsubmit="ReplyWrite__submitForm(this); return false;">
				<input type="hidden" name="relTypeCode" value="article"/>
				<input type="hidden" name="relId" value="${article.id }"/>
				<input type="hidden" name="replaceUri" value="${rq.currentUri }"/>
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr>
							<th>작성자</th>
							<td>${rq.loginedMember.nickname }</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea class="w-full textarea textarea-info" name="body" 
								placeholder="댓글을 입력해주세요." rows="5"></textarea>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<button class="btn btn-outline btn-success" type="submit">댓글 작성</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</c:if>
		<c:if test="${rq.notLogined }">
			<a class="btn btn-outline btn-success" href="${rq.loginUri }">로그인</a> 후 이용해주세요.
		</c:if>
	</div>
</section>

<section class="mt-2">
	<div class="container-md reply mx-auto px-3">
		<h2>댓글 목록(${repliesCount })</h2>
		<c:if test="${rq.logined }">
			<div class="table-box-type-1 mt-2 mb-2">
				<table>
					<colgroup>
						<col width="80" />
						<col  />
						<col width="120" />
						<col width="120" />
						<col width="70" />
						<col width="150" />
					</colgroup>

					<thead>
						<tr>
							<th>번호</th>
							<th>내용</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>추천</th>
							<th>비고</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="reply" items="${replies }">
						<tr>
							<td>${reply.id }</td>
							<td>${reply.getForPirntBody() }</td>
							<td>${reply.extra__writerName }</td>
							<td>${reply.forPrintType1RegDate }</td>
							<td>${reply.goodReactionPoint }</td>
							<td>
								<c:if test="${reply.extra__actorCanModify }">
									<a class="btn btn-outline btn-success" href="../reply/modify?id=${reply.id }&replaceUri=${rq.encodedCurrentUri }">수정</a>
								</c:if>
								<c:if test="${reply.extra__actorCanDelete }">
									<a class="btn btn-outline btn-success" 
										onclick="if(confirm('삭제하시겠습니까?') == false) return false;" 
										href="../reply/doDelete?id=${reply.id }&replaceUri=${rq.encodedCurrentUri }">삭제</a>
								</c:if>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>