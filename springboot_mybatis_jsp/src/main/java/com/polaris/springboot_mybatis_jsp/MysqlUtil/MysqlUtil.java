package com.polaris.springboot_mybatis_jsp.MysqlUtil;



import java.sql.Connection;
import java.sql.DriverManager;

public class MysqlUtil
{
    private static Connection conn = null; //数据库连接
    private static String server = "localhost"; //服务ip
    private static String port = "3306"; //服务端口
    public static String dbname = "spotfi_v1"; //数据库名
    private static String user = "root"; //数据库用户名
    private static String pass = "meiyoumima"; //数据库密码
    private static String drivername = "com.mysql.jdbc.Driver"; //MySql驱动类名
    private static String url = "jdbc:mysql://" + server + ":" + port + "/" + dbname + "?user=" + user + "&password=" + pass + "&useUnicode=true&characterEncoding=UTF-8"; //连接地址

    public static Connection getConn()
    {
        try
        {
            Class.forName(drivername).newInstance(); //加载JDBC驱动
            conn = DriverManager.getConnection(url); //建立连接
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return conn;
    }
}
