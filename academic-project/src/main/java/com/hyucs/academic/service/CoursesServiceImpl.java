package com.hyucs.academic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hyucs.academic.domain.CoursesVO;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.persistence.CoursesDAO;

@Service
public class CoursesServiceImpl implements CoursesService {
	@Inject
	private CoursesDAO dao;
	
	@Override
	public List<CoursesVO> listAll() throws Exception {
		return dao.listAll();
	}
	
	@Override
	public void create(CoursesVO vo) throws Exception {
		dao.create(vo);
	}

	@Override
	public CoursesVO read(String lcode) throws Exception {
		return dao.read(lcode);
	}

	@Override
	public void modify(CoursesVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void remove(String lcode) throws Exception {
		dao.delete(lcode);
	}

	@Override
	public List<CoursesVO> listSearch(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}

	@Override
	public List<CoursesVO> listByProf(String pcode) throws Exception {
		return dao.listByProf(pcode);
	}

	@Override
	public List<CoursesVO> listByStudent(String scode) throws Exception {
		return dao.listByStudent(scode);
	}
}
