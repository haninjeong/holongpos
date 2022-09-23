package com.study.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMenuDAO {
	
	public List<MenuDTO> menuList(String typebread);
	public List<MenuDTO> breadList();
	public List<MenuDTO> allMenuList(long pagenum ,long amount);
	public int totalMenu();
	public int updateMenu(String name,long  price,long  menunum);
	public int deleteMenu(long menunum);
	public int insertMenu(String typebread,String name,long price);
	

}
