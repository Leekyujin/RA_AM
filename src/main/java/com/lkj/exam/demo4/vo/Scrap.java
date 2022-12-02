package com.lkj.exam.demo4.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Scrap {
	int id;
	String regDate;
	String updateDate;
	int relId;
	int memberId;
	int loginedMemberId;
	String title;
	String body;
	int scraped;
	
	private String extra__writerName;
	
	public String getForPrintType1RegDate() {
		return regDate.substring(2, 16).replace(" ", "<br />");
	}
}
