package com.hyucs.academic.service;

import java.util.Date;

import com.hyucs.academic.domain.UserVO;
import com.hyucs.academic.dto.LoginDTO;

public interface UserService {
	public void create(UserVO vo) throws Exception;
	
	public UserVO login(LoginDTO dto) throws Exception;
	
	public int loginCheck(String uid, String upw) throws Exception;
	
	public int countById(String uid) throws Exception;
	
	public void keepLogin(String uid, String sessionId, Date next) throws Exception;
	
	public UserVO checkLoginBefore(String value);
}
