package kr.co.sunmoon.domain;

import java.util.List;

import lombok.Data;

@Data
public class ResultReportVO {
	private int bno; // 번호
	private int teamno; //팀 번호
	private String userid; 
	
	//담당 과목
	private String subjectName; 
	private String division; 
	private String professorCharge; 
	private String year; 
	private String semester; 
	
	//팀 유형
	private String teamName; 
	private String assignType; 
	private String projectTitle; 
	private String applyFee; 
	private String writer; 
	private String approval; 
	
	//기업연계
	private String type; 
	private String company; 
	private String ceo; 
	private String license; 
	private String business; 
	private String postcode; 
	private String address; 
	
	private List<BoardAttachVO> attachList;
}
