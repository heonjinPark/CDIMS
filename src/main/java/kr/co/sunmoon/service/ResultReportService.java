package kr.co.sunmoon.service;

import java.util.List;

import kr.co.sunmoon.domain.BoardAttachVO;
import kr.co.sunmoon.domain.ResultReportTeamDTO;
import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;

public interface ResultReportService {
	
	public List<ResultReportVO> getList(String year, String semester, String subjectname, String division);

	public ResultReportVO rsRead(int bno, int teamno); // 해당 결과보고서 정보 가져옴

	public List<ResultReportTeamVO> rsTeamRead(int teamno);

	
	public void resultReportInsert(ResultReportVO vo, ResultReportTeamDTO teamVo); 

	public boolean resultReportUpdate(ResultReportVO vo, ResultReportTeamDTO teamVo); 

	public boolean resultReportDelete(ResultReportVO resultVO); 
	
	
	public List<ResultReportVO> subRead(); // 과목 리스트 불러옴
	
	public int teamCount(int teamno);
	
	public int approvalUpdate(int teamno, String approval);

	public List<BoardAttachVO> getAttachList(int teamno);
}
