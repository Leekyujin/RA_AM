package com.lkj.exam.demo4.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.lkj.exam.demo4.vo.Scrap;

@Mapper
public interface ScrapRepository {

	@Select("""
			<script>
			SELECT S.*, M.nickname AS extra__writerName
			FROM scrap AS S
			LEFT JOIN `member` AS M
			ON S.memberId = M.id
			WHERE S.relId = #{relId }
			AND S.loginedMemberId = #{actorId }
			</script>
			""")
	public Scrap getScrap(int actorId, int relId);

	@Insert("""
			<script>
			INSERT INTO scrap
			SET regDate = NOW(), 
			updateDate = NOW(),
			relId = #{relId },
			memberId = #{memberId},
			loginedMemberId = #{actorId },
			title = #{title}, 
			`body` = #{body},
			scraped = 1
			</script>
			""")
	public void scrapArticle(int actorId, int id, int relId, int memberId, String title, String body);

	@Delete("""
			<script>
			DELETE FROM scrap
			WHERE id = #{id }
			</script>
			""")
	public void scrapCancel(int id);

}
