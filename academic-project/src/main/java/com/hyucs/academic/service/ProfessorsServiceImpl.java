package com.hyucs.academic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hyucs.academic.domain.ProfessorsVO;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.persistence.ProfessorsDAO;

@Service
public class ProfessorsServiceImpl implements ProfessorsService {
	@Inject
	private ProfessorsDAO dao;
	
	@Override
	public List<ProfessorsVO> listAll() throws Exception {
		return dao.listAll();
	}
	
	@Override
	public void create(ProfessorsVO vo) throws Exception {
		dao.create(vo);
	}

	@Override
	public ProfessorsVO read(String pcode) throws Exception {
		return dao.read(pcode);
	}

	@Override
	public void modify(ProfessorsVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void remove(String pcode) throws Exception {
		dao.delete(pcode);
	}

	@Override
	public List<ProfessorsVO> listSearch(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}
}
