package kr.co.sunmoon.controller;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.activation.MimetypesFileTypeMap;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.sunmoon.domain.BoardAttachVO;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/fd_upload/*")
public class FDUploadController {
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {

		String uploadFolder = "/Users/parkheonjin/Desktop/upload/formDoc";

		for (MultipartFile multipartFile : uploadFile) {

			log.info("-------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

			try {
				multipartFile.transferTo(saveFile); // 업로드되는 원래 파일의 이름으로 upload 폴더에 원래 이름으로 저장
			} catch (Exception e) {
				log.error(e.getMessage());
			} // end catch
		} // end for
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	public boolean checkImageType(File file) {
		MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
		String mimeType = mimeTypesMap.getContentType(file);
		
		if (mimeType.contains("image")) {
			log.info("image true");
			return true;
		} else {
			log.info("image false");
			return false;
		}
	}
	
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("update ajax post....");
		
		
		List<BoardAttachVO> list = new ArrayList<>();
		String uploadFolder = "/Users/parkheonjin/Desktop/upload/formDoc";
		
		String uploadFolderPath = getFolder(); 
		
		File uploadPath = new File(uploadFolder, uploadFolderPath); 
		log.info("upload path : " + uploadPath);
		
		//yyyy/MM/dd folder 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs(); 
		}
				
		for (MultipartFile multipartFile : uploadFile) {
			log.info("--------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			BoardAttachVO boardAttachVO = new BoardAttachVO();
			
			String uploadfileName = multipartFile.getOriginalFilename();
			//IE has file path
			uploadfileName = uploadfileName.substring(uploadfileName.lastIndexOf("\\") + 1);
			log.info("only file name : " + uploadfileName);
			boardAttachVO.setFileName(uploadfileName);
			
			UUID uuid = UUID.randomUUID();
			uploadfileName = uuid.toString() + "_" + uploadfileName;
			
			try {
				File saveFile = new File(uploadPath, uploadfileName);
				multipartFile.transferTo(saveFile); // 업로드되는 원래 파일의 이름으로 upload폴더에 원래 이름으로 저장
				
				boardAttachVO.setUuid(uuid.toString());
				boardAttachVO.setUploadPath(uploadFolderPath);
				
				if (checkImageType(saveFile)) {
					log.info("checkImageType true");
					boardAttachVO.setFileType("1");
				} else {
					log.info("checkImageType false");
					boardAttachVO.setFileType("0"); 
				}
				
				list.add(boardAttachVO); //add to list
			} catch (Exception e) {
				log.error(e.getMessage());
			} //end catch
		} //end for
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		File file = new File("/Users/parkheonjin/Desktop/upload/formDoc/" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
			
			header.add("content-Type", mimeTypesMap.getContentType(file)); // 적절한 MIME 타입 데이터를 Http의 헤더 메세지에 포함할 수 있도록 처리 
			log.info("mime : " + mimeTypesMap.getContentType(file));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		log.info("download file : " + fileName);
		
		Resource resource = new FileSystemResource("/Users/parkheonjin/Desktop/upload/formDoc/" + fileName);
		log.info("resource : " + resource);
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			// 브라우저별 encoding 설정
			String downloadName = null;
			if (userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				log.info("Edge name : " + downloadName);
			} else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			log.info("downloadName : " + downloadName);
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName);
		
		File file;
		try {
			file = new File("/Users/parkheonjin/Desktop/upload/formDoc/" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
	
}