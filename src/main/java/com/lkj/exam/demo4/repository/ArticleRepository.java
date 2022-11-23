package com.lkj.exam.demo4.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lkj.exam.demo4.vo.Article;

@Mapper
public interface ArticleRepository {

	public Article writeArticle(String title, String body);
	
	public List<Article> getArticles();

	public Article getArticle(int id);

	public void deleteArticle(int id);

	public void modifyArticle(int id, String title, String body);
	
	public int getLastInsertId();
}
