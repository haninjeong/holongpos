package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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


@WebServlet("/SearchOrserList")
public class SearchOrserList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out =response.getWriter();
		String select=request.getParameter("select");
		String searchtext=request.getParameter("searchtext");
		
		OrderMenuDAO dao = new OrderMenuDAO();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yy/MM/dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
		System.out.println(select);
		System.out.println(searchtext);
		JSONObject obj2 = new JSONObject();
		JSONArray  jList = new JSONArray();
		
		try {
			
			if(select.equals("payment")) {
				
				List<OrderMenuDTO> paymentSearchList = dao.paymentSearchList(searchtext);
			
				for(int i=0;i<paymentSearchList.size();i++) {
					
					JSONObject obj3 = new JSONObject();
					obj3.put("receipt_no", paymentSearchList.get(i).getReceipt_no());
					obj3.put("pay_date",sdf1.format( paymentSearchList.get(i).getPay_date()));
					obj3.put("pay_date2",sdf2.format( paymentSearchList.get(i).getPay_date()));
					obj3.put("totalprice", paymentSearchList.get(i).getTotalprice());
					obj3.put("payment", paymentSearchList.get(i).getPayment());
					jList.put(obj3);
					
					
				}
				
				obj2.put("receiptList", jList);
				System.out.println(obj2.toString());
				String jsonInfo =obj2.toString();
				out.print(jsonInfo);
				
				
				
			}else if(select.equals("receiptno")) {
				int receiptno=Integer.parseInt(searchtext);
				List<OrderMenuDTO>receiptSearchList = dao.receiptSearchList(receiptno);
				
					for(int i=0;i<receiptSearchList.size();i++) {
						
						JSONObject obj3 = new JSONObject();
						obj3.put("receipt_no", receiptSearchList.get(i).getReceipt_no());
						obj3.put("pay_date",sdf1.format( receiptSearchList.get(i).getPay_date()));
						obj3.put("pay_date2",sdf2.format( receiptSearchList.get(i).getPay_date()));
						obj3.put("totalprice", receiptSearchList.get(i).getTotalprice());
						obj3.put("payment", receiptSearchList.get(i).getPayment());
						jList.put(obj3);
						
						
					}
					obj2.put("receiptList", jList);
					System.out.println(obj2.toString());
					String jsonInfo = obj2.toString();
					out.print(jsonInfo);
					
		
				
				
				
			}
			
			
		}catch (Exception e) {
			out.print(0);	
		}

		
	
	
	}

	

}
