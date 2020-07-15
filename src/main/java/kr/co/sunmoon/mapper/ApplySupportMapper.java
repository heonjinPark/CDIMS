package kr.co.sunmoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;

public interface ApplySupportMapper {
	public List<ResultReportVO> getList(@Param("year") String year, @Param("semester") String semester,
				@Param("subjectname") String subjectname, @Param("division") String division);
	
	public ResultReportVO asRead(@Param("bno") int bno, @Param("teamno") int teamno);
	
	//과목 PK 번호 가져오기
	public int subjectNum(@Param("year") String year, @Param("semester") String semester,
			@Param("subjectname") String subjectname, @Param("division") String division);
	
	public List<ResultReportTeamVO> asTeamRead(int teamno);
	
	//insert
	public void applySupportInsert(ResultReportVO vo); // 결과보고 데이터 insert
	public void applyCompanyConnInsert(ResultReportVO vo); //최종기업연계 데이터 insert
	public void applyTeamInsert(ResultReportTeamVO vo); //최종팀원 데이터 insert
	
	//update
	public int applySupportUpdate(ResultReportVO vo); // 결과보고 데이터 update
	public int applyCompanyConnUpdate(ResultReportVO vo); //최종기업연계 데이터 update
	public int applyTeamUpdate(ResultReportTeamVO teamVO); //최종팀원 데이터 update
	
	//delete
	public int applySupportDelete(int teamno); // 결과보고 데이터 delete
	public int applyCompanyConnDelete(int teamno); // 결과보고 데이터 delete
	public int applyTeamDelete(int rtkey); // 결과보고 데이터 delete
	
	//과목명 리스트
	public List<ResultReportVO> subRead();
	
	//팀원 수
	public int teamCount(int teamno);
	
	//승인상태 변경
	public int approvalUpdate(@Param("teamno") int teamno, @Param("approval") String approval);
}
