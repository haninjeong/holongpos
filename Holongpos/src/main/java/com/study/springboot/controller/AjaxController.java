package com.study.springboot.controller;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.study.springboot.jdbc.IPosMemberDAO;

import lombok.extern.slf4j.Slf4j;
//ajax 전용 컨트롤러
@Controller
@Slf4j
public class AjaxController {
	@Autowired
	IPosMemberDAO posmemberDao;
	
	
	@RequestMapping("/ajax")
	public@ResponseBody String root() {
		
		return "ajax";
	}
	
	@RequestMapping("/ajax/loginCheck")
	public @ResponseBody int loginCheck(HttpServletRequest request,String id,String pw) {
		
		System.out.println(id +"pw는 "+pw);
		int result = posmemberDao.loginCheck(id, pw) ;
		
		System.out.println("반환"+result);	
		if(result == 1) {
			HttpSession session  = request.getSession();
			session.setAttribute("id", id);
			
		}
		
		return result;
	}

}
