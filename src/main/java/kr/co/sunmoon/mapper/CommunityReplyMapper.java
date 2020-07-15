package kr.co.sunmoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.domain.ReplyVO;

public interface CommunityReplyMapper {
public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int update(ReplyVO reply);
	
	public int delete(Long rno);
	
	public int bnoDelete(Long bno); // 해당 게시물 댓글 전체 삭제
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno); 
	
	public int getCountByBno(Long bno); 
}
