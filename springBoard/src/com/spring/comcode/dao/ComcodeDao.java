package com.spring.comcode.dao;

import java.util.List;

import com.spring.comcode.vo.ComcodeVo;

public interface ComcodeDao {
	public List<ComcodeVo> selectComcodeList() throws Exception;
	
	public List<ComcodeVo> selectPhone() throws Exception;
	
	public List<ComcodeVo> selectMenu() throws Exception;
	
}
