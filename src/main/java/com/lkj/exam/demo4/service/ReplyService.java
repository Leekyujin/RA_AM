package com.lkj.exam.demo4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lkj.exam.demo4.repository.ReplyRepository;
import com.lkj.exam.demo4.util.Ut;
import com.lkj.exam.demo4.vo.Reply;
import com.lkj.exam.demo4.vo.ResultData;

@Service
public class ReplyService {
	@Autowired
	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {

		this.replyRepository = replyRepository;
	}

	public ResultData<Integer> writeReply(int actorId, String relTypeCode, int relId, String body) {

		replyRepository.writeReply(actorId, relTypeCode, relId, body);

		int id = replyRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 댓글이 등록되었습니다.", id), "id", id);
	}
	
	public List<Reply> getFroPrintReplies(int actorId, String relTypeCode, int relId) {
		return replyRepository.getFroPrintReplies(actorId, relTypeCode, relId);
	}

}