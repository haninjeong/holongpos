package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.OrderMenuDAO;


@WebServlet("/ReturnProgress.do")
public class ReturnProgress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	 request.setCharacterEncoding("utf-8");
	 response.setContentType("text/html; charset=UTF-8");
	 PrintWriter out = response.getWriter();
	 
	 String s_receipt_no = request.getParameter("receipt_no");
	 
	 
	 int receipt_no = Integer.parseInt(s_receipt_no);
	 
	 
	 OrderMenuDAO dao = new  OrderMenuDAO();
	 
	 int result = dao.updateOrderMenu(receipt_no);
	 out.print(result);
	 
	 
		
	}

}
