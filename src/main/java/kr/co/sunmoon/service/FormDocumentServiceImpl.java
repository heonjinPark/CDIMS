package kr.co.sunmoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sunmoon.domain.BoardAttachVO;
import kr.co.sunmoon.domain.BoardVO;
import kr.co.sunmoon.domain.Criteria;
import kr.co.sunmoon.mapper.FDAttachMapper;
import kr.co.sunmoon.mapper.FormDocumentMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FormDocumentServiceImpl implements FormDocumentService {

	@Setter(onMethod_ = @Autowired)
	private FormDocumentMapper formDocMapper;
	@Setter(onMethod_ = @Autowired)
	private FDAttachMapper fdAttachMapper;

	@Override
	public void register(BoardVO board) {
		log.info("service register : " + board);
		formDocMapper.insertSelectKey(board);
		
		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			fdAttachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get : " + bno);

		return formDocMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("service modify : " + board);
		
		fdAttachMapper.deleteAll(board.getBno());

		boolean modifyResult = formDocMapper.update(board) == 1;
		
		log.info("modifyResult! : " + modifyResult);
		log.info("size : " + board.getAttachList());
		if (modifyResult && board.getAttachList() != null) {
			
			log.info("file exist");
			board.getAttachList().forEach(attach -> {

				attach.setBno(board.getBno());
				fdAttachMapper.insert(attach);
			});
		} else {
			log.info("file not exist");
		}

		return modifyResult;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("service remove : " + bno);
		
		// 해당 게시물 모든 첨부파일 삭제
		fdAttachMapper.deleteAll(bno);

		return formDocMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("service getList : " + cri);

		return formDocMapper.getListwithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("service getTotal : " + cri);

		return formDocMapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno : " + bno);
		
		return fdAttachMapper.findByBno(bno); // 게시물의 첨부 파일 데이터 가져옴
	}

}
