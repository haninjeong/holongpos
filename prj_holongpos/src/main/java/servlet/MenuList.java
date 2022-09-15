package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import dbcon.MenuDAO;
import dto.MenuDTO;

@WebServlet("/MenuList.do")
public class MenuList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out =response.getWriter();
		
		String typebread =request.getParameter("typebread");
	
		
		
		MenuDAO dao = new MenuDAO();
		
		List<MenuDTO> menuList = new ArrayList<>();
		
		menuList = dao.menuList(typebread);
		JSONObject obj2 = new JSONObject();
		JSONArray  jList = new JSONArray();
		
		for(int i=0;i<menuList.size();i++) {
			
			
			JSONObject obj3 = new JSONObject();
			obj3.put("price",menuList.get(i).getPrice());
			obj3.put("name",menuList.get(i).getName());
			
			
			jList.put(obj3);
			
		}
		obj2.put("menuList",jList);
		//System.out.println("리스트:"+menuList.toString());
		//System.out.println("젝슨리스트:"+obj2.toString());
		String jsonInfo = obj2.toString();
		out.print(jsonInfo);
		
	

		
	}

}
