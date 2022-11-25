<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="NOTICE"/>
<%@ include file="../common/head.jspf" %>

<section class="mt-8">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<table>
				<colgroup>
				<col width="80"/>
				<col />
				<col width="140"/>
				<col width="200"/>
				<col width="100"/>
				<col width="100"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="article" items="${articles }">
					<tr>
						<td>${article.id}</td>
						<td><a class="hover:text-red-600" href="../article/detail?id=${article.id}">${article.title}</a></td>
						<td>${article.extra__writerName}</td>
						<td>${article.updateDate.substring(2,16)}</td>
						<td><a class="hover:text-red-600" href="../article/modify?id=${article.id }">수정</a></td>
						<td><a class="hover:text-red-600" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="../article/doDelete?id=${article.id }">삭제</a></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="btns float-right">
			<c:if test="${rq.isLogined() }">
				<a class="btn-text-link btn btn-outline btn-success" href="../article/write">글 작성</a>
			</c:if>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>