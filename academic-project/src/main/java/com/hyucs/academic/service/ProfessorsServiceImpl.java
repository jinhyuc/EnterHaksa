package com.hyucs.academic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hyucs.academic.domain.ProfessorsVO;
import com.hyucs.academic.domain.SearchCriteria;
import com.hyucs.academic.persistence.ProfessorsDAO;

@Service
public class ProfessorsServiceImpl implements ProfessorsService {
	@Inject
	private ProfessorsDAO dao;
	
	@Override
	public List<ProfessorsVO> listAll() throws Exception {
		return dao.listAll();
	}
	
	@Override
	public void create(ProfessorsVO vo) throws Exception {
		String picture = vo.getPicture();
		String pcode = vo.getPcode();
		
		dao.create(vo);
		
		dao.addPicture(picture, pcode);
	}

	@Override
	public ProfessorsVO read(String pcode) throws Exception {
		return dao.read(pcode);
	}

	@Override
	public void modify(ProfessorsVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void remove(String pcode) throws Exception {
		dao.deletePictureByPcode(pcode);
		
		dao.delete(pcode);
	}

	@Override
	public List<ProfessorsVO> listSearch(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}

	@Override
	public void addPicture(String picture, String pcode) throws Exception {
		dao.addPicture(picture, pcode);
	}

	@Override
	public String getPicture(String pcode) throws Exception {
		return dao.getPicture(pcode);
	}

	@Override
	public void deletePictureByFilename(String fileName) throws Exception {
		dao.deletePictureByFilename(fileName);
	}
}
