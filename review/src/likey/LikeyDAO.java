package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class LikeyDAO {
	
	public int like(String userID, String evaluationID, String userIP) {
		String SQL = "INSERT INTO Likey VALUES (?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� sql���� ������ �ڿ� ���� ������� �޾ƿ�
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, evaluationID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return -1; //�ߺ��� ��õ ������ -1 ����
	}
}
