package kr.co.sunmoon.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.sunmoon.domain.ResultReportTeamDTO;
import kr.co.sunmoon.domain.ResultReportTeamVO;
import kr.co.sunmoon.domain.ResultReportVO;
import kr.co.sunmoon.service.ApplySupportService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/apply_support/*")
@Log4j
@AllArgsConstructor
public class ApplySupportController {
	private ApplySupportService applySupportService;
	
	@GetMapping("/cdims_apply_support")
	@PreAuthorize("isAuthenticated()")
	public void list(Model model) {
		model.addAttribute("subname", applySupportService.subRead());
	}

	@GetMapping("cdims_apply_support_write")
	@PreAuthorize("isAuthenticated()")
	public void getRegister(Model model) {
		model.addAttribute("subname", applySupportService.subRead());
	}

	@PostMapping("/cdims_apply_support_write")
	@PreAuthorize("isAuthenticated()")
	public String register(ResultReportVO resultVO, ResultReportTeamDTO teamList) {
		log.info("register resultVO : " + resultVO);
		log.info("register teamList : " + teamList);

		applySupportService.applySupportInsert(resultVO, teamList);

		return "redirect:/apply_support/cdims_apply_support";
	}

	@GetMapping("/cdims_apply_support_get")
	@PreAuthorize("isAuthenticated()")
	public void get(ResultReportVO resultVO, Model model) {
		log.info("get resultVO bno : " + resultVO.getBno() + ", teamno : " + resultVO.getTeamno());
		log.info("get resultVO : " + resultVO);

		ResultReportVO result = applySupportService.asRead(resultVO.getBno(), resultVO.getTeamno());

		List<ResultReportTeamVO> teamList = applySupportService.asTeamRead(resultVO.getTeamno());

		model.addAttribute("resultvo", result);
		model.addAttribute("teamList", teamList);
		
	}
	
	@GetMapping("/cdims_apply_support_update")
	@PreAuthorize("isAuthenticated()")
	public void modify(ResultReportVO resultVO, Model model) {
		log.info("modify resultVO bno : " + resultVO.getBno() + ", teamno : " + resultVO.getTeamno());

		ResultReportVO result = applySupportService.asRead(resultVO.getBno(), resultVO.getTeamno());

		List<ResultReportTeamVO> teamList = applySupportService.asTeamRead(resultVO.getTeamno());

		log.info("get modify result : " + result);
		log.info("get modify teamList : " + teamList);
		model.addAttribute("resultvo", result);
		model.addAttribute("teamList", teamList);
		model.addAttribute("subname", applySupportService.subRead());
		model.addAttribute("count", applySupportService.teamCount(resultVO.getTeamno()));
	}

	@PostMapping("/cdims_apply_support_update")
	@PreAuthorize("principal.username == #resultVO.writer")
	public String modify(ResultReportVO resultVO, ResultReportTeamDTO teamList) {
		log.info("post modify resultVO : " + resultVO);
		log.info("post modify teamList : " + teamList);
		
		applySupportService.applySupportUpdate(resultVO, teamList);
		
		return "redirect:/apply_support/cdims_apply_support";
	}

	@PostMapping("/cdims_apply_support_delete")
	public String delete(ResultReportVO resultVO) {
		log.info("post delete resultVO : " + resultVO);
		
		applySupportService.applySupportDelete(resultVO);
		
		return "redirect:/apply_support/cdims_apply_support";
	}
}
