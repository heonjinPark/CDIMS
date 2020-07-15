package kr.co.sunmoon.controller;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/cdims_main")
	public void mainPage() {
	}
	
	@GetMapping("/cdims_login")
	public void login() {
	}
	
	@PostMapping("/cdims_logout")
	public void logoutPOST() {
		log.info("post logout");
	}
	
	@GetMapping("/cdims_intro")
	public void intro() {
	}
	
	@GetMapping("/cdims_global_intro")
	public void globalIntro() {
	}
}
