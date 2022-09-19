package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.OrderMenuDAO;



@WebServlet("/OrderList.do")
public class OrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		String[] menus = request.getParameterValues("menus");
		String[] menusprice = request.getParameterValues("menusprice");
		String[] menusno = request.getParameterValues("menusno");
		String [] menustotalprice = request.getParameterValues("menustotalprice");
		String totalno = request.getParameter("totalno");
		String totalprice = request.getParameter("totalprice");
		String payment = request.getParameter("payment");
		
		String menu_arr = "";
		String menusprice_arr = "";
		String menusno_arr = "";
		String menustotalprice_arr = "";
		for(int i=0 ;i<menus.length;i++) {
			
			if(i <menus.length-1) {
				menu_arr+= menus[i]+ "," ;
				menusprice_arr+= menusprice[i]+",";
				menusno_arr+= menusno[i]+",";
				menustotalprice_arr+= menustotalprice[i]+",";
			}else {
				menu_arr+= menus[i];
				menusprice_arr+= menusprice[i];
				menusno_arr+= menusno[i];
				menustotalprice_arr+= menustotalprice[i];
			}
			
					
		}
		System.out.println(menu_arr);
		System.out.println(menusprice_arr);
		System.out.println(menusno_arr);
		System.out.println(menustotalprice_arr);
		int num_totalno = Integer.parseInt(totalno);
		
		OrderMenuDAO dao = new OrderMenuDAO();
		
		int result = dao.insertOrderMenu(menu_arr, menusprice_arr, menusno_arr,menustotalprice_arr, num_totalno, totalprice, payment) ;
		out.print(result);
		
		
		
		
	}

}
