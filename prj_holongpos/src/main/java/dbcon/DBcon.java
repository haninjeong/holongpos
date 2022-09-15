package dbcon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBcon {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String id = "green01";
	String pw = "1234";
	Connection con = null;


	public Connection dbConnect() {
		try {
			Class.forName(driver);
			try {
				con = DriverManager.getConnection(url, id, pw);
			} catch (SQLException e) {

				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		}
		return con;
	}

}
