package com.lkj.exam.demo4.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReactionPointRepository {

	@Select("""
			<script>
				SELECT IFNULL(SUM(RP.point),0) AS s
				FROM reactionPoint AS RP
				WHERE RP.relTypeCode = #{relTypeCode }
				AND RP.relId = #{relId }
				AND RP.memberId = #{actorId }
			</script>
			""")
	public int getSumReactionPointByMemberId(int actorId, String relTypeCode, int relId);

	@Insert("""
			<script>
				INSERT INTO reactionPoint
				SET regDate = NOW(),
				updateDate = NOW(),
				relTypeCode = #{relTypeCode },
				relId = #{relId },
				memberId = #{actorId },
				`point` = 1
			</script>
			""")
	public void addGoodReactionPoint(int actorId, String relTypeCode, int relId);

	@Insert("""
			<script>
				INSERT INTO reactionPoint
				SET regDate = NOW(),
				updateDate = NOW(),
				relTypeCode = #{relTypeCode },
				relId = #{relId },
				memberId = #{actorId },
				`point` = -1
			</script>
			""")
	public void addBadReactionPoint(int actorId, String relTypeCode, int relId);

	@Delete("""
			<script>
				DELETE FROM reactionPoint 
				WHERE relTypeCode = #{relTypeCode }
				AND relId = #{relId }
				AND memberId = #{actorId }
			</script>
			""")
	public void deleteGoodReactionPoint(int actorId, String relTypeCode, int relId);

	@Delete("""
			<script>
				DELETE FROM reactionPoint 
				WHERE relTypeCode = #{relTypeCode }
				AND relId = #{relId }
				AND memberId = #{actorId }
			</script>
			""")
	public void deleteBadReactionPoint(int actorId, String relTypeCode, int relId);

}
