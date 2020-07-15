package kr.co.sunmoon.domain;

import lombok.Data;

@Data
public class ResultReportTeamVO {
	private int rtkey; //팀원 번호
	private int teamno; //팀 번호
	private String department; 
	private String studentId; 
	private String grade; 
	private String name; 
	private String phoneNumber; 
	private String email; 
}
