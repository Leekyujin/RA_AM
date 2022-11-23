package com.lkj.exam.demo4.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.lkj.exam.demo4.vo.Article;

@Component
public class ArticleRepository {
	
	private int lastArticleId;
	private List<Article> articles;

	public ArticleRepository() {
		lastArticleId = 0;
		articles = new ArrayList<>();
	}

	public List<Article> getArticles() {
		return articles;
	}

	public Article writeArticle(String title, String body) {
		int id = lastArticleId + 1;
		Article article = new Article(id, title, body);

		articles.add(article);
		lastArticleId= id;

		return article;
	}

	public Article getArticle(int id) {
		for (Article article : articles) {
			if (article.getId() == id) {
				return article;
			}
		}

		return null;
	}

	public void deleteArticle(int id) {
		Article article = getArticle(id);

		articles.remove(article);
	}

	public void modifyArticle(int id, String title, String body) {
		Article article = getArticle(id);

		article.setTitle(title);
		article.setBody(body);
	}
}
