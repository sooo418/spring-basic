package com.spring.comcode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.spring.comcode.dao.ComcodeDao;
import com.spring.comcode.service.ComcodeService;
import com.spring.comcode.vo.ComcodeVo;

@Service
public class ComcodeServiceImpl implements ComcodeService{

	@Autowired
	ComcodeDao comcodeDao;
	
	@Override
	public List<ComcodeVo> selectComcodeList() throws Exception {
		return comcodeDao.selectComcodeList();
	}

	@Override
	public List<ComcodeVo> selectPhone() throws Exception {
		return comcodeDao.selectPhone();
	}

	@Override
	public List<ComcodeVo> selectMenu() throws Exception {
		return comcodeDao.selectMenu();
	}



}
