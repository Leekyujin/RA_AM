package com.lkj.exam.demo4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lkj.exam.demo4.repository.ScrapRepository;
import com.lkj.exam.demo4.util.Ut;
import com.lkj.exam.demo4.vo.Article;
import com.lkj.exam.demo4.vo.Member;
import com.lkj.exam.demo4.vo.Reply;
import com.lkj.exam.demo4.vo.ResultData;
import com.lkj.exam.demo4.vo.Scrap;

@Service
public class ScrapService {
	
	@Autowired
	private ScrapRepository scrapRepository;
	
	public 

	public ResultData actorCanScrap(int actorId, Article article, int relId) {
		
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요.");
		}
		
		if (article.getMemberId() == actorId) {
			return ResultData.from("F-3", "자신의 게시물을 스크랩 할 수 없습니다.");
		}
		
		Scrap scrap = scrapRepository.getScrap(actorId, relId);
		
		if (scrap != null && scrap.getScraped() == 1) {
			return ResultData.from("S-2", "스크랩 취소 가능");
		}

		return ResultData.from("S-1", "스크랩 가능");
	}
	

	private void updateForPrintData(Member actor, Scrap scrap) {
		
		if (actor == null) {
			return;
		}
		
		ResultData actorCanScrapRd = actorCanScrap(actor, scrap);
		scrap.setExtra__actorCanScrap(actorCanScrapRd.isSuccess());
		
		ResultData actorCanCancelScrapRd = actorCanCancelScrap(actor, scrap);
		scrap.setExtra__actorCanCancelScrap(actorCanCancelScrapRd.isSuccess());
	}
	
	public ResultData<Article> scrapArticle(int actorId, int id, int relId, int memberId, String title, String body) {
		
		Scrap scrap = scrapRepository.getScrap(actorId, relId);
		
		if (scrap == null) {
			scrapRepository.scrapArticle(actorId, id, relId, memberId, title, body);
		} else if (scrap.getScraped() == 1){
			return ResultData.from("F-1", "이미 스크랩한 게시물 입니다.");
		}

		return ResultData.from("S-1", Ut.f("%d번 게시물을 스크랩했습니다.", relId));
	}

	public ResultData scrapCancel(int actorId, int relId) {
		
		Scrap scrap = scrapRepository.getScrap(actorId, relId);
		
		if (scrap != null) {
			scrapRepository.scrapCancel(scrap.getId());
		} else {
			return ResultData.from("F-1", "스크랩 되어있지 않습니다.");
		}
		
		return ResultData.from("S-1", Ut.f("게시물 스크랩을 취소했습니다."));
	}
	
	public List<Scrap> getScraps(int memberId) {
		
		List<Scrap> scraps = scrapRepository.getForPrintScraps(memberId);

		return scraps;
	}
	
}
