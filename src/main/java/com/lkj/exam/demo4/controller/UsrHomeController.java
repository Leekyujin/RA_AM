package com.lkj.exam.demo4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrHomeController {
	
	public UsrHomeController() {
	}
	
	@RequestMapping("/usr/home/main")
	public String showMain() {
		
		return "usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
}


