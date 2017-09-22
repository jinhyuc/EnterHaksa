package com.hyucs.academic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hyucs.academic.domain.CoursesVO;
import com.hyucs.academic.domain.PageMaker;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.service.CoursesService;
import com.hyucs.academic.service.ProfessorsService;

@Controller
@RequestMapping("/courses/*")
public class CoursesController {
	private static final Logger logger = LoggerFactory.getLogger(CoursesController.class);
	
	@Inject
	private CoursesService service;
	
	@Inject
	private ProfessorsService pservice;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void listGet(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info(cri.toString());
		
		List<CoursesVO> list = null;
		list = service.listSearch(cri);
		logger.info(list.toString());
		
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public void createGET(Model model) throws Exception {
		model.addAttribute("plist", pservice.listAll());
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createPOST(CoursesVO vo, RedirectAttributes rttr) throws Exception {
		if(service.read(vo.getLcode()) != null) {
			rttr.addFlashAttribute("result", "CREATE-FAIL");
			return "redirect:/courses/list";
		}
		
		service.create(vo);
		rttr.addFlashAttribute("result", "CREATE-SUCCESS");
		
		return "redirect:/courses/list";
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public void detailGET(@RequestParam("lcode") String lcode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		model.addAttribute("cvo", service.read(lcode));
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modifyGET(@RequestParam("lcode") String lcode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		CoursesVO vo = service.read(lcode);
		
		model.addAttribute("cvo", vo);
		model.addAttribute("plist", pservice.listAll());
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modifyPOST(CoursesVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		logger.info(vo.toString());
		
		service.modify(vo);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "MODIFY-SUCCESS");
		
		logger.info(rttr.toString());
		
		return "redirect:/courses/list";
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public String removePOST(@RequestParam("lcode") String lcode, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		service.remove(lcode);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "REMOVE-SUCCESS");
		
		return "redirect:/courses/list";
	}
	
	@RequestMapping(value="/listAll" , method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> listAll() {
		
		ResponseEntity<Map<String, Object>> entity=null;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<CoursesVO> list = service.listAll();
			logger.info(list.toString());
		
			paramMap.put("list", list);
		
			entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/listByStudent/{scode}" , method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> listByStudent(@PathVariable("scode") String scode) {
		logger.info("-------- Courses list By Student --------");
		logger.info(scode);
		
		ResponseEntity<Map<String, Object>> entity=null;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<CoursesVO> list = service.listByStudent(scode);
			logger.info(list.toString());
		
			paramMap.put("list", list);
		
			entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/countByProf/{instructor}" , method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> countByProf(@PathVariable("instructor") String instructor) {
		logger.info("-------- countByProf --------");
		logger.info(instructor);
		
		ResponseEntity<Map<String, Object>> entity=null;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			int count = service.countByProf(instructor);
			logger.info(String.valueOf(count));
		
			paramMap.put("count", count);
		
			entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}