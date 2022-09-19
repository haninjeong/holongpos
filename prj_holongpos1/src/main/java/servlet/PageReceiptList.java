package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import dbcon.OrderMenuDAO;
import dto.OrderMenuDTO;
import dto.PageVO;



@WebServlet("/PageReceiptList")
public class PageReceiptList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		int amount = 5;
		String num = request.getParameter("pageNum");
		System.out.println("넘어온 페이지 숫자변환전 :"+num);
		System.out.println("화면에 그려질데이터  :"+amount);
		int pageNum=Integer.parseInt(num);
		System.out.println("넘어온 페이지 :"+pageNum);
		
		OrderMenuDAO dao = new OrderMenuDAO();
		
		List<OrderMenuDTO> receiptList=dao.receiptList(pageNum, amount);
		
		int total = dao.totalOrderMenu();
		JSONObject obj2 = new JSONObject();
		JSONArray  jList = new JSONArray();
	
		for(int i=0;i< receiptList.size();i++) {
			SimpleDateFormat sdf1 = new SimpleDateFormat("yy/MM/dd");
			 SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
			 JSONObject obj3 = new JSONObject();
			 obj3.put("receipt_no", receiptList.get(i).getReceipt_no());
			 obj3.put("pay_date",sdf1.format(receiptList.get(i).getPay_date()));
			 obj3.put("pay_date2",sdf2.format(receiptList.get(i).getPay_date()));
			 obj3.put("totalprice",receiptList.get(i).getTotalprice());
			 obj3.put("payment",receiptList.get(i).getPayment());
			jList.put(obj3);
		}
		obj2.put("receiptList", jList);
		
		
		PageVO pageVO = new PageVO(pageNum, amount,total);
		request.setAttribute("pageVO", pageVO);
		
		
		String jsonInfo = obj2.toString();
		System.out.println(obj2.toString());
		out.print(jsonInfo);
		
	
	}

}
