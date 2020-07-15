package kr.co.sunmoon.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.sunmoon.domain.BoardAttachVO;
import kr.co.sunmoon.domain.ResultReportTeamDTO;
import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;
import kr.co.sunmoon.service.ResultReportService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/result_report/*")
@Log4j
@AllArgsConstructor
public class ResultReportController {
	private ResultReportService resultReportService;
	
	@GetMapping("/cdims_result_report")
	@PreAuthorize("isAuthenticated()")
	public void list(Model model) {
		model.addAttribute("subname", resultReportService.subRead());
	}

	@GetMapping("cdims_result_report_write")
	@PreAuthorize("isAuthenticated()")
	public void getRegister(Model model) {
		model.addAttribute("subname", resultReportService.subRead());
	}

	@PostMapping("/cdims_result_report_write")
	@PreAuthorize("isAuthenticated()")
	public String register(ResultReportVO resultVO, ResultReportTeamDTO teamList) {
		log.info("post register resultVO : " + resultVO + ", teamList : " + teamList);
		
		log.info("attach list : " + resultVO.getAttachList());
		if (resultVO.getAttachList() != null) {
			resultVO.getAttachList().forEach(attach -> log.info("attach : " + attach));
		}

		resultReportService.resultReportInsert(resultVO, teamList);

		return "redirect:/result_report/cdims_result_report";
	}

	@GetMapping("/cdims_result_report_get")
	@PreAuthorize("isAuthenticated()")
	public void get(ResultReportVO resultVO, Model model) {
		log.info("get get : " + resultVO.getBno() + ", teamno : " + resultVO.getTeamno());
		log.info("resultVO : " + resultVO);

		ResultReportVO result = resultReportService.rsRead(resultVO.getBno(), resultVO.getTeamno());

		List<ResultReportTeamVO> teamList = resultReportService.rsTeamRead(resultVO.getTeamno());

		log.info("get result : " + result + ", teamList : " + teamList);
		model.addAttribute("resultvo", result);
		model.addAttribute("teamList", teamList);
		
	}
	
	@GetMapping("/cdims_result_report_update")
	@PreAuthorize("isAuthenticated()")
	public void modify(ResultReportVO resultVO, Model model) {
		log.info("get modify bno : " + resultVO.getBno() + ", teamno : " + resultVO.getTeamno());

		ResultReportVO result = resultReportService.rsRead(resultVO.getBno(), resultVO.getTeamno());

		List<ResultReportTeamVO> teamList = resultReportService.rsTeamRead(resultVO.getTeamno());

		log.info("get modify result : " + result + ", teamList : " + teamList);
		model.addAttribute("resultvo", result);
		model.addAttribute("teamList", teamList);
		model.addAttribute("subname", resultReportService.subRead());
		model.addAttribute("count", resultReportService.teamCount(resultVO.getTeamno()));
		
	}

	@PostMapping("/cdims_result_report_update")
	@PreAuthorize("principal.username == #resultVO.writer")
	public String modify(ResultReportVO resultVO, ResultReportTeamDTO teamList) {
		log.info("post modify result : " + resultVO + ", teamList : " + teamList);
		
		resultReportService.resultReportUpdate(resultVO, teamList);
		
		return "redirect:/result_report/cdims_result_report";
	}

	@PostMapping("/cdims_result_report_delete")
	public String delete(ResultReportVO resultVO) {
		log.info("post delete resultVO : " + resultVO);
		
		List<BoardAttachVO> attachList = resultReportService.getAttachList(resultVO.getTeamno());
		
		deleteFiles(attachList); // delete Attach Files
		
		resultReportService.resultReportDelete(resultVO);
		
		return "redirect:/result_report/cdims_result_report";
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int teamno) {
		log.info("getAttachList : " + teamno);
		
		return new ResponseEntity<>(resultReportService.getAttachList(teamno), HttpStatus.OK); // 해당 게시물 첨부파일 리스트 가져옴
	}
	
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if (attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files...");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("/Users/parkheonjin/Desktop/upload/formDoc/" +
						attach.getUploadPath() + "/" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);
				log.info("FILE PATH : " + file);

			} catch (Exception e) {
				log.error("delete file error : " + e.getMessage());
			} //end catch
		}); //end foreach
	}
}
