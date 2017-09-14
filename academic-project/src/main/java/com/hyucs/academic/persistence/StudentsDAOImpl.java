package com.hyucs.academic.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.domain.StudentsVO;

@Repository
public class StudentsDAOImpl implements StudentsDAO {
	@Inject
	SqlSession session;
	
	private String namespace="com.hyucs.academic.mapper.StudentsMapper";
	
	@Override
	public List<StudentsVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}
	
	@Override
	public List<StudentsVO> listByCourse(String lcode) throws Exception {
		return session.selectList(namespace + ".listByCourse", lcode);
	}

	@Override
	public void create(StudentsVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public void addPicture(String picture, String scode) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("picture", picture);
		paramMap.put("scode", scode);
		
		session.insert(namespace + ".addPicture", paramMap);
	}
	
	@Override
	public String getPicture(String scode) throws Exception {
		return session.selectOne(namespace + ".getPicture", scode);		
	}
	
	@Override
	public void deletePictureByScode(String scode) throws Exception {
		session.delete(namespace + ".deletePicByScode", scode);
	}
	
	@Override
	public void deletePictureByFilename(String fileName) throws Exception {
		session.delete(namespace + ".deletePicByFilename", fileName);		
	}
	
	@Override
	public StudentsVO read(String scode) throws Exception {
		return session.selectOne(namespace + ".read", scode);
	}

	@Override
	public void update(StudentsVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(String scode) throws Exception {
		session.delete(namespace + ".delete", scode);
	}

	@Override
	public List<StudentsVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}
}
