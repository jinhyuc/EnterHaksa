package com.hyucs.academic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.domain.StudentsVO;
import com.hyucs.academic.persistence.StudentsDAO;

@Service
public class StudentsServiceImpl implements StudentsService {
	@Inject
	private StudentsDAO dao;
	
	@Override
	public List<StudentsVO> listAll() throws Exception {
		return dao.listAll();
	}
	
	@Override
	public List<StudentsVO> listByCourse(String lcode) throws Exception {
		return dao.listByCourse(lcode);
	}

	@Transactional
	@Override
	public void create(StudentsVO vo) throws Exception {
		String picture = vo.getPicture();
		String scode = vo.getScode();
		
		dao.create(vo);
		
		dao.addPicture(picture, scode);
	}

	@Override
	public StudentsVO read(String scode) throws Exception {
		return dao.read(scode);
	}

	@Override
	public void modify(StudentsVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void remove(String scode) throws Exception {
		dao.deletePictureByScode(scode);
		dao.delete(scode);
	}

	@Override
	public List<StudentsVO> listSearch(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}
	
	@Override
	public void addPicture(String picture, String scode) throws Exception {
		dao.addPicture(picture, scode);
	}
	
	@Override
	public String getPicture(String scode) throws Exception {
		return dao.getPicture(scode);
	}
	
	@Override
	public void deletePictureByFilename(String fileName) throws Exception {
		dao.deletePictureByFilename(fileName);
	}
}
