package kr.co.sunmoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sunmoon.domain.BoardAttachVO;
import kr.co.sunmoon.domain.ResultReportTeamDTO;
import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;
import kr.co.sunmoon.mapper.RRAttachMapper;
import kr.co.sunmoon.mapper.ResultReportMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ResultReportServiceImpl implements ResultReportService {
	@Setter(onMethod_ = @Autowired)
	private ResultReportMapper resultreportMapper;
	@Setter(onMethod_ = @Autowired)
	private RRAttachMapper rrAttachMapper;

	@Override
	public List<ResultReportVO> getList(String year, String semester, String subjectname, String division) {
		log.info("getList year : " + year + ", semester : " + semester + ", subjectname" + subjectname + ", division : "
				+ division);

		return resultreportMapper.getList(year, semester, subjectname, division);
	}

	@Override
	public ResultReportVO rsRead(int bno, int teamno) { // 해당 결과보고서 정보 가져옴
		log.info("rsRead bno : " + bno + ", teamno : " + teamno);

		return resultreportMapper.rsRead(bno, teamno);
	}

	@Override
	public List<ResultReportTeamVO> rsTeamRead(int teamno) { // 팀 리스트 불러옴
		log.info("rsTeamRead teamno : " + teamno);
		return resultreportMapper.rsTeamRead(teamno);
	}

	@Override
	public void resultReportInsert(ResultReportVO vo, ResultReportTeamDTO teamVo) {
		int subjectBno = resultreportMapper.subjectNum(vo.getYear(), vo.getSemester(), vo.getSubjectName(),
				vo.getDivision());

		log.info("subjectBno : " + subjectBno);
		log.info("resultReportInsert vo" + vo + ", teamVo : " + teamVo);

		vo.setBno(subjectBno);
		resultreportMapper.resultReportInsert(vo);
		resultreportMapper.resultCompanyConnInsert(vo);

		for (ResultReportTeamVO team : teamVo.getTeamList()) {
			team.setTeamno(vo.getTeamno());
			resultreportMapper.resultTeamInsert(team);
		}
		
		if (vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		vo.getAttachList().forEach(attach -> {
			attach.setTeamno(vo.getTeamno());
			rrAttachMapper.insert(attach);
		});

	}
	
	@Override
	public boolean resultReportUpdate(ResultReportVO vo, ResultReportTeamDTO teamVo) {
		log.info("UPDATE resultReportUPDATE vo" + vo + ", teamVo : " + teamVo);
		
		rrAttachMapper.deleteAll(vo.getTeamno());
		
		List<ResultReportTeamVO> persisList = resultreportMapper.rsTeamRead(vo.getTeamno());
		
		log.info("persisList Size : " + persisList.size());
		log.info("teamVo Size : " + teamVo.getTeamList().size());
		log.info("VO ATTACH LIST : " + vo.getAttachList());
		
		boolean teamNumResult; // 팀원 번호가 존재 하는 지 확인하는 변수
		
		// 팀원 삭제 로직
		// client data와 DB data 키 값 비교 후 존재하지 않을 시 DB data delete
		for (int i = 0; i < persisList.size(); i++) {
			teamNumResult = false;
			for (int j = 0; j < teamVo.getTeamList().size(); j++) {
				if (persisList.get(i).getRtkey() == teamVo.getTeamList().get(j).getRtkey()) { 
					teamNumResult = true;
					break;
				}
			}
			
			if (teamNumResult == false) {
				resultreportMapper.resultTeamDelete(persisList.get(i).getRtkey());
			}
		}
		
		// 팀원 추가 로직
		for (int i = 0; i < teamVo.getTeamList().size(); i++) {
			if (teamVo.getTeamList().get(i).getRtkey() == 0) { // 키값이 존재하지 않으면 팀원 추가
				teamVo.getTeamList().get(i).setTeamno(vo.getTeamno());
				resultreportMapper.resultTeamInsert(teamVo.getTeamList().get(i));
			}
		}
		
		resultreportMapper.resultReportUpdate(vo);
		resultreportMapper.resultCompanyConnUpdate(vo);
		for (ResultReportTeamVO team : teamVo.getTeamList()) {
			team.setTeamno(vo.getTeamno());
			resultreportMapper.resultTeamUpdate(team);
		}
		
		if (vo.getAttachList() != null) {
			log.info("file exist");
			vo.getAttachList().forEach(attach -> {

				attach.setTeamno(vo.getTeamno());
				rrAttachMapper.insert(attach);
			});
			
		} else {
			log.info("file not exist");
		}

		return true;
	}


	@Override
	public boolean resultReportDelete(ResultReportVO resultVO) {
		log.info("resultReportDelete resultVO : " + resultVO);
		
		// 해당 게시물 모든 첨부파일 삭제
		rrAttachMapper.deleteAll(resultVO.getTeamno());
		
//		delete 할 때에는 무결성 관련해서 삭세 순서가 중요
		for (ResultReportTeamVO teamno : resultreportMapper.rsTeamRead(resultVO.getTeamno())) {
			resultreportMapper.resultTeamDelete(teamno.getRtkey());
		}
		resultreportMapper.resultCompanyConnDelete(resultVO.getTeamno());
		resultreportMapper.resultReportDelete(resultVO.getTeamno());

		return true;
	}

	@Override
	public List<ResultReportVO> subRead() { // 과목 리스트 불러옴
		return resultreportMapper.subRead();
	}

	@Override
	public int teamCount(int teamno) {
		log.info("teamcount : " + teamno);
		
		return resultreportMapper.teamCount(teamno);
	}

	@Override
	public int approvalUpdate(int teamno, String approval) {
		log.info("approvalUpdate teamno : " + teamno + ", approval : " + approval);
		
		return resultreportMapper.approvalUpdate(teamno, approval); 
	}

	@Override
	public List<BoardAttachVO> getAttachList(int teamno) {
		log.info("get Attach list by bno : " + teamno);
		
		return rrAttachMapper.findByBno(teamno); // 게시물의 첨부 파일 데이터 가져옴
	}
	

}
