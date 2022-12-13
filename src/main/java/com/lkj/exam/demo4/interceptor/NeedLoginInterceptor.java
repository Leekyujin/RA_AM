package com.lkj.exam.demo4.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.lkj.exam.demo4.vo.Rq;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor{
	@Autowired
	private Rq rq;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		// 이 인터셉터 실행 전에 beforeActionInterceptor 가 실행되고 거기서 isLogined 라는 속성 생성
		// 그래서 여기서 단순히 rq.isLogined() 를 통해 로그인 여부를 알 수 있음
		if (!rq.isLogined()) {
			if (rq.isAjax()) {
				resp.setContentType("application/json; charset=UTF-8");
				resp.getWriter().append("{\"resultCode\":\"F-A\",\"msg\":\"로그인 후 이용해주세요.\"}");
			} else {
				String afterLoginUri = rq.getAfterLoginUri();
				rq.printReplaceJs("로그인 후 이용해주세요", "/usr/member/login?afterLoginUri=" + afterLoginUri);
			}
			return false;
		}
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}
