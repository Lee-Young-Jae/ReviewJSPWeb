package util;

import java.security.MessageDigest;

public class SHA256 {
	//�̸��� ���� HASH�� ������ ���� ��ȯ�ϴ� Ŭ����
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] salt = "MY NAME IS YOUNG JAE HELLO.".getBytes(); //������ ���� �ؽ��� �߻�
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			for(int i=0; i< chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append("0"); // 1�ڸ� ���� ��� 0�� �ٿ��� �� ���ڸ� ���� ������ �ϴ� 16���� ���·� ����Ҽ� �ֵ��� ��
				result.append(hex);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return result.toString();
	}
}
