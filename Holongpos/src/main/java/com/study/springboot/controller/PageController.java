package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.jdbc.IMenuDAO;
import com.study.springboot.jdbc.MenuDTO;

import lombok.extern.slf4j.Slf4j;




//페이지 연결 컨드롤러
@Controller
@Slf4j
public class PageController {
	
	@Autowired
	IMenuDAO menuDao ;
	
	@RequestMapping("/")
	public@ResponseBody String root() {
		
		return "pos";
	}
	
	@RequestMapping("/loginpage")
	public String logInPage() {
		return "loginpage";
		
	}

	@RequestMapping("/explansation")
	public String explansation() {
		return "explansation";
	}
	@RequestMapping("/main")
	public String main() {
		return "main";
	}
	@RequestMapping("/index")
	public String index(Model model ) {
		String typebread = "단과자";
		List<MenuDTO> breadList = menuDao.breadList();
		List<MenuDTO> menuList = menuDao.menuList(typebread);
		model.addAttribute("breadList", breadList);
		model.addAttribute("menuList", menuList);
		
		
		
		return "index";
	}

}
