<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 작성" />
<%@ include file="../common/head.jspf"%>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../article/doWrite">
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
						<th>게시판</th>
						<td>
							<select class="select select-info w-full max-w-xs" name="boardId">
							  <option disabled>게시판을 선택해주세요</option>
							  <option value=1>공지사항</option>
							  <option value=2>스토리</option>
							  <option value=3>소식</option>
							  <option value=4>팁과 노하우</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input class="w-full input input-bordered input-info w-full max-w-xs" name="title"
								required="required" type="text" placeholder="제목을 입력해주세요." />
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea class="w-full textarea textarea-info" name="body"
								required="required" placeholder="내용을 입력해주세요."></textarea>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><button class="btn btn-outline btn-success" type="submit" value="작성">작성</button></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>

	<div class="container mx-auto px-3 btns mt-2">
		<button class="btn btn-outline btn-success float-right" type="button" onclick="history.back();">뒤로가기</button>
	</div>

</section>

<%@ include file="../common/foot.jspf"%>