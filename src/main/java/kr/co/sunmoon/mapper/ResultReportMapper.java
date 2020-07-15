package kr.co.sunmoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;

public interface ResultReportMapper {
	public List<ResultReportVO> getList(@Param("year") String year, @Param("semester") String semester,
				@Param("subjectname") String subjectname, @Param("division") String division);
	
	public ResultReportVO rsRead(@Param("bno") int bno, @Param("teamno") int teamno);
	
	//result_subjects_tbl PK(bno) 가져오기
	public int subjectNum(@Param("year") String year, @Param("semester") String semester,
			@Param("subjectname") String subjectname, @Param("division") String division);
	
	public List<ResultReportTeamVO> rsTeamRead(int teamno);
	
	//insert
	public void resultReportInsert(ResultReportVO vo); // 결과보고 데이터 insert
	public void resultCompanyConnInsert(ResultReportVO vo); //최종기업연계 데이터 insert
	public void resultTeamInsert(ResultReportTeamVO vo); //최종팀원 데이터 insert
	
	//update
	public int resultReportUpdate(ResultReportVO vo); // 결과보고 데이터 update
	public int resultCompanyConnUpdate(ResultReportVO vo); //최종기업연계 데이터 update
	public int resultTeamUpdate(ResultReportTeamVO teamVO); //최종팀원 데이터 update
	
	//delete
	public int resultReportDelete(int teamno); // 결과보고 데이터 delete
	public int resultCompanyConnDelete(int teamno); // 결과보고 데이터 delete
	public int resultTeamDelete(int rtkey); // 결과보고 데이터 delete
	
	//과목명 리스트
	public List<ResultReportVO> subRead();
	
	//팀원 수
	public int teamCount(int teamno);
	
	//승인상태 변경
	public int approvalUpdate(@Param("teamno") int teamno, @Param("approval") String approval);
}
