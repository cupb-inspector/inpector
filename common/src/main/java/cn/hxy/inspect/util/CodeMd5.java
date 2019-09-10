package cn.hxy.inspect.util;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import sun.misc.BASE64Encoder;

public class CodeMd5 {
	public String codeMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		BASE64Encoder base64Decoder = new BASE64Encoder();//使用64位加密算法
		String newstr = base64Decoder.encode(md5.digest(str.getBytes("utf-8")));
		return newstr;//生成一个16字节的字符串
	}
}
