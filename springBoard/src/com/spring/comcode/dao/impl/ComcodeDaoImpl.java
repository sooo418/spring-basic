package com.spring.comcode.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.comcode.dao.ComcodeDao;
import com.spring.comcode.vo.ComcodeVo;

@Repository
public class ComcodeDaoImpl implements ComcodeDao{
	
	@Autowired
	private SqlSession sqlsession;
	
	@Override
	public List<ComcodeVo> selectComcodeList() throws Exception {
		
		return sqlsession.selectList("comcode.codeList");
	}

	@Override
	public List<ComcodeVo> selectPhone() throws Exception {
		return sqlsession.selectList("comcode.phoneNum");
	}

	@Override
	public List<ComcodeVo> selectMenu() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList("comcode.codeMenu");
	}


}
