<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${article.id}번 게시물 상세보기"/>
<%@ include file="../common/head.jspf" %>

<table border="1" bordercolor="orange" align="center">
	<tr>
		<td>번호</td>
		<td>${article.id}</td>
	</tr>
	<tr>
		<td>작성날짜</td>
		<td>${article.regDate.substring(2,16)}</td>
	</tr>
	<tr>
		<td>수정날짜</td>
		<td>${article.updateDate.substring(2,16)}</td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${article.memberId}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${article.title}</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>${article.body}</td>
	</tr>
</table>

<%@ include file="../common/foot.jspf" %>