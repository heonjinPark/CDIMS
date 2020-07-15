package kr.co.sunmoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.mapper.CommunityReplyMapper;
import kr.co.sunmoon.mapper.QAMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class QAServiceImpl implements QAService {
	
	@Setter(onMethod_ = @Autowired)
	private QAMapper qaMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CommunityReplyMapper crMapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("register : " + board);
		
		qaMapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get : " + bno);
		
		return qaMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify : " + board);
		
		return qaMapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove : " + bno);
		
//		해당 게시물 댓글 삭제
		crMapper.bnoDelete(bno);
//		해당 게시글 댓글 삭제 후 게시글 삭제 (무결성)
		return qaMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList : " + cri);
		
		return qaMapper.getListwithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("getTotal : " + cri);
		
		return qaMapper.getTotalCount(cri);
	}
	
}
