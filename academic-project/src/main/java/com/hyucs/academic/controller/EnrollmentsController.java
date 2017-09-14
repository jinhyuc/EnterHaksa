package com.hyucs.academic.controller;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hyucs.academic.domain.EnrollmentsVO;
import com.hyucs.academic.domain.PageMaker;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.domain.StudentsVO;
import com.hyucs.academic.service.CoursesService;
import com.hyucs.academic.service.EnrollmentsService;
import com.hyucs.academic.service.StudentsService;

@Controller
@RequestMapping("/enrollments/*")
public class EnrollmentsController {
	private static final Logger logger = LoggerFactory.getLogger(EnrollmentsController.class);
	
	@Inject
	private EnrollmentsService service;
	
	@Inject
	private CoursesService cservice;
	
	@Inject
	private StudentsService stservice;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void listGET(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		List<EnrollmentsVO> list = service.listSearch(cri);
		logger.info(list.toString());
		
		model.addAttribute("list", list);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		
	}
	
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public void createGET(Model model) throws Exception {
		model.addAttribute("clist", cservice.listAll());
		model.addAttribute("slist", stservice.listAll());
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createPOST(EnrollmentsVO vo, String enroll_yy, String enroll_mm, String enroll_dd, RedirectAttributes rttr) throws Exception {
		if(service.read(vo.getLcode(), vo.getScode()) != null) {
			rttr.addFlashAttribute("result", "CREATE-FAIL");
			return "redirect:/enrollments/list";
		}
		
		vo.seteDate(Date.valueOf(enroll_yy + "-" + enroll_mm + "-" + enroll_dd));
		
		service.create(vo);
		rttr.addFlashAttribute("result", "CREATE-SUCCESS");
		
		return "redirect:/enrollments/list";
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public void detailGET(@RequestParam("lcode") String lcode, @RequestParam("scode") String scode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info("---------- Enrollments Detail --------------");
		EnrollmentsVO vo = service.read(lcode, scode);
		logger.info(vo.toString());
		model.addAttribute("evo", vo);
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modifyGET(@RequestParam("lcode") String lcode, @RequestParam("scode") String scode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		EnrollmentsVO vo = service.read(lcode, scode);
		String enrollDate = vo.geteDate().toString();
		
		model.addAttribute("evo", vo);
		model.addAttribute("yy", enrollDate.substring(0, 4));
		model.addAttribute("mm", enrollDate.substring(5, 7));
		model.addAttribute("dd", enrollDate.substring(8, 10));
		model.addAttribute("clist", cservice.listAll());
		model.addAttribute("slist", stservice.listAll());
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modifyPOST(EnrollmentsVO vo, SearchCriteria cri, String enroll_yy, String enroll_mm, String enroll_dd, RedirectAttributes rttr) throws Exception {
		vo.seteDate(Date.valueOf(enroll_yy + "-" + enroll_mm + "-" + enroll_dd));
		logger.info(vo.toString());
		
		service.modify(vo);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "MODIFY-SUCCESS");
		
		logger.info(rttr.toString());
		
		return "redirect:/enrollments/list";
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public String removePOST(@RequestParam("lcode") String lcode, @RequestParam("scode") String scode, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		service.remove(lcode, scode);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "REMOVE-SUCCESS");
		
		return "redirect:/enrollments/list";
	}
	
	@RequestMapping(value="/register/", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> register(@RequestBody EnrollmentsVO vo) {
		ResponseEntity<String> entity = null;
		
		try {
			service.create(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/listByCourse/{lcode}" , method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<List<EnrollmentsVO>> listByCourse(@PathVariable("lcode") String lcode) {
		logger.info("-------- listByCourse --------");
		logger.info(lcode);
		
		ResponseEntity<List<EnrollmentsVO>> entity=null;
		
		try {
			List<EnrollmentsVO> list = service.listByCourse(lcode);
			logger.info(list.toString());
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}