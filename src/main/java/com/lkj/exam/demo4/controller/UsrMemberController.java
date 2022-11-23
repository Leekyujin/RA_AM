package com.lkj.exam.demo4.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lkj.exam.demo4.service.MemberService;

@Controller
public class UsrMemberController {
	
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name,
			String nickname, String cellphoneNum, String email) {

		memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		return name + "님 회원가입 되었습니다.";
	}
}
