package kr.co.sunmoon.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.mapper.NoticeMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	
//	@Test
//	public void testGetList() {
//		Criteria cri = new Criteria(2, 10);
//		mapper.getListwithPaging(cri);
//		
//	}
	
//	@Test
//	public void testRead() {
//		mapper.read(895L);
//	}
	
//	@Test
//	public void testDelete() {
//		mapper.delete(896L);
//	}
	
//	@Test
//	public void testModify() {
//		BoardVO vo = new BoardVO();
//		vo.setBno(895L);
//		vo.setTitle("수정합니다");
//		vo.setContent("내용을 수정하는 테스트입니다");
//		vo.setWriter("유저00");
//		mapper.update(vo);
//	}
	
	@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("추가하는 제목입니다");
		vo.setContent("추가하는 내용입니다");
		vo.setWriter("유저01");
		
		mapper.insertSelectKey(vo);
	}
	
	
	
	
	
}
