package com.polaris.springboot_mybatis_jsp.controller;


import com.polaris.springboot_mybatis_jsp.pojo.User;
import com.polaris.springboot_mybatis_jsp.service.UserService;
import com.polaris.springboot_mybatis_jsp.Servlet.GetPoiInfoServlet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@Controller
public class UserController {
    @Autowired
    private UserService userService;
    private GetPoiInfoServlet getPoiInfoServlet=new GetPoiInfoServlet();

    @RequestMapping(value = "findAll")
    public String findAll(HttpServletRequest request) {

        System.out.println("PageController:page()");

        List<User> list = userService.findAll();

        request.setAttribute("userlist", list);

        return "listall";


    }

    @RequestMapping(value = "testmysql")
    public String testmysql(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("mysql test start!");
        try{

            getPoiInfoServlet.doPost(request, response);

        }catch(IOException e){

            System.out.println("IOE 异常:"+e);
        }
        catch(ServletException e1){

            System.out.println("Servlet 异常:"+e1);
        }

        System.out.println("run there");

       // request.setAttribute("userlist", list);
        return "showdata";

    }
}




