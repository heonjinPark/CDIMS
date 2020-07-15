package kr.co.sunmoon.mapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.domain.ReplyVO;
import kr.co.sunmoon.service.CommunityReplyService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CommunityReplyMapperTests {
	@Setter(onMethod_ = @Autowired)
	private CommunityReplyService service;
	
//	@Test
//	public void registerTest() {
//		ReplyVO vo = new ReplyVO();
//		vo.setBno(192L);
//		vo.setReply("지원금은 다 써야 하나요?");
//		vo.setReplyer("박수빈");
//		
//		service.register(vo);
//	}
	
//	@Test
//	public void getTest() {
//		service.get(7L);
//		
//	}
	
//	@Test
//	public void modifyTest() {
//		ReplyVO vo = new ReplyVO();
//		vo.setRno(7L);
//		vo.setReply("지원금은 다 써야 하나요? 수정");
//		
//		service.modify(vo);
//		
//	}
	
//	@Test
//	public void modifyTest() {
//		service.remove(7L);
//		
//	}
	
	@Test
	public void modifyTest() {
		Criteria cri = new Criteria();
		
		service.getListPage(cri, 192L);
		
	}
}
