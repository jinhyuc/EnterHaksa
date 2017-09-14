package com.hyucs.academic.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hyucs.academic.domain.ProfessorsVO;
import com.hyucs.academic.domain.SearchCriteria;

@Repository
public class ProfessorsDAOImpl implements ProfessorsDAO {
	@Inject
	private SqlSession session;
	private String namespace = "com.hyucs.academic.mapper.professorsMapper";
	
	@Override
	public List<ProfessorsVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}
	
	@Override
	public void create(ProfessorsVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public ProfessorsVO read(String pcode) throws Exception {
		return session.selectOne(namespace + ".read", pcode);
	}

	@Override
	public void update(ProfessorsVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(String pcode) throws Exception {
		session.delete(namespace + ".delete", pcode);
	}

	@Override
	public List<ProfessorsVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}
}
