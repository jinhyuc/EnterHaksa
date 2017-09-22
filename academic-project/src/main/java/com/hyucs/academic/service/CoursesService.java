package com.hyucs.academic.service;

import java.util.List;

import com.hyucs.academic.domain.CoursesVO;
import com.hyucs.academic.domain.SearchCriteria;

public interface CoursesService {
	public List<CoursesVO> listAll() throws Exception;
	
	public void create(CoursesVO vo) throws Exception;
	
	public CoursesVO read(String lcode) throws Exception;
	
	public void modify(CoursesVO vo) throws Exception;
	
	public void remove(String lcode) throws Exception;
	
	public List<CoursesVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public List<CoursesVO> listByProf(String pcode) throws Exception;
	
	public List<CoursesVO> listByStudent(String scode) throws Exception;
	
	public int countByProf(String instructor) throws Exception;
}
