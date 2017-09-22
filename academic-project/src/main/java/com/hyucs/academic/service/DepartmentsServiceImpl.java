package com.hyucs.academic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hyucs.academic.domain.DepartmentsVO;
import com.hyucs.academic.persistence.DepartmentsDAO;

@Service
public class DepartmentsServiceImpl implements DepartmentsService {
	@Inject
	private DepartmentsDAO dao;

	@Override
	public List<DepartmentsVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<DepartmentsVO> listByCollege(String college) throws Exception {
		return dao.listByCollege(college);
	}

}
