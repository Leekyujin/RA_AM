package com.lkj.exam.demo4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lkj.exam.demo4.repository.ArticleRepository;
import com.lkj.exam.demo4.util.Ut;
import com.lkj.exam.demo4.vo.Article;
import com.lkj.exam.demo4.vo.ResultData;
import com.lkj.exam.demo4.vo.Scrap;

@Service
public class ArticleService {
	
	@Autowired
	private ArticleRepository articleRepository;
	
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}
	
	public Article getForPrintArticle(int actorId, int id) {
		Article article =  articleRepository.getForPrintArticle(id);

		updateForPrintData(actorId, article);

		return article;
	}

	private void updateForPrintData(int actorId, Article article) {
		if (article == null) {
			return;
		}

		ResultData actorCanDeleteRd = actorCanDelete(actorId, article);
		article.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());
		
		ResultData actorCanModifyRd = actorCanModify(actorId, article);
		article.setExtra__actorCanModify(actorCanModifyRd.isSuccess());
		
		ResultData actorCanScrapRd = actorCanScrap(actorId, article);
		article.setExtra__actorCanScrap(actorCanScrapRd.isSuccess());
	}

	public List<Article> getForPrintArticles(int actorId, int boardId, String searchKeywordTypeCode,
			String searchKeyword, int itemsInAPage,	int page) {
		
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		List<Article> articles =  articleRepository.getForPrintArticles(boardId, searchKeywordTypeCode, searchKeyword, limitStart, limitTake);

		for (Article article : articles) {
			updateForPrintData(actorId, article);
		}

		return articles;
	}
	
	public ResultData<Integer> writeArticle(int memberId, int boardId, String title, String body) {
		
		articleRepository.writeArticle(memberId, boardId, title, body);
		
		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%s번 게시물이 생성되었습니다.", id), "id", id);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public ResultData<Article> modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
		
		Article article = getForPrintArticle(0, id);

		return ResultData.from("S-1", Ut.f("%d번 게시물을 수정했습니다.", id), "article", article);
	}
	
	public ResultData actorCanScrap(int actorId, Article article) {

		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요.");
		}

		if (article.getMemberId() == actorId) {
			return ResultData.from("F-2", "자신의 게시물을 스크랩 할 수 없습니다.");
		}

		Scrap scrap = articleRepository.getScrap(actorId, article.getId());

		if (scrap != null && scrap.getScraped() == 1) {
			return ResultData.from("S-2", "스크랩 취소 가능");
		}

		return ResultData.from("S-1", "스크랩 가능");
	}

	public ResultData actorCanModify(int loginedMemberId, Article article) {

		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", "해당 게시물에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "수정 가능");
	}
	
	public ResultData actorCanDelete(int actorId, Article article) {

		if (article == null) {
			return ResultData.from("F-1", "게시물이 존재하지 않습니다.");
		}

		if (article.getMemberId() != actorId) {
			return ResultData.from("F-2", "해당 게시물에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "삭제 가능");
	}
	
	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
	}
	
	public ResultData<Integer> increaseHitCount(int id) {
		int affectedRowsCount =  articleRepository.increaseHitCount(id);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "조회수 증가", "affectedRowsCount", affectedRowsCount);
	}
	
	public int getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}
	
	public ResultData increaseGoodReactionPoint(int relId) {
		int affectedRowsCount =  articleRepository.increaseGoodReactionPoint(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "좋아요 증가", "affectedRowsCount", affectedRowsCount);
	}

	public ResultData increaseBadReactionPoint(int relId) {
		int affectedRowsCount =  articleRepository.increaseBadReactionPoint(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "싫어요 증가", "affectedRowsCount", affectedRowsCount);
	}

	public ResultData decreaseGoodReactionPoint(int relId) {
		int affectedRowsCount =  articleRepository.decreaseGoodReactionPoint(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "좋아요 감소", "affectedRowsCount", affectedRowsCount);
	}

	public ResultData decreaseBadReactionPoint(int relId) {
		int affectedRowsCount =  articleRepository.decreaseBadReactionPoint(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "좋아요 감소", "affectedRowsCount", affectedRowsCount);
	}
	
	public Article getArticle(int id) {
		return articleRepository.getArticle(id);
	}
	
	public ResultData<Article> scrapArticle(int actorId, int id, int relId, int memberId, String title, String body) {

		Scrap scrap = articleRepository.getScrap(actorId, relId);

		if (scrap == null) {
			articleRepository.scrapArticle(actorId, id, relId, memberId, title, body);
		} else if (scrap.getScraped() == 1){
			return ResultData.from("F-1", "이미 스크랩한 게시물 입니다.");
		}

		return ResultData.from("S-1", "게시물을 스크랩했습니다.");
	}
	
	public ResultData scrapCancel(int actorId, int relId) {

		Scrap scrap = articleRepository.getScrap(actorId, relId);

		if (scrap != null) {
			articleRepository.scrapCancel(scrap.getId());
		} else {
			return ResultData.from("F-1", "스크랩 되어있지 않습니다.");
		}

		return ResultData.from("S-1", Ut.f("게시물 스크랩을 취소했습니다."));
	}
	
	public List<Scrap> getScraps(int memberId) {

		List<Scrap> scraps = articleRepository.getForPrintScraps(memberId);

		return scraps;
	}

	public void deleteScrap(int relId) {
		articleRepository.deleteScrap(relId);
	}

}
