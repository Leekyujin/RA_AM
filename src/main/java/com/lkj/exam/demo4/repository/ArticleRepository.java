package com.lkj.exam.demo4.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lkj.exam.demo4.vo.Article;
import com.lkj.exam.demo4.vo.Scrap;

@Mapper
public interface ArticleRepository {

	public void writeArticle(int memberId, int boardId, String title, String body);
	
	public List<Article> getForPrintArticles(int boardId, String searchKeywordTypeCode, String searchKeyword, int limitStart, int limitTake);

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
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'title'">
						AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordTypeCode == 'body'">
						AND A.body LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND (
							A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR A.body LIKE CONCAT('%', #{searchKeyword}, '%')
							)
					</otherwise>
				</choose>
			</if>
			</script>
			""")
	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword);
	
	public int increaseHitCount(int id);
	
	public int getArticleHitCount(int id);
	
	public int getSumReactionPointByMemberId(int memberId, int id);
	
	@Update("""
			<script>
			UPDATE article 
			SET goodReactionPoint = goodReactionPoint + 1
			WHERE id = #{relId }
			</script>
			""")
	public int increaseGoodReactionPoint(int relId);

	@Update("""
			<script>
			UPDATE article 
			SET badReactionPoint = badReactionPoint + 1
			WHERE id = #{relId }
			</script>
			""")
	public int increaseBadReactionPoint(int relId);

	@Update("""
			<script>
			UPDATE article 
			SET goodReactionPoint = goodReactionPoint - 1
			WHERE id = #{relId }
			</script>
			""")
	public int decreaseGoodReactionPoint(int relId);

	@Update("""
			<script>
			UPDATE article 
			SET badReactionPoint = badReactionPoint - 1
			WHERE id = #{relId }
			</script>
			""")
	public int decreaseBadReactionPoint(int relId);
	
	@Select("""
			SELECT *
			FROM article
			WHERE id = #{id }
			""")
	public Article getArticle(int id);

	@Insert("""
			<script>
			INSERT INTO scrap
			SET regDate = NOW(), 
			updateDate = NOW(),
			relId = #{relId },
			memberId = #{memberId},
			loginedMemberId = #{loginedMemberId },
			title = #{title}, 
			`body` = #{body},
			scraped = 1
			</script>
			""")
	public void scrapArticle(int loginedMemberId, int id, int relId, int memberId, String title, String body);

	@Select("""
			<script>
			SELECT S.*, M.nickname AS extra__writerName
			FROM scrap AS S
			LEFT JOIN `member` AS M
			ON S.memberId = M.id
			WHERE S.relId = #{relId }
			AND S.loginedMemberId = #{loginedMemberId }
			</script>
			""")
	public Scrap getScrap(int loginedMemberId, int relId);
	
	@Delete("""
			<script>
			DELETE FROM scrap
			WHERE id = #{id }
			</script>
			""")
	public void scrapCancel(int id);

	@Select("""
			<script>
			SELECT S.*, M.nickname AS extra__writerName
			FROM scrap AS S
			LEFT JOIN `member` AS M
			ON S.memberId = M.id
			WHERE S.loginedMemberId = #{memberId }
			</script>
			""")
	public List<Scrap> getForPrintScraps(int memberId);
}
