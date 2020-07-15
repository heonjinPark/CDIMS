package kr.co.sunmoon.service;

import java.util.List;

import kr.co.sunmoon.domain.BoardAttachVO;
import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;

public interface FormDocumentService {
	
	public List<BoardVO> getList(Criteria cri); 
	
	public void register(BoardVO board); 

	public BoardVO get(Long bno); 

	public boolean modify(BoardVO board); 

	public boolean remove(Long bno); 

	public int getTotal(Criteria cri);

	public List<BoardAttachVO> getAttachList(Long bno);
}
