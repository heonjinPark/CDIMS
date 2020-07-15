package kr.co.sunmoon.mapper;

import java.util.List;

import kr.co.sunmoon.domain.BoardAttachVO;

// 결과보고서 첨부파일 Mapper
public interface RRAttachMapper {

	public void insert(BoardAttachVO vo);

	public void delete(String uuid);	

	public List<BoardAttachVO> findByBno(int teamno);
	
	public void deleteAll(int i);
}
