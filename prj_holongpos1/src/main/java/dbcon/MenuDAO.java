package dbcon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.MenuDTO;






public class MenuDAO {
	
	Connection con = null;
	PreparedStatement pstmt =null;
	Statement stmt=null;
	ResultSet rs =null;
	
	DBcon db =new DBcon();
	
	public List<MenuDTO> menuList(String typebread){
		List<MenuDTO> menuList =new ArrayList<MenuDTO>();
		con=db.dbConnect();
		//System.out.println("typebread = " + typebread);
		String sql="select name,price from menu where typebread=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,typebread);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				MenuDTO vo =new MenuDTO();
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				menuList.add(vo);
				
			}
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return menuList;
		
	}
	public List<MenuDTO> breadList(){
		List<MenuDTO> breadList =new ArrayList<MenuDTO>();
		con=db.dbConnect();
		String sql="SELECT DISTINCT typebread FROM menu";
		
		try {
			stmt=con.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				MenuDTO vo =new MenuDTO();
				vo.setTypebread(rs.getString(1));
				breadList.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return breadList;
		
	}
	public List<MenuDTO> allMenuList(int pagenum ,int amount){
		List<MenuDTO> menuList =new ArrayList<MenuDTO>();
		con=db.dbConnect();

		 String sql =" SELECT *FROM (\r\n"
		 		+ " SELECT ROWNUM RN, A.*  \r\n"
		 		+ " FROM \r\n"
		 		+ " (SELECT menunum,typebread,name,price from menu order by menunum )A )\r\n"
		 		+ " WHERE RN > ? AND rn<=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,(pagenum-1)*amount);
			pstmt.setInt(2,pagenum*amount);
			rs=pstmt.executeQuery();
			
			
			while(rs.next()) {
				MenuDTO vo =new MenuDTO();
				vo.setMenunum(rs.getInt("menunum"));
				vo.setTypebread(rs.getString("typebread"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				menuList.add(vo);
				
			}
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return menuList;
		
	}
	public int totalMenu() {
		int totalpage = 0;
		con = db.dbConnect();
		String sql = "SELECT COUNT(*) FROM menu";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				totalpage = rs.getInt(1);
				
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return totalpage;
		
	}
	public int updateMenu(String name,int price,int menunum)   {
		con = db.dbConnect();
		int result = 0;
		String sql = "UPDATE menu SET name=?,price=? WHERE menunum=? ";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,name);
			pstmt.setInt(2,price);
			pstmt.setInt(3,menunum);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		}
		return result;
		
	}
	public int deleteMenu(int menunum) {
		
		con = db.dbConnect();
		int result = 0;
		String sql = "DELETE menu WHERE menunum=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,menunum);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		
		}finally {
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				
				
			}
		}
		return result;
		
	}
	public int insertMenu(String typebread,String name,int price) {
		con = db.dbConnect();
		int result = 0;
		String sql = "INSERT INTO menu VALUES(?,?,?,seq_menunum.nextval)";
		try {
			pstmt=con.prepareStatement(sql);
		
			pstmt.setString(1, typebread);
			pstmt.setString(2, name);
			pstmt.setInt(3, price);
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	
	
	
	

}
