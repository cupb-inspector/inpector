package cn.hxy.inspect.entity.admin;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * 通过账号密码进行身份验证
 */
public class MailAuthenticator extends Authenticator {
    private String userName;
    private String password;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(userName, password);
    }

    public MailAuthenticator(String username, String password) {
        this.userName = username;
        this.password = password;
    }
}