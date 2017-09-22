package com.hyucs.academic.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hyucs.academic.domain.EnrollmentsVO;
import com.hyucs.academic.domain.SearchCriteria;

@Repository
public class EnrollmentsDAOImpl implements EnrollmentsDAO {
	@Inject
	private SqlSession session;
	
	private String namespace="com.hyucs.academic.mapper.EnrollmentsMapper";

	@Override
	public void create(EnrollmentsVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public EnrollmentsVO read(String lcode, String scode) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("lcode", lcode);
		paramMap.put("scode", scode);
		
		return session.selectOne(namespace + ".read", paramMap);
	}

	@Override
	public void update(EnrollmentsVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}
	
	@Override
	public void updateGrade(EnrollmentsVO vo) throws Exception {
		session.update(namespace + ".updateGrade", vo);
	}

	@Override
	public void delete(String lcode, String scode) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("lcode", lcode);
		paramMap.put("scode", scode);
		
		session.delete(namespace + ".delete", paramMap);
	}

	@Override
	public List<EnrollmentsVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public List<EnrollmentsVO> listByCourse(String lcode) throws Exception {
		return session.selectList(namespace + ".listByCourse", lcode);
	}

	@Override
	public int countByStudent(String scode) throws Exception {
		return session.selectOne(namespace + ".countByStudent", scode);
	}

	@Override
	public int countByCourse(String lcode) throws Exception {
		return session.selectOne(namespace + ".countByCourse", lcode);
	}
}
