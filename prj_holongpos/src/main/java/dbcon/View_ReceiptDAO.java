package dbcon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.View_ReceiptDTO;

public class View_ReceiptDAO {
	
	Connection con = null;
	PreparedStatement pstmt =null;
	Statement stmt=null;
	ResultSet rs =null;
	
	DBcon db =new DBcon();
	
	public List<View_ReceiptDTO> receiptList(int receiptnum){
		
		con=db.dbConnect();
		List<View_ReceiptDTO> receiptList = new ArrayList<>();
		
		String sql ="SELECT * FROM view_receipt where receiptnum=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, receiptnum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				View_ReceiptDTO dto =new View_ReceiptDTO();
				dto.setValue(rs.getString("value"));
				dto.setPrice(rs.getString("price"));
				dto.setEa(rs.getString("ea"));
				dto.setTotalprice(rs.getString("totalprice"));
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
	
	public List<View_ReceiptDTO> popValueList (int startDate ,int lastDate ) {
		
		con=db.dbConnect();
		List<View_ReceiptDTO>  popValueList = new ArrayList<>();
		
		String sql = "select value,count(value) as 갯수 FROM view_receipt where to_number(to_char(reg_date, 'yyyymmdd'))  BETWEEN ? \r\n"
				+ "AND ? GROUP by value ORDER by 갯수 DESC";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startDate);
			pstmt.setInt(2, lastDate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				View_ReceiptDTO dto = new View_ReceiptDTO();
				
				dto.setValue(rs.getString(1));
				dto.setEa(rs.getString(2));
				popValueList.add(dto);
				
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return popValueList;
		
		
	}
	

}
