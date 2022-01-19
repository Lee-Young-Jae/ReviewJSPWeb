package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	
	public int login(String userID, String userPassword) {  //ID�� ��й�ȣ�� �޾Ƽ� �α��� (������ ��ȯ)
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� sql���� ������ �� ���� ������� �޾ƿ�
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) { //�Է��� ��й�ȣ�� ���� ���� ��й�ȣ�� ������
					return 1; //�α��� ����
				}
				else {
					return 0; // ���̵�� �����ϳ� ��й�ȣ Ʋ��
				}
			}
			return -1; // ���̵� �������� ����
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
			// connection, PreparedStatement ��ü�� ����Ŀ� �ڿ��� �����Ͽ� �����
		}
		return -2; // ���� �߻��� �����ͺ��̽� ����
		
	}
	
	public int join(UserDTO user) { // ������� ������ �Է¹޾Ƽ� ���� (������ ��ȯ)
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� sql���� ������ �� ���� ������� �޾ƿ�
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate(); // executeUpdate�� intŸ���� �� ��ȯ SELECT�� ������ ���� ����� ���
										  // �ݿ��� ���ڵ��� �Ǽ��� ��ȯ �� CREATE�� / DROP ������ -1 ��ȯ 
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return -1; //ȸ������ ���� 
	}
	public String getUserEmail(String userID) { // ������� ID���� �޾Ƽ� ������� �̸����� ��ȯ
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); //executeQuery�� resultSet��ü�� ���� ��ȯ SELECT�� ���� ���
			if(rs.next()) {
				return rs.getString(1); // ù��° �Ӽ��� ��
			}
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return null; //�����ͺ��̽� ���� 
	}
	
	public boolean getUserEmailChecked(String userID) { //������� �̸��� ���� ������ �Ҹ����� ��ȯ
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1); // ù��° �Ӽ��� ��
			}
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return false; //�����ͺ��̽� ���� 
	}
	
	public boolean setUserEmailChecked(String userID) { //������� �̸��� ������ ����
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return false; //�����ͺ��̽� ���� 
		
	}

	
}
