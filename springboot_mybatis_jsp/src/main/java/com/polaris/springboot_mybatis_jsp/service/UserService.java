package com.polaris.springboot_mybatis_jsp.service;

import com.polaris.springboot_mybatis_jsp.mapper.UserMapper;
import com.polaris.springboot_mybatis_jsp.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public List<User> findAll(){


        return userMapper.findAll();
    }

    public int add(User user){

        return userMapper.add(user);

    }
}

