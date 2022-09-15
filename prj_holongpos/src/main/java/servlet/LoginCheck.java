package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.PosMemberDAO;
import dbcon.SalesDAO;


@WebServlet("/LoginCheck.do")
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out = response.getWriter();
		
		Date date = new Date();

		String pattrtn = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattrtn);

		int startDate = Integer.parseInt(sdf.format(date));
		PosMemberDAO dao = new PosMemberDAO();
		
		SalesDAO saldao = new SalesDAO();
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		
		int result = dao.loginCheck(id, pw)+ saldao.openmoneyCount(startDate);
		if(result == 2 || result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id",id);
		}
		out.print(result);
		
		
		
		
		
		
		
	}

}
