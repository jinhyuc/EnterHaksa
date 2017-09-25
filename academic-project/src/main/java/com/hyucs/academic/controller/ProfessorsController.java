package com.hyucs.academic.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hyucs.academic.domain.PageMaker;
import com.hyucs.academic.domain.ProfessorsVO;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.service.CoursesService;
import com.hyucs.academic.service.ProfessorsService;
import com.hyucs.academic.service.StudentsService;

@Controller
@RequestMapping("/professors/*")
public class ProfessorsController {
	private static final Logger logger = LoggerFactory.getLogger(ProfessorsController.class);
			
	@Inject
	private ProfessorsService service;
	
	@Inject
	private CoursesService cservice;
	
	@Inject
	private StudentsService stservice;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);

	    // true passed to CustomDateEditor constructor means convert empty String to null
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}	
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void listGet(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info(cri.toString());
		
		List<ProfessorsVO> list = null;
		list = service.listSearch(cri);
		logger.info(list.toString());
		
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public void registGET() throws Exception {
		logger.info("create GET........");
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String registPOST(ProfessorsVO vo, RedirectAttributes rttr) throws Exception {
		if(service.read(vo.getPcode()) != null) {
			rttr.addFlashAttribute("result", "CREATE-DUPLICATE");
			return "redirect:/professors/list";
		}
		
		service.create(vo);
		logger.info("create POST........");
		logger.info(vo.toString());
		rttr.addFlashAttribute("result", "CREATE-SUCCESS");
		
		return "redirect:/professors/list";
	}
	
	@RequestMapping(value="/read", method=RequestMethod.GET)
	public void readGET(@RequestParam("pcode") String pcode, Model model) throws Exception {
		ProfessorsVO vo = service.read(pcode);
		String hireDate = vo.getHireDate().toString();
		model.addAttribute("vo", vo);
		model.addAttribute("yy", hireDate.substring(0, 4));
		model.addAttribute("mm", hireDate.substring(5, 7));
		model.addAttribute("dd", hireDate.substring(8, 10));
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modifyGET(@RequestParam("pcode") String pcode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		ProfessorsVO vo = service.read(pcode);
		
		model.addAttribute("pvo", vo);		
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modifyPOST(ProfessorsVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		logger.info(vo.toString());
		
		service.modify(vo);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "MODIFY-SUCCESS");
		
		logger.info(rttr.toString());
		
		return "redirect:/professors/list";
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public String removePOST(@RequestParam("pcode") String pcode, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		
		service.remove(pcode);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "REMOVE-SUCCESS");
		
		return "redirect:/professors/list";
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public void detailGET(@RequestParam("pcode") String pcode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		model.addAttribute("pvo", service.read(pcode));
		model.addAttribute("clistByProf", cservice.listByProf(pcode));
	}
	
	@RequestMapping(value="/getPicture/{pcode}", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getPicture(@PathVariable("pcode") String pcode) throws Exception {
		logger.info("-------------- Professors getPicture ------------------");
		logger.info("pcode : " + pcode);
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		String pictureName = service.getPicture(pcode);
		
		logger.info("pictureName : " + pictureName);
		
		paramMap.put("picture", pictureName);
		entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		
		logger.info(entity.toString());
		return entity;
	}
	
	@RequestMapping(value="/deletePicture", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> deletePicture(String fileName) throws Exception {
		logger.info("-------------- Professors deletePicture ------------------");
		logger.info("fileName: " + fileName);
		
		service.deletePictureByFilename(fileName);
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	@RequestMapping(value="/addPicture", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> addPicture(String fileName, String pcode) throws Exception {
		logger.info("-------------- Professors addPicture ------------------");
		logger.info("pcode: " + pcode);
		logger.info("fileName: " + fileName);
		
		service.addPicture(fileName, pcode);
		
		return new ResponseEntity<String>("added", HttpStatus.OK);
	}
	
	@RequestMapping(value="/{dept}", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<List<ProfessorsVO>> listByDepartment(@PathVariable("dept") String dept) {
		ResponseEntity<List<ProfessorsVO>> entity = null;
		
		try {
			entity = new ResponseEntity<>(service.listByDepartment(dept), HttpStatus.OK);			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
