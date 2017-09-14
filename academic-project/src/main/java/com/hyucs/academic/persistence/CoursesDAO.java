package com.hyucs.academic.persistence;

import java.util.List;

import com.hyucs.academic.domain.CoursesVO;
import com.hyucs.academic.domain.SearchCriteria;

public interface CoursesDAO {
	public List<CoursesVO> listAll() throws Exception;
	
	public void create(CoursesVO vo) throws Exception;
	
	public CoursesVO read(String lcode) throws Exception;
	
	public void update(CoursesVO vo) throws Exception;
	
	public void delete(String lcode) throws Exception;
	
	public List<CoursesVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public List<CoursesVO> listByProf(String pcode) throws Exception;
	
	public List<CoursesVO> listByStudent(String scode) throws Exception;
}
