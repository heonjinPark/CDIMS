package kr.co.sunmoon.service;

import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.domain.ReplyPageDTO;
import kr.co.sunmoon.domain.ReplyVO;

public interface CommunityReplyService {
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
