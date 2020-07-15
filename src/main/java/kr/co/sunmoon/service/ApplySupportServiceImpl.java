package kr.co.sunmoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sunmoon.domain.ResultReportTeamDTO;
import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;
import kr.co.sunmoon.mapper.ApplySupportMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ApplySupportServiceImpl implements ApplySupportService {
	@Setter(onMethod_ = @Autowired)
	private ApplySupportMapper applysupportMapper;

	@Override
	public List<ResultReportVO> getList(String year, String semester, String subjectname, String division) {
		log.info("getList year : " + year + ", semester : " + semester + ", subjectname" + subjectname + ", division : "
				+ division);

		return applysupportMapper.getList(year, semester, subjectname, division);
	}

	@Override
	public ResultReportVO asRead(int bno, int teamno) { // 해당 지원신청서 정보 가져옴
		log.info("rsRead bno : " + bno + ", teamno : " + teamno);

		return applysupportMapper.asRead(bno, teamno);
	}

	@Override
	public List<ResultReportTeamVO> asTeamRead(int teamno) { // 팀 리스트 불러옴
		log.info("rsTeamRead teamno : " + teamno);
		
		return applysupportMapper.asTeamRead(teamno);
	}

	@Override
	public void applySupportInsert(ResultReportVO vo, ResultReportTeamDTO teamVo) {
		int subjectBno = applysupportMapper.subjectNum(vo.getYear(), vo.getSemester(), vo.getSubjectName(),
				vo.getDivision());

		log.info("subjectBno : " + subjectBno);
		log.info("resultReportInsert vo" + vo + ", teamVo : " + teamVo);

		vo.setBno(subjectBno);
		applysupportMapper.applySupportInsert(vo);
		applysupportMapper.applyCompanyConnInsert(vo);

		for (ResultReportTeamVO team : teamVo.getTeamList()) {
			team.setTeamno(vo.getTeamno());
			applysupportMapper.applyTeamInsert(team);
		}

	}
	
	@Override
	public boolean applySupportUpdate(ResultReportVO vo, ResultReportTeamDTO teamVo) {
		log.info("UPDATE resultReportUPDATE vo" + vo + ", teamVo : " + teamVo);
		
		List<ResultReportTeamVO> persisList = applysupportMapper.asTeamRead(vo.getTeamno());
		
		log.info("persisList Size : " + persisList.size());
		log.info("teamVo Size : " + teamVo.getTeamList().size());
		
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
				applysupportMapper.applyTeamDelete(persisList.get(i).getRtkey());
			}
		}
		
		// 팀원 추가 로직
		for (int i = 0; i < teamVo.getTeamList().size(); i++) {
			if (teamVo.getTeamList().get(i).getRtkey() == 0) { // 키값이 존재하지 않으면 팀원 추가
				teamVo.getTeamList().get(i).setTeamno(vo.getTeamno());
				applysupportMapper.applyTeamInsert(teamVo.getTeamList().get(i));
			}
		}
		
		applysupportMapper.applySupportUpdate(vo);
		applysupportMapper.applyCompanyConnUpdate(vo);
		for (ResultReportTeamVO team : teamVo.getTeamList()) {
			team.setTeamno(vo.getTeamno());
			applysupportMapper.applyTeamUpdate(team);
		}

		return true;
	}


	@Override
	public boolean applySupportDelete(ResultReportVO resultVO) {
		log.info("resultReportDelete resultVO : " + resultVO);
		
//		delete 할 때에는 무결성 관련해서 삭세 순서가 중요
		for (ResultReportTeamVO teamno : applysupportMapper.asTeamRead(resultVO.getTeamno())) {
			applysupportMapper.applyTeamDelete(teamno.getRtkey());
		}
		applysupportMapper.applyCompanyConnDelete(resultVO.getTeamno());
		applysupportMapper.applySupportDelete(resultVO.getTeamno());

		return true;
	}

	@Override
	public List<ResultReportVO> subRead() { // 과목 리스트 불러옴
		return applysupportMapper.subRead();
	}

	@Override
	public int teamCount(int teamno) {
		log.info("teamcount : " + teamno);
		
		return applysupportMapper.teamCount(teamno);
	}

	@Override
	public int approvalUpdate(int teamno, String approval) {
		log.info("approvalUpdate teamno : " + teamno + ", approval : " + approval);
		
		return applysupportMapper.approvalUpdate(teamno, approval); 
	}
	

}
