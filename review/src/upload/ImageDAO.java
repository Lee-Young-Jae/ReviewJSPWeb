package upload;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DatabaseUtil;


public class ImageDAO{
	
	public int imgupload(String thumbImg, String imgName) {
		
		String SQL = "INSERT INTO UPLOADFILE VALUES (?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, thumbImg);
			pstmt.setString(2, imgName);
			return pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return -1;
	}
}