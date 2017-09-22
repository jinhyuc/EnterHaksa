package com.hyucs.academic.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hyucs.academic.domain.DepartmentsVO;

@Repository
public class DepartmentsDAOImpl implements DepartmentsDAO {
	@Inject
	private SqlSession session;
	private String namespace="com.hyucs.academic.mapper.DepartmentsMapper";

	@Override
	public List<DepartmentsVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}

	@Override
	public List<DepartmentsVO> listByCollege(String college) throws Exception {
		return session.selectList(namespace + ".listByCollege", college);
	}
}
