package kr.co.sunmoon.mapper;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ResultReportMapperTests {
	@Setter(onMethod_ = @Autowired)
	private ResultReportMapper mapper;
	
	
//	@Test
//	public void testRead() {
//		ResultReportVO vo = mapper.rsRead(1, 38);
//		log.info(vo);
//		
//		// ResultReportVO 데이터 출력이 안될 경우 다 출력해보기		
//		log.info("BNO : ! " + vo.getBno());
//		log.info("TEAMNO : ! " + vo.getTeamno());
//		
//		List<ResultReportTeamVO> teamVO = mapper.rsTeamRead(vo.getTeamno());
//		teamVO.forEach(team -> log.info(team));
//	}
	
//	@Test
//	public void testGetList() {
//		List<ResultReportVO> vo = mapper.getList("2019", "1", "모바일프로젝트", "11");
//		vo.forEach(list -> log.info(list));
//	}
	
//	@Test
//	public void testInsert() {
//		ResultReportVO vo = new ResultReportVO();
//		vo.setBno(1L);
//		vo.setTeamName("팀명테스트2");
//		vo.setAssignType("과제유형테스트2");
//		vo.setProjectTitle("과제명테스트2");
//		vo.setApplyFee("지원신청금테스트2");
//		vo.setWriter("작성자테스트2");
//		vo.setApproval("승인여부테스트2");
//		
//		mapper.resultReportInsert(vo);
////		log.info("RESULT : " + );
//		log.info("TEAM NUMBER : " + vo.getTeamno());
//		
//		vo.setType("연계형태테스트2");
//		vo.setCompany("기관명 테스트2");
//		vo.setCeo("대표자 테스트2");
//		vo.setLicense("사업자등록번호 테스트2");
//		vo.setBusiness("업종 테스트2");
//		vo.setPostcode("우편번호 테스트2");
//		vo.setAddress("주소 테스트2");
//		mapper.resultCompanyConnInsert(vo);
//		log.info("TEAM NUMBER2 : " + vo.getTeamno());
//		
//		ResultReportTeamVO teamVO = new ResultReportTeamVO();
//		
//		for (int i = 0; i < 4; i++) {
//			teamVO.setTeamno(vo.getTeamno());
//			teamVO.setDepartment("소속학과 테스트" + i);
//			teamVO.setStudentId("학번테스트" + i);
//			teamVO.setGrade("학년테스트" + i);
//			teamVO.setName("이름테스트" + i);
//			teamVO.setPhoneNumber("핸드폰번호테스트" + i);
//			teamVO.setEmail("이메일테스트" + i);
//			
//			mapper.resultTeamInsert(teamVO);
//		}
//
//	}
	
//	@Test
//	public void testUpdate() {
//		ResultReportVO vo = new ResultReportVO();
//		vo.setTeamno(36);
//		vo.setBno(1);
//		vo.setTeamName("13's");
//		vo.setAssignType("일반형");
//		vo.setProjectTitle("통합관리해버리쥬");
//		vo.setApplyFee("15만원");
//		vo.setWriter("박헌진이다잇");
//		vo.setApproval("승인대기");
//		
//		vo.setType("연계형");
//		vo.setCompany("유플러스에이티라잇");
//		vo.setCeo("이상아상아");
//		vo.setLicense("122212-3213123");
//		vo.setBusiness("SM/SI");
//		vo.setPostcode("2333-33");
//		vo.setAddress("천안 서북구");
//		
//		ResultReportTeamVO teamVO = new ResultReportTeamVO();
//		teamVO.setRtkey(2);
//		teamVO.setTeamno(36);
//		teamVO.setDepartment("정보통신공학과");
//		teamVO.setStudentId("2017380112");
//		teamVO.setGrade("2");
//		teamVO.setName("김신철");
//		teamVO.setPhoneNumber("010-3432-4324");
//		teamVO.setEmail("dasd@dasdals.com");
//		
//		mapper.resultReportUpdate(vo);
//		mapper.resultCompanyConnUpdate(vo);
//		mapper.resultTeamUpdate(teamVO);
//		
//	}
	
//	@Test
//	public void testDelete() {
//		// 순서 중요		
//		mapper.resultCompanyConnDelete(36);
//		mapper.resultTeamDelete(2);
//		mapper.resultReportDelete(36);
//	}
	
	@Test
	public void testSubjectNum() {
		int num = mapper.subjectNum("2020", "1", "객체지향프로젝트", "11");
		log.info(num);
	}
	
	
}
