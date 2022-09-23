package com.study.springboot.jdbc;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IPosMemberDAO {
	
	public int loginCheck(String id,String pw);
	
	
	

}
