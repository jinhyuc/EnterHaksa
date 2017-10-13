package com.hyucs.academic.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.hyucs.academic.domain.UserVO;
import com.hyucs.academic.dto.LoginDTO;
import com.hyucs.academic.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Inject
	private UserService service;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public void registerGET() throws Exception {
		
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerPOST(UserVO vo, RedirectAttributes rttr) throws Exception {
		String encoded_passwd = passwordEncoder.encode(vo.getUpw());
		
		vo.setUpw(encoded_passwd);

		service.create(vo);
		
		rttr.addFlashAttribute("result", "CREATE-SUCCESS");
		
		return "redirect:/user/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) throws Exception {

	}
	
	@RequestMapping(value="/loginPOST", method=RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {
		UserVO vo = service.login(dto);
		
		if(vo == null) {
			return;
		}
		
		model.addAttribute("userVO", vo);		
		
		if(dto.isUseCookie()) {
			int amount = 60 * 60 * 24 * 7;
			
			Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
			service.keepLogin(vo.getUid(), session.getId(), sessionLimit);
		}
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session, RedirectAttributes rttr) throws Exception {
		Object obj = session.getAttribute("login");
		
		if(obj != null) {
			UserVO vo = (UserVO) obj;
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				service.keepLogin(vo.getUid(), session.getId(), new Date());
			}
		}
		
		rttr.addFlashAttribute("result", "LOGOUT");
		return "redirect:/user/login";
	}
	
	@RequestMapping(value="/logincheck", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> logincheck(String id, String passwd) throws Exception {
		
		UserVO vo = service.loginCheck(id);
		
		if(vo == null) {
			return new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
		
		if(passwordEncoder.matches(passwd, vo.getUpw())) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
	}
	
	@RequestMapping(value="/isValidId", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> isValidId(String id) throws Exception {
		
		int count = service.countById(id);
		
		if(id == null || id.length() == 0) {
			return new ResponseEntity<String>("EMPTY", HttpStatus.OK);
		}
		
		if(count > 0) {
			return new ResponseEntity<String>("EXIST", HttpStatus.OK);
		}
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
}
