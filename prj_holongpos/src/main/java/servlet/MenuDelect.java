package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.MenuDAO;

@WebServlet("/MenuDelect.do")
public class MenuDelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		String no = request.getParameter("no");
		System.out.println(no);
		String name = request.getParameter("titlename");
		String price = request.getParameter("reprice");
		
		if( name == null) {
		try {
				
				int menunum = Integer.parseInt(no);
				MenuDAO dao = new MenuDAO();
				
				int result=dao.deleteMenu(menunum);
				out.print(result);
				
				
				
			}catch (Exception e) {
				e.printStackTrace();
				out.print(0);
			}
			
		}else if (name != null) {
			
			
			try {
				
				int menunum = Integer.parseInt(no);
				int menuprice = Integer.parseInt(price);
				MenuDAO dao = new MenuDAO();
				
				int result=dao.updateMenu(name, menuprice, menunum);
				out.print(result);
				
				
				
			}catch (Exception e) {
				e.printStackTrace();
				out.print(0);
			}
			
			
			
			
		}
		

		
	}
		
	

}
