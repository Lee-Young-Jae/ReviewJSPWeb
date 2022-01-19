package util;

import java.security.MessageDigest;

public class SHA256 {
	//이메일 값에 HASH를 적용한 값을 반환하는 클래스
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] salt = "MY NAME IS YOUNG JAE HELLO.".getBytes(); //보안을 위해 해쉬값 발생
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			for(int i=0; i< chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append("0"); // 1자리 수인 경우 0을 붙여서 총 두자리 값을 가지게 하는 16진수 형태로 출력할수 있도록 함
				result.append(hex);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return result.toString();
	}
}
