package kr.co.sunmoon.mapper;

import java.util.List;

import kr.co.sunmoon.domain.BoardAttachVO;

// 양식서류 첨부파일 mapper
public interface FDAttachMapper {
	
	public void insert(BoardAttachVO vo);
	 
	public void delete(String uuid);	
	
	public List<BoardAttachVO> findByBno(Long bno);
	
	public void deleteAll(Long bno);
}
