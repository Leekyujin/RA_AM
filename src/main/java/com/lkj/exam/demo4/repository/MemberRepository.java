package com.lkj.exam.demo4.repository;

import org.apache.ibatis.annotations.Mapper;

import com.lkj.exam.demo4.vo.Member;

@Mapper
public interface MemberRepository {

	public void join(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);
	
	public int getLastInsertId();
	
	public Member getMemberById(int id);

	public Member getMemberByLoginId(String loginId);
	
	public Member getMemberByNameAndEmail(String name, String email);
}
