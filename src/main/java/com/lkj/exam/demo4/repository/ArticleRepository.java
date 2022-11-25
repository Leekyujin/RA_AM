package com.lkj.exam.demo4.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.lkj.exam.demo4.vo.Article;

@Mapper
public interface ArticleRepository {

	public void writeArticle(int memberId, String title, String body);
	
	public List<Article> getArticles(int boardId);

	public Article getForPrintArticle(int id);

	public void deleteArticle(int id);

	public void modifyArticle(int id, String title, String body);
	
	public int getLastInsertId();
	
	@Select("""
			<script>
			SELECT COUNT(*) AS cnt
			FROM article AS A
			WHERE 1
			<if test="boardId != 0">
				AND A.boardId = #{boardId}
			</if>
			</script>
			""")
	public int getArticlesCount(int boardId);
}
