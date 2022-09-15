package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JList;

import org.json.JSONArray;
import org.json.JSONObject;

import dbcon.View_ReceiptDAO;
import dto.View_ReceiptDTO;

@WebServlet("/PopmenuList.do")
public class PopmenuList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String start = request.getParameter("startDate");
		String last = request.getParameter("lastDate");
		
		if( last == null) {
			System.out.println("값이 없음");
		}
		int startDate = Integer.parseInt(start.replace("-", ""));
		int lastDate = Integer.parseInt(last.replace("-", ""));
		
		View_ReceiptDAO dao = new View_ReceiptDAO();
		
		List<View_ReceiptDTO> popmenuList = dao.popValueList(startDate, lastDate);
		
		JSONObject obj = new JSONObject();
		JSONArray  jList = new JSONArray();
		
		for(int i=0;i<popmenuList.size();i++) {
			JSONObject obj3 = new JSONObject();
			
			obj3.put("name",popmenuList.get(i).getValue());
			obj3.put("ea",popmenuList.get(i).getEa());
			
			jList.put(obj3);
			
		}
		obj.put("popmenuList",jList);
		String jsonInfo = obj.toString();
		
		out.print(jsonInfo);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}
