package kr.co.sunmoon.service;

import java.util.List;

import kr.co.sunmoon.domain.ResultReportTeamDTO;
import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;

public interface ApplySupportService {
	
	public List<ResultReportVO> getList(String year, String semester, String subjectname, String division);

	public ResultReportVO asRead(int bno, int teamno); // 해당 지원신청서 정보 가져옴

	public List<ResultReportTeamVO> asTeamRead(int teamno); // 팀 리스트 불러옴

	
	public void applySupportInsert(ResultReportVO vo, ResultReportTeamDTO teamVo);

	public boolean applySupportUpdate(ResultReportVO vo, ResultReportTeamDTO teamVo); 

	public boolean applySupportDelete(ResultReportVO resultVO);
	
	
	public List<ResultReportVO> subRead(); // 과목 리스트 불러옴
	
	public int teamCount(int teamno);
	
	public int approvalUpdate(int teamno, String approval);
}
