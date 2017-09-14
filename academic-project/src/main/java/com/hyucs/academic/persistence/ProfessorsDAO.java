package com.hyucs.academic.persistence;

import java.util.List;

import com.hyucs.academic.domain.ProfessorsVO;
import com.hyucs.academic.domain.SearchCriteria;

public interface ProfessorsDAO {
	public List<ProfessorsVO> listAll() throws Exception;
	
	public void create(ProfessorsVO vo) throws Exception;
	
	public ProfessorsVO read(String pcode) throws Exception;
	
	public void update(ProfessorsVO vo) throws Exception;
	
	public void delete(String pcode) throws Exception;
	
	public List<ProfessorsVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
}
