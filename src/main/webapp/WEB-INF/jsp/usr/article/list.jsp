<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name } 게시판"/>
<%@ include file="../common/head.jspf" %>

<section class="mt-12">
	<div class="container-md main mx-auto px-3">
		<div class="flex">
			<div class="text-xl">게시물 갯수 : <span class="badge">${articlesCount }개</span></div>
			<div class="flex-grow"></div>
			<form class="flex">
				<input type="hidden" name="boardId" value=${param.boardId } />

				<select data-value="${param.searchKeywordTypeCode }" class="select select-info max-w-xs"
					 name="searchKeywordTypeCode">
				  <option disabled>검색</option>
				  <option value="title">제목</option>
				  <option value="body">내용</option>
				  <option value="title,body">제목+내용</option>
				</select>

				<input class="input input-bordered input-info w-96 max-w-xs ml-1" type="text" name="searchKeyword" 
					placeholder="검색어를 입력해주세요." maxlength="20" value="${param.searchKeyword }" autocomplete="off" />
				<button class="btn-text-link btn btn-outline btn-success ml-1" type="submit">검색</button>
			</form>
		</div>
		
		<div class="table-box-type-1 mt-1">
			<table>
				<colgroup>
					<col width="80"/>
					<col />
					<col width="120"/>
					<col width="160"/>
					<col width="80"/>
					<col width="80"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>조회수</th>
						<th>추천</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="article" items="${articles }">
					<tr>
						<td>${article.id}</td>
						<td><a class="hover:text-red-600" href="${rq.getArticleDetailUriFromArticleList(article) }">${article.title}</a></td>
						<td>${article.extra__writerName }</td>
						<td>${article.forPrintType1RegDate }</td>
						<td>${article.hitCount }</td>
						<td>${article.goodReactionPoint }</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page-menu mt-3 flex justify-center">
			<div class="btn-group">
				<c:set var="pageMenuLen" value="5"/>
				<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1 }"/>
				<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}"/>
				
				<c:set var="pageBaseUri" value="?boardId=${boardId }"/>
				<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeywordTypeCode=${param.searchKeywordTypeCode }"/>
				<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeyword=${param.searchKeyword }"/>
				
				<c:if test="${startPage > 1 }">
					<a class="btn btn-sm" href="${pageBaseUri }&page=1">1</a>
					<c:if test="${startPage > 2 }">
						<a class="btn btn-sm btn-disabled">...</a>
					</c:if>
				</c:if>
				<c:forEach begin="${startPage }" end="${endPage }" var="i">
					<a class="btn btn-sm ${page == i ? 'btn-active' : '' }" href="${pageBaseUri }&page=${i }">${i }</a>
				</c:forEach>
				<c:if test="${endPage < pagesCount }">
					<c:if test="${endPage < pagesCount - 1 }">
						<a class="btn btn-sm btn-disabled">...</a>
					</c:if>
					<a class="btn btn-sm" href="${pageBaseUri }&page=${pagesCount }">${pagesCount }</a>
				</c:if>
			</div>
		</div>
		<div class="btns float-right">
			<c:if test="${rq.isLogined() }">
				<a class="btn-text-link btn btn-outline btn-success" href="../article/write">글 작성</a>
			</c:if>
		</div>
	</div>
</section>
<%@ include file="../common/foot.jspf" %>