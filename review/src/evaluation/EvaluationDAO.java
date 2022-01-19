package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	
	public int write(EvaluationDTO evaluationDTO) {  //후기 쓰기 
		String SQL = "INSERT INTO REVIEW VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, 0, NULL, NULL)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //sql문 실행 후 나온 결과값을 받아올 변수
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);  //sql 구문을 실행 해주는 클래스
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getshopName());
			pstmt.setString(3, evaluationDTO.getFoodType());
			pstmt.setString(4, evaluationDTO.getShopLocation());
			pstmt.setString(5, evaluationDTO.getTitle());
			pstmt.setString(6, evaluationDTO.getContent());
			pstmt.setString(7, evaluationDTO.getTotalScore());
			return pstmt.executeUpdate(); //영향 데이터의 갯수 반환 함수 성공적으로 값이 들어가면 1 반환 (INSERT, UPDATE, DELETE) 쿼리문 사용시 사용 함수
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
			// connection, PreparedStatement 객체는 사용후에 자원을 해제하여 줘야함
		}
		return -1; // 오류 발생시 데이터베이스 오류
		
	}
	public ArrayList<EvaluationDTO> getList (String foodType, String searchType, String search, int pageNumber){
		if(foodType.equals("전체")) {
			foodType = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //쿼리문을 실행 후 나온 리턴값 반환
		try {
			if(searchType.equals("최신순")) {
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

			} else if(searchType.equals("추천많은순")) {

				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}  else if(searchType.equals("평점높은순")) {
				
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY totalScore DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}	else if(searchType.equals("평점낮은순")) {
				
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(shopLocation, shopName, Title, Content)"
						+ " LIKE ? ORDER BY totalScore ASC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}	else if(searchType.equals("회원후기찾기")) {
				
				SQL = "SELECT * FROM REVIEW WHERE foodType LIKE ? AND CONCAT(userID, shopName, Title, Content)"
						+ " LIKE ? LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				
			}	else if(searchType.equals("포토후기만")) {
				
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
			// 게시물이 존재할 때마다
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
			// connection, PreparedStatement 객체는 사용후에 자원을 해제해줘야함
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
		return -1; //데이터베이스 오류 
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
		return -1; //데이터베이스 오류 
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
				return rs.getString(1); // evaluationID 리턴
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
