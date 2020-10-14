package com.spring.user.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.user.dao.UserDao;
import com.spring.user.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{

	@Autowired
	SqlSession sqlsession;
	
	@Override
	public int selectUserIdCheck(String id) {
		return sqlsession.selectOne("user.userIdCheck", id);
	}

	@Override
	public UserVo selectUserInfo(String id) {
		return sqlsession.selectOne("user.userInfo", id);
	}

	@Override
	public int userInsert(UserVo userVo) {
		return sqlsession.insert("user.userJoin", userVo);
	}

}
