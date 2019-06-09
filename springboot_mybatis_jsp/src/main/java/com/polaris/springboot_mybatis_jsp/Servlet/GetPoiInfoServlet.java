package com.polaris.springboot_mybatis_jsp.Servlet;

import com.polaris.springboot_mybatis_jsp.MysqlUtil.MysqlUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/gclass")

public class GetPoiInfoServlet extends HttpServlet
{

    private static final long serialVersionUID = 1L;
    private static List convertList(ResultSet rs) throws SQLException {
        List list = new ArrayList();
        ResultSetMetaData md = rs.getMetaData();
        int columnCount = md.getColumnCount();
        while (rs.next()) {
            Map rowData = new HashMap();
            for (int i = 1; i <= columnCount; i++) {
                rowData.put(md.getColumnName(i), rs.getObject(i));
            }
            list.add(rowData);
        }
        return list;
    }

    /**
     * The doGet method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to get.
     *
     * @param request
     *            the request send by the client to the server
     * @param response
     *            the response send by the server to the client
     * @throws ServletException
     *             if an error occurred
     * @throws IOException
     *             if an error occurred
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        this.doPost(request, response);
    }

    /**
     * The doPost method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to
     * post.
     *
     * @param request
     *            the request send by the client to the server
     * @param response
     *            the response send by the server to the client
     * @throws ServletException
     *             if an error occurred
     * @throws IOException
     *             if an error occurred
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("application/json");
//        Connection ct = null;
//        Statement  sm = null;
//        ResultSet rs = null;
//        try{
//            Class.forName("com.mysql.jdbc.Driver");     //连接mysql数据库
//            ct = DriverManager.getConnection("jdbc:mysql://localhost:3306/spotfi_v1?useUnicode=true&characterEncoding=utf-8","root" , "meiyoumima");
//            sm = ct.createStatement();
//            rs = sm.executeQuery("select *from user");
//
//            JSONArray jsonData = JSONArray.fromObject(convertList(rs));      //先转成List格式，再转成json格式
//
//            System.out.println(jsonData.toString());
//
//            PrintWriter out = response.getWriter();    //把json数据传递到前端，记着前端用ajax接收
//            out.print(jsonData);
//        }
//        catch(Exception ex)
//        {
//            //error 代码
//        }






        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        JSONArray array = new JSONArray();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select * from aoa_p_table";


//        String callback = (String)request.getParameter("callback");
//        String jsonData = "{\"id\":\"3\", \"name\":\"sada\", \"telephone\":\"13612348\"}";
//        String retStr = callback + "(" + jsonData + ")";
//        response.getWriter().print(retStr);
        try
        {
            con = MysqlUtil.getConn();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next())
            {
                double aoa=rs.getDouble("aoa");
                double p=rs.getDouble("p");
                System.out.println(aoa+","+p);
                double location_x=0;
                double location_y=0;
                location_x= Math.sqrt((p*p) / (1 + Math.tan(aoa)*Math.tan(aoa))) + 600;
                location_y = Math.sqrt((p*p) / (1 + Math.tan(aoa)*Math.tan(aoa)))*Math.tan(aoa) + 400;
                System.out.println("true location is :"+location_x+","+location_y);
//                try{
//                    Thread.sleep(1000);
//                }catch(Exception e){
//                    System.exit(0);//退出程序
//                }
//                try {
//                    Thread.sleep(1000);
//                }catch(InterruptedException ex)
//                {
//
//                }

                JSONObject temp = new JSONObject().element("aoa", rs.getDouble("aoa")).element("p", rs.getDouble("p"));
                array.add(temp);
            }

            response.getWriter().print(array.toString());
////            out.println("web:");
////            out.print(array.toString());  //将array对象传到前端
//            System.out.println("server:");
            System.out.println(array.toString());
//            out.flush();
//            //out.close();
        } catch (SQLException e)
        {
            e.printStackTrace();
        } finally
        {
            try
            {
                //依次关闭连接
                if (rs != null)
                {
                    rs.close();
                    rs = null;
                }
                if (ps != null)
                {
                    ps.close();
                    ps = null;
                }
                if (con != null)
                {
                    con.close();
                    con = null;
                }
            } catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
    }
}

