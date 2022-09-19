package dbcon;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SalesDAO {
	
	Connection con = null;
	PreparedStatement pstmt =null;
	Statement stmt=null;
	ResultSet rs =null;
	
	DBcon db =new DBcon();
	
	public int insertOpenshop(int money) {
		
		int result = 0;
		con = db.dbConnect();
		String sql = "INSERT INTO openshop VALUES (?,sysdate)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,money);
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
	
	public int insertCloseShop(int cashsales,int cardsales, int totalsales) {
		con = db.dbConnect();
		String sql = "INSERT INTO closeshop VALUES (?,?,?,sysdate)";
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,cashsales);
			pstmt.setInt(2,cardsales);
			pstmt.setInt(3,totalsales);
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
	
	public int openMoney(int daydate)  {
		int result = 0;
		con = db.dbConnect();
		String sql = "SELECT money FROM openshop WHERE  to_number(to_char(daydate, 'yyyymmdd')) = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, daydate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
			
				e.printStackTrace();
			}
		}
		
		return result;
		
		
	}
	
	public int selectclose(int closedate) {
		int result = 0;
		con = db.dbConnect();
		String sql = "SELECT COUNT(*) FROM  closeshop WHERE  to_number(to_char(closedate, 'yyyymmdd')) = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, closedate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if (rs.getInt(1) == 1) {
					result  = 1;
				}
				
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
		
		return result;
		
	}
	public int delectclose(int closedate) {
		int result = 0;
		con = db.dbConnect();
		String sql = "delete closeshop WHERE  to_number(to_char(closedate, 'yyyymmdd')) = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, closedate);
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
	
	public int openmoneyCount(int daydate) {
		int result = 0;
		con = db.dbConnect();
		String sql =  "SELECT COUNT(*) FROM  openshop WHERE  to_number(to_char(daydate, 'yyyymmdd')) = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, daydate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if (rs.getInt(1) == 1) {
					result  = 1;
				}
				
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
		
		return result;
		
	}

}
