package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.SalesDAO;


@WebServlet("/ShopCalculate.do")
public class ShopCalculate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		String s_openmoney = request.getParameter("openmoney");
		SalesDAO dao = new SalesDAO();
		int result = 0;
		if( s_openmoney != null) {
			int openmoney = Integer.parseInt(s_openmoney);
			result = dao.insertOpenshop(openmoney);
			out.print(result);
		}else {
			
			int cashsales = Integer.parseInt(request.getParameter("cashsales"));
			int cardsales = Integer.parseInt(request.getParameter("cardsales"));
			int totalsales = cardsales+cashsales;
			
			result = dao.insertCloseShop(cashsales, cardsales, totalsales);
			out.print(result);
			

			
		}
		
	}

}
