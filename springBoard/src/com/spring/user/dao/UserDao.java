package com.spring.user.dao;

import com.spring.user.vo.UserVo;

public interface UserDao {
	public int selectUserIdCheck(String id);
	
	public UserVo selectUserInfo(String id);
	
	public int userInsert(UserVo userVo);
}
