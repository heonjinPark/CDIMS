package kr.co.sunmoon.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CommunityReplyServiceTests {
	@Setter(onMethod_ = @Autowired)
	private NoticeService noticeService;
	
//	@Test
//	public void registerServiceTest() {
//		BoardVO vo = new BoardVO();
//		vo.setTitle("testTitle");
//		vo.setContent("testContent");
//		vo.setWriter("testUser00");
//		
//		noticeService.register(vo);
//	}
	
//	@Test
//	public void getServiceTest() {
//		noticeService.get(897L);
//	}
	
//	@Test
//	public void modifyServiceTest() {
//		BoardVO vo = new BoardVO();
//		
//		vo.setBno(889L);
//		vo.setTitle("modifyTestTitle");
//		vo.setContent("modifyTestContent");
//		vo.setWriter("user01");
//		
//		noticeService.modify(vo);
//	}
	
//	@Test
//	public void removeServiceTest() {
//		noticeService.remove(898L);
//	}
	
	@Test
	public void getListServiceTest() {
		Criteria cri = new Criteria();
		
		noticeService.getList(cri);
	}
	
	
	
	
}
