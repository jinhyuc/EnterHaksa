package com.hyucs.academic.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hyucs.academic.domain.CoursesVO;
import com.hyucs.academic.domain.SearchCriteria;

@Repository
public class CoursesDAOImpl implements CoursesDAO {
	@Inject
	private SqlSession session;
	private String namespace="com.hyucs.academic.mapper.CoursesMapper";
	
	@Override
	public List<CoursesVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}
	
	@Override
	public void create(CoursesVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public CoursesVO read(String lcode) throws Exception {
		return session.selectOne(namespace + ".read", lcode);
	}

	@Override
	public void update(CoursesVO vo) throws Exception {
		session.update(namespace + ".update", vo);		
	}

	@Override
	public void delete(String lcode) throws Exception {
		session.delete(namespace + ".delete", lcode);
	}

	@Override
	public List<CoursesVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public List<CoursesVO> listByProf(String pcode) throws Exception {
		return session.selectList(namespace + ".listByProf", pcode);
	}

	@Override
	public List<CoursesVO> listByStudent(String scode) throws Exception {
		return session.selectList(namespace + ".listByStudent", scode);
	}
}
