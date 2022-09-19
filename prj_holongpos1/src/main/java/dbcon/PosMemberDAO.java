package dbcon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PosMemberDAO {
	
	DBcon db = new DBcon();
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public int loginCheck(String id,String pw) {
		
		int result = 0;
		con = db.dbConnect();
		String sql = "select count(*) from tbl_posmember where id =? and pw = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				result = rs.getInt(1);
				if(result == 1) {
					
					return 1 ;
					
				}
				
				
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return result;
		
		
	}

}
