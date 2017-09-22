package com.hyucs.academic.service;

import java.util.List;

import com.hyucs.academic.domain.DepartmentsVO;

public interface DepartmentsService {
	public List<DepartmentsVO> listAll() throws Exception;
	
	public List<DepartmentsVO> listByCollege(String college) throws Exception;
}
