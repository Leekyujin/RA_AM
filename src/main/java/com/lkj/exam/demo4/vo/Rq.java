package com.lkj.exam.demo4.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.lkj.exam.demo4.service.MemberService;
import com.lkj.exam.demo4.util.Ut;

import lombok.Getter;

@Component
@Scope(value="request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;
	
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;

	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {
		
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();
		
		isLogined = false;
		loginedMemberId = 0;
		loginedMember = null;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		
		this.req.setAttribute("rq", this);
	}
	
	public void printHistoryBackJs(String msg) throws IOException{
		
		resp.setContentType("text/html; charset=UTF-8");

		print(Ut.jsHistoryBack(msg));
	}

	public void print(String str) throws IOException {
		
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void println(String str) throws IOException {
		
		print(str + "\n");
	}
	
	public void login(Member member) {
		
		session.setAttribute("loginedMemberId", member.getId());
	}

	public void logout() {
		
		session.removeAttribute("loginedMemberId");
	}
	
	public boolean isNotLogined() {
		return !isLogined;
	}
	
	public String jsHistoryBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		
		return "usr/common/js";
	}
	
	public String jsHistoryBack(String msg) {
		return Ut.jsHistoryBack(msg);
	}

	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}
	
	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		if(queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}

	public String getEncodedCurrentUri() {

		return Ut.getUriEncoded(getCurrentUri());
	}
	
	public void initOnBeforeActionInterceptor() {

	}

}
