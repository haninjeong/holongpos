package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import dbcon.OrderMenuDAO;
import dto.OrderMenuDTO;


@WebServlet("/SalPriceList.do")
public class SalPriceList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		OrderMenuDAO dao = new OrderMenuDAO();
		PrintWriter out = response.getWriter();
		JSONObject obj1 = new JSONObject();
		JSONArray jlist = new JSONArray();
		Date date = new Date();
		String pattrtn = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattrtn);

		int lastDate1 = Integer.parseInt(sdf.format(date));

		Calendar week = Calendar.getInstance();
		week.add(Calendar.DATE, -7);
		SimpleDateFormat sdf1 = new SimpleDateFormat(pattrtn);

		int startDate1 = Integer.parseInt(sdf1.format(week.getTime()));
			
		int startDate = 0;
		int lastDate = 0;
		String start = request.getParameter("startDate");
		String last = request.getParameter("lastDate");
		if(start == null) {
			System.out.println("값이 없음");
			startDate = startDate1 ;
			lastDate = lastDate1;
			System.out.println(startDate);
			System.out.println(lastDate);
			
		}else if(start != null) {
			
			 startDate = Integer.parseInt(start.replace("-", ""));
			 lastDate = Integer.parseInt(last.replace("-", ""));
			
		}
		
	
		
	
	
		List<OrderMenuDTO> totalList = dao.totalpriceList(startDate,lastDate);
		
		for(int i =0;i<totalList.size();i++) {
			
			JSONObject obj2 = new JSONObject();
			obj2.put("pay_date",totalList.get(i).getPay_date());
			obj2.put("totalprice",totalList.get(i).getTotalprice());
			jlist.put(obj2);
			
		}
		obj1.put("totalList",jlist);
		String jsonInfo = obj1.toString();
		System.out.println(jsonInfo);
		out.print(jsonInfo);
		
		
		
		
		
		
	}

}
