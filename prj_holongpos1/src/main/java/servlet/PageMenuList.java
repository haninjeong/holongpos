package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
import dto.PageVO;


@WebServlet("/PageMenuList.do")
public class PageMenuList extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out =response.getWriter();
		int amount = 8;
		String num = request.getParameter("pageNum");
		int pageNum = Integer.parseInt(num);
		
		MenuDAO dao = new MenuDAO();
		int total = dao.totalMenu();
		JSONObject obj = new JSONObject();
		JSONArray  jList = new JSONArray();
		List<MenuDTO> menuList = dao.allMenuList(pageNum, amount);
		
		for(int i=0;i<menuList.size();i++) {
			JSONObject obj2 = new JSONObject();
			obj2.put("menunum", menuList.get(i).getMenunum());
			obj2.put("typebread",menuList.get(i).getTypebread());
			obj2.put("name",menuList.get(i).getName());
			obj2.put("price", menuList.get(i).getPrice());
			jList.put(obj2);
		}
		obj.put("menuList",jList);
		PageVO pageVO = new PageVO(pageNum, amount,total);
		request.setAttribute("pageVO", pageVO);
		String jsonInfo = obj.toString();
		System.out.println(obj.toString());
		out.print(jsonInfo);
		
		
		
		
		
		
		
		
		
		
	}

}
