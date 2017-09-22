package com.hyucs.academic.controller;

import java.sql.Date;
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
	
	@RequestMapping(value="/grade/", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> grade(@RequestBody EnrollmentsVO vo) {
		ResponseEntity<String> entity = null;
		
		try {
			service.modifyGrade(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/countByStudent/{scode}" , method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> countByStudent(@PathVariable("scode") String scode) {
		logger.info("-------- Enrollments countByStudent --------");
		logger.info(scode);
		
		ResponseEntity<Map<String, Object>> entity=null;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			int count = service.countByStudent(scode);
			logger.info(String.valueOf(count));
		
			paramMap.put("count", count);
		
			entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/countByCourse/{lcode}" , method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> countByCourse(@PathVariable("lcode") String lcode) {
		logger.info("-------- Enrollments countByCourse --------");
		logger.info(lcode);
		
		ResponseEntity<Map<String, Object>> entity=null;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			int count = service.countByCourse(lcode);
			logger.info(String.valueOf(count));
		
			paramMap.put("count", count);
		
			entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.DELETE)
	@ResponseBody
	public ResponseEntity<String> delete(@RequestBody List<EnrollmentsVO> list) {
		ResponseEntity<String> entity = null;
		
		logger.info(list.toString());
		
		try {
			for(EnrollmentsVO vo : list) {
				logger.info(vo.toString());
				service.remove(vo.getLcode(), vo.getScode());
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}