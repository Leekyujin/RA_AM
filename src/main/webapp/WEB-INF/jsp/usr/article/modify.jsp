<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 수정"/>
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>

<script>
	let ArticleModify__submitDone = false;
	function ArticleModify__submit(form) {
		if (ArticleModify__submitDone) {
			return;
		}
		
		const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
		const markdown = editor.getMarkdown().trim();
	  
		if(markdown.length == 0){
	    	alert('내용을 입력해주세요.');
	    	editor.focus();
	    
	    	return;
	  	}
	  	
		form.body.value = markdown;
		
		ArticleModify__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-12">
	<div class="container-md main mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../article/doModify"
			onsubmit="ArticleModify__submit(this); return false;">
		<input type="hidden" name="id" value="${article.id }"/>
		<input type="hidden" name="body" />
			<table class="text-base">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tr>
					<th>번호</th>
					<td>${article.id}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${article.extra__writerName}</td>
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
					<th>추천</th>
					<td>
						<c:if test="${actorCanMakeReaction }">
							<button class="btn-text-link btn btn-outline btn-accent">좋아요 👍</button>
							<span>&nbsp;</span>
						</c:if>
						<span class="badge badge-accent">👍 ${article.goodReactionPoint }</span>
						<c:if test="${actorCanMakeReaction }">
							<button class="btn-text-link btn btn-outline btn-accent ml-2">싫어요 👎</button>
							<span>&nbsp;</span>
						</c:if>
						<span class="badge badge-accent">👎 ${article.badReactionPoint }</span>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input class="w-full input input-bordered input-info max-w-xs" autocomplete="off" type="text" name="title"
						 	placeholder="제목을 입력해주세요." autocomplete="off" value="${article.title}" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="toast-ui-editor">
      						<script type="text/x-template">${article.body}</script>
    					</div>
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