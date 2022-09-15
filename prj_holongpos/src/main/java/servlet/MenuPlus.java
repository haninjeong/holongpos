package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.MenuDAO;


@WebServlet("/MenuPlus.do")
public class MenuPlus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		try {
			String typebread = request.getParameter("typebread");
			String name = request.getParameter("name");
			String s_price = request.getParameter("price");
			
			System.out.println(typebread);
			System.out.println(name );
			System.out.println(s_price);
			MenuDAO dao = new MenuDAO();
			
			int price =Integer.parseInt(s_price);
			int result=dao.insertMenu(typebread, name, price);
			out.print(result);
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			out.print(0);
		}
		
		
	}

}
