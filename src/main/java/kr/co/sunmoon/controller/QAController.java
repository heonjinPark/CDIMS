package kr.co.sunmoon.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.domain.PageDTO;
import kr.co.sunmoon.service.QAService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/community/*")
@AllArgsConstructor
public class QAController {
	private QAService qaService;
	
	@GetMapping("/cdims_qa")
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
		
		log.info("getList : " + qaService.getList(cri));
		model.addAttribute("list", qaService.getList(cri)); //목록 데이터 전달
		
		int total = qaService.getTotal(cri);
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total)); //페이징 처리 데이터 전달
	}
	
	@PostMapping("/cdims_qa_write")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register : " + board);
		
		qaService.register(board);
		
		rttr.addFlashAttribute("result", board.getBno()); //list에서 등록 성공 모달창에 출력할 게시글 번호 전달
		
		return "redirect:/community/cdims_qa";
	}
	
	@GetMapping("/cdims_qa_write")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	@GetMapping({"/cdims_qa_get", "/cdims_qa_update"})
	@PreAuthorize("isAuthenticated()")
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model, String writer) {
		log.info("/cdims_qa_get or cdims_qa_update");
		model.addAttribute("board", qaService.get(bno));
	}

	@PostMapping("/cdims_qa_update")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("cdims_qa_update : " + board);
		
		if (qaService.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());
		
		return "redirect:/community/cdims_qa" + cri.getListLink();
	}
	
	@PostMapping("/cdims_qa_delete")
	@PreAuthorize("principal.username == #writer")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, 
			RedirectAttributes rttr, String writer) {
		log.info("/cdims_qa_remove");
		
		if (qaService.remove(bno)) {
			rttr.addAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());
		
		return "redirect:/community/cdims_qa" + cri.getListLink();
	}

}
