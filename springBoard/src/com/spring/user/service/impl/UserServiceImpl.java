package com.spring.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.user.dao.UserDao;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserDao userDao;
	
	@Override
	public int selectUserIdCheck(String id) {
		return userDao.selectUserIdCheck(id);
	}

	@Override
	public UserVo selectUserInfo(String id) {
		return userDao.selectUserInfo(id);
	}

	@Override
	public int userInsert(UserVo userVo) {
		return userDao.userInsert(userVo);
	}

}
