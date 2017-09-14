package com.hyucs.academic.persistence;

import java.util.List;

import com.hyucs.academic.domain.EnrollmentsVO;
import com.hyucs.academic.domain.SearchCriteria;

public interface EnrollmentsDAO {
	public void create(EnrollmentsVO vo) throws Exception;
	
	public EnrollmentsVO read(String lcode, String scode) throws Exception;
	
	public void update(EnrollmentsVO vo) throws Exception;
	
	public void delete(String lcode, String scode) throws Exception;
	
	public List<EnrollmentsVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public List<EnrollmentsVO> listByCourse(String lcode) throws Exception;
}
