package com.spring.comcode.service;

import java.util.List;

import com.spring.comcode.vo.ComcodeVo;

public interface ComcodeService {
	public List<ComcodeVo> selectComcodeList() throws Exception;
	
	public List<ComcodeVo> selectPhone() throws Exception;
	
	public List<ComcodeVo> selectMenu() throws Exception;
}
