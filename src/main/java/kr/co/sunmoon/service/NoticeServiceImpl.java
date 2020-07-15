package kr.co.sunmoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.mapper.NoticeMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class NoticeServiceImpl implements NoticeService {
	
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("register : " + board);
		
		noticeMapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get : " + bno);
		
		return noticeMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify : " + board);
		
		return noticeMapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove : " + bno);
		
		return noticeMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList : " + cri);
		
		return noticeMapper.getListwithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("getTotal : " + cri);
		
		return noticeMapper.getTotalCount(cri);
	}
	
}
