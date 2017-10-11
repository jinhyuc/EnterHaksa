package com.hyucs.academic.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hyucs.academic.domain.UserVO;
import com.hyucs.academic.dto.LoginDTO;
import com.hyucs.academic.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {
	@Inject
	private UserDAO dao;

	@Override
	public void create(UserVO vo) throws Exception {
		dao.create(vo);
	}
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return dao.login(dto);
	}
	
	@Override
	public int loginCheck(String uid, String upw) throws Exception {
		return dao.loginCheck(uid, upw);
	}

	@Override
	public int countById(String uid) throws Exception {
		return dao.countById(uid);
	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) throws Exception {
		dao.keepLogin(uid, sessionId, next);
	}

	@Override
	public UserVO checkLoginBefore(String value) {
		return dao.checkUserWithSessionKey(value);
	}
}
