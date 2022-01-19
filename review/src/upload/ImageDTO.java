package upload;

public class ImageDTO {
	
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
	
	public ImageDTO() {
		
	}
	public ImageDTO(String thumbImg, String imgName) {
		super();
		this.thumbImg = thumbImg;
		this.imgName = imgName;
	}
	
	
}
