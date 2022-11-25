package com.lkj.exam.demo4.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lkj.exam.demo4.vo.Article;

@Mapper
public interface ArticleRepository {

	public void writeArticle(int memberId, String title, String body);
	
	public List<Article> getArticles();

	public Article getForPrintArticle(int id);

	public void deleteArticle(int id);

	public void modifyArticle(int id, String title, String body);
	
	public int getLastInsertId();
}
