package evaluation;

public class EvaluationDTO {
	int evaluationID;
	String userID;
	String shopName;
	String foodType;
	String shopLocation;
	String Title;
	String Content;
	String totalScore;
	int likeCount;
	String thumbImg;
	String imgName;
	
	
	
	public String getThumbImg() {
		return thumbImg;
	}
	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getshopName() {
		return shopName;
	}
	public void setshopName(String shopName) {
		this.shopName = shopName;
	}
	public String getFoodType() {
		return foodType;
	}
	public void setFoodType(String foodType) {
		this.foodType = foodType;
	}
	public String getShopLocation() {
		return shopLocation;
	}
	public void setShopLocation(String shopLocation) {
		this.shopLocation = shopLocation;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String Title) {
		this.Title = Title;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String Content) {
		this.Content = Content;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public EvaluationDTO() {
		
	}
	
	public EvaluationDTO(int evaluationID, String userID, String shopName, String foodType,
			String shopLocation, String Title, String Content,
			String totalScore, int likeCount, String thumbImg, String imgName) {
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.shopName = shopName;
		this.foodType = foodType;
		this.shopLocation = shopLocation;
		this.Title = Title;
		this.Content = Content;
		this.totalScore = totalScore;
		this.likeCount = likeCount;
		this.thumbImg = thumbImg;
		this.imgName = imgName;
	}
	
	
}
