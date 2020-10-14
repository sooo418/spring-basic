package com.spring.user.service;

import com.spring.user.vo.UserVo;

public interface UserService {
	public int selectUserIdCheck(String id);
	
	public UserVo selectUserInfo(String id);
	
	public int userInsert(UserVo userVo);
}
