package dbcon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dto.OrderMenuDTO;

public class OrderMenuDAO {
	
	Connection con = null;
	PreparedStatement pstmt =null;
	Statement stmt=null;
	ResultSet rs =null;
	
	DBcon db =new DBcon();
	
	
	public int insertOrderMenu(String menus,String menus_price,String menus_no,String menus_totalprice,int totalno,
			String totalprice,String payment) {
		
		con=db.dbConnect();
		String sql="INSERT into ordermenu VALUES(SEQ_ORDERMENU.nextval,?,?,?,?,?,?,?,sysdate,seq_receipt.nextval)";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, menus);
			pstmt.setString(2, menus_price);
			pstmt.setString(3, menus_no);
			pstmt.setString(4, menus_totalprice);
			pstmt.setInt(5, totalno);
			pstmt.setString(6, totalprice);
			pstmt.setString(7, payment);
		int result=	pstmt.executeUpdate();
		return result;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return 0;
		
		
	}
	public List<OrderMenuDTO> orderList (int receiptnum){
		
		con=db.dbConnect();
		 List<OrderMenuDTO> orderList =new ArrayList<>();
		 String sql ="SELECT totalprice ,pay_date ,receipt_no,payment  from ordermenu where receipt_no =?";
		 
		 try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, receiptnum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				OrderMenuDTO dto =new OrderMenuDTO();
				dto.setTotalprice(rs.getInt("totalprice"));
				dto.setPay_date(rs.getDate("pay_date"));
				dto.setReceipt_no(rs.getInt("receipt_no"));
				dto.setPayment(rs.getString("payment"));
				orderList.add(dto);
				
				
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
		return orderList;
		 
		 
		
	}
	public List<OrderMenuDTO> receiptList (int pagenum ,int amount){
		con=db.dbConnect();
		 List<OrderMenuDTO> receiptList =new ArrayList<>();
		 Date date = new Date();
		
		 
		 SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		 SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
		 
		 String sql =" SELECT *FROM (\r\n"
		 		+ " SELECT ROWNUM RN, A.*  \r\n"
		 		+ " FROM \r\n"
		 		+ " (SELECT receipt_no, pay_date , totalprice,payment from ordermenu order by receipt_no desc)A )\r\n"
		 		+ " WHERE RN > ? AND rn<=?";
		
		 try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,(pagenum-1)*amount);
			pstmt.setInt(2,pagenum*amount);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OrderMenuDTO dto =new OrderMenuDTO();
				dto.setReceipt_no(rs.getInt("receipt_no"));
				dto.setPay_date(rs.getDate("pay_date"));
				dto.setTotalprice(rs.getInt("totalprice"));
				dto.setPayment(rs.getString("payment"));
				
				
				receiptList.add(dto);
				
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
		return receiptList;
		
	}
	public String removeComma(String Number) {
		 return Number.replaceAll("\\,","");
		
	}
	public int updateOrderMenu(int receipt_no ) {
		
		con=db.dbConnect();
		String sql ="UPDATE ordermenu set totalno=totalno*-1, totalprice=totalprice*-1 where receipt_no=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, receipt_no);
			int result=pstmt.executeUpdate();
			return result;
			
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
		return 0;
	
		
	}
	
	public int totalOrderMenu() {
		int totalpage =0;
		con=db.dbConnect();
		String sql = "SELECT COUNT(*) FROM ordermenu";
		try {
			stmt=con.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				totalpage =rs.getInt(1);
				
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
	
	public List<OrderMenuDTO>paymentSearchList(String payment) {
		con=db.dbConnect();
		List<OrderMenuDTO>paymentSearchList =new ArrayList<>();
		String sql ="SELECT totalprice ,pay_date ,receipt_no,payment  from ordermenu where payment LIKE ? order by receipt_no desc";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,"%"+payment+"%");
			rs=pstmt.executeQuery();
			while(rs.next()) {
				OrderMenuDTO dto = new OrderMenuDTO();
				dto.setTotalprice(rs.getInt("totalprice"));
				dto.setPay_date(rs.getDate("pay_date"));
				dto.setReceipt_no(rs.getInt("receipt_no"));
				dto.setPayment(rs.getString("payment"));
				paymentSearchList .add(dto);
				
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
		
		return paymentSearchList;
		
		
		
		
	}
	public List<OrderMenuDTO>receiptSearchList(int receipt) {
		con=db.dbConnect();
	
		List<OrderMenuDTO>receiptSearchList =new ArrayList<>();
		String receipt_no="%"+receipt+"%";
		String sql ="SELECT totalprice ,pay_date ,receipt_no,payment  from ordermenu where receipt_no"
				+ " \n LIKE ? order by receipt_no desc";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,receipt_no);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				OrderMenuDTO dto = new OrderMenuDTO();
				dto.setTotalprice(rs.getInt("totalprice"));
				dto.setPay_date(rs.getDate("pay_date"));
				dto.setReceipt_no(rs.getInt("receipt_no"));
				dto.setPayment(rs.getString("payment"));
				receiptSearchList .add(dto);
				
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
		
		return receiptSearchList;
		
		
		
		
	}
	public List<OrderMenuDTO> totalpriceList(int startDate,int lastDate){
		con=db.dbConnect();
		List<OrderMenuDTO>totalpriceList = new ArrayList<>();
		String sql = "SELECT TO_CHAR(pay_date,'yyyy-mm-dd') AS JRNL_DT, SUM(totalprice) AS TAKEOUT_AMOUNT "+
		"FROM ordermenu "+
		"WHERE to_number(to_char(pay_date, 'yyyymmdd'))  BETWEEN ?   AND ?"+
		"GROUP BY TO_CHAR(pay_date,'yyyy-mm-dd') ORDER BY TO_CHAR(pay_date,'yyyy-mm-dd') "; 
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startDate);
			pstmt.setInt(2, lastDate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderMenuDTO dto = new OrderMenuDTO();
				dto.setPay_date(rs.getDate(1));
				dto.setTotalprice(rs.getInt(2));
				totalpriceList.add(dto);
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
		return totalpriceList;
		
	}
	public List<OrderMenuDTO> closecash(int date) {
		con=db.dbConnect();
		List<OrderMenuDTO>closeShop  = new ArrayList<>();
		
		String sql = "select sum(totalprice) ,count(*)  FROM ordermenu where payment = '현금' and to_number(to_char(pay_date, 'yyyymmdd')) = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				OrderMenuDTO dto = new OrderMenuDTO();
				dto.setTotalprice(rs.getInt(1));
				dto.setTotalno(rs.getInt(2));
				
				closeShop.add(dto);
				
				
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
		
		
		
		return closeShop; 
		
		
	}
	
	public List<OrderMenuDTO> closecard(int date) {
		con=db.dbConnect();
		List<OrderMenuDTO> closeShop  = new ArrayList<>();
		
		String sql = "select sum(totalprice) ,count(*)  FROM ordermenu where payment = '카드' and to_number(to_char(pay_date, 'yyyymmdd')) = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				OrderMenuDTO dto = new OrderMenuDTO();
				dto.setTotalprice(rs.getInt(1));
				dto.setTotalno(rs.getInt(2));
				
				closeShop.add(dto);
				
				
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
		
		return closeShop; 
		
		
	}
	
	
	
	
	

}
