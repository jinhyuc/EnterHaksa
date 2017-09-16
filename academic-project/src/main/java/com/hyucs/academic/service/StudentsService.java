package com.hyucs.academic.service;

import java.util.List;

import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.domain.StudentsVO;

public interface StudentsService {
	public List<StudentsVO> listAll() throws Exception;
	
	public List<StudentsVO> listByCourse(String lcode) throws Exception;
	
	public void create(StudentsVO vo) throws Exception;
	
	public StudentsVO read(String scode) throws Exception;
	
	public void modify(StudentsVO vo) throws Exception;
	
	public void remove(String scode) throws Exception;
	
	public List<StudentsVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public void addPicture(String picture, String scode) throws Exception;
	
	public String getPicture(String scode) throws Exception;
	
	public void deletePictureByFilename(String fileName) throws Exception;
}
