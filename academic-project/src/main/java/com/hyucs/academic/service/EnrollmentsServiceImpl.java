package com.hyucs.academic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyucs.academic.domain.EnrollmentsVO;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.persistence.CoursesDAO;
import com.hyucs.academic.persistence.EnrollmentsDAO;

@Service
public class EnrollmentsServiceImpl implements EnrollmentsService {
	@Inject
	private EnrollmentsDAO dao;
	
	@Inject
	private CoursesDAO cdao;

	@Transactional
	@Override
	public void create(EnrollmentsVO vo) throws Exception {
		dao.create(vo);
		cdao.updatePersons(vo.getLcode(), 1);
	}

	@Override
	public EnrollmentsVO read(String lcode, String scode) throws Exception {
		return dao.read(lcode, scode);
	}

	@Override
	public void modify(EnrollmentsVO vo) throws Exception {
		dao.update(vo);
	}
	
	@Override
	public void modifyGrade(EnrollmentsVO vo) throws Exception {
		dao.updateGrade(vo);
	}

	@Transactional
	@Override
	public void remove(String lcode, String scode) throws Exception {
		dao.delete(lcode, scode);
		cdao.updatePersons(lcode, -1);
	}

	@Override
	public List<EnrollmentsVO> listSearch(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}

	@Override
	public List<EnrollmentsVO> listByCourse(String lcode) throws Exception {
		return dao.listByCourse(lcode);
	}

	@Override
	public int countByStudent(String scode) throws Exception {
		return dao.countByStudent(scode);
	}

	@Override
	public int countByCourse(String lcode) throws Exception {
		return dao.countByCourse(lcode);
	}
}