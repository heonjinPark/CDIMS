package kr.co.sunmoon.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.co.sunmoon.domain.ResultReportVO;
import kr.co.sunmoon.service.ApplySupportService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/apply_support")
public class ApplySupportRestController {
	private ApplySupportService applySupportService;
	
	@GetMapping(value = "/list/{year}/{semester}/{subjectname}/{division}",
			produces = {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ResultReportVO>> getList(@PathVariable("year") String year, @PathVariable("semester") String semester,
			@PathVariable("subjectname") String subjectname, @PathVariable("division") String division) {
		
		log.info("getList year : " + year + ", " + "semester : " + semester + "," + "subject : " + subjectname + "," + "division: " + division);
		
		return new ResponseEntity<>(applySupportService.getList(year, semester, subjectname, division), HttpStatus.OK);
	}
	
	@RequestMapping(method={RequestMethod.PUT, RequestMethod.PATCH}, value="/{teamno}/{approval}",
			consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> approvalUpdate(@PathVariable("teamno") int teamno, @PathVariable("approval") String approval) {
		log.info("approvalUpdate teamno : " + teamno + ", approval : " + approval);
		
		
		return applySupportService.approvalUpdate(teamno, approval) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) :
			new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}