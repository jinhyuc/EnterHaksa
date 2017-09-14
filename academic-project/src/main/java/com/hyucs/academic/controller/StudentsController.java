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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hyucs.academic.domain.PageMaker;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.domain.StudentsVO;
import com.hyucs.academic.service.CoursesService;
import com.hyucs.academic.service.ProfessorsService;
import com.hyucs.academic.service.StudentsService;

@Controller
@RequestMapping("/students/*")
public class StudentsController {
	private static final Logger logger = LoggerFactory.getLogger(StudentsController.class);
	
	@Inject
	private StudentsService service;
	
	@Inject
	private ProfessorsService pservice;
	
	@Inject
	private CoursesService cservice;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void listGet(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info(cri.toString());
		
		List<StudentsVO> list = null;
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
	public String createPOST(StudentsVO vo, String birth_yy, String birth_mm, String birth_dd, RedirectAttributes rttr) throws Exception {
		if(service.read(vo.getScode()) != null) {
			rttr.addFlashAttribute("result", "CREATE-FAIL");
			return "redirect:/students/list";
		}
		
		vo.setBirthday(Date.valueOf(birth_yy + "-" + birth_mm + "-" + birth_dd));
		
		service.create(vo);
		rttr.addFlashAttribute("result", "CREATE-SUCCESS");
		
		return "redirect:/students/list";
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public void detailGET(@RequestParam("scode") String scode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info("------- Student Detail GET --------");
		logger.info(scode);
		
		StudentsVO vo = service.read(scode);
		logger.info(vo.toString());
		
		model.addAttribute("svo", vo);
		model.addAttribute("clist", cservice.listAll());
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modifyGET(@RequestParam("scode") String scode, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		StudentsVO vo = service.read(scode);
		String birthDay = vo.getBirthday().toString();
		
		model.addAttribute("svo", vo);
		model.addAttribute("yy", birthDay.substring(0, 4));
		model.addAttribute("mm", birthDay.substring(5, 7));
		model.addAttribute("dd", birthDay.substring(8, 10));
		model.addAttribute("plist", pservice.listAll());
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modifyPOST(StudentsVO vo, SearchCriteria cri, String birth_yy, String birth_mm, String birth_dd, RedirectAttributes rttr) throws Exception {
		vo.setBirthday(Date.valueOf(birth_yy + "-" + birth_mm + "-" + birth_dd));
		logger.info(vo.toString());
		
		service.modify(vo);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "MODIFY-SUCCESS");
		
		logger.info(rttr.toString());
		
		return "redirect:/students/list";
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public String removePOST(@RequestParam("scode") String scode, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		service.remove(scode);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("result", "REMOVE-SUCCESS");
		
		return "redirect:/students/list";
	}
	
	@RequestMapping(value="/listByCourse/{lcode}" , method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> listByCourse(@PathVariable("lcode") String lcode) throws Exception {
		logger.info("-------- Students listByCourse --------");
		logger.info(lcode);
		
		ResponseEntity<Map<String, Object>> entity=null;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<StudentsVO> list = service.listByCourse(lcode);
			logger.info(list.toString());
		
			paramMap.put("list", list);
		
			entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/getPicture/{scode}", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getPicture(@PathVariable("scode") String scode) throws Exception {
		logger.info("-------------- Students getPicture ------------------");
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		String pictureName = service.getPicture(scode);
		
		paramMap.put("picture", pictureName);
		entity = new ResponseEntity<Map<String, Object>>(paramMap, HttpStatus.OK);
		
		logger.info(entity.toString());
		return entity;
	}
	
	@RequestMapping(value="/deletePicture", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> deletePicture(String fileName) throws Exception {
		logger.info("-------------- Students deletePicture ------------------");
		logger.info("fileName: " + fileName);
		
		service.deletePictureByFilename(fileName);
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	@RequestMapping(value="/addPicture", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> addPicture(String fileName, String scode) throws Exception {
		logger.info("-------------- Students addPicture ------------------");
		logger.info("scode: " + scode);
		logger.info("fileName: " + fileName);
		
		service.addPicture(fileName, scode);
		
		return new ResponseEntity<String>("added", HttpStatus.OK);
	}
}