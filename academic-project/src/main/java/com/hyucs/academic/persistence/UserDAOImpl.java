package com.hyucs.academic.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hyucs.academic.domain.UserVO;
import com.hyucs.academic.dto.LoginDTO;

@Repository
public class UserDAOImpl implements UserDAO {
	@Inject
	private SqlSession session;
	
	private String namespace = "com.hyucs.academic.mapper.UserMapper";

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return session.selectOne(namespace + ".login", dto);
	}
	
	@Override
	public int loginCheck(String uid, String upw) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uid", uid);
		paramMap.put("upw", upw);
		
		return session.selectOne(namespace + ".loginCheck", upw);
	}

	@Override
	public void create(UserVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public int countById(String uid) throws Exception {
		return session.selectOne(namespace + ".countById", uid);
	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uid", uid);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);
		
		session.update(namespace + ".keepLogin", paramMap);
	}

	@Override
	public UserVO checkUserWithSessionKey(String value) {
		return session.selectOne(namespace + ".checkUserWithSessionKey", value);
	}


}
