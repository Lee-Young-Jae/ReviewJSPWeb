package util;

import java.sql.Connection;
import java.sql.DriverManager;

//import javax.lang.model.element.ModuleElement.ExportsDirective;

public class DatabaseUtil {
	
	public static Connection getConnection() {
		try {
			String MysqlURL = "jdbc:mysql://localhost:3306/review?serverTimezone=UTC";
			String MysqlID = "root";
			String MysqlPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(MysqlURL, MysqlID, MysqlPassword); 
			//jdbc:mysql://localhost:3306/review?serverTimezone=UTC&root&root
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("util.getConnection() : " + ex.toString());
		}
		return null;
	}
	
	
}
