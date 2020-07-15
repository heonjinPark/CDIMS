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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.sunmoon.domain.BoardAttachVO;
import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.domain.PageDTO;
import kr.co.sunmoon.service.FormDocumentService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/community/*")
@AllArgsConstructor
public class FormDocumentController {
	private FormDocumentService formDocService;

	@GetMapping("/cdims_form_document")
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);

		model.addAttribute("list", formDocService.getList(cri)); // 목록 데이터 전달

		int total = formDocService.getTotal(cri);
		log.info("total : " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total)); // 페이징 처리 데이터 전달
	}

	@PostMapping("/cdims_form_document_write")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("form register : " + board);
		
		log.info("attach list : " + board.getAttachList());
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info("attach : " + attach));
		}
		
		formDocService.register(board);
		rttr.addFlashAttribute("result", board.getBno()); // list에서 등록 성공 모달창에 출력할 게시글 번호 전달

		return "redirect:/community/cdims_form_document";
	}

	@GetMapping("/cdims_form_document_write")
	@PreAuthorize("isAuthenticated()")
	public void register() {

	}

	@GetMapping({ "/cdims_form_document_get", "/cdims_form_document_update" })
	@PreAuthorize("isAuthenticated()")
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model, String writer) {
		log.info("/cdims_form_document_get or cdims_form_document_update");
		model.addAttribute("board", formDocService.get(bno));
	}

	@PostMapping("/cdims_form_document_update")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("post modify : " + board);

		if (formDocService.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());

		return "redirect:/community/cdims_form_document" + cri.getListLink();
	}

	@PostMapping("/cdims_form_document_delete")
	@PreAuthorize("principal.username == #writer")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,
			String writer) {
		log.info("/cdims_form_document_remove");
		
		List<BoardAttachVO> attachList = formDocService.getAttachList(bno);
		
		if (formDocService.remove(bno)) {
			deleteFiles(attachList); // delete Attach Files
			
			rttr.addAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());

		return "redirect:/community/cdims_form_document" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList : " + bno);
		
		return new ResponseEntity<>(formDocService.getAttachList(bno), HttpStatus.OK); // 해당 게시물 첨부파일 리스트 가져옴
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
