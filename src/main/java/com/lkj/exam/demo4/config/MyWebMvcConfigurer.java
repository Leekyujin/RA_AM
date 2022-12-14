package com.lkj.exam.demo4.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.lkj.exam.demo4.interceptor.BeforeActionInterceptor;
import com.lkj.exam.demo4.interceptor.NeedAdminInterceptor;
import com.lkj.exam.demo4.interceptor.NeedLoginInterceptor;
import com.lkj.exam.demo4.interceptor.NeedLogoutInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer{
	// BeforeActionInterceptor 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	// NeedLoginInterceptor 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	// NeedLogoutInterceptor 불러오기
	@Autowired
	NeedLogoutInterceptor needLogoutInterceptor;
	// NeedAdminInterceptor 불러오기
	@Autowired
	NeedAdminInterceptor needAdminInterceptor;

	// 인터셉터를 적용하는 역할
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		InterceptorRegistration ir;

		// BeforeActionInterceptor가 모든 액션 실행 전에 실행되도록 처리
		ir = registry.addInterceptor(beforeActionInterceptor);
		ir.addPathPatterns("/**");
		ir.addPathPatterns("/favicon.ico");
		ir.excludePathPatterns("/resource/**");
		ir.excludePathPatterns("/error");
		
		// 로그인 없이도 접속할 수 있는 URI 기술
		ir = registry.addInterceptor(needLoginInterceptor);
		ir.addPathPatterns("/usr/article/write");
		ir.addPathPatterns("/usr/article/doWrite");
		ir.addPathPatterns("/usr/article/modify");
		ir.addPathPatterns("/usr/article/doModify");
		ir.addPathPatterns("/usr/article/doDelete");
		ir.addPathPatterns("/usr/reactionPoint/doGoodReaction");
		ir.addPathPatterns("/usr/reactionPoint/doBadReaction");
		ir.addPathPatterns("/usr/reactionPoint/doCancelGoodReaction");
		ir.addPathPatterns("/usr/reactionPoint/doCancelBadReaction");
		ir.addPathPatterns("/usr/reply/doWrite");
		ir.addPathPatterns("/usr/reply/doDelete");
		ir.addPathPatterns("/usr/reply/modify");
		ir.addPathPatterns("/usr/reply/doModify");
		ir.addPathPatterns("/usr/member/doLogout");
		ir.addPathPatterns("/usr/member/myPage");
		ir.addPathPatterns("/usr/member/showMyPage");
		ir.addPathPatterns("/usr/member/checkPassword");
		ir.addPathPatterns("/usr/member/doCheckPassword");
		ir.addPathPatterns("/usr/member/modify");
		ir.addPathPatterns("/usr/member/doModify");
		ir.addPathPatterns("/adm/**");
		ir.addPathPatterns("/adm/member/login");
		ir.addPathPatterns("/adm/member/doLogin");
		ir.addPathPatterns("/adm/member/findLoginId");
		ir.addPathPatterns("/adm/member/doFindLoginId");
		ir.addPathPatterns("/adm/member/findLoginPw");
		ir.addPathPatterns("/adm/member/doFindLoginPw");

		// 로그인 상태에서 접속할 수 없는 URI 기술
		ir = registry.addInterceptor(needLogoutInterceptor);
		ir.addPathPatterns("/usr/member/login");
		ir.addPathPatterns("/usr/member/doLogin");
		ir.addPathPatterns("/usr/member/getLoginIdDup");
		ir.addPathPatterns("/usr/member/join");
		ir.addPathPatterns("/usr/member/doJoin");
		ir.addPathPatterns("/usr/member/findLoginId");
		ir.addPathPatterns("/usr/member/doFindLoginId");
		ir.addPathPatterns("/usr/member/findLoginPw");
		ir.addPathPatterns("/usr/member/doFindLoginPw");
		
		// admin 로그인 상태에서 접속할 수 없는 URI 기술
		ir = registry.addInterceptor(needAdminInterceptor);
		ir.addPathPatterns("/adm/**");
		ir.addPathPatterns("/adm/member/login");
		ir.addPathPatterns("/adm/member/doLogin");
		ir.addPathPatterns("/adm/member/findLoginId");
		ir.addPathPatterns("/adm/member/doFindLoginId");
		ir.addPathPatterns("/adm/member/findLoginPw");
		ir.addPathPatterns("/adm/member/doFindLoginPw");

	}
}
