package com.lkj.exam.demo4.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lkj.exam.demo4.service.ArticleService;
import com.lkj.exam.demo4.util.Ut;
import com.lkj.exam.demo4.vo.Article;
import com.lkj.exam.demo4.vo.ResultData;
import com.lkj.exam.demo4.vo.Rq;

@Controller
public class UsrScrapController {
	
	@Autowired
	private ArticleService articleService;
	@Autowired
	private Rq rq;

	@RequestMapping("/usr/article/doScrap")
	@ResponseBody
	public String doScrap(int id) {
		
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		ResultData actorCanScrapRd = articleService.actorCanScrap(rq.getLoginedMemberId(), article);

		if (actorCanScrapRd.isFail()) {
			return rq.jsHistoryBack(actorCanScrapRd.getMsg());
		}

		ResultData scrapRd = articleService.scrapArticle(rq.getLoginedMemberId(), id, article.getId(), article.getMemberId(), article.getTitle(), article.getBody());

		return rq.jsReplace(Ut.f(scrapRd.getMsg(), id), Ut.f("../article/detail?id=%d", id));
	}
	
	@RequestMapping("/usr/article/doCancelScrap")
	@ResponseBody
	public String doCancelScrap(int id) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		ResultData actorCanScrapRd = articleService.actorCanScrap(rq.getLoginedMemberId(), article);

		if (actorCanScrapRd.isFail()) {
			return rq.jsHistoryBackOnView(actorCanScrapRd.getMsg());
		}

		ResultData scrapRd = articleService.scrapCancel(rq.getLoginedMemberId(), article.getId());

		return rq.jsReplace(Ut.f(scrapRd.getMsg(), id), Ut.f("../article/detail?id=%d", id));
	}
}
