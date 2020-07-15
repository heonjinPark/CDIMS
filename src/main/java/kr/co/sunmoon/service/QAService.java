package kr.co.sunmoon.service;

import java.util.List;

import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;

public interface QAService {
	
	public void register(BoardVO board); 

	public BoardVO get(Long bno); 

	public boolean modify(BoardVO board); 

	public boolean remove(Long bno); 

	public List<BoardVO> getList(Criteria cri); 

	public int getTotal(Criteria cri);
}
