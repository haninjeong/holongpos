package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.SalesDAO;

@WebServlet("/DelectCloseShop.do")
public class DelectCloseShop extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("서블릿으로온다!");
		PrintWriter out = response.getWriter();
		int closedate = Integer.parseInt(request.getParameter("closedate"));
		System.out.println("넘어온 날짜값"+closedate);
		SalesDAO dao = new SalesDAO();
		
		int result = dao.delectclose(closedate);
		System.out.println("결과"+result);
		out.print(result);
		
		
	}

}
