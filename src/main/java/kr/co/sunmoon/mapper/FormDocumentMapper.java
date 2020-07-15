package kr.co.sunmoon.mapper;

import java.util.List;

import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;

public interface FormDocumentMapper {
	
	public List<BoardVO> getListwithPaging(Criteria cri);
	
	public void insertSelectKey(BoardVO board);

	public BoardVO read(Long bno);

	public int delete(Long bno);

	public int update(BoardVO board);

	public int getTotalCount(Criteria cri);
}
