package cn.hxy.inspect.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author eric
 * @date 9/19/19 2:34 PM
 */
public class SystemProperties {
    static Properties properties = new Properties();
    static InputStream in = SystemProperties.class.getClassLoader().getResourceAsStream("dev.properties");

    static {

        try {
            // 加载属性文件
            properties.load(in);
        } catch (IOException e) {
        }

    }

    /**
     * @param name
     *            property name
     * @return string value (or null if the property does not exist)
     */
    public static String getProperty(String name) {
        try {
            String value = properties.getProperty(name);
            if (value != null) {
                return value;
            }
            return System.getProperty(name);
        } catch (Exception e) {
            return null;
        }

    }

}
