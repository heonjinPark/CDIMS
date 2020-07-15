package kr.co.sunmoon.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.sunmoon.domain.ResultReportTeamDTO;
import kr.co.sunmoon.domain.ResultReportTeamVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ResultReportServiceTests {
	@Setter(onMethod_ = @Autowired)
	private ResultReportService resultReportService;
	
//	@Test
//	public void getListTest() {
//		resultReportService.getList("2019", "1", "종합프로젝트", "11");
//	}
	
//	@Test
//	public void readTest() {	
//		resultReportService.rsRead(1, 37);
//		resultReportService.rsTeamRead(37);
//	}
	
//	@Test
//	public void insertTest() {
//		ResultReportVO vo = new ResultReportVO();
//		vo.setBno(1);
//		vo.setTeamName("팀명테스트21");
//		vo.setAssignType("과제유형테스트21");
//		vo.setProjectTitle("과제명테스트21");
//		vo.setApplyFee("지원신청금테스트21");
//		vo.setWriter("작성자테스트21");
//		vo.setApproval("승인여부테스트21");
//		
//		log.info("TEAM NUMBER : " + vo.getTeamno());
//		
//		vo.setType("연계형태테스트21");
//		vo.setCompany("기관명 테스트21");
//		vo.setCeo("대표자 테스트21");
//		vo.setLicense("사업자등록번호 테스트21");
//		vo.setBusiness("업종 테스트21");
//		vo.setPostcode("우편번호 테스트21");
//		vo.setAddress("주소 테스트21");
//		
//		log.info("TEAM NUMBER2 : " + vo.getTeamno());
//		
//		ResultReportTeamVO teamVo = new ResultReportTeamVO();
//		
//		for (int i = 0; i < 4; i++) {
//			teamVo.setTeamno(vo.getTeamno());
//			teamVo.setDepartment("소속학과 테스트!!" + i);
//			teamVo.setStudentId("학번테스트!!" + i);
//			teamVo.setGrade("학년테스트!!" + i);
//			teamVo.setName("이름테스트!!" + i);
//			teamVo.setPhoneNumber("핸드폰번호테스트!!" + i);
//			teamVo.setEmail("이메일테스트!!" + i);
//			
////			mapper.resultTeamInsert(teamVO);
//		}
//		
//		resultReportService.resultReportInsert(vo, teamVo);
//		
//		log.info("TEAM NUMBER3 : " + vo.getTeamno());
//		
//	}
	
	
//	@Test
//	public void modifyTest() {
//		ResultReportVO vo = new ResultReportVO();
//		vo.setBno(1);
//		vo.setTeamno(61);
//		vo.setTeamName("팀명테스트5");
//		vo.setAssignType("과제유형테스트5");
//		vo.setProjectTitle("과제명테스트5");
//		vo.setApplyFee("지원신청금테스트5");
//		vo.setWriter("작성자테스트5");
//		vo.setApproval("승인여부테스트5");
//		
//		log.info("TEAM NUMBER : " + vo.getTeamno());
//		
//		vo.setType("연계형태테스트5");
//		vo.setCompany("기관명 테스트5");
//		vo.setCeo("대표자 테스트5");
//		vo.setLicense("사업자등록번호 테스트5");
//		vo.setBusiness("업종 테스트5");
//		vo.setPostcode("우편번호 테스트5");
//		vo.setAddress("주소 테스트5");
//		
//		log.info("TEAM NUMBER2 : " + vo.getTeamno());
//		
//		ResultReportTeamVO teamVo = new ResultReportTeamVO();
//		teamVo.setRtkey(26);
//		
//		for (int i = 0; i < 4; i++) {
//			teamVo.setDepartment("소속학과 테스트5" + i);
//			teamVo.setStudentId("학번테스트5" + i);
//			teamVo.setGrade("학년테스트5" + i);
//			teamVo.setName("이름테스트5" + i);
//			teamVo.setPhoneNumber("핸드폰번호테스트5" + i);
//			teamVo.setEmail("이메일테스트5" + i);
//			
//		}
//		
//		resultReportService.resultReportUpdate(vo, teamVo);
//		
//		log.info("TEAM NUMBER3 : " + vo.getTeamno());
//	}
	
//	@Test
//	public void deleteTest() {
//		resultReportService.resultReportDelete(61, 26);
//	}
	
	
//	@Test
//	public void subReadTest() {
//		resultReportService.subRead();
//	}
	
	@Test
	public void insertTest() {
		ResultReportTeamVO vo = new ResultReportTeamVO();
		ResultReportTeamDTO dto = new ResultReportTeamDTO();
		
		
	}
	
	
}
