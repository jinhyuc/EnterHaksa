package com.hyucs.academic.controller;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hyucs.academic.domain.PageMaker;
import com.hyucs.academic.domain.ProfessorsVO;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.service.CoursesService;
import com.hyucs.academic.service.ProfessorsService;

@Controller
@RequestMapping("/professors/*")
public class ProfessorsController {
	private static final Logger logger = LoggerFactory.getLogger(ProfessorsController.class);
			
	@Inject
	private ProfessorsService service;
	
	@Inject
	private CoursesService cservice;
	
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
	public String registPOST(ProfessorsVO vo, String hire_yy, String hire_mm, String hire_dd, RedirectAttributes rttr) throws Exception {
		if(service.read(vo.getPcode()) != null) {
			rttr.addFlashAttribute("result", "CREATE-FAIL");
			return "redirect:/professors/list";
		}
		
		vo.setHireDate(Date.valueOf(hire_yy + "-" + hire_mm + "-" + hire_dd));
		
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
		String hireDate = vo.getHireDate().toString();
		
		model.addAttribute("pvo", vo);
		model.addAttribute("yy", hireDate.substring(0, 4));
		model.addAttribute("mm", hireDate.substring(5, 7));
		model.addAttribute("dd", hireDate.substring(8, 10));		
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modifyPOST(ProfessorsVO vo, SearchCriteria cri, String hire_yy, String hire_mm, String hire_dd, RedirectAttributes rttr) throws Exception {
		vo.setHireDate(Date.valueOf(hire_yy + "-" + hire_mm + "-" + hire_dd));
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
}
