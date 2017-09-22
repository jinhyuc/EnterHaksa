package com.hyucs.academic.persistence;

import java.util.List;

import com.hyucs.academic.domain.DepartmentsVO;

public interface DepartmentsDAO {
	public List<DepartmentsVO> listAll() throws Exception;
	
	public List<DepartmentsVO> listByCollege(String college) throws Exception;
}
