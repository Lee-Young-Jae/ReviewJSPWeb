package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	
	public int write(EvaluationDTO evaluationDTO) {  //�ı� ���� 
		String SQL = "INSERT INTO REVIEW VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, 0, NULL, NULL)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //sql�� ���� �� ���� ������� �޾ƿ� ����
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);  //sql ������ ���� ���ִ� Ŭ����
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getshopName());
			pstmt.setString(3, evaluationDTO.getFoodType());
			pstmt.setString(4, evaluationDTO.getShopLocation());
			pstmt.setString(5, evaluationDTO.getTitle());
			pstmt.setString(6, evaluationDTO.getContent());
			pstmt.setString(7, evaluationDTO.getTotalScore());
			return pstmt.executeUpdate(); //���� �������� ���� ��ȯ �Լ� ���������� ���� ���� 1 ��ȯ (INSERT, UPDATE, DELETE) ������ ���� ��� �Լ�
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
			// connection, PreparedStatement ��ü�� ����Ŀ� �ڿ��� �����Ͽ� �����
		}
		return -1; // ���� �߻��� �����ͺ��̽� ����
		
	}
	public ArrayList<EvaluationDTO> getList (String foodType, String searchType, String search, int pageNumber){
		if(foodType.equals("��ü")) {
			foodType = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //�������� ���� �� ���� ���ϰ� ��ȯ
		try {
			if(searchType.equals("�ֽż�")) {
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

			} else if(searchType.equals("��õ������")) {

				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}  else if(searchType.equals("����������")) {
				
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY totalScore DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}	else if(searchType.equals("����������")) {
				
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY totalScore ASC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}	else if(searchType.equals("ȸ���ı�ã��")) {
				
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(userID, shopName, Title, Content)"
						+ " LIKE ? LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}	else if(searchType.equals("�����ı⸸")) {
				
				SQL = "SELECT * FROM REVIEW "
						+ "WHERE foodType LIKE ? AND CONCAT(userID, shopName, Title, Content) LIKE ? "
						+ "AND CONCAT(thumbImg, imgName) IS NOT NULL"
						+ " ORDER BY totalScore ASC;"
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			
			
			
			conn = DatabaseUtil.getConnection(); 
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, "%" + foodType + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			// �Խù��� ������ ������
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getInt(9),
						rs.getString(10),
						rs.getString(11)
						);
					evaluationList.add(evaluation);
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
			// connection, PreparedStatement ��ü�� ����Ŀ� �ڿ��� �����������
		}
		return evaluationList;
		
	}
	
	public int like(String evaluationID) {
		String SQL = "UPDATE REVIEW SET likeCount = likeCount + 1 WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return -1; //�����ͺ��̽� ���� 
	}
	public int delete(String evaluationID) {
		String SQL = "DELETE FROM REVIEW WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return -1; //�����ͺ��̽� ���� 
	}
	public String getUserID(String evaluationID) {
		String SQL = "SELECT userID FROM REVIEW WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); // evaluationID ����
			}
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return null;
	}
}
